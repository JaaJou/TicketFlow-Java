package com.jaajou.ticketflow.utils;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordGenerator {

    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        String password = "ticketflow_mdp";
        String hash = encoder.encode(password);

        System.out.println(hash);
    }
}
