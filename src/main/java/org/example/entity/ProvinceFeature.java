package org.example.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("province_feature")
public class ProvinceFeature {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String provinceName;
    private String cuisineName;
    private String description;
    private String previewImage;
    private String recommendDishIds;
    private Integer status;
    private Integer sortOrder;
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedAt;
}
