package com.jaajou.ticketflow.service;

import com.jaajou.ticketflow.entity.User;

import java.util.List;

public interface UserService {
    User createUser(String firstName, String lastName, String email, String password, String phone, String profilePictureUrl);
    User getUserById(Long id);
    List<User> getAllUsers();
    User updateUser(Long id, String firstName, String lastName, String email, String phone, String profilePictureUrl);
    void deleteUser(Long id);
    User assignRole(Long userId, String roleName);
}
