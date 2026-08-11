package com.jaajou.ticketflow.controller;

import com.jaajou.ticketflow.dto.request.UserCreateRequest;
import com.jaajou.ticketflow.dto.request.UserUpdateRequest;
import com.jaajou.ticketflow.dto.response.UserResponse;
import com.jaajou.ticketflow.entity.User;
import com.jaajou.ticketflow.mapper.UserMapper;
import com.jaajou.ticketflow.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final UserMapper userMapper;

    @GetMapping
    public ResponseEntity<List<UserResponse>> getAll() {
        List<UserResponse> users = userService.getAllUsers().stream()
                .map(userMapper::toResponse)
                .toList();
        return ResponseEntity.ok(users);
    }

    @GetMapping("/{id}")
    public ResponseEntity<UserResponse> getById(@PathVariable Long id) {
        User user = userService.getUserById(id);
        return ResponseEntity.ok(userMapper.toResponse(user));
    }

    @PostMapping
    public ResponseEntity<UserResponse> create(@Valid @RequestBody UserCreateRequest request) {
        User user = userService.createUser(
                request.firstName(),
                request.lastName(),
                request.email(),
                request.password(),
                request.phone(),
                request.profilePictureUrl()
        );
        return ResponseEntity.status(HttpStatus.CREATED).body(userMapper.toResponse(user));
    }

    @PutMapping("/{id}")
    public ResponseEntity<UserResponse> update(@PathVariable Long id, @Valid @RequestBody UserUpdateRequest request) {
        User user = userService.updateUser(id, request.firstName(), request.lastName(), request.email(), request.phone(), request.profilePictureUrl());
        return ResponseEntity.ok(userMapper.toResponse(user));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        userService.deleteUser(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/roles/{roleName}")
    public ResponseEntity<UserResponse> assignRole(@PathVariable Long id, @PathVariable String roleName) {
        User user = userService.assignRole(id, roleName);
        return ResponseEntity.ok(userMapper.toResponse(user));
    }
}
