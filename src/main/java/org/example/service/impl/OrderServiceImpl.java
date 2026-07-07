package org.example.service.impl;

import org.example.entity.*;
import org.example.mapper.*;
import org.example.service.OrderService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private OrderItemMapper orderItemMapper;
    @Autowired
    private CartMapper cartMapper;
    @Autowired
    private CartServiceImpl cartService;
    @Autowired
    private DishMapper dishMapper;

    private synchronized String generateOrderNo() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"))
                + String.format("%04d", new Random().nextInt(10000));
    }

    @Override
    @Transactional
    public Order createOrder(Long userId, String remark) {
        List<Cart> cartList = cartMapper.selectByUserId(userId);
        if (cartList.isEmpty()) {
            throw new RuntimeException("购物车为空，无法下单");
        }
        BigDecimal total = BigDecimal.ZERO;
        for (Cart item : cartList) {
            Dish dish = dishMapper.selectById(item.getDishId());
            if (dish == null || dish.getStatus() == 0) {
                throw new RuntimeException("菜品【" + (dish != null ? dish.getName() : "未知") + "】已下架");
            }
            total = total.add(dish.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
        }
        Order order = new Order();
        order.setOrderNo(generateOrderNo());
        order.setUserId(userId);
        order.setTotalPrice(total);
        order.setStatus(0);
        order.setRemark(remark);
        orderMapper.insert(order);
        for (Cart item : cartList) {
            Dish dish = dishMapper.selectById(item.getDishId());
            OrderItem oi = new OrderItem();
            oi.setOrderId(order.getId());
            oi.setDishId(item.getDishId());
            oi.setDishName(dish.getName());
            oi.setDishImage(dish.getImageUrl());
            oi.setPrice(dish.getPrice());
            oi.setQuantity(item.getQuantity());
            oi.setSubtotal(dish.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
            orderItemMapper.insert(oi);
            dish.setSalesCount(dish.getSalesCount() + item.getQuantity());
            dishMapper.updateById(dish);
        }
        cartService.clearByUser(userId);
        return order;
    }

    @Override
    public Order getById(Long userId, Long orderId) {
        Order order = orderMapper.selectById(orderId);
        if (order == null || !order.getUserId().equals(userId)) {
            return null;
        }
        return order;
    }

    @Override
    public List<Order> listByUser(Long userId) {
        return orderMapper.selectByUserId(userId);
    }

    @Override
    @Transactional
    public void updateStatus(Long userId, Long orderId, Integer status) {
        Order order = orderMapper.selectById(orderId);
        if (order == null) throw new RuntimeException("订单不存在");
        boolean isAdmin = false;
        if (userId != null && !order.getUserId().equals(userId)) {
            isAdmin = true;
        }
        order.setStatus(status);
        orderMapper.updateById(order);
    }
}
