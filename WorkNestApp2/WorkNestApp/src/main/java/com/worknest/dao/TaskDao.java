package com.worknest.dao;

import com.worknest.model.Task;
import com.worknest.model.TaskStatus;
import com.worknest.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TaskDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session session() {
        return sessionFactory.getCurrentSession();
    }

    public void save(Task t) {
        session().save(t);
    }

    // Use merge to handle detached entities cleanly
    public void update(Task t) {
        session().merge(t);
    }

    // ✅ Fetch join to avoid LazyInitializationException on assignee
    public Task findById(Integer id) {
        return session().createQuery(
                "SELECT t FROM Task t " +
                "LEFT JOIN FETCH t.assignee " +
                "WHERE t.id = :id",
                Task.class
        ).setParameter("id", id)
         .uniqueResult();
    }

    // ✅ Fetch join to load tasks + their assignees
    public List<Task> findAll() {
        return session().createQuery(
                "SELECT DISTINCT t FROM Task t " +
                "LEFT JOIN FETCH t.assignee " +
                "ORDER BY t.id ASC",
                Task.class
        ).list();
    }

    public List<Task> findByAssignee(User u) {
        return session().createQuery(
                "SELECT DISTINCT t FROM Task t " +
                "LEFT JOIN FETCH t.assignee " +
                "WHERE t.assignee = :u",
                Task.class
        ).setParameter("u", u)
         .list();
    }

    public long countByStatus(TaskStatus status) {
        return session().createQuery(
                "SELECT COUNT(t) FROM Task t WHERE t.status = :status",
                Long.class
        ).setParameter("status", status)
         .getSingleResult();
    }
}
