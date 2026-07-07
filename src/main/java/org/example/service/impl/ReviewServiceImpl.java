package org.example.service.impl;

import org.example.entity.Review;
import org.example.mapper.ReviewMapper;
import org.example.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
public class ReviewServiceImpl implements ReviewService {
    @Autowired
    private ReviewMapper reviewMapper;

    @Override
    public void add(Long userId, Long dishId, Long orderId, Integer rating, String content) {
        if (rating < 1 || rating > 5) throw new RuntimeException("评分范围为1-5");
        Review review = new Review();
        review.setUserId(userId);
        review.setDishId(dishId);
        review.setOrderId(orderId);
        review.setRating(rating);
        review.setContent(content);
        reviewMapper.insert(review);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> listByDish(Long dishId) {
        return (List<Map<String, Object>>)(Object)reviewMapper.selectByDishId(dishId);
    }
}
