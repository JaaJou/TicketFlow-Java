package com.jaajou.ticketflow.repository;

import com.jaajou.ticketflow.entity.UserRole;
import com.jaajou.ticketflow.entity.UserRoleId;
import java.util.List;
import java.util.Optional;


public interface UserRoleRepository {
    UserRole save(UserRole userRole);
    Optional<UserRole> findById(UserRoleId id);
    List<UserRole> findByUserId(long userId);
    void deleteById(UserRoleId id);
}
