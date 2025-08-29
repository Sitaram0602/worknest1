package com.worknest.controller;

import com.worknest.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/")  // Base path for all AuthController methods
public class AuthController {

    // Show registration form (GET /register)
    @GetMapping("register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());  // empty user form backing object
        return "register";  // resolves to /WEB-INF/views/register.jsp
    }

    // Process registration form (POST /register)
    @PostMapping("register")
    public String processRegister(@ModelAttribute("user") User user, Model model) {
        // TODO: Save the user to DB (e.g., userService.save(user))
        System.out.println("User Registered: " + user.getEmail());

        model.addAttribute("message", "Registration successful! Please login.");
        return "login";  // after register, show login page
    }

    // Show login form (GET /login)
    @GetMapping("login")
    public String showLoginForm() {
        return "login";  // resolves to /WEB-INF/views/login.jsp
    }

    // Process login form submission (POST /login)
    @PostMapping("login")
    public String processLogin(@RequestParam String email,
                               @RequestParam String password,
                               Model model) {
        // Dummy authentication check — replace with DB lookup in real app
        if ("admin@example.com".equals(email) && "1234".equals(password)) {
            return "user-dashboard";  // logged in successfully
        } else {
            model.addAttribute("error", "Invalid email or password");
            return "login";  // back to login page with error
        }
    }

    // Optional: Logout endpoint (GET /logout)
    @GetMapping("logout")
    public String logout(Model model) {
        // TODO: Invalidate session if using session-based auth
        model.addAttribute("message", "You have logged out successfully.");
        return "login";
    }
}
