package org.example.service;

import org.example.entity.Cart;
import java.util.List;

public interface CartService {
    void add(Long userId, Long dishId, Integer quantity);
    void updateQuantity(Long userId, Long cartId, Integer quantity);
    void remove(Long userId, Long cartId);
    List<Cart> listByUser(Long userId);
    void clearByUser(Long userId);
}
