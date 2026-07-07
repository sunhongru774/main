package org.example.controller;

import org.example.common.R;
import org.example.entity.Notification;
import org.example.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/notification")
public class NotificationController {
    @Autowired
    private NotificationService notificationService;

    @GetMapping("/unread")
    public R<List<Notification>> unread(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        return R.success(notificationService.listUnread(userId));
    }

    @GetMapping("/list")
    public R<List<Notification>> list(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        return R.success(notificationService.listAll(userId));
    }

    @PostMapping("/read")
    public R<Void> read(@RequestBody Map<String, Object> params, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        Object id = params.get("id");
        if (id != null) {
            notificationService.markAsRead(userId, Long.valueOf(id.toString()));
        } else {
            notificationService.markAllRead(userId);
        }
        return R.success(null);
    }
}
