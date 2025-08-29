package com.worknest.controller;

import com.worknest.model.Task;
import com.worknest.model.TaskComment;
import com.worknest.model.TaskStatus;
import com.worknest.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    private Integer currentUserId(HttpSession s) {
        Object id = s.getAttribute("userId");
        return id == null ? null : (Integer) id;
    }

    // Static Pages
    @GetMapping("/home")
    public String homePage() {
        return "home";
    }

    @GetMapping("/about")
    public String aboutPage() {
        return "about";
    }

    @GetMapping("/contact")
    public String contactPage() {
        return "contact";
    }

    // Show My Tasks
    @GetMapping("/tasks")
    public String myTasks(HttpSession s, Model model,
                          @RequestParam(value = "message", required = false) String message) {
        Integer uid = currentUserId(s);
        if (uid == null) return "redirect:/login";

        List<Task> tasks = userService.tasksForUser(uid);
        model.addAttribute("tasks", tasks);
        model.addAttribute("statuses", TaskStatus.values());

        if (message != null) {
            model.addAttribute("message", message);
        }

        return "user-tasks";
    }

    // Update Task Status
    @PostMapping("/tasks/{taskId}/status")
    public String updateStatus(@PathVariable Integer taskId,
                               @RequestParam("status") String status,
                               HttpSession s) {
        Integer uid = currentUserId(s);
        if (uid == null) return "redirect:/login";

        userService.updateStatus(taskId, TaskStatus.valueOf(status), uid);
        return "redirect:/user/tasks?message=Updated successfully!";
    }

    // Task Details
    @GetMapping("/tasks/{taskId}")
    public String taskDetails(@PathVariable Integer taskId, HttpSession s, Model model) {
        Integer uid = currentUserId(s);
        if (uid == null) return "redirect:/login";

        List<TaskComment> comments = userService.commentsForTask(taskId);
        model.addAttribute("taskId", taskId);
        model.addAttribute("comments", comments);
        return "task-details";
    }

    // Add Comment
    @PostMapping("/tasks/{taskId}/comments")
    public String addComment(@PathVariable Integer taskId,
                             @RequestParam String content,
                             HttpSession s) {
        Integer uid = currentUserId(s);
        if (uid == null) return "redirect:/login";

        userService.addComment(taskId, uid, content);
        return "redirect:/user/tasks/" + taskId;
    }
}