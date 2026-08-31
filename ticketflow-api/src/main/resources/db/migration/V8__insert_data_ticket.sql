SET search_path TO ticketflow;

INSERT INTO ticket
(
    title,
    description,
    creator_id,
    assignee_id,
    status_id,
    priority_id,
    category_id,
    created_at,
    updated_at,
    closed_at
)
VALUES
('Impossible de se connecter', 'L''utilisateur ne peut pas se connecter malgré des identifiants valides.', 3, 1, 1, 2, 3, NOW(), NOW(), NULL),

('Erreur 500 lors de la création d''un ticket', 'Une erreur interne est affichée lors de la création d''un nouveau ticket.', 4, 2, 2, 3, 1, NOW(), NOW(), NULL),

('Ajouter un mode sombre', 'Proposition d''ajouter un thème sombre à l''application.', 5, 1, 4, 1, 2, NOW(), NOW(), NOW()),

('Réinitialisation du mot de passe impossible', 'Le lien reçu par email est expiré immédiatement.', 6, 2, 3, 2, 3, NOW(), NOW(), NULL),

('Serveur de préproduction inaccessible', 'Le serveur ne répond plus depuis ce matin.', 7, 1, 2, 4, 4, NOW(), NOW(), NULL),

('Affichage incorrect sur mobile', 'Les boutons dépassent de l''écran sur smartphone.', 8, 2, 1, 2, 1, NOW(), NOW(), NULL),

('Export PDF des tickets', 'Ajouter une fonctionnalité d''export au format PDF.', 9, 1, 5, 1, 2, NOW(), NOW(), NOW()),

('Erreur SQL lors de la sauvegarde', 'Violation de contrainte lors de l''enregistrement.', 10, 2, 2, 3, 1, NOW(), NOW(), NULL),

('Photo de profil non enregistrée', 'La nouvelle photo n''est jamais sauvegardée.', 11, 1, 1, 2, 3, NOW(), NOW(), NULL),

('Ajouter un filtre par priorité', 'Pouvoir filtrer les tickets selon leur priorité.', 12, 2, 4, 2, 2, NOW(), NOW(), NOW()),

('Notifications email absentes', 'Aucun email n''est envoyé lors d''une mise à jour.', 13, 1, 3, 3, 3, NOW(), NOW(), NULL),

('Performances dégradées', 'Les recherches prennent plus de dix secondes.', 14, 2, 2, 4, 4, NOW(), NOW(), NULL),

('Tri des tickets par date', 'Ajouter un tri croissant et décroissant.', 15, 1, 5, 1, 2, NOW(), NOW(), NOW()),

('Erreur JavaScript', 'Une exception JavaScript apparaît à l''ouverture du tableau de bord.', 16, 2, 1, 2, 1, NOW(), NOW(), NULL),

('Compte utilisateur verrouillé', 'Le compte reste verrouillé après réinitialisation du mot de passe.', 17, 1, 2, 3, 3, NOW(), NOW(), NULL),

('Erreur de validation du formulaire', 'Le formulaire refuse des données pourtant valides.', 18, 2, 1, 2, 3, NOW(), NOW(), NULL),

('Page blanche après connexion', 'Une page blanche apparaît immédiatement après authentification.', 19, 1, 2, 3, 1, NOW(), NOW(), NULL),

('Ajouter un tableau de bord', 'Créer un tableau de bord avec les principaux indicateurs.', 20, 2, 4, 1, 2, NOW(), NOW(), NOW()),

('Notifications en double', 'Deux emails sont envoyés pour une seule action.', 3, 1, 3, 2, 3, NOW(), NOW(), NULL),

('Serveur de fichiers indisponible', 'Le stockage des pièces jointes ne répond plus.', 4, 2, 2, 4, 4, NOW(), NOW(), NULL),

('Recherche avancée', 'Ajouter une recherche multicritère sur les tickets.', 5, 1, 5, 1, 2, NOW(), NOW(), NOW()),

('Suppression de commentaire impossible', 'Une erreur apparaît lors de la suppression d''un commentaire.', 6, 2, 1, 3, 1, NOW(), NOW(), NULL),

('Session expirée rapidement', 'La session utilisateur expire après quelques minutes.', 7, 1, 2, 2, 3, NOW(), NOW(), NULL),

('Ajout d''un champ SLA', 'Permettre de définir un délai de traitement.', 8, 2, 4, 2, 2, NOW(), NOW(), NOW()),

('Charge CPU importante', 'Le serveur présente une consommation CPU anormale.', 9, 1, 3, 4, 4, NOW(), NOW(), NULL),

('API REST retourne une erreur', 'L''API renvoie un code HTTP 400 de manière aléatoire.', 10, 2, 2, 3, 1, NOW(), NOW(), NULL),

('Téléversement d''images impossible', 'Les images de profil ne peuvent plus être importées.', 11, 1, 1, 2, 3, NOW(), NOW(), NULL),

('Historique des actions', 'Ajouter un historique complet des modifications des tickets.', 12, 2, 5, 1, 2, NOW(), NOW(), NOW()),

('Email de confirmation absent', 'Le mail de validation du compte n''est jamais reçu.', 13, 1, 2, 3, 3, NOW(), NOW(), NULL),

('Problème d''encodage UTF-8', 'Les caractères accentués sont affichés de manière incorrecte.', 14, 2, 4, 2, 1, NOW(), NOW(), NOW());