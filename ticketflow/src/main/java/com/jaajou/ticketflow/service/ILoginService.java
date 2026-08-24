package com.jaajou.ticketflow.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface ILoginService extends UserDetailsService {
    UserDetails loadUserByUsername( String email);
}
