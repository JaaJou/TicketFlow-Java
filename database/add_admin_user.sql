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
    ('admin','admin','admin@ticketflow.fr','$2a$10$WPhGGKSYjt3KGyqxdY15pOO5fw2LdS6YVSfb2HH8Ta4r.JWIoxgf2','060000000',NULL,TRUE,1,NOW(),NOW(),NOW());
