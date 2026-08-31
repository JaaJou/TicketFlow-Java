/******************************************************************************
 * Projet : TicketFlow
 * Script : 06_views.sql
 * Objet   : Création des vues
 ******************************************************************************/

/*
Les vues (VIEW) ne sont pas obligatoires, mais elles sont très utiles pour éviter de réécrire les mêmes JOIN partout dans ton application.

- vw_ticket_details : affiche un ticket avec toutes ses informations (statut, priorité, catégorie, créateur, assigné).
- vw_ticket_comments : affiche les commentaires avec le nom de leur auteur.
- vw_user_profile : affiche les informations d'un utilisateur avec son rôle et son statut.
*/
SET search_path TO ticketflow;

-- ============================================================================
-- VUE : vw_ticket_details
-- Description :
-- Retourne un ticket avec toutes les informations utiles.
-- ============================================================================

CREATE OR REPLACE VIEW vw_ticket_details AS
SELECT
    t.id,
    t.title,
    t.description,

    ts.name AS status,
    tp.name AS priority,
    tc.name AS category,

    creator.id AS creator_id,
    creator.firstname AS creator_firstname,
    creator.lastname AS creator_lastname,
    creator.email AS creator_email,

    assignee.id AS assignee_id,
    assignee.firstname AS assignee_firstname,
    assignee.lastname AS assignee_lastname,

    t.created_at,
    t.updated_at,
    t.closed_at

FROM ticket t

INNER JOIN ticket_status ts
    ON ts.id = t.status_id

INNER JOIN ticket_priority tp
    ON tp.id = t.priority_id

INNER JOIN ticket_category tc
    ON tc.id = t.category_id

INNER JOIN app_user creator
    ON creator.id = t.creator_id

LEFT JOIN app_user assignee
    ON assignee.id = t.assignee_id;

-- ============================================================================
-- VUE : vw_ticket_comments
-- Description :
-- Retourne les commentaires avec les informations de leur auteur.
-- ============================================================================

CREATE OR REPLACE VIEW vw_ticket_comments AS
SELECT

    c.id,

    c.ticket_id,

    c.content,

    c.created_at,

    c.updated_at,

    u.id AS author_id,

    u.firstname,

    u.lastname,

    u.email

FROM ticket_comment c

INNER JOIN app_user u
    ON u.id = c.author_id;

-- ============================================================================
-- VUE : vw_user_profile
-- Description :
-- Retourne les informations principales d'un utilisateur.
-- ============================================================================

CREATE OR REPLACE VIEW vw_user_profile AS
SELECT

    u.id,

    u.firstname,

    u.lastname,

    u.email,

    u.phone,

    u.profile_picture_url,

    us.name AS status,

    r.name AS role,

    u.created_at,

    u.last_login_at

FROM app_user u

INNER JOIN user_status us
    ON us.id = u.status_id

INNER JOIN role r
    ON r.id = u.role_id;