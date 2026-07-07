package org.example.service.impl;

import org.example.entity.ProvinceFeature;
import org.example.mapper.ProvinceFeatureMapper;
import org.example.service.ProvinceFeatureService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProvinceFeatureServiceImpl implements ProvinceFeatureService {
    @Autowired
    private ProvinceFeatureMapper provinceFeatureMapper;

    @Override
    public List<ProvinceFeature> listAll() {
        LambdaQueryWrapper<ProvinceFeature> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ProvinceFeature::getStatus, 1).orderByAsc(ProvinceFeature::getSortOrder);
        return provinceFeatureMapper.selectList(wrapper);
    }

    @Override
    public ProvinceFeature getByProvinceName(String provinceName) {
        LambdaQueryWrapper<ProvinceFeature> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ProvinceFeature::getProvinceName, provinceName);
        return provinceFeatureMapper.selectOne(wrapper);
    }
}
