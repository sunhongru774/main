package org.example.controller;

import org.example.common.R;
import org.example.entity.Dish;
import org.example.entity.DishCategory;
import org.example.service.DishService;
import org.example.mapper.DishCategoryMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/dish")
public class DishController {
    @Autowired
    private DishService dishService;
    @Autowired
    private DishCategoryMapper categoryMapper;

    @GetMapping("/list")
    public R<List<Dish>> list(@RequestParam(required = false) String province,
                              @RequestParam(required = false) Long categoryId) {
        if (province != null && !province.isEmpty()) {
            return R.success(dishService.listByProvince(province));
        }
        if (categoryId != null) {
            return R.success(dishService.listByCategory(categoryId));
        }
        return R.success(dishService.listAll());
    }

    @GetMapping("/{id}")
    public R<Dish> getById(@PathVariable Long id) {
        Dish dish = dishService.getById(id);
        if (dish == null) return R.error(404, "菜品不存在");
        return R.success(dish);
    }

    @GetMapping("/category/list")
    public R<List<DishCategory>> categoryList() {
        LambdaQueryWrapper<DishCategory> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DishCategory::getStatus, 1).orderByAsc(DishCategory::getSortOrder);
        return R.success(categoryMapper.selectList(wrapper));
    }
}
