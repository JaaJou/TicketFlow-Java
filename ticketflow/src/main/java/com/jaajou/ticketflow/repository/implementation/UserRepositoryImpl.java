package com.jaajou.ticketflow.repository.implementation;

import com.jaajou.ticketflow.entity.User;
import com.jaajou.ticketflow.repository.UserRepository;

import java.util.Collection;
import java.util.List;

public class UserRepositoryImpl implements UserRepository<User> {

    @Override
    public User create(User data) {
        return null;
    }

    @Override
    public Collection<User> list(int page, int pageSize) {
        return List.of();
    }

    @Override
    public User get(Long id) {
        return null;
    }

    @Override
    public User update(User data) {
        return null;
    }

    @Override
    public void delete(User data) {

    }

    @Override
    public Boolean delete(Long id) {
        return null;
    }
}
