/******************************************************************************
 * Projet : TicketFlow
 * Script : 05_init_data.sql
 * Objet   : Initialisation des données de référence
 ******************************************************************************/

/*
C'est un script important. Son objectif est d'insérer les données de référence (ou seed data) qui ne changent quasiment jamais.
Ne jamais y insérer de vrais utilisateurs ou de vrais tickets. Ce script ne doit contenir que les valeurs métier nécessaires au fonctionnement de l'application.

Utiliser des valeurs en anglais (TO_DO, HIGH, FEATURE, etc.).

À conserver, même si l'interface est en français : 
- Les données stockées restent indépendantes de la langue de l'application.
- Si tu ajoutes un jour l'anglais, l'espagnol ou une autre langue, il suffira de traduire les libellés dans l'interface, sans modifier les données.
- Les constantes Java (enum) pourront reprendre exactement les mêmes valeurs, ce qui simplifiera le code.
*/

SET search_path TO ticketflow;

-- ============================================================================
-- STATUTS DES UTILISATEURS
-- ============================================================================

INSERT INTO user_status (name, description)
VALUES
(
    'PENDING',
    'Compte créé, en attente de validation de l''adresse e-mail.'
),
(
    'ACTIVE',
    'Compte actif.'
),
(
    'DISABLED',
    'Compte désactivé.'
);

-- ============================================================================
-- ROLES
-- ============================================================================

INSERT INTO role (name, description)
VALUES
(
    'USER',
    'Utilisateur standard de TicketFlow.'
),
(
    'ADMIN',
    'Administrateur de l''application.'
);

-- ============================================================================
-- STATUTS DES TICKETS
-- ============================================================================

INSERT INTO ticket_status (name, description)
VALUES
(
    'TO_DO',
    'Ticket créé, pas encore traité.'
),
(
    'IN_PROGRESS',
    'Ticket actuellement en cours de traitement.'
),
(
    'ON_HOLD',
    'Traitement suspendu temporairement.'
),
(
    'RESOLVED',
    'Problème résolu, en attente de validation.'
),
(
    'CLOSED',
    'Ticket définitivement fermé.'
),
(
    'CANCELLED',
    'Ticket annulé.'
);

-- ============================================================================
-- PRIORITES
-- ============================================================================

INSERT INTO ticket_priority (name, level)
VALUES
(
    'LOW',
    1
),
(
    'MEDIUM',
    2
),
(
    'HIGH',
    3
),
(
    'CRITICAL',
    4
);

-- ============================================================================
-- CATEGORIES
-- ============================================================================

INSERT INTO ticket_category (name, description)
VALUES
(
    'BUG',
    'Anomalie de fonctionnement.'
),
(
    'FEATURE',
    'Nouvelle fonctionnalité.'
),
(
    'SUPPORT',
    'Demande d''assistance.'
),
(
    'QUESTION',
    'Question ou demande d''information.'
),
(
    'OTHER',
    'Autre demande.'
);