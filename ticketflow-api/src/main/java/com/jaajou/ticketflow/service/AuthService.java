package com.jaajou.ticketflow.service;

import com.jaajou.ticketflow.dto.auth.AuthResponse;
import com.jaajou.ticketflow.dto.auth.LoginRequest;
import com.jaajou.ticketflow.dto.auth.RegisterRequest;
import com.jaajou.ticketflow.entity.User;
import com.jaajou.ticketflow.exception.EmailAlreadyUsedException;
import com.jaajou.ticketflow.repository.UserRepository;
import com.jaajou.ticketflow.utils.auth.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Collection;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    private final JwtUtil jwtUtil;
    private final AuthenticationManager authenticationManager;

    public void register(RegisterRequest request) {

        if(userRepository.findByEmail(request.email()).isPresent()){
            throw  new EmailAlreadyUsedException(request.email());
        }

        User user = new User();
        user.setEmail(request.email());
        user.setPasswordHash(passwordEncoder.encode(request.password()));

        userRepository.save(user);
    }

    public AuthResponse login(LoginRequest request) {

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.email(), request.password())
        );

        Collection<String> roles = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .toList();

        String token = jwtUtil.generateToken(
                authentication.getName(),
                roles
        );

        return new AuthResponse(token);
    }
}
