-- =========================================
-- Script de creation de la base Ticket-flow
-- =========================================

-- Extension pour generer des UUID si besoin (optionnel)
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Table des utilisateurs
CREATE TABLE users (
    id              SERIAL PRIMARY KEY,
    nom             VARCHAR(100) NOT NULL,
    email           VARCHAR(150) NOT NULL UNIQUE,
    mot_de_passe    VARCHAR(255) NOT NULL,
    role            VARCHAR(20) NOT NULL DEFAULT 'USER' CHECK (role IN ('USER', 'AGENT', 'ADMIN')),
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Table des categories de tickets
CREATE TABLE categories (
    id              SERIAL PRIMARY KEY,
    nom             VARCHAR(100) NOT NULL UNIQUE,
    description     VARCHAR(255)
);

-- Table des tickets
CREATE TABLE tickets (
    id              SERIAL PRIMARY KEY,
    titre           VARCHAR(200) NOT NULL,
    description     TEXT,
    statut          VARCHAR(20) NOT NULL DEFAULT 'OUVERT' CHECK (statut IN ('OUVERT', 'EN_COURS', 'RESOLU', 'FERME')),
    priorite        VARCHAR(20) NOT NULL DEFAULT 'NORMALE' CHECK (priorite IN ('BASSE', 'NORMALE', 'HAUTE', 'CRITIQUE')),
    user_id         INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    assigned_to     INTEGER REFERENCES users(id) ON DELETE SET NULL,
    category_id     INTEGER REFERENCES categories(id) ON DELETE SET NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Table des commentaires sur les tickets
CREATE TABLE comments (
    id              SERIAL PRIMARY KEY,
    ticket_id       INTEGER NOT NULL REFERENCES tickets(id) ON DELETE CASCADE,
    user_id         INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    contenu         TEXT NOT NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Index utiles pour les recherches frequentes
CREATE INDEX idx_tickets_statut ON tickets(statut);
CREATE INDEX idx_tickets_priorite ON tickets(priorite);
CREATE INDEX idx_tickets_user_id ON tickets(user_id);
CREATE INDEX idx_comments_ticket_id ON comments(ticket_id);

-- Trigger pour mettre a jour updated_at automatiquement sur tickets
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_tickets_updated_at
BEFORE UPDATE ON tickets
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();