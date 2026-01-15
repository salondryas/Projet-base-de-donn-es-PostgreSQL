-- AJOUT DE NOUVEAUX RÉSIDENTS
INSERT INTO RESIDENT VALUES (7, 'Petit', 'Hugo', 'hugo@mail.com', '0600000007', '2001-05-05');
INSERT INTO RESIDENT VALUES (8, 'Rousseau', 'Lea', 'lea@mail.com', '0600000008', '1994-11-30');

-- RÉSERVATIONS ACTUELLES (Aujourd'hui : 12 Janvier 2026)
-- Hugo est à Nice (Residence 1), Lea est à Sophia (Residence 2)
INSERT INTO RESERVATION VALUES (7, 7, 1, '2026-01-01', '2026-02-01');
INSERT INTO RESERVATION VALUES (8, 8, 4, '2026-01-01', '2026-02-01');

-- HISTORIQUE DE PARTICIPATION
-- Hugo (Résidence 1) a adoré le Yoga (qui a eu lieu en Résidence 2)
INSERT INTO PARTICIPATION_EVENEMENT VALUES (7, 2, 'Génial');

-- CAS LIMITE : Ex-æquo de popularité en Résidence 1
-- On ajoute un nouvel événement passé pour créer une égalité
INSERT INTO EVENEMENT VALUES (3, 'Tournoi E-sport', '2025-12-20 14:00:00', 'Lobby', 1);
-- Alice (1) et Bob (2) y ont participé (ils sont en Résidence 1)
INSERT INTO PARTICIPATION_EVENEMENT VALUES (1, 3, 'Top');
INSERT INTO PARTICIPATION_EVENEMENT VALUES (2, 3, 'À refaire');