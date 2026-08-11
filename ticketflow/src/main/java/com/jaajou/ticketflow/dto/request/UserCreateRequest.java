package com.jaajou.ticketflow.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record UserCreateRequest(
        @NotBlank(message = "Le prénom est obligatoire") String firstName,
        @NotBlank(message = "Le nom est obligatoire") String lastName,
        @Email(message = "Email invalide") @NotBlank String email,
        @Size(min = 8, message = "Le mot de passe doit faire au moins 8 caractères") String password,
        String phone,
        String profilePictureUrl
) {}