package com.worknest.service;

import com.worknest.model.Task;
import java.util.List;

public interface TaskService {
    void save(Task task);           // <-- Make sure this exists
    Task getTaskById(int id);
    List<Task> getAllTasks();
    void deleteTask(int id);
}
