/******************************************************************************
 * Projet : TicketFlow
 * Script : 04_indexes.sql
 * Objet   : Création des index
 ******************************************************************************/

/*
Une règle importante :
- Les clés primaires (PRIMARY KEY) sont déjà indexées automatiquement par PostgreSQL.
- Les colonnes UNIQUE sont également indexées automatiquement.
- On crée donc des index uniquement sur les colonnes fréquemment utilisées dans les WHERE, JOIN et ORDER BY.
*/

SET search_path TO ticketflow;

-- ============================================================================
-- APP_USER
-- ============================================================================

-- Recherche d'un utilisateur par son statut
CREATE INDEX idx_app_user_status
ON app_user(status_id);

-- ============================================================================
-- TICKET
-- ============================================================================

-- Recherche des tickets créés par un utilisateur
CREATE INDEX idx_ticket_creator
ON ticket(creator_id);

-- Recherche des tickets affectés à un utilisateur
CREATE INDEX idx_ticket_assignee
ON ticket(assignee_id);

-- Recherche des tickets par statut
CREATE INDEX idx_ticket_status
ON ticket(status_id);

-- Recherche des tickets par priorité
CREATE INDEX idx_ticket_priority
ON ticket(priority_id);

-- Recherche des tickets par catégorie
CREATE INDEX idx_ticket_category
ON ticket(category_id);

-- Tri des tickets par date de création
CREATE INDEX idx_ticket_created_at
ON ticket(created_at);

-- ============================================================================
-- TICKET_COMMENT
-- ============================================================================

-- Recherche des commentaires d'un ticket
CREATE INDEX idx_ticket_comment_ticket
ON ticket_comment(ticket_id);

-- Recherche des commentaires d'un utilisateur
CREATE INDEX idx_ticket_comment_author
ON ticket_comment(author_id);

-- ============================================================================
-- TICKET_ATTACHMENT
-- ============================================================================

-- Recherche des pièces jointes d'un ticket
CREATE INDEX idx_ticket_attachment_ticket
ON ticket_attachment(ticket_id);

-- ============================================================================
-- TICKET_HISTORY
-- ============================================================================

-- Recherche de l'historique d'un ticket
CREATE INDEX idx_ticket_history_ticket
ON ticket_history(ticket_id);

-- Recherche des actions réalisées par un utilisateur
CREATE INDEX idx_ticket_history_user
ON ticket_history(user_id);

-- ============================================================================
-- EMAIL VERIFICATION TOKEN
-- ============================================================================

-- Recherche des jetons d'un utilisateur
CREATE INDEX idx_email_verification_user
ON email_verification_token(user_id);

-- ============================================================================
-- PASSWORD RESET TOKEN
-- ============================================================================

-- Recherche des jetons de réinitialisation d'un utilisateur
CREATE INDEX idx_password_reset_user
ON password_reset_token(user_id);