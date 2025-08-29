package com.worknest.controller;

import com.worknest.model.Task;
import com.worknest.model.TaskStatus;
import com.worknest.model.User;
import com.worknest.service.AdminService;
import com.worknest.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;
    private final AuthService authService;

    @Autowired
    public AdminController(AdminService adminService, AuthService authService) {
        this.adminService = adminService;
        this.authService = authService;
    }

    private boolean isAdmin(HttpSession s) {
        Object role = s.getAttribute("role");
        return role != null && "ADMIN".equals(role.toString());
    }

    // ================= Dashboard =================
    @GetMapping("/dashboard")
    public String dashboard(HttpSession s, Model model) {
        if (!isAdmin(s)) return "redirect:/login";

        Map<TaskStatus, Long> enumCounts = adminService.getStatusCounts();

        Map<String, Long> counts = new LinkedHashMap<>();
        counts.put("PENDING", enumCounts.getOrDefault(TaskStatus.PENDING, 0L));
        counts.put("IN_PROGRESS", enumCounts.getOrDefault(TaskStatus.IN_PROGRESS, 0L));
        counts.put("COMPLETED", enumCounts.getOrDefault(TaskStatus.COMPLETED, 0L));
        counts.put("DELAYED", enumCounts.getOrDefault(TaskStatus.DELAYED, 0L));

        List<Task> tasks = adminService.listAllTasks();

        model.addAttribute("counts", counts);
        model.addAttribute("tasks", tasks);
        return "admin-dashboard"; // JSP page
    }

    // ================= Users =================
    @GetMapping("/users")
    public String users(HttpSession s, Model model) {
        if (!isAdmin(s)) return "redirect:/login";
        model.addAttribute("users", adminService.listUsers());
        model.addAttribute("newUser", new User());
        return "admin-users"; // JSP page
    }

    @PostMapping("/users")
    public String addUser(@ModelAttribute("newUser") User user, HttpSession s, Model model) {
        if (!isAdmin(s)) return "redirect:/login";

        if (user.getPassword() == null || user.getPassword().isEmpty()) {
            model.addAttribute("error", "Password required");
            model.addAttribute("users", adminService.listUsers());
            return "admin-users";
        }

        if (authService.existsByUsername(user.getUsername())) {
            model.addAttribute("error", "Username already exists");
            model.addAttribute("users", adminService.listUsers());
            return "admin-users";
        }

        authService.registerUser(user);
        model.addAttribute("successMessage", "User added successfully!");
        return "redirect:/admin/users";
    }

    @PostMapping("/users/{id}/delete")
    public String deleteUser(@PathVariable Integer id, HttpSession s, RedirectAttributes redirectAttributes) {
        if (!isAdmin(s)) return "redirect:/login";
        adminService.deleteUser(id);
        redirectAttributes.addFlashAttribute("successMessage", "User deleted successfully!");
        return "redirect:/admin/users";
    }

    // ================= Tasks =================
    @GetMapping("/tasks/new")
    public String newTask(HttpSession s, Model model) {
        if (!isAdmin(s)) return "redirect:/login";
        model.addAttribute("users", adminService.listNonAdminUsers());
        return "task-form";
    }

    @PostMapping("/tasks")
    public String createTask(@RequestParam String title,
                             @RequestParam(required = false) String description,
                             @RequestParam String startDate,
                             @RequestParam String dueDate,
                             @RequestParam Integer assigneeId,
                             HttpSession s,
                             RedirectAttributes redirectAttributes) {
        if (!isAdmin(s)) return "redirect:/login";

        adminService.createTask(
                title,
                description,
                LocalDate.parse(startDate),
                LocalDate.parse(dueDate),
                assigneeId
        );

        redirectAttributes.addFlashAttribute("successMessage", "Task created successfully!");
        return "redirect:/admin/dashboard";
    }

    @PostMapping("/tasks/{taskId}/status")
    public String updateTaskStatus(@PathVariable Integer taskId,
                                   @RequestParam("status") TaskStatus status,
                                   HttpSession s,
                                   RedirectAttributes redirectAttributes) {
        if (!isAdmin(s)) return "redirect:/login";

        boolean updated = adminService.updateTaskStatus(taskId, status);
        if (updated) {
            redirectAttributes.addFlashAttribute("successMessage", "Task status updated successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update task status!");
        }
        return "redirect:/admin/dashboard";
    }

    // ================= Comments =================
    @GetMapping("/tasks/{taskId}/comments")
    public String viewComments(@PathVariable Integer taskId, HttpSession s, Model model) {
        if (!isAdmin(s)) return "redirect:/login";
        model.addAttribute("comments", adminService.getCommentsForTask(taskId));
        return "admin-task-comments";
    }
}
