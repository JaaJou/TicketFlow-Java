package com.jaajou.ticketflow.repository;

import com.jaajou.ticketflow.entity.Role;
import java.util.List;
import java.util.Optional;

public interface RoleRepository {
    Role save(Role role);
    Optional<Role> findById(Long id);
    List<Role> findAll();
    void deleteById(Long id);
    Optional<Role> findByName(String name);
}
