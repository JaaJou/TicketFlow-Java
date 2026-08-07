SET search_path TO ticketflow;

INSERT INTO app_user
(
    firstname,
    lastname,
    email,
    password_hash,
    phone,
    profile_picture_url,
    email_verified,
    status_id,
    created_at,
    updated_at,
    last_login_at
)
VALUES
('Jean','Dupont','jean.dupont@ticketflow.fr','$2a$10$dummyPasswordHash','0601020304',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Marie','Martin','marie.martin@ticketflow.fr','$2a$10$dummyPasswordHash','0601020305',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Pierre','Bernard','pierre.bernard@ticketflow.fr','$2a$10$dummyPasswordHash','0601020306',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Julie','Petit','julie.petit@ticketflow.fr','$2a$10$dummyPasswordHash','0601020307',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Thomas','Robert','thomas.robert@ticketflow.fr','$2a$10$dummyPasswordHash','0601020308',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Camille','Richard','camille.richard@ticketflow.fr','$2a$10$dummyPasswordHash','0601020309',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Lucas','Durand','lucas.durand@ticketflow.fr','$2a$10$dummyPasswordHash','0601020310',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Emma','Moreau','emma.moreau@ticketflow.fr','$2a$10$dummyPasswordHash','0601020311',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Hugo','Simon','hugo.simon@ticketflow.fr','$2a$10$dummyPasswordHash','0601020312',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Léa','Laurent','lea.laurent@ticketflow.fr','$2a$10$dummyPasswordHash','0601020313',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Nathan','Michel','nathan.michel@ticketflow.fr','$2a$10$dummyPasswordHash','0601020314',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Sarah','Garcia','sarah.garcia@ticketflow.fr','$2a$10$dummyPasswordHash','0601020315',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Antoine','David','antoine.david@ticketflow.fr','$2a$10$dummyPasswordHash','0601020316',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Chloé','Roux','chloe.roux@ticketflow.fr','$2a$10$dummyPasswordHash','0601020317',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Louis','Vincent','louis.vincent@ticketflow.fr','$2a$10$dummyPasswordHash','0601020318',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Manon','Fournier','manon.fournier@ticketflow.fr','$2a$10$dummyPasswordHash','0601020319',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Arthur','Morel','arthur.morel@ticketflow.fr','$2a$10$dummyPasswordHash','0601020320',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Lucie','Girard','lucie.girard@ticketflow.fr','$2a$10$dummyPasswordHash','0601020321',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Gabriel','Andre','gabriel.andre@ticketflow.fr','$2a$10$dummyPasswordHash','0601020322',NULL,TRUE,1,NOW(),NOW(),NOW()),
('Clara','Lefebvre','clara.lefebvre@ticketflow.fr','$2a$10$dummyPasswordHash','0601020323',NULL,TRUE,1,NOW(),NOW(),NOW());


INSERT INTO user_role
(
    user_id,
    role_id,
    assigned_at
)
VALUES
-- Administrateurs
(1, 2, NOW()),
(2, 2, NOW()),

-- Utilisateurs
(3, 1, NOW()),
(4, 1, NOW()),
(5, 1, NOW()),
(6, 1, NOW()),
(7, 1, NOW()),
(8, 1, NOW()),
(9, 1, NOW()),
(10, 1, NOW()),
(11, 1, NOW()),
(12, 1, NOW()),
(13, 1, NOW()),
(14, 1, NOW()),
(15, 1, NOW()),
(16, 1, NOW()),
(17, 1, NOW()),
(18, 1, NOW()),
(19, 1, NOW()),
(20, 1, NOW());