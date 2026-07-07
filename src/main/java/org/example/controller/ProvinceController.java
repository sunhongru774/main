package org.example.controller;

import org.example.common.R;
import org.example.entity.ProvinceFeature;
import org.example.service.ProvinceFeatureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/province")
public class ProvinceController {
    @Autowired
    private ProvinceFeatureService provinceFeatureService;

    @GetMapping("/list")
    public R<List<ProvinceFeature>> list() {
        return R.success(provinceFeatureService.listAll());
    }

    @GetMapping("/{provinceName}")
    public R<ProvinceFeature> getByProvince(@PathVariable String provinceName) {
        ProvinceFeature pf = provinceFeatureService.getByProvinceName(provinceName);
        if (pf == null) return R.error(404, "省份信息不存在");
        return R.success(pf);
    }
}
