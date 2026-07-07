package org.example.service;

import org.example.entity.Order;
import java.util.List;

public interface OrderService {
    Order createOrder(Long userId, String remark);
    Order getById(Long userId, Long orderId);
    List<Order> listByUser(Long userId);
    void updateStatus(Long userId, Long orderId, Integer status);
}
