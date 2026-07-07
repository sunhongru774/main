package org.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.example.entity.DishCategory;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DishCategoryMapper extends BaseMapper<DishCategory> {
}
