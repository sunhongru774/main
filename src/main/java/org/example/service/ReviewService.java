package org.example.service;

import org.example.entity.Review;
import java.util.List;
import java.util.Map;

public interface ReviewService {
    void add(Long userId, Long dishId, Long orderId, Integer rating, String content);
    List<Map<String, Object>> listByDish(Long dishId);
}
