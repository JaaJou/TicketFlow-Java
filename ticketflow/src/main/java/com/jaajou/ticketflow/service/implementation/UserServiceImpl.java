package com.jaajou.ticketflow.service.implementation;

import com.jaajou.ticketflow.entity.User;
import com.jaajou.ticketflow.entity.Role;
import com.jaajou.ticketflow.entity.UserRole;
import com.jaajou.ticketflow.entity.UserStatus;
import com.jaajou.ticketflow.repository.UserRepository;
import com.jaajou.ticketflow.repository.RoleRepository;
import com.jaajou.ticketflow.repository.UserRoleRepository;
import com.jaajou.ticketflow.repository.UserStatusRepository;
import com.jaajou.ticketflow.service.UserService;
import com.jaajou.ticketflow.exception.ResourceNotFoundException;
import com.jaajou.ticketflow.exception.EmailAlreadyUsedException;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final UserRoleRepository userRoleRepository;
    private final UserStatusRepository userStatusRepository;

    private final PasswordEncoder passwordEncoder;

    @Override
    @Transactional
    public User createUser(String firstName, String lastName, String email, String password, String phone, String profilePictureUrl) {
        if (userRepository.findByEmail(email).isPresent()) {
            throw new EmailAlreadyUsedException(email);
        }

        UserStatus activeStatus = userStatusRepository.findByName("ACTIVE")
                .orElseThrow(() -> new ResourceNotFoundException("UserStatus", "ACTIVE"));

        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPasswordHash(passwordEncoder.encode(password));
        user.setStatus(activeStatus);
        user.setEmailVerified(false);
        user.setCreatedAt(LocalDateTime.now());

        User savedUser = userRepository.save(user);

        assignRole(savedUser.getId(), "USER");

        return savedUser;
    }

    @Override
    public User getUserById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User", id));
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    @Transactional
    public User updateUser(Long id, String firstName, String lastName, String email, String phone, String profilePictureUrl) {
        User user = getUserById(id);

        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setPhone(phone);
        user.setUpdatedAt(LocalDateTime.now());

        return userRepository.save(user);
    }

    @Override
    @Transactional
    public void deleteUser(Long id) {
        User user = getUserById(id);
        userRepository.deleteById(user.getId());
    }

    @Override
    @Transactional
    public User assignRole(Long userId, String roleName) {
        User user = getUserById(userId);
        Role role = roleRepository.findByName(roleName)
                .orElseThrow(() -> new ResourceNotFoundException("Role", roleName));

        UserRole userRole = new UserRole();
        userRole.setUser(user);
        userRole.setRole(role);
        userRole.setAssignedAt(LocalDateTime.now());

        userRoleRepository.save(userRole);

        return user;
    }
}
