package org.example.service.impl;

import org.example.entity.Notification;
import org.example.mapper.NotificationMapper;
import org.example.service.NotificationService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class NotificationServiceImpl implements NotificationService {
    @Autowired
    private NotificationMapper notificationMapper;

    @Override
    public List<Notification> listUnread(Long userId) {
        return notificationMapper.selectUnreadByUserId(userId);
    }

    @Override
    public List<Notification> listAll(Long userId) {
        LambdaQueryWrapper<Notification> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Notification::getUserId, userId).orderByDesc(Notification::getCreatedAt);
        return notificationMapper.selectList(wrapper);
    }

    @Override
    public void markAsRead(Long userId, Long notificationId) {
        Notification n = notificationMapper.selectById(notificationId);
        if (n != null && n.getUserId().equals(userId)) {
            n.setIsRead(1);
            notificationMapper.updateById(n);
        }
    }

    @Override
    public void markAllRead(Long userId) {
        List<Notification> list = listUnread(userId);
        for (Notification n : list) {
            n.setIsRead(1);
            notificationMapper.updateById(n);
        }
    }

    @Override
    public void create(Long userId, Long orderId, String title, String message) {
        Notification n = new Notification();
        n.setUserId(userId);
        n.setOrderId(orderId);
        n.setTitle(title);
        n.setMessage(message);
        n.setIsRead(0);
        notificationMapper.insert(n);
    }
}
