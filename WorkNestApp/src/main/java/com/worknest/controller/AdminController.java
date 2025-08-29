package com.worknest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

    // Admin Dashboard page
    @GetMapping("/admin-dashboard")
    public String adminDashboard() {
        return "admin-dashboard"; // resolves to /WEB-INF/views/admin-dashboard.jsp
    }

    // Admin Users page
    @GetMapping("/admin-users")
    public String adminUsers(Model model) {
        // For now, dummy data or empty, later add user list
        // model.addAttribute("users", userService.getAllUsers());
        return "admin-users";  // resolves to /WEB-INF/views/admin-users.jsp
    }

    // Admin Comments page
    @GetMapping("/admin-task-comments")
    public String adminComments(Model model) {
        // For now, dummy data or empty, later add comments list
        // model.addAttribute("comments", commentService.getAllComments());
        return "admin-task-comments";  // resolves to /WEB-INF/views/admin-task-comments.jsp
    }
}
