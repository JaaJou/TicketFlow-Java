package com.jaajou.ticketflow.service.implementation;

import com.jaajou.ticketflow.entity.User;
import com.jaajou.ticketflow.entity.UserRole;
import com.jaajou.ticketflow.repository.UserRepository;
import com.jaajou.ticketflow.repository.UserRoleRepository;
import com.jaajou.ticketflow.service.ILoginService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class LoginServiceImpl implements ILoginService {

    private final UserRepository userRepository;
    private final UserRoleRepository userRoleRepository;

    @Override
    public UserDetails loadUserByUsername(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() ->
                        new UsernameNotFoundException(
                                "Utilisateur introuvable : " + email
                        )
                );

        List<UserRole> userRoles = userRoleRepository.findByUserId(user.getId());

        String[] authorities = userRoles.stream()
                .map(userRole -> "ROLE_" + userRole.getRole().getName())
                .toArray(String[]::new);

        return org.springframework.security.core.userdetails.User
                .withUsername(user.getEmail())
                .password(user.getPasswordHash())
                .authorities(authorities)
                .build();
    }
}
