package com.worknest.controller;

import com.worknest.model.Task;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/tasks")  // Base URL for tasks
public class TaskController {

    // Show task form at /tasks/task-form
    @GetMapping("/task-form")
    public String showTaskForm(Model model) {
        model.addAttribute("task", new Task());  // empty Task object for the form
        return "task-form";  // JSP view name (task-form.jsp)
    }

    // Handle form submission at /tasks/save
    @PostMapping("/save")
    public String saveTask(@ModelAttribute Task task) {
        // Print to console for now (replace with your save logic)
        System.out.println("Saving task: " + task);

        // After saving, redirect back to form or list page
        return "redirect:/tasks/task-form";
    }
    @GetMapping("/task-details")
    public String taskDetails(Model model) {
        // You can add attributes to the model here if needed
        // model.addAttribute("someData", someValue);
        return "task-details";  // this should correspond to task-details.jsp inside /WEB-INF/views/
    }

}
