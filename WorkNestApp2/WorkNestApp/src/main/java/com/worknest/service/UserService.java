package com.worknest.service;

import com.worknest.dao.CommentDao;
import com.worknest.dao.TaskDao;
import com.worknest.dao.UserDao;
import com.worknest.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserService {

    private final TaskDao taskDao;
    private final UserDao userDao;
    private final CommentDao commentDao;

    @Autowired
    public UserService(TaskDao taskDao, UserDao userDao, CommentDao commentDao) {
        this.taskDao = taskDao;
        this.userDao = userDao;
        this.commentDao = commentDao;
    }

    @Transactional(readOnly = true)
    public List<Task> tasksForUser(Integer userId) {
        User u = userDao.findById(userId);
        return taskDao.findByAssignee(u);
    }

    @Transactional
    public void updateStatus(Integer taskId, TaskStatus status, Integer userId) {
        Task t = taskDao.findById(taskId);
        if (t != null && t.getAssignee() != null && t.getAssignee().getId().equals(userId)) {
            t.setStatus(status);
            taskDao.update(t);
        }
    }

    @Transactional
    public void addComment(Integer taskId, Integer authorId, String content) {
        Task t = taskDao.findById(taskId);
        User a = userDao.findById(authorId);

        TaskComment c = new TaskComment();
        c.setTask(t);
        c.setAuthor(a);
        c.setContent(content);

        commentDao.add(c);
    }

    @Transactional(readOnly = true)
    public List<TaskComment> commentsForTask(Integer taskId) {
        Task t = taskDao.findById(taskId);
        return commentDao.findByTask(t);
    }
}
