package com.jaajou.ticketflow.utils.auth;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;

@Component
public class JwtUtil {

    /**
     * Injecte la valeur de la clé "jwt.secret" définie dans application.yml ou en variable d'environnement
     * Cette clé sert à signer et vérifier les tokens ; elle ne doit jamais être codée en dur ni versionnée sur GitHub
     */
    @Value("${jwt.secret}")
    private String secretKey;

    /**
     * Injecte la durée de validité du token en millisecondes, également externalisée dans la configuration
     */
    @Value("${jwt.expiration}")
    private long expirationMs;

    /**
     * Génère un token JWT signé pour un email donné (appelée depuis AuthService après authentification réussie)
     *  .subject(email) :
     *          Définit le "subject" du token, c'est-à-dire l'identifiant principal qu'il représente (ici l'email)
     *
     *  .issuedAt(new Date()) :
     *          Enregistre la date de création du token, utile pour du débogage ou des règles métier futures
     *
     *  .expiration(new Date(System.currentTimeMillis() + expirationMs)) :
     *          Calcule la date d'expiration en ajoutant la durée de validité à l'instant présent
     *
     *  .signWith(getSigningKey()) :
     *          Signe le token avec la clé secrète, garantissant qu'il ne pourra pas être falsifié sans être détecté
     *
     *  .compact() :
     *          Assemble les trois parties (header, payload, signature) en une seule chaîne de caractères finale
     */
    public String generateToken(String email) {
        return Jwts.builder()
                .subject(email)
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + expirationMs))
                .signWith(getSigningKey())
                .compact();
    }

    /**
     * Convertit la clé secrète (une simple chaîne de caractères) en un objet SecretKey utilisable par la librairie JWT
     */
    private SecretKey getSigningKey() {
        return Keys.hmacShaKeyFor(secretKey.getBytes(StandardCharsets.UTF_8));
    }

    /**
     * Extrait l'email (le "subject") contenu dans un token déjà validé
     */
    public String extractEmail(String token) {
        return extractAllClaims(token).getSubject();
    }

    /**
     * Vérifie qu'un token correspond bien à l'utilisateur fourni et qu'il n'est pas expiré
     */
    public boolean isTokenValid(String token, UserDetails userDetails) {
        String email = extractEmail(token);
        return email.equals(userDetails.getUsername()) && !isTokenExpired(token);
    }

    /**
     * Vérifie si la date d'expiration du token est déjà dépassée par rapport à l'instant présent
     */
    private boolean isTokenExpired(String token) {
        return extractAllClaims(token).getExpiration().before(new Date());
    }

    /**
     * Décode et vérifie la signature du token, puis retourne l'ensemble de ses claims (email, dates, etc.)
     * C'est ici que le token est réellement validé cryptographiquement : une signature invalide lève une exception
     */
    private Claims extractAllClaims(String token) {
        return Jwts.parser()
                .verifyWith(getSigningKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }
}