package com.jaajou.ticketflow.dto.response;

import java.util.List;

public record UserResponse(
        Long id,
        String firstname,
        String lastname,
        String email,
        String phone,
        String status,
        List<String> roles
) {}