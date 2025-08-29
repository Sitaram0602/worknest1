package com.worknest.dao;

import com.worknest.model.Task;
import java.util.List;

public interface TaskDao {
    void save(Task task);
    Task getById(int id);
    List<Task> getAll();
    void delete(int id);
}
