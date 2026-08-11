package com.jaajou.ticketflow.dto.request;

import jakarta.validation.constraints.NotBlank;

public record UserUpdateRequest(
        @NotBlank
        String firstName,
        @NotBlank
        String lastName,
        String email,
        String phone,
        String profilePictureUrl
) {}
