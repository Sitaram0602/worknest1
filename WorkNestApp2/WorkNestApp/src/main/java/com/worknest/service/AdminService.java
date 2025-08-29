package com.worknest.service;

import com.worknest.dao.CommentDao;
import com.worknest.dao.TaskDao;
import com.worknest.dao.UserDao;
import com.worknest.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.time.LocalDate;
import java.util.EnumMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Transactional
public class AdminService {

    private final UserDao userDao;
    private final TaskDao taskDao;
    private final CommentDao commentDao;

    @PersistenceContext
    private EntityManager em;

    @Autowired
    public AdminService(UserDao userDao, TaskDao taskDao, CommentDao commentDao) {
        this.userDao = userDao;
        this.taskDao = taskDao;
        this.commentDao = commentDao;
    }

    // ================= USERS =================
    public List<User> listUsers() {
        return userDao.findAll();
    }

    public List<User> listNonAdminUsers() {
        return userDao.findAll().stream()
                .filter(u -> !"ADMIN".equalsIgnoreCase(u.getRole()))
                .collect(Collectors.toList());
    }

    public void addUser(User user) {
        userDao.save(user);
    }

    /**
     * Safely delete a user:
     * 1) Unassign tasks assigned to this user
     * 2) Remove all entries from task_assignees join table
     * 3) Delete the user
     */
    public void deleteUser(Integer id) {
        User u = userDao.findById(id);
        if (u == null) return;

        // 1) Unassign tasks assigned to this user (if tasks have assignee_id column)
        List<Task> assignedTasks = taskDao.findByAssignee(u);
        if (assignedTasks != null && !assignedTasks.isEmpty()) {
            for (Task t : assignedTasks) {
                t.setAssignee(null);       // unassign user
                taskDao.update(t);         // persist change
            }
        }

        // 2) Remove any references from task_assignees join table (if exists)
        em.createNativeQuery("DELETE FROM task_assignees WHERE user_id = :uid")
          .setParameter("uid", u.getId())
          .executeUpdate();

        // 3) Delete the user
        userDao.delete(id);
    }

    // ================= TASKS =================
    public void createTask(String title, String description, LocalDate start, LocalDate due, Integer assigneeId) {
        User assignee = userDao.findById(assigneeId);
        Task t = new Task();
        t.setTitle(title);
        t.setDescription(description);
        t.setStartDate(start);
        t.setDueDate(due);
        t.setAssignee(assignee);
        t.setStatus(TaskStatus.PENDING);
        taskDao.save(t);
    }

    public Map<TaskStatus, Long> getStatusCounts() {
        Map<TaskStatus, Long> map = new EnumMap<>(TaskStatus.class);
        for (TaskStatus s : TaskStatus.values()) {
            map.put(s, taskDao.countByStatus(s));
        }
        return map;
    }

    @Transactional(readOnly = true)
    public List<Task> listAllTasks() {
        return em.createQuery(
                "SELECT DISTINCT t FROM Task t " +
                "LEFT JOIN FETCH t.assignee " +
                "ORDER BY t.id ASC",
                Task.class
        ).getResultList();
    }

    @Transactional
    public boolean updateTaskStatus(Integer taskId, TaskStatus newStatus) {
        Task task = taskDao.findById(taskId);
        if (task == null) return false;

        task.setStatus(newStatus);
        taskDao.update(task);
        return true;
    }

    // ================= COMMENTS =================
    @Transactional(readOnly = true)
    public List<TaskComment> getCommentsForTask(Integer taskId) {
        return em.createQuery(
                "SELECT c FROM TaskComment c " +
                "LEFT JOIN FETCH c.author " +
                "WHERE c.task.id = :taskId " +
                "ORDER BY c.createdAt DESC",
                TaskComment.class
        )
        .setParameter("taskId", taskId)
        .getResultList();
    }
}
