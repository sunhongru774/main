package org.example.controller;

import org.example.common.R;
import org.example.entity.*;
import org.example.mapper.*;
import org.example.service.NotificationService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.*;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    @Autowired private UserMapper userMapper;
    @Autowired private DishMapper dishMapper;
    @Autowired private OrderMapper orderMapper;
    @Autowired private OrderItemMapper orderItemMapper;
    @Autowired private NotificationService notificationService;

    private boolean checkAdmin(HttpSession session) {
        Integer role = (Integer) session.getAttribute("userRole");
        return role != null && role == 1;
    }

    // ========== 用户管理 ==========
    @GetMapping("/users")
    public R<List<User>> listUsers(HttpSession session) {
        if (!checkAdmin(session)) return R.forbidden("无权访问");
        List<User> users = userMapper.selectList(null);
        users.forEach(u -> u.setPassword(null));
        return R.success(users);
    }

    @PostMapping("/user/status")
    public R<Void> toggleUserStatus(@RequestBody User user, HttpSession session) {
        if (!checkAdmin(session)) return R.forbidden("无权访问");
        User u = userMapper.selectById(user.getId());
        if (u == null) return R.error(404, "用户不存在");
        u.setStatus(user.getStatus());
        userMapper.updateById(u);
        return R.success(null);
    }

    // ========== 菜品管理 ==========
    @GetMapping("/dishes")
    public R<List<Dish>> listDishes(HttpSession session) {
        if (!checkAdmin(session)) return R.forbidden("无权访问");
        return R.success(dishMapper.selectList(null));
    }

    @PostMapping("/dish/save")
    public R<Void> saveDish(@RequestBody Dish dish, HttpSession session) {
        if (!checkAdmin(session)) return R.forbidden("无权访问");
        if (dish.getId() == null) {
            dishMapper.insert(dish);
        } else {
            dishMapper.updateById(dish);
        }
        return R.success(null);
    }

    @PostMapping("/dish/delete")
    public R<Void> deleteDish(@RequestBody Dish dish, HttpSession session) {
        if (!checkAdmin(session)) return R.forbidden("无权访问");
        Dish d = dishMapper.selectById(dish.getId());
        if (d != null) {
            d.setStatus(0);
            dishMapper.updateById(d);
        }
        return R.success(null);
    }

    // ========== 订单管理(含用户信息) ==========
    @GetMapping("/orders")
    public R<List<Map<String, Object>>> listOrders(HttpSession session) {
        if (!checkAdmin(session)) return R.forbidden("无权访问");
        LambdaQueryWrapper<Order> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(Order::getCreatedAt);
        List<Order> orders = orderMapper.selectList(wrapper);
        List<Map<String, Object>> result = new ArrayList<>();
        for (Order o : orders) {
            Map<String, Object> m = new HashMap<>();
            m.put("order", o);
            User u = userMapper.selectById(o.getUserId());
            m.put("user", u != null ? u.getUsername() : "未知用户");
            m.put("nickname", u != null ? u.getNickname() : "");
            List<OrderItem> items = orderItemMapper.selectByOrderId(o.getId());
            m.put("items", items);
            result.add(m);
        }
        return R.success(result);
    }

    @PostMapping("/order/status")
    public R<Void> updateOrderStatus(@RequestBody Map<String, Object> params, HttpSession session) {
        if (!checkAdmin(session)) return R.forbidden("无权访问");
        Long orderId = Long.valueOf(params.get("id").toString());
        Integer status = Integer.valueOf(params.get("status").toString());
        Order o = orderMapper.selectById(orderId);
        if (o == null) return R.error(404, "订单不存在");
        o.setStatus(status);
        orderMapper.updateById(o);

        // 如果是"已上菜"状态(3)，发送通知
        if (status == 3) {
            notificationService.create(o.getUserId(), orderId, "🍽️ 上菜通知",
                    "您的订单(" + o.getOrderNo() + ")已上菜，祝您用餐愉快！");
        }

        return R.success(null);
    }

    // ========== 本月收益统计 ==========
    @GetMapping("/revenue")
    public R<Map<String, Object>> monthlyRevenue(HttpSession session) {
        if (!checkAdmin(session)) return R.forbidden("无权访问");
        // 本月已完成的订单(状态>=3 已上菜)
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime monthStart = now.withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0).withNano(0);
        LocalDateTime nextMonth = monthStart.plusMonths(1);

        LambdaQueryWrapper<Order> wrapper = new LambdaQueryWrapper<>();
        wrapper.ge(Order::getStatus, 3)
                .ge(Order::getCreatedAt, monthStart)
                .lt(Order::getCreatedAt, nextMonth);
        List<Order> orders = orderMapper.selectList(wrapper);

        double totalRevenue = orders.stream().mapToDouble(o -> o.getTotalPrice().doubleValue()).sum();
        int orderCount = orders.size();

        // 本月每日收益(用于图表)
        Map<String, Object> result = new HashMap<>();
        result.put("totalRevenue", totalRevenue);
        result.put("orderCount", orderCount);
        result.put("month", now.getMonthValue());
        result.put("year", now.getYear());

        return R.success(result);
    }

    // ========== 省份特色管理 ==========
    @GetMapping("/provinces")
    public R<List<ProvinceFeature>> listProvinces(HttpSession session) {
        if (!checkAdmin(session)) return R.forbidden("无权访问");
        return R.success(null); // placeholder
    }
}
