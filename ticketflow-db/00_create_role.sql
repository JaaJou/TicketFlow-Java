/******************************************************************************
 * Création de l'utilisateur PostgreSQL de l'application TicketFlow
 * À exécuter une seule fois avec un compte administrateur PostgreSQL.
 ******************************************************************************/

-- Création du rôle
CREATE ROLE ticketflow_app
WITH LOGIN
PASSWORD 'ticketflow_mdp';

-- Autorisation de connexion à la base
GRANT CONNECT ON DATABASE ticketflow TO ticketflow_app;

-- Autorisation d'utiliser le schéma
GRANT USAGE ON SCHEMA ticketflow TO ticketflow_app;

-- Droits sur toutes les tables existantes
GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA ticketflow
TO ticketflow_app;

-- Droits sur les séquences (IDENTITY)
GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA ticketflow
TO ticketflow_app;