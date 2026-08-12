package com.jaajou.ticketflow.service;

import com.jaajou.ticketflow.entity.Role;
import com.jaajou.ticketflow.entity.User;
import com.jaajou.ticketflow.entity.UserRole;
import com.jaajou.ticketflow.entity.UserStatus;
import com.jaajou.ticketflow.exception.EmailAlreadyUsedException;
import com.jaajou.ticketflow.exception.ResourceNotFoundException;
import com.jaajou.ticketflow.repository.RoleRepository;
import com.jaajou.ticketflow.repository.UserRepository;
import com.jaajou.ticketflow.repository.UserRoleRepository;
import com.jaajou.ticketflow.repository.UserStatusRepository;
import com.jaajou.ticketflow.service.implementation.UserServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserServiceImplTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private RoleRepository roleRepository;

    @Mock
    private UserRoleRepository userRoleRepository;

    @Mock
    private UserStatusRepository userStatusRepository;

    @Mock
    private PasswordEncoder passwordEncoder;

    @InjectMocks
    private UserServiceImpl userService;

    private UserStatus activeStatus;
    private Role userRole;

    @BeforeEach
    void setUp() {
        activeStatus = new UserStatus();
        activeStatus.setId(1L);
        activeStatus.setName("ACTIVE");

        userRole = new Role();
        userRole.setId(1L);
        userRole.setName("USER");
    }

    // ---------- createUser ----------

    @Test
    void createUser_shouldCreateUserWithActiveStatusAndDefaultRole_whenEmailIsNotUsed() {
        // given
        when(userRepository.findByEmail("jean@test.com")).thenReturn(Optional.empty());
        when(userStatusRepository.findByName("ACTIVE")).thenReturn(Optional.of(activeStatus));
        when(passwordEncoder.encode("password123")).thenReturn("hashed-password");
        User savedUser = new User();
        savedUser.setId(42L);
        when(userRepository.save(any(User.class))).thenAnswer(invocation -> {
            User u = invocation.getArgument(0);
            u.setId(42L);
            return u;
        });
        when(userRepository.findById(42L)).thenReturn(Optional.of(savedUser));
        when(roleRepository.findByName("USER")).thenReturn(Optional.of(userRole));

        // when
        User result = userService.createUser("Jean", "Dupont", "jean@test.com", "password123", "0671151769", "jaajou.png");

        // then
        assertThat(result.getId()).isEqualTo(42L);
        assertThat(result.getEmail()).isEqualTo("jean@test.com");
        assertThat(result.getPasswordHash()).isEqualTo("hashed-password");
        assertThat(result.getStatus()).isEqualTo(activeStatus);
        assertThat(result.isEmailVerified()).isFalse();

        verify(userRepository).save(any(User.class));
        verify(userRoleRepository).save(any(UserRole.class));
    }

    @Test
    void createUser_shouldThrowEmailAlreadyUsedException_whenEmailAlreadyExists() {
        // given
        User existingUser = new User();
        existingUser.setEmail("jean@test.com");
        when(userRepository.findByEmail("jean@test.com")).thenReturn(Optional.of(existingUser));

        // when / then
        assertThatThrownBy(() ->
                userService.createUser("Jean", "Dupont", "jean@test.com", "password123","0671151769", "jaajou.png")
        )
                .isInstanceOf(EmailAlreadyUsedException.class)
                .hasMessageContaining("jean@test.com");

        // le flux doit s'arrêter avant toute tentative de sauvegarde
        verify(userRepository, never()).save(any(User.class));
        verifyNoInteractions(userStatusRepository, userRoleRepository, passwordEncoder);
    }

    @Test
    void createUser_shouldThrowResourceNotFoundException_whenActiveStatusIsMissing() {
        // given
        when(userRepository.findByEmail(anyString())).thenReturn(Optional.empty());
        when(userStatusRepository.findByName("ACTIVE")).thenReturn(Optional.empty());

        // when / then
        assertThatThrownBy(() ->
                userService.createUser("Jean", "Dupont", "jean@test.com", "password123", "0671151769", "jaajou.png")
        )
                .isInstanceOf(ResourceNotFoundException.class);

        verify(userRepository, never()).save(any(User.class));
    }

    // ---------- getUserById ----------

    @Test
    void getUserById_shouldReturnUser_whenUserExists() {
        // given
        User user = new User();
        user.setId(1L);
        when(userRepository.findById(1L)).thenReturn(Optional.of(user));

        // when
        User result = userService.getUserById(1L);

        // then
        assertThat(result.getId()).isEqualTo(1L);
    }

    @Test
    void getUserById_shouldThrowResourceNotFoundException_whenUserDoesNotExist() {
        // given
        when(userRepository.findById(999L)).thenReturn(Optional.empty());

        // when / then
        assertThatThrownBy(() -> userService.getUserById(999L))
                .isInstanceOf(ResourceNotFoundException.class);
    }

    // ---------- assignRole ----------

    @Test
    void assignRole_shouldCreateUserRole_whenUserAndRoleExist() {
        // given
        User user = new User();
        user.setId(1L);
        Role adminRole = new Role();
        adminRole.setId(2L);
        adminRole.setName("ADMIN");

        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(roleRepository.findByName("ADMIN")).thenReturn(Optional.of(adminRole));

        // when
        User result = userService.assignRole(1L, "ADMIN");

        // then
        assertThat(result).isEqualTo(user);
        verify(userRoleRepository).save(argThat(userRoleArg ->
                userRoleArg.getUser().equals(user) && userRoleArg.getRole().equals(adminRole)
        ));
    }

    @Test
    void assignRole_shouldThrowResourceNotFoundException_whenRoleDoesNotExist() {
        // given
        User user = new User();
        user.setId(1L);
        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(roleRepository.findByName("UNKNOWN")).thenReturn(Optional.empty());

        // when / then
        assertThatThrownBy(() -> userService.assignRole(1L, "UNKNOWN"))
                .isInstanceOf(ResourceNotFoundException.class);

        verify(userRoleRepository, never()).save(any(UserRole.class));
    }
}