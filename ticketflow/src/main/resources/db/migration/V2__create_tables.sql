/******************************************************************************
 * Projet : TicketFlow
 * Script : 02_tables.sql
 * Objet   : Création des tables de l'application
 ******************************************************************************/

SET search_path TO ticketflow;

-- ============================================================================
-- TABLE : app_user
-- Représente un utilisateur de l'application.
-- ============================================================================

CREATE TABLE app_user
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    firstname           VARCHAR(100) NOT NULL,
    lastname            VARCHAR(100) NOT NULL,

    email               VARCHAR(255) NOT NULL UNIQUE,
    password_hash       VARCHAR(255) NOT NULL,

    phone               VARCHAR(20),

    profile_picture_url VARCHAR(500),

    email_verified      BOOLEAN NOT NULL DEFAULT FALSE,

    status_id BIGINT NOT NULL,

    created_at          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_login_at       TIMESTAMP
);

-- ============================================================================
-- TABLE : user_role
-- Table d'association entre les utilisateurs et leurs rôles.
-- Un utilisateur peut posséder plusieurs rôles.
-- ============================================================================

CREATE TABLE user_role
(
    user_id BIGINT NOT NULL,

    role_id BIGINT NOT NULL,

    assigned_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (user_id, role_id)
);

-- ============================================================================
-- TABLE : user_status
-- Liste des statuts possibles d'un utilisateur.
-- ============================================================================

CREATE TABLE user_status
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    name VARCHAR(50) NOT NULL UNIQUE,

    description TEXT
);

-- ============================================================================
-- TABLE : role
-- Liste des rôles disponibles dans l'application.
-- ============================================================================

CREATE TABLE role
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    name VARCHAR(50) NOT NULL UNIQUE,

    description TEXT
);

-- ============================================================================
-- TABLE : email_verification_token
-- Jetons servant à confirmer une adresse mail.
-- ============================================================================

CREATE TABLE email_verification_token
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    token VARCHAR(255) NOT NULL UNIQUE,

    expires_at TIMESTAMP NOT NULL,
    used_at TIMESTAMP,

    user_id BIGINT NOT NULL
);

-- ============================================================================
-- TABLE : password_reset_token
-- Jetons utilisés lors d'une réinitialisation de mot de passe.
-- ============================================================================

CREATE TABLE password_reset_token
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    token VARCHAR(255) NOT NULL UNIQUE,

    expires_at TIMESTAMP NOT NULL,
    used_at TIMESTAMP,

    user_id BIGINT NOT NULL
);

-- ============================================================================
-- TABLE : ticket_status
-- Liste des statuts disponibles.
-- ============================================================================

CREATE TABLE ticket_status
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    name VARCHAR(50) NOT NULL UNIQUE,

    description TEXT
);

-- ============================================================================
-- TABLE : ticket_priority
-- Liste des priorités.
-- ============================================================================

CREATE TABLE ticket_priority
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    name VARCHAR(50) NOT NULL UNIQUE,

    level SMALLINT NOT NULL UNIQUE
);

-- ============================================================================
-- TABLE : ticket_category
-- Catégories des tickets.
-- ============================================================================

CREATE TABLE ticket_category
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    name VARCHAR(100) NOT NULL UNIQUE,

    description TEXT
);

-- ============================================================================
-- TABLE : ticket
-- Ticket créé par un utilisateur.
-- ============================================================================

CREATE TABLE ticket
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    title VARCHAR(200) NOT NULL,

    description TEXT NOT NULL,

    creator_id BIGINT NOT NULL,

    assignee_id BIGINT,

    status_id BIGINT NOT NULL,

    priority_id BIGINT NOT NULL,

    category_id BIGINT NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    closed_at TIMESTAMP
);

-- ============================================================================
-- TABLE : ticket_comment
-- Historique des commentaires.
-- ============================================================================

CREATE TABLE ticket_comment
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    ticket_id BIGINT NOT NULL,

    author_id BIGINT NOT NULL,

    content TEXT NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- TABLE : ticket_attachment
-- Pièces jointes d'un ticket.
-- ============================================================================

CREATE TABLE ticket_attachment
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    ticket_id BIGINT NOT NULL,

    uploader_id BIGINT NOT NULL,

    file_name VARCHAR(255) NOT NULL,

    storage_path VARCHAR(500) NOT NULL,

    content_type VARCHAR(100) NOT NULL,

    file_size BIGINT NOT NULL,

    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- TABLE : ticket_history
-- Journal des modifications d'un ticket.
-- ============================================================================

CREATE TABLE ticket_history
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    ticket_id BIGINT NOT NULL,

    user_id BIGINT NOT NULL,

    action VARCHAR(100) NOT NULL,

    field_name VARCHAR(100),

    old_value TEXT,

    new_value TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);