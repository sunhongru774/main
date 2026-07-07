package org.example.service;

import org.example.entity.Review;
import java.util.List;

public interface ReviewService {
    void add(Long userId, Long dishId, Long orderId, Integer rating, String content);
    List<Review> listByDish(Long dishId);
}
