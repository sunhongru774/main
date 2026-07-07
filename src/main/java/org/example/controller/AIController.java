package org.example.controller;

import org.example.common.R;
import org.example.dto.AIRecommendDTO;
import org.example.service.AIRecommendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/ai")
public class AIController {
    @Autowired
    private AIRecommendService aiRecommendService;

    @PostMapping("/recommend")
    public R<List<Map<String, Object>>> recommend(@RequestBody AIRecommendDTO dto) {
        List<Map<String, Object>> result = aiRecommendService.recommend(
                dto.getTaste(), dto.getBudget(), dto.getPeopleCount(), dto.getProvince());
        return R.success(result);
    }
}
