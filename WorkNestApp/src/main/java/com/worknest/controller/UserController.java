package com.worknest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {

    @GetMapping("/dashboard")
    public String userDashboard() {
        System.out.println("User dashboard controller called");
        return "user-dashboard";
    }

    @GetMapping("/tasks")
    public String userTasks() {
        System.out.println("User tasks controller called");
        return "user-tasks";
    }
}
