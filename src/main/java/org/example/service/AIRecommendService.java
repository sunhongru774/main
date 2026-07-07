package org.example.service;

import java.util.List;
import java.util.Map;

public interface AIRecommendService {
    List<Map<String, Object>> recommend(String taste, Integer budget, Integer peopleCount, String province);
    String chat(String message, java.util.List<String> history);
}
