package com.worknest.service;

import com.worknest.model.User;

public interface UserService {
    void saveUser(User user);
    User findByEmail(String email);
}
