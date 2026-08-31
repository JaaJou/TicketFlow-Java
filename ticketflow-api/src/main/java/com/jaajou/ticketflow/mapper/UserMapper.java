package com.jaajou.ticketflow.mapper;

import com.jaajou.ticketflow.dto.response.UserResponse;
import com.jaajou.ticketflow.entity.User;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class UserMapper {

    public UserResponse toResponse(User user) {
        return new UserResponse(
                user.getId(),
                user.getFirstName(),
                user.getLastName(),
                user.getEmail(),
                user.getPhone(),
                user.getStatus().getName(),
                user.getUserRoles().stream()
                        .map(ur -> ur.getRole().getName())
                        .toList()
        );
    }
}