package com.jaajou.ticketflow.dto.response;

import java.util.List;

public record UserResponse(
        Long id,
        String firstName,
        String lastName,
        String email,
        String phone,
        String status,
        List<String> roles
) {}