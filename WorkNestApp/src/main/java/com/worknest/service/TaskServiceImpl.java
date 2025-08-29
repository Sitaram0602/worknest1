package com.worknest.service;

import com.worknest.dao.TaskDao;
import com.worknest.model.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class TaskServiceImpl implements TaskService {

    @Autowired
    private TaskDao taskDao;

    @Override
    public void save(Task task) {
        taskDao.save(task);
    }

    @Override
    public Task getTaskById(int id) {
        return taskDao.getById(id);
    }

    @Override
    public List<Task> getAllTasks() {
        return taskDao.getAll();
    }

    @Override
    public void deleteTask(int id) {
        taskDao.delete(id);
    }
}
