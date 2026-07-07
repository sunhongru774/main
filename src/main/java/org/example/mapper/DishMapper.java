package org.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.example.entity.Dish;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface DishMapper extends BaseMapper<Dish> {
    List<Dish> selectByProvince(@Param("province") String province);
    List<Dish> selectByCategoryId(@Param("categoryId") Long categoryId);
}
