package com.worknest.controller;

import com.worknest.model.User;
import com.worknest.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    private final AuthService authService;

    @Autowired
    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @GetMapping("/register")
    public String showRegister(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String doRegister(@ModelAttribute("user") User user, Model model, HttpSession session) {
        if (authService.existsByUsername(user.getUsername())) {
            model.addAttribute("error", "Username already exists!");
            return "register";
        }

        authService.registerUser(user);

        // ✅ Store session for auto-login
        session.setAttribute("userId", user.getId());
        session.setAttribute("username", user.getUsername());
        session.setAttribute("role", user.getRole());

        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            // After registering as admin → go to admin add-users page
            return "redirect:/admin/users";
        } else {
            // After registering as user → go to login page
            model.addAttribute("success", "Registration successful. Please login.");
            return "login";
        }
    }

    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String username,
                          @RequestParam String password,
                          HttpSession session,
                          Model model) {
        User u = authService.login(username, password);
        if (u == null) {
            model.addAttribute("error", "Invalid username or password!");
            return "login";
        }
        session.setAttribute("userId", u.getId());
        session.setAttribute("username", u.getUsername());
        session.setAttribute("role", u.getRole());

        if ("ADMIN".equalsIgnoreCase(u.getRole())) {
            return "redirect:/admin/dashboard";
        }
        return "redirect:/user/tasks";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
   
}
