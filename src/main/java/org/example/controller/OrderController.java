package org.example.controller;

import org.example.common.R;
import org.example.entity.Order;
import org.example.entity.OrderItem;
import org.example.mapper.OrderItemMapper;
import org.example.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/order")
public class OrderController {
    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderItemMapper orderItemMapper;

    @PostMapping("/create")
    public R<Order> create(@RequestBody(required = false) Map<String, String> params, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        String remark = params != null ? params.get("remark") : null;
        Order order = orderService.createOrder(userId, remark);
        return R.success("下单成功", order);
    }

    @GetMapping("/list")
    public R<List<Order>> list(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        return R.success(orderService.listByUser(userId));
    }

    @GetMapping("/{id}")
    public R<Map<String, Object>> detail(@PathVariable Long id, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        Order order = orderService.getById(userId, id);
        if (order == null) return R.error(404, "订单不存在");
        List<OrderItem> items = orderItemMapper.selectByOrderId(id);
        Map<String, Object> result = new HashMap<>();
        result.put("order", order);
        result.put("items", items);
        return R.success(result);
    }

    @PostMapping("/status")
    public R<Void> updateStatus(@RequestBody Map<String, Object> params, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        Long orderId = Long.valueOf(params.get("orderId").toString());
        Integer status = Integer.valueOf(params.get("status").toString());
        orderService.updateStatus(userId, orderId, status);
        return R.success(null);
    }
}
