package com.jaajou.ticketflow.controller;

import com.jaajou.ticketflow.dto.auth.AuthResponse;
import com.jaajou.ticketflow.dto.auth.LoginRequest;
import com.jaajou.ticketflow.dto.auth.RegisterRequest;
import com.jaajou.ticketflow.service.AuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Expose les endpoints publics d'inscription et de connexion.
 * Délègue toute la logique métier à AuthService.
 */
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    /**
     * Crée un nouvel utilisateur à partir de son email et mot de passe.
     * Retourne 201 (Created) en cas de succès, sans corps de réponse.
     */
    @PostMapping("/register")
    public ResponseEntity<Void> register(@Valid @RequestBody RegisterRequest request) {
        authService.register(request);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    /**
     * Authentifie un utilisateur existant et retourne un token JWT en cas de succès.
     */
    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody LoginRequest request) {
        AuthResponse response = authService.login(request);
        return ResponseEntity.ok(response);
    }
}
