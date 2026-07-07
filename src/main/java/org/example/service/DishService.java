package org.example.service;

import org.example.entity.Dish;
import java.util.List;

public interface DishService {
    Dish getById(Long id);
    List<Dish> listByProvince(String province);
    List<Dish> listByCategory(Long categoryId);
    List<Dish> listAll();
    List<Dish> listByIds(List<Long> ids);
    List<Dish> searchByName(String keyword);
}
