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

    private List<Map<String, Object>> parseRecommendResult(String json, List<Dish> allDishes) {
        List<Map<String, Object>> result = new ArrayList<>();
        try {
            com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
            List<Map<String, Object>> items = mapper.readValue(json, List.class);
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
