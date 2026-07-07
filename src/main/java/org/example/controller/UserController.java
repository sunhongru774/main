package org.example.controller;

import org.example.common.R;
import org.example.dto.LoginDTO;
import org.example.dto.UserRegisterDTO;
import org.example.entity.User;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/user")
public class UserController {
    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public R<User> login(@RequestBody LoginDTO dto, HttpSession session) {
        User user = userService.login(dto);
        session.setAttribute("userId", user.getId());
        session.setAttribute("userRole", user.getRole());
        return R.success(user);
    }

    @PostMapping("/register")
    public R<User> register(@RequestBody UserRegisterDTO dto) {
        return R.success("注册成功", userService.register(dto));
    }

    @GetMapping("/logout")
    public R<Void> logout(HttpSession session) {
        session.invalidate();
        return R.success(null);
    }

    @GetMapping("/current")
    public R<?> current(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("未登录");
        User user = userService.getById(userId);
        return R.success(user);
    }

    @PostMapping("/update")
    public R<Void> updateProfile(@RequestBody java.util.Map<String, String> params, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        String nickname = params.get("nickname");
        String phone = params.get("phone");
        try {
            userService.updateProfile(userId, nickname, phone);
            return R.success(null);
        } catch (RuntimeException e) {
            return R.error(400, e.getMessage());
        }
    }

    @PostMapping("/change-password")
    public R<Void> changePassword(@RequestBody java.util.Map<String, String> params, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return R.unauthorized("请先登录");
        String oldPassword = params.get("oldPassword");
        String newPassword = params.get("newPassword");
        if (oldPassword == null || newPassword == null || newPassword.length() < 6) {
            return R.error(400, "密码至少需要6位");
        }
        try {
            userService.changePassword(userId, oldPassword, newPassword);
            return R.success(null);
        } catch (RuntimeException e) {
            return R.error(400, e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public R<User> getById(@PathVariable Long id) {
        return R.success(userService.getById(id));
    }
}
