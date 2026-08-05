/******************************************************************************
 * Projet : TicketFlow
 * Script : 03_foreign_keys.sql
 * Objet   : Création des clés étrangères
 * Le principe est simple : toutes les clés étrangères sont regroupées dans un seul script. 
 * Cela permet de créer les tables dans n'importe quel ordre puis de lier le modèle une fois que toutes les tables existent.
 ******************************************************************************/

SET search_path TO ticketflow;

-- ============================================================================
-- APP_USER
-- ============================================================================

ALTER TABLE app_user
ADD CONSTRAINT fk_app_user_status
FOREIGN KEY (status_id)
REFERENCES user_status(id);

ALTER TABLE app_user
ADD CONSTRAINT fk_app_user_role
FOREIGN KEY (role_id)
REFERENCES role(id);

-- ============================================================================
-- EMAIL VERIFICATION TOKEN
-- ============================================================================

ALTER TABLE email_verification_token
ADD CONSTRAINT fk_email_verification_user
FOREIGN KEY (user_id)
REFERENCES app_user(id)
ON DELETE CASCADE;

-- ============================================================================
-- PASSWORD RESET TOKEN
-- ============================================================================

ALTER TABLE password_reset_token
ADD CONSTRAINT fk_password_reset_user
FOREIGN KEY (user_id)
REFERENCES app_user(id)
ON DELETE CASCADE;

-- ============================================================================
-- TICKET
-- ============================================================================

ALTER TABLE ticket
ADD CONSTRAINT fk_ticket_creator
FOREIGN KEY (creator_id)
REFERENCES app_user(id)
ON DELETE RESTRICT;

ALTER TABLE ticket
ADD CONSTRAINT fk_ticket_assignee
FOREIGN KEY (assignee_id)
REFERENCES app_user(id)
ON DELETE SET NULL;

ALTER TABLE ticket
ADD CONSTRAINT fk_ticket_status
FOREIGN KEY (status_id)
REFERENCES ticket_status(id);

ALTER TABLE ticket
ADD CONSTRAINT fk_ticket_priority
FOREIGN KEY (priority_id)
REFERENCES ticket_priority(id);

ALTER TABLE ticket
ADD CONSTRAINT fk_ticket_category
FOREIGN KEY (category_id)
REFERENCES ticket_category(id);

-- ============================================================================
-- COMMENTAIRES
-- ============================================================================

ALTER TABLE ticket_comment
ADD CONSTRAINT fk_comment_ticket
FOREIGN KEY (ticket_id)
REFERENCES ticket(id)
ON DELETE CASCADE;

ALTER TABLE ticket_comment
ADD CONSTRAINT fk_comment_author
FOREIGN KEY (author_id)
REFERENCES app_user(id)
ON DELETE RESTRICT;

-- ============================================================================
-- PIECES JOINTES
-- ============================================================================

ALTER TABLE ticket_attachment
ADD CONSTRAINT fk_attachment_ticket
FOREIGN KEY (ticket_id)
REFERENCES ticket(id)
ON DELETE CASCADE;

ALTER TABLE ticket_attachment
ADD CONSTRAINT fk_attachment_uploader
FOREIGN KEY (uploader_id)
REFERENCES app_user(id)
ON DELETE RESTRICT;

-- ============================================================================
-- HISTORIQUE
-- ============================================================================

ALTER TABLE ticket_history
ADD CONSTRAINT fk_history_ticket
FOREIGN KEY (ticket_id)
REFERENCES ticket(id)
ON DELETE CASCADE;

ALTER TABLE ticket_history
ADD CONSTRAINT fk_history_user
FOREIGN KEY (user_id)
REFERENCES app_user(id)
ON DELETE RESTRICT;

/*
Pourquoi ces choix ?

Je n'ai pas choisi les ON DELETE au hasard.

Relation	Action	Justification
Utilisateur → Jetons	CASCADE	Si un utilisateur est supprimé, ses jetons n'ont plus d'utilité.
Ticket → Commentaires	CASCADE	Un commentaire ne peut pas exister sans ticket.
Ticket → Pièces jointes	CASCADE	Même logique.
Ticket → Historique	CASCADE	L'historique appartient au ticket.
Ticket → Créateur	RESTRICT	On ne doit pas supprimer un utilisateur ayant créé des tickets.
Ticket → Assigné	SET NULL	Si le technicien disparaît, le ticket reste non affecté.
Commentaire → Auteur	RESTRICT	On conserve l'auteur des commentaires.
Pièce jointe → Auteur	RESTRICT	On conserve l'information sur l'auteur de l'ajout.
Historique → Utilisateur	RESTRICT	On conserve la traçabilité des actions.
Une dernière recommandation

Je te recommande d'éviter la suppression physique des utilisateurs.

Dans une application de tickets, il est préférable de procéder à une suppression logique :

conserver la ligne dans app_user ;
passer son status à DISABLED ;
empêcher sa connexion.

Ainsi, tu conserves :

les tickets créés ;
les commentaires ;
l'historique ;
les statistiques.

C'est l'approche adoptée dans la plupart des applications professionnelles (Jira, GLPI, Redmine, GitLab, etc.).

À partir du prochain script (04_indexes.sql), nous allons nous concentrer sur les performances de la base en créant les index réellement utiles aux recherches les plus fréquentes.
*/