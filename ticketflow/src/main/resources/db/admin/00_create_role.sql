-- ============================================================
-- Création du rôle applicatif
-- ============================================================

CREATE ROLE ticketflow_app
    WITH
    LOGIN
    PASSWORD 'ticketflow_mdp';

-- ============================================================
-- Création de la base
-- ============================================================

CREATE DATABASE ticketflow
    OWNER ticketflow_app;

-- ============================================================
-- Connexion à la base ticketflow
-- ============================================================
-- À exécuter ensuite dans la base ticketflow

CREATE SCHEMA IF NOT EXISTS ticketflow
    AUTHORIZATION ticketflow_app;

GRANT CONNECT ON DATABASE ticketflow TO ticketflow_app;
GRANT CREATE ON DATABASE ticketflow TO ticketflow_app;

GRANT USAGE, CREATE
ON SCHEMA ticketflow
TO ticketflow_app;

-- Objets existants
GRANT ALL PRIVILEGES
ON ALL TABLES IN SCHEMA ticketflow
TO ticketflow_app;

GRANT ALL PRIVILEGES
ON ALL SEQUENCES IN SCHEMA ticketflow
TO ticketflow_app;

GRANT ALL PRIVILEGES
ON ALL FUNCTIONS IN SCHEMA ticketflow
TO ticketflow_app;

-- Objets futurs
ALTER DEFAULT PRIVILEGES
IN SCHEMA ticketflow
GRANT ALL PRIVILEGES ON TABLES
TO ticketflow_app;

ALTER DEFAULT PRIVILEGES
IN SCHEMA ticketflow
GRANT ALL PRIVILEGES ON SEQUENCES
TO ticketflow_app;

ALTER DEFAULT PRIVILEGES
IN SCHEMA ticketflow
GRANT ALL PRIVILEGES ON FUNCTIONS
TO ticketflow_app;