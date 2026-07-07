package org.example.controller;

import org.example.common.R;
import org.example.entity.Review;
import org.example.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/review")
public class ReviewController {
    @Autowired
    private ReviewService reviewService;

    @PostMapping("/add")
    public R<Void> add(@RequestBody Map<String, Object> params, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        Long dishId = Long.valueOf(params.get("dishId").toString());
        Long orderId = params.get("orderId") != null ? Long.valueOf(params.get("orderId").toString()) : null;
        Integer rating = Integer.valueOf(params.get("rating").toString());
        String content = (String) params.get("content");
        reviewService.add(userId, dishId, orderId, rating, content);
        return R.success("评价成功", null);
    }

    @GetMapping("/dish/{dishId}")
    public R<List<Review>> listByDish(@PathVariable Long dishId) {
        return R.success(reviewService.listByDish(dishId));
    }
}
