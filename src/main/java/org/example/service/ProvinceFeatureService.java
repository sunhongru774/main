package org.example.service;

import org.example.entity.ProvinceFeature;
import java.util.List;

public interface ProvinceFeatureService {
    List<ProvinceFeature> listAll();
    ProvinceFeature getByProvinceName(String provinceName);
}
