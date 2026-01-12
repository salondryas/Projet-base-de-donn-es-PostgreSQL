-- ======================================================
-- Jeu de tests – R5 Impact des prolongations
-- Objectif :
-- Valider l’identification des prolongations de séjour
-- modélisées par des réservations consécutives et
-- mesurer l’indisponibilité générée pour les
-- réservations futures.
-- ======================================================


-- ======================================================
-- Cas 1 : Résident sans prolongation
-- Réservations non consécutives
-- ======================================================

INSERT INTO RESERVATION VALUES
(21, 4, 4, '2026-02-01', '2026-02-05'),
(22, 4, 4, '2026-02-10', '2026-02-15');


-- ======================================================
-- Cas 2 : Prolongation simple
-- Deux réservations consécutives sur le même logement
-- ======================================================

INSERT INTO RESERVATION VALUES
(23, 1, 1, '2026-03-01', '2026-03-10'),
(24, 1, 1, '2026-03-11', '2026-03-18');


-- ======================================================
-- Cas 3 : Prolongations multiples (fort impact)
-- Chaîne de réservations consécutives
-- ======================================================

INSERT INTO RESERVATION VALUES
(25, 2, 2, '2026-04-01', '2026-04-07'),
(26, 2, 2, '2026-04-08', '2026-04-14'),
(27, 2, 2, '2026-04-15', '2026-04-25');


-- ======================================================
-- Cas 4 : Changement de logement
-- Réservations consécutives mais logements différents
-- ======================================================

INSERT INTO RESERVATION VALUES
(28, 3, 1, '2026-05-01', '2026-05-05'),
(29, 3, 2, '2026-05-06', '2026-05-12');


-- ======================================================
-- Cas 5 : Interruption entre réservations
-- ======================================================

INSERT INTO RESERVATION VALUES
(30, 1, 1, '2026-06-01', '2026-06-05'),
(31, 1, 1, '2026-06-07', '2026-06-12');