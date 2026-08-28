package com.jaajou.ticketflow.dto.auth;

public record LoginRequest (
        String email,
        String password
) {}
