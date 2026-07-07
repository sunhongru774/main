package org.example.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("notification")
public class Notification {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private Long orderId;
    private String title;
    private String message;
    private Integer isRead;
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
}
