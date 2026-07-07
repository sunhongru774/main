//package org.example.entity;
//
//import com.baomidou.mybatisplus.annotation.*;
//import lombok.Data;
//import java.math.BigDecimal;
//import java.time.LocalDateTime;
//
//@Data
//@TableName("dish")
//public class Dish {
//    @TableId(type = IdType.AUTO)
//    private Long id;
//    private String name;
//    private String description;
//    private BigDecimal price;
//    private String imageUrl;
//    private Long categoryId;
//    private String province;
//    private String tasteTags;
//    private String sideDishes;
//    private Integer stock;
//    private Integer status;
//    private Integer salesCount;
//    @TableField(fill = FieldFill.INSERT)
//    private LocalDateTime createdAt;
//    @TableField(fill = FieldFill.INSERT_UPDATE)
//    private LocalDateTime updatedAt;
//}
package org.example.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("dish")
public class Dish {
    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;
    private String description;
    private BigDecimal price;

    // 【核心修复】：显式绑定数据库中的下划线列名，绝对不会再返回 null！
    @TableField("image_url")
    private String imageUrl;

    @TableField("category_id")
    private Long categoryId;

    private String province;

    @TableField("taste_tags")
    private String tasteTags;

    @TableField("side_dishes")
    private String sideDishes;

    private Integer stock;
    private Integer status;

    @TableField("sales_count")
    private Integer salesCount;

    @TableField(value = "created_at", fill = FieldFill.INSERT)
    private LocalDateTime createdAt;

    @TableField(value = "updated_at", fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedAt;
}