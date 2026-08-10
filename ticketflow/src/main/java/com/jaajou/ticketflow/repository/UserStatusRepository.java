package com.jaajou.ticketflow.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.jaajou.ticketflow.entity.UserStatus;

import java.util.Optional;

public interface UserStatusRepository extends JpaRepository<UserStatus, Long> {
    Optional<UserStatus> findByName(String name);
}
