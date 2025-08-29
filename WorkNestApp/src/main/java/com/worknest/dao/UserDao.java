package com.worknest.dao;

import com.worknest.model.User;

public interface UserDao {
    void save(User user);
    User findByEmail(String email);
}
