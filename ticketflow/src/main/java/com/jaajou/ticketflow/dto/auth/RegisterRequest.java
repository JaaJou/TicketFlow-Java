package com.jaajou.ticketflow.dto.auth;

public record RegisterRequest (
        String email,
        String password
){ }
