package org.example.service.impl;

import org.example.entity.Dish;
import org.example.mapper.DishMapper;
import org.example.service.AIRecommendService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class AIRecommendServiceImpl implements AIRecommendService {

    @Autowired
    private DishMapper dishMapper;

    @Value("${deepseek.api-key:sk-placeholder}")
    private String apiKey;

    @Value("${deepseek.api-url:https://api.deepseek.com/chat/completions}")
    private String apiUrl;

    @Value("${deepseek.model:deepseek-chat}")
    private String model;

    // ==================== 【修复核心】：在此添加餐厅基础信息配置 ====================
    private String restaurantName = "吃在科大";
    private String restaurantAddress = "青岛科技大学南苑食堂";
    private String restaurantPhone = "028-88889999";
    private String restaurantHours = "周一至周日 09:30 - 22:00";
    private String restaurantDescription = "主打经典中华非遗传统名菜，融合川、粤、鲁、苏等八大菜系精髓，全场满88元免外卖配送费！";

    @Override
    public List<Map<String, Object>> recommend(String taste, Integer budget, Integer peopleCount, String province) {
        // 构建菜品列表上下文
        LambdaQueryWrapper<Dish> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Dish::getStatus, 1);
        if (province != null && !province.isEmpty()) {
            wrapper.eq(Dish::getProvince, province);
        }
        List<Dish> allDishes = dishMapper.selectList(wrapper);

        if (apiKey == null || apiKey.isEmpty() || "sk-placeholder".equals(apiKey)) {
            return fallbackRecommend(allDishes, taste, budget, peopleCount);
        }

        // 构建 prompt
        StringBuilder dishContext = new StringBuilder("【菜品列表】\n");
        for (Dish d : allDishes) {
            dishContext.append(String.format("ID:%d, 名称:%s, 价格:%.0f元, 口味:%s, 省份:%s\n",
                    d.getId(), d.getName(), d.getPrice(), d.getTasteTags(), d.getProvince()));
        }

        StringBuilder prompt = new StringBuilder();
        prompt.append("你是一个智能点餐助手。请根据以下菜品列表，结合用户的口味、预算和人数推荐菜品组合。\n");
        prompt.append("【规则】\n");
        prompt.append("1. 只能从以下菜品列表中推荐，不要编造列表中不存在的菜品。\n");
        prompt.append("2. 推荐的总价不能超过预算 × 人数。\n");
        prompt.append("3. 以JSON数组格式返回，每个元素包含 dishId（菜品ID）、reason（推荐理由）。\n");
        prompt.append("4. 至少推荐2道菜，最多推荐5道菜。\n");
        prompt.append("5. 返回格式示例：[{\"dishId\":1,\"reason\":\"麻辣鲜香，价格适中\"}]\n");
        prompt.append("6. 只返回JSON，不要包含其他文字。\n\n");
        prompt.append(dishContext).append("\n");
        prompt.append(String.format("【用户需求】口味:%s, 预算:人均%d元, 人数:%d人\n",
                taste != null ? taste : "不限", budget != null ? budget : 50, peopleCount != null ? peopleCount : 1));

        try {
            // 调用 DeepSeek API
            String result = callDeepSeek(prompt.toString());
            // 解析返回的JSON
            return parseRecommendResult(result, allDishes);
        } catch (Exception e) {
            // 异常降级
            return fallbackRecommend(allDishes, taste, budget, peopleCount);
        }
    }

    private String callDeepSeek(String prompt) throws Exception {
        java.net.URL url = new java.net.URL(apiUrl);
        java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", "Bearer " + apiKey);
        conn.setDoOutput(true);
        conn.setConnectTimeout(10000);
        conn.setReadTimeout(10000);

        String body = String.format(
                "{\"model\":\"%s\",\"messages\":[{\"role\":\"user\",\"content\":\"%s\"}],\"temperature\":0.7}",
                model, prompt.replace("\"", "\\\"").replace("\n", "\\n"));

        conn.getOutputStream().write(body.getBytes("UTF-8"));

        StringBuilder response = new StringBuilder();
        try (Scanner scanner = new Scanner(conn.getInputStream(), "UTF-8")) {
            while (scanner.hasNextLine()) {
                response.append(scanner.nextLine());
            }
        }

        // 简单解析 content
        String resp = response.toString();
        int contentStart = resp.indexOf("\"content\":\"");
        if (contentStart > 0) {
            contentStart += 11;
            int contentEnd = resp.indexOf("\"", contentStart);
            return resp.substring(contentStart, contentEnd).replace("\\n", "\n").replace("\\\"", "\"");
        }
        return "[]";
    }

    // 使用 TypeReference 消除未经检查的转换警告
    private List<Map<String, Object>> parseRecommendResult(String json, List<Dish> allDishes) {
        List<Map<String, Object>> result = new ArrayList<>();
        try {
            com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
            // 消除 -Xlint:unchecked 警告的安全解析方式
            List<Map<String, Object>> items = mapper.readValue(json, new com.fasterxml.jackson.core.type.TypeReference<List<Map<String, Object>>>() {});
            for (Map<String, Object> item : items) {
                Integer dishId = (Integer) item.get("dishId");
                String reason = (String) item.get("reason");
                Optional<Dish> dishOpt = allDishes.stream().filter(d -> d.getId().equals(Long.valueOf(dishId))).findFirst();
                if (dishOpt.isPresent()) {
                    Dish d = dishOpt.get();
                    Map<String, Object> m = new HashMap<>();
                    m.put("dishId", d.getId());
                    m.put("name", d.getName());
                    m.put("price", d.getPrice());
                    m.put("imageUrl", d.getImageUrl());
                    m.put("tasteTags", d.getTasteTags());
                    m.put("province", d.getProvince());
                    m.put("reason", reason);
                    result.add(m);
                }
            }
        } catch (Exception e) {
            return fallbackRecommend(allDishes, null, null, null);
        }
        if (result.isEmpty()) {
            return fallbackRecommend(allDishes, null, null, null);
        }
        return result;
    }

    @Override
    public String chat(String message, java.util.List<String> history) {
        String systemPrompt = buildSystemPrompt();
        if (apiKey == null || apiKey.isEmpty() || "sk-placeholder".equals(apiKey)) {
            return localFallback(message);
        }
        try {
            return callDeepSeekChat(message, history, systemPrompt);
        } catch (Exception e) {
            return localFallback(message);
        }
    }

    private String buildSystemPrompt() {
        StringBuilder sb = new StringBuilder();
        sb.append("你是一家餐厅的智能助手。餐厅信息如下：\n");
        // 【已修复语法错误】：直接调用上方定义的成员变量
        sb.append("名称：").append(restaurantName).append("\n");
        sb.append("地址：").append(restaurantAddress).append("\n");
        sb.append("电话：").append(restaurantPhone).append("\n");
        sb.append("营业时间：").append(restaurantHours).append("\n");
        sb.append("简介：").append(restaurantDescription).append("\n\n");
        sb.append("请根据以上信息回答顾客的问题。回答要热情友好，体现中华美食文化。");
        return sb.toString();
    }

    private String localFallback(String message) {
        String msg = message;
        if (msg.contains("营业") || msg.contains("时间") || msg.contains("几点")) {
            return "我们的营业时间是 " + restaurantHours + "。欢迎光临！";
        }
        if (msg.contains("地址") || msg.contains("位置") || msg.contains("在哪")) {
            return "我们的地址是 " + restaurantAddress + "。期待您的到来！";
        }
        if (msg.contains("电话") || msg.contains("联系") || msg.contains("手机")) {
            return "我们的联系电话是 " + restaurantPhone + "。随时欢迎来电咨询！";
        }
        if (msg.contains("菜品") || msg.contains("菜") || msg.contains("菜单") || msg.contains("推荐")) {
            java.util.List<Dish> dishes = dishMapper.selectList(null);
            StringBuilder sb = new StringBuilder("我们的菜品包括：\n");
            for (Dish d : dishes) {
                if (d.getStatus() == 1) {
                    sb.append("- ").append(d.getName()).append(" \u00a5").append(d.getPrice()).append("（").append(d.getProvince() != null ? d.getProvince() : "").append("）\n");
                }
            }
            sb.append("\n请问您想了解哪道菜？");
            return sb.toString();
        }
        return "您好！我是餐厅点餐与评价系统的AI助手。我可以回答关于营业时间、地址、联系电话、菜品信息等问题。您想了解什么？";
    }

    private String callDeepSeekChat(String message, java.util.List<String> history, String systemPrompt) throws Exception {
        java.net.URL url = new java.net.URL(apiUrl);
        java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", "Bearer " + apiKey);
        conn.setDoOutput(true);
        conn.setConnectTimeout(15000);
        conn.setReadTimeout(30000);

        java.util.List<java.util.Map<String, String>> messages = new java.util.ArrayList<>();
        java.util.Map<String, String> sysMsg = new java.util.HashMap<>();
        sysMsg.put("role", "system");
        sysMsg.put("content", systemPrompt);
        messages.add(sysMsg);
        if (history != null) {
            for (int i = 0; i < history.size() - 1; i += 2) {
                java.util.Map<String, String> userMsg = new java.util.HashMap<>();
                userMsg.put("role", "user");
                userMsg.put("content", history.get(i));
                messages.add(userMsg);

                java.util.Map<String, String> asstMsg = new java.util.HashMap<>();
                asstMsg.put("role", "assistant");
                asstMsg.put("content", history.get(i + 1));
                messages.add(asstMsg);
            }
        }
        java.util.Map<String, String> currentMsg = new java.util.HashMap<>();
        currentMsg.put("role", "user");
        currentMsg.put("content", message);
        messages.add(currentMsg);

        java.util.Map<String, Object> requestBody = new java.util.HashMap<>();
        requestBody.put("model", model);
        requestBody.put("messages", messages);
        requestBody.put("temperature", 0.7);

        com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
        String body = mapper.writeValueAsString(requestBody);

        conn.getOutputStream().write(body.getBytes("UTF-8"));

        StringBuilder response = new StringBuilder();
        try (java.util.Scanner scanner = new java.util.Scanner(conn.getInputStream(), "UTF-8")) {
            while (scanner.hasNextLine()) {
                response.append(scanner.nextLine());
            }
        }

        String resp = response.toString();
        try {
            com.fasterxml.jackson.databind.JsonNode root = mapper.readTree(resp);
            String text = root.get("choices").get(0).get("message").get("content").asText();
            return text;
        } catch (Exception e2) {
            int contentStart = resp.indexOf("\"content\":\"");
            if (contentStart > 0) {
                contentStart += 12;
                int contentEnd = resp.indexOf("\"", contentStart);
                if (contentEnd > contentStart) {
                    return resp.substring(contentStart, contentEnd).replace("\\n", "\n").replace("\\\"", "\"");
                }
            }
            return "对不起，暂时无法回答，请稍后再试。";
        }
    }

    private List<Map<String, Object>> fallbackRecommend(List<Dish> dishes, String taste, Integer budget, Integer peopleCount) {
        List<Map<String, Object>> result = new ArrayList<>();
        int maxTotal = (budget != null && peopleCount != null) ? budget * peopleCount : 200;
        int currentTotal = 0;
        Random rand = new Random();
        List<Dish> shuffled = new ArrayList<>(dishes);
        Collections.shuffle(shuffled, rand);

        for (Dish d : shuffled) {
            if (result.size() >= 4) break;
            int price = d.getPrice().intValue();
            if (currentTotal + price > maxTotal && !result.isEmpty()) continue;
            Map<String, Object> m = new HashMap<>();
            m.put("dishId", d.getId());
            m.put("name", d.getName());
            m.put("price", d.getPrice());
            m.put("imageUrl", d.getImageUrl());
            m.put("tasteTags", d.getTasteTags());
            m.put("province", d.getProvince());
            String reason = "推荐理由: ";
            if (taste != null && d.getTasteTags() != null && d.getTasteTags().contains(taste)) {
                reason += "口味符合您的需求";
            } else {
                reason += "人气菜品，广受好评";
            }
            m.put("reason", reason);
            result.add(m);
            currentTotal += price;
        }
        return result;
    }
}