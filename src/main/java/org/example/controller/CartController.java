package org.example.controller;

import org.example.common.R;
import org.example.entity.Cart;
import org.example.entity.Dish;
import org.example.service.CartService;
import org.example.service.DishService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/cart")
public class CartController {
    @Autowired
    private CartService cartService;
    @Autowired
    private DishService dishService;

    @GetMapping("/list")
    public R<List<Map<String, Object>>> list(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        List<Cart> cartList = cartService.listByUser(userId);
        List<Map<String, Object>> result = new ArrayList<>();
        for (Cart item : cartList) {
            Dish dish = dishService.getById(item.getDishId());
            if (dish == null) continue;
            Map<String, Object> map = new HashMap<>();
            map.put("cartId", item.getId());
            map.put("dishId", dish.getId());
            map.put("dishName", dish.getName());
            map.put("imageUrl", dish.getImageUrl());
            map.put("price", dish.getPrice());
            map.put("quantity", item.getQuantity());
            map.put("subtotal", dish.getPrice().multiply(new java.math.BigDecimal(item.getQuantity())));
            result.add(map);
        }
        return R.success(result);
    }

    @PostMapping("/add")
    public R<Void> add(@RequestBody Map<String, Object> params, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        Long dishId = Long.valueOf(params.get("dishId").toString());
        Integer quantity = params.get("quantity") != null ? Integer.valueOf(params.get("quantity").toString()) : 1;
        cartService.add(userId, dishId, quantity);
        return R.success("已加入购物车", null);
    }

    @PostMapping("/update")
    public R<Void> update(@RequestBody Map<String, Object> params, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        Long cartId = Long.valueOf(params.get("cartId").toString());
        Integer quantity = Integer.valueOf(params.get("quantity").toString());
        cartService.updateQuantity(userId, cartId, quantity);
        return R.success(null);
    }

    @PostMapping("/remove")
    public R<Void> remove(@RequestBody Map<String, Object> params, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        Long cartId = Long.valueOf(params.get("cartId").toString());
        cartService.remove(userId, cartId);
        return R.success(null);
    }
}
