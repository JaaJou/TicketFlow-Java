package com.jaajou.ticketflow.filter;

import com.jaajou.ticketflow.service.CustomUserDetailsService;
import com.jaajou.ticketflow.utils.auth.JwtUtil;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

/**
 * Filtre d'authentification exécuté une seule fois par requête HTTP.
 * Intercepte le header "Authorization", valide le token JWT présent,
 * et positionne l'utilisateur authentifié dans le SecurityContext
 * avant que la requête n'atteigne le controller cible.
 */
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;
    private final CustomUserDetailsService customUserDetailsService;

    /**
     * Point d'entrée du filtre, appelé automatiquement par Spring pour chaque requête entrante.
     *
     * Vérifie la présence et la validité d'un token JWT dans le header Authorization.
     * Si le token est valide, authentifie l'utilisateur correspondant pour la durée de la requête.
     * Si le token est absent, invalide ou expiré, la requête poursuit sans authentification
     * (elle sera alors rejetée plus tard par SecurityConfig si la route est protégée).
     *
     * @param request     la requête HTTP entrante
     * @param response    la réponse HTTP à construire
     * @param filterChain la chaîne de filtres à poursuivre après ce traitement
     * @throws ServletException en cas d'erreur de traitement du servlet
     * @throws IOException      en cas d'erreur d'entrée/sortie
     */
    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain
    ) throws ServletException, IOException {

        final String authHeader = request.getHeader("Authorization");

        /**
         *  Pas de header Authorization
          */
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }

        /**
         * Récupération du token
         */
        final String token = authHeader.substring(7);

        try {
            /**
             * Récupération de l'email depuis le JWT
             */
            final String email = jwtUtil.extractEmail(token);

            /**
             * Si un utilisateur est identifié et qu'il n'est pas encore authentifié
             */
            if (email != null && SecurityContextHolder.getContext().getAuthentication() == null) {

                UserDetails userDetails = customUserDetailsService.loadUserByUsername(email);

                /**
                 * Vérification du token
                 */
                if (jwtUtil.isTokenValid(token, userDetails)) {

                    UsernamePasswordAuthenticationToken authentication =
                            new UsernamePasswordAuthenticationToken(
                                    userDetails,
                                    null,
                                    userDetails.getAuthorities()
                            );

                    authentication.setDetails(
                            new WebAuthenticationDetailsSource().buildDetails(request)
                    );

                    SecurityContextHolder.getContext().setAuthentication(authentication);
                }
            }
        } catch (JwtException | UsernameNotFoundException ex) {
            /**
             *  Token invalide, expiré, ou utilisateur supprimé entre-temps : on ignore silencieusement,
             *  la requête continuera sans authentification et sera rejetée plus loin si la route est protégée
             */
            SecurityContextHolder.clearContext();
        }

        filterChain.doFilter(request, response);
    }
}