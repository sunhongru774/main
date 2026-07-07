package org.example.service;

import org.example.entity.Notification;
import java.util.List;

public interface NotificationService {
    List<Notification> listUnread(Long userId);
    List<Notification> listAll(Long userId);
    void markAsRead(Long userId, Long notificationId);
    void markAllRead(Long userId);
    void create(Long userId, Long orderId, String title, String message);
}
