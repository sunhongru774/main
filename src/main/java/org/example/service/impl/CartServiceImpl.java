package org.example.service.impl;

import org.example.entity.Cart;
import org.example.mapper.CartMapper;
import org.example.service.CartService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class CartServiceImpl implements CartService {
    @Autowired
    private CartMapper cartMapper;

    @Override
    @Transactional
    public void add(Long userId, Long dishId, Integer quantity) {
        LambdaQueryWrapper<Cart> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Cart::getUserId, userId).eq(Cart::getDishId, dishId);
        Cart existing = cartMapper.selectOne(wrapper);
        if (existing != null) {
            existing.setQuantity(existing.getQuantity() + quantity);
            cartMapper.updateById(existing);
        } else {
            Cart cart = new Cart();
            cart.setUserId(userId);
            cart.setDishId(dishId);
            cart.setQuantity(quantity);
            cartMapper.insert(cart);
        }
    }

    @Override
    @Transactional
    public void updateQuantity(Long userId, Long cartId, Integer quantity) {
        Cart cart = cartMapper.selectById(cartId);
        if (cart == null || !cart.getUserId().equals(userId)) {
            throw new RuntimeException("购物车记录不存在");
        }
        if (quantity <= 0) {
            cartMapper.deleteById(cartId);
        } else {
            cart.setQuantity(quantity);
            cartMapper.updateById(cart);
        }
    }

    @Override
    @Transactional
    public void remove(Long userId, Long cartId) {
        Cart cart = cartMapper.selectById(cartId);
        if (cart != null && cart.getUserId().equals(userId)) {
            cartMapper.deleteById(cartId);
        }
    }

    @Override
    public List<Cart> listByUser(Long userId) {
        return cartMapper.selectByUserId(userId);
    }

    @Override
    @Transactional
    public void clearByUser(Long userId) {
        LambdaQueryWrapper<Cart> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Cart::getUserId, userId);
        cartMapper.delete(wrapper);
    }
}
