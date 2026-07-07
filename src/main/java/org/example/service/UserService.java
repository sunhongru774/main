package org.example.service;

import org.example.entity.User;
import org.example.dto.LoginDTO;
import org.example.dto.UserRegisterDTO;

public interface UserService {
    User login(LoginDTO dto);
    User register(UserRegisterDTO dto);
    User getById(Long id);
    void changePassword(Long userId, String oldPassword, String newPassword);
    void updateProfile(Long userId, String nickname, String phone);
}
