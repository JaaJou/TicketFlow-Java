package com.jaajou.ticketflow.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jaajou.ticketflow.dto.request.UserCreateRequest;
import com.jaajou.ticketflow.dto.request.UserUpdateRequest;
import com.jaajou.ticketflow.dto.response.UserResponse;
import com.jaajou.ticketflow.entity.User;
import com.jaajou.ticketflow.exception.EmailAlreadyUsedException;
import com.jaajou.ticketflow.exception.ResourceNotFoundException;
import com.jaajou.ticketflow.mapper.UserMapper;
import com.jaajou.ticketflow.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;

@WebMvcTest(UserController.class)
@AutoConfigureMockMvc(addFilters = false)
class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockitoBean
    private UserService userService;

    @MockitoBean
    private UserMapper userMapper;

    // ---------- POST /api/users ----------

    @Test
    void create_shouldReturn201_whenRequestIsValid() throws Exception {

        // given
        UserCreateRequest request = new UserCreateRequest(
                "Jean", "Dupont", "jean.test1@test.com", "password123", "0671151769", "jaajou.png"
        );
        User createdUser = new User();
        createdUser.setId(1L);

        UserResponse response = new UserResponse(
                1L, "Jean", "Dupont", "jean.test1@test.com", "0671151769","ACTIVE", List.of("USER")
        );

        when(userService.createUser("Jean", "Dupont", "jean.test1@test.com", "password123", "0671151769", "jaajou.png"))
                .thenReturn(createdUser);
        when(userMapper.toResponse(createdUser)).thenReturn(response);

        // when / then
        mockMvc.perform(post("/api/users")
                        .with(csrf())
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.email").value("jean.test1@test.com"))
                .andExpect(jsonPath("$.roles[0]").value("USER"));

        verify(userService).createUser("Jean", "Dupont", "jean.test1@test.com", "password123", "0671151769", "jaajou.png");
    }

    @Test
    void create_shouldReturn400_whenEmailIsInvalid() throws Exception {
        // given — email invalide, déclenche @Valid avant même d'appeler le service
        UserCreateRequest request = new UserCreateRequest(
                "Jean", "Dupont", "pas-un-email", "password123", "0671151769", "jaajou.png"
        );

        // when / then
        mockMvc.perform(post("/api/users")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isBadRequest());

        verifyNoInteractions(userService);
    }

    @Test
    void create_shouldReturn409_whenEmailAlreadyUsed() throws Exception {
        // given
        UserCreateRequest request = new UserCreateRequest(
                "Jean", "Dupont", "jean@test.com", "password123", "0671151769", "jaajou.png"
        );
        when(userService.createUser(anyString(), anyString(), anyString(), anyString(), anyString(), anyString()))
                .thenThrow(new EmailAlreadyUsedException("jean@test.com"));

        // when / then
        mockMvc.perform(post("/api/users")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isConflict())
                .andExpect(jsonPath("$.message").value("Email already used: jean@test.com"));
    }

    // ---------- GET /api/users/{id} ----------

    @Test
    void getById_shouldReturn200_whenUserExists() throws Exception {
        // given
        User user = new User();
        user.setId(1L);
        UserResponse response = new UserResponse(
                1L, "Jean", "Dupont", "jean@test.com", "0671151769", "ACTIVE", List.of("USER")
        );

        when(userService.getUserById(1L)).thenReturn(user);
        when(userMapper.toResponse(user)).thenReturn(response);

        // when / then
        mockMvc.perform(get("/api/users/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.firstname").value("Jean"));
    }

    @Test
    void getById_shouldReturn404_whenUserDoesNotExist() throws Exception {
        // given
        when(userService.getUserById(999L))
                .thenThrow(new ResourceNotFoundException("User", 999L));

        // when / then
        mockMvc.perform(get("/api/users/999"))
                .andExpect(status().isNotFound());
    }

    // ---------- PUT /api/users/{id} ----------

    @Test
    void update_shouldReturn200_whenRequestIsValid() throws Exception {
        // given
        UserUpdateRequest request = new UserUpdateRequest("Jean-Updated", "Dupont", "jean@test.com", "0671151769", "jaajou.png");
        User updatedUser = new User();
        updatedUser.setId(1L);

        UserResponse response = new UserResponse(
                1L, "Jean-Updated", "Dupont", "jean@test.com", "0671151769", "ACTIVE", List.of("USER")
        );

        when(userService.updateUser(1L, "Jean-Updated", "Dupont", "jean@test.com", "0671151769", "jaajou.png"))
                .thenReturn(updatedUser);
        when(userMapper.toResponse(updatedUser)).thenReturn(response);

        // when / then
        mockMvc.perform(put("/api/users/1")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.firstname").value("Jean-Updated"));
    }

    // ---------- DELETE /api/users/{id} ----------

    @Test
    void delete_shouldReturn204_whenUserExists() throws Exception {
        // given
        doNothing().when(userService).deleteUser(1L);

        // when / then
        mockMvc.perform(delete("/api/users/1"))
                .andExpect(status().isNoContent());

        verify(userService).deleteUser(1L);
    }

    // ---------- POST /api/users/{id}/roles/{roleName} ----------

    @Test
    void assignRole_shouldReturn200_whenUserAndRoleExist() throws Exception {
        // given
        User user = new User();
        user.setId(1L);
        UserResponse response = new UserResponse(
                1L, "Jean", "Dupont", "jean@test.com", "0671151769","ACTIVE", List.of("USER", "ADMIN")
        );

        when(userService.assignRole(1L, "ADMIN")).thenReturn(user);
        when(userMapper.toResponse(user)).thenReturn(response);

        // when / then
        mockMvc.perform(post("/api/users/1/roles/ADMIN"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.roles[1]").value("ADMIN"));
    }
}