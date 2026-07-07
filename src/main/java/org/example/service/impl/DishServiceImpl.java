package org.example.service.impl;

import org.example.entity.Dish;
import org.example.mapper.DishMapper;
import org.example.service.DishService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DishServiceImpl implements DishService {
    @Autowired
    private DishMapper dishMapper;

    @Override
    public Dish getById(Long id) {
        return dishMapper.selectById(id);
    }

    @Override
    public List<Dish> listByProvince(String province) {
        return dishMapper.selectByProvince(province);
    }

    @Override
    public List<Dish> listByCategory(Long categoryId) {
        return dishMapper.selectByCategoryId(categoryId);
    }

    @Override
    public List<Dish> listAll() {
        LambdaQueryWrapper<Dish> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Dish::getStatus, 1).orderByDesc(Dish::getSalesCount);
        return dishMapper.selectList(wrapper);
    }

    @Override
    public List<Dish> listByIds(List<Long> ids) {
        return dishMapper.selectBatchIds(ids);
    }
}
