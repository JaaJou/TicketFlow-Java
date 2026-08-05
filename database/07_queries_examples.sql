/******************************************************************************
 * Projet : TicketFlow
 * Script : 07_queries_examples.sql
 * Objet   : Requêtes SQL utiles
 ******************************************************************************/

/*
A ne pas executer automatiquement, c'est une boite à outils pour les tests
*/

SET search_path TO ticketflow;

-- ============================================================================
-- UTILISATEURS
-- ============================================================================

-- Afficher tous les utilisateurs
SELECT *
FROM app_user;

-- Rechercher un utilisateur par son e-mail
SELECT *
FROM app_user
WHERE email = 'john.doe@email.com';

-- Compter le nombre d'utilisateurs
SELECT COUNT(*)
FROM app_user;

-- ============================================================================
-- TICKETS
-- ============================================================================

-- Afficher tous les tickets
SELECT *
FROM vw_ticket_details;

-- Rechercher un ticket par son identifiant
SELECT *
FROM vw_ticket_details
WHERE id = 1;

-- Tous les tickets d'un utilisateur
SELECT *
FROM vw_ticket_details
WHERE creator_id = 1;

-- Tous les tickets affectés à un utilisateur
SELECT *
FROM vw_ticket_details
WHERE assignee_id = 2;

-- Tous les tickets ouverts
SELECT *
FROM vw_ticket_details
WHERE status IN ('TO_DO', 'IN_PROGRESS', 'ON_HOLD');

-- Tous les tickets fermés
SELECT *
FROM vw_ticket_details
WHERE status = 'CLOSED';

-- Tickets critiques
SELECT *
FROM vw_ticket_details
WHERE priority = 'CRITICAL';

-- Tickets d'une catégorie
SELECT *
FROM vw_ticket_details
WHERE category = 'BUG';

-- ============================================================================
-- COMMENTAIRES
-- ============================================================================

-- Tous les commentaires d'un ticket
SELECT *
FROM vw_ticket_comments
WHERE ticket_id = 1
ORDER BY created_at;

-- Nombre de commentaires d'un ticket
SELECT COUNT(*)
FROM ticket_comment
WHERE ticket_id = 1;

-- ============================================================================
-- STATISTIQUES
-- ============================================================================

-- Nombre de tickets par statut
SELECT
    ts.name,
    COUNT(*) AS total
FROM ticket t
JOIN ticket_status ts
    ON ts.id = t.status_id
GROUP BY ts.name
ORDER BY ts.name;

-- Nombre de tickets par priorité
SELECT
    tp.name,
    COUNT(*) AS total
FROM ticket t
JOIN ticket_priority tp
    ON tp.id = t.priority_id
GROUP BY tp.name
ORDER BY tp.level;

-- Nombre de tickets par catégorie
SELECT
    tc.name,
    COUNT(*) AS total
FROM ticket t
JOIN ticket_category tc
    ON tc.id = t.category_id
GROUP BY tc.name
ORDER BY tc.name;

-- Nombre de tickets créés par utilisateur
SELECT
    u.firstname,
    u.lastname,
    COUNT(*) AS total
FROM ticket t
JOIN app_user u
    ON u.id = t.creator_id
GROUP BY u.id, u.firstname, u.lastname
ORDER BY total DESC;

-- ============================================================================
-- MAINTENANCE
-- ============================================================================

-- Nombre de lignes par table
SELECT COUNT(*) FROM app_user;
SELECT COUNT(*) FROM ticket;
SELECT COUNT(*) FROM ticket_comment;
SELECT COUNT(*) FROM ticket_attachment;
SELECT COUNT(*) FROM ticket_history;

-- Vérifier les statuts disponibles
SELECT *
FROM ticket_status;

-- Vérifier les priorités disponibles
SELECT *
FROM ticket_priority;

-- Vérifier les catégories disponibles
SELECT *
FROM ticket_category;

-- Vérifier les rôles disponibles
SELECT *
FROM role;

-- Vérifier les statuts utilisateur
SELECT *
FROM user_status;