/******************************************************************************
 * Projet : TicketFlow
 * Script : 01_schema.sql
 * Objet   : Création du schéma de la base de données
 *
 * Ce script est le premier à exécuter.
 * Il crée le schéma applicatif et configure la session SQL.
 *
 *  01_schema.sql
 *      Création du schéma ticketflow
 *      Configuration initiale
 *  02_tables.sql
 *      Création de toutes les tables
 *      Colonnes
 *      Clés primaires
 *      Contraintes (NOT NULL, UNIQUE, etc.)
 *  03_foreign_keys.sql
 *      Toutes les relations entre les tables
 *  04_indexes.sql
 *      Création des index pour les recherches fréquentes
 *  05_init_data.sql
 *      Insertion des données de référence
 *      Statuts
 *      Priorités
 *      Catégories
 *  06_views.sql (optionnel)
 *      Vues SQL utiles
 *  07_queries_examples.sql (optionnel)
 *      Exemples de requêtes courantes
 ******************************************************************************/

-- ============================================================================
-- Création du schéma de l'application
-- ============================================================================
-- Un schéma permet de regrouper toutes les tables de TicketFlow.
-- Cela évite de tout placer dans le schéma "public".
--
-- IF NOT EXISTS évite une erreur si le schéma existe déjà.
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS ticketflow;

-- ============================================================================
-- Définition du schéma par défaut
-- ============================================================================
-- Toutes les tables créées par la suite seront créées dans le schéma
-- "ticketflow", sans avoir besoin d'écrire ticketflow.nom_table.
-- ============================================================================

SET search_path TO ticketflow;

-- ============================================================================
-- Vérification (optionnel)
-- ============================================================================
-- Permet de vérifier le schéma actuellement utilisé.
-- ============================================================================

SHOW search_path;