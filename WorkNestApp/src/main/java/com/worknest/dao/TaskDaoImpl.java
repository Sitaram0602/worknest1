package com.worknest.dao;

import com.worknest.model.Task;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class TaskDaoImpl implements TaskDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Task task) {
        sessionFactory.getCurrentSession().saveOrUpdate(task);
    }

    @Override
    public Task getById(int id) {
        return sessionFactory.getCurrentSession().get(Task.class, id);
    }

    @Override
    public List<Task> getAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("from Task", Task.class)
                .list();
    }

    @Override
    public void delete(int id) {
        Task task = getById(id);
        if(task != null) {
            sessionFactory.getCurrentSession().delete(task);
        }
    }
}
