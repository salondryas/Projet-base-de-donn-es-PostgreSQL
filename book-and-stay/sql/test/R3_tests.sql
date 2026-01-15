-- Ajout de résidents pour peupler une colocation
INSERT INTO RESIDENT VALUES (5, 'Lefebvre', 'Emma', 'emma@mail.com', '0600000005', '1999-12-01');
INSERT INTO RESIDENT VALUES (6, 'Moreau', 'Jean', 'jean@mail.com', '0600000006', '1996-07-20');

-- Création d'une colocation active au 12 Janvier 2026 (Logement 2)
-- Claire (3) est déjà là. On ajoute Emma (5) et Jean (6).
INSERT INTO RESERVATION VALUES (5, 5, 2, '2026-01-01', '2026-01-30');
INSERT INTO RESERVATION VALUES (6, 6, 2, '2026-01-10', '2026-01-15');

-- CAS LIMITE 1 : Un conflit qui ne concerne que 2 personnes sur les 3
-- Conflit entre Claire (3) et Emma (5) dans le logement 2
INSERT INTO CONFLIT VALUES (2, 'Bruit nocturne', '2026-01-11', 2, 2);
INSERT INTO IMPLICATION_CONFLIT VALUES (2, 3), (2, 5);

-- CAS LIMITE 2 : Un résident en conflit mais dans une réservation passée
-- On crée un conflit historique pour Alice (1) qui n'est plus dans le logement 1
INSERT INTO CONFLIT VALUES (3, 'Ancien litige', '2026-01-05', 1, 1);
INSERT INTO IMPLICATION_CONFLIT VALUES (3, 1), (3, 2);