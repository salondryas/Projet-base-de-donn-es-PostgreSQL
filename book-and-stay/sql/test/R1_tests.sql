-- ======================================================
-- PRÉPARATION : Création des références pour le test R1
-- ======================================================
INSERT INTO LOGEMENT (id_logement, nombre_chambres, colocation, id_residence, id_type) VALUES
(51, 1, false, 1, 1), -- Cas 1 : Disponible
(52, 1, false, 1, 1), -- Cas 2 : Occupé (Chevauchement début)
(53, 1, false, 1, 1), -- Cas 3 : Occupé (Chevauchement fin)
(54, 1, false, 1, 1), -- Cas 4 : Occupé (Englobe la période)
(55, 1, false, 1, 1); -- Cas 5 : Occupé par Maintenance

-- ======================================================
-- Jeu de tests – R1 Disponibilité
-- Objectif : Identifier les logements libres entre
-- le 15/01/2026 et le 20/01/2026.
-- ======================================================

-- ======================================================
-- Cas 1 : Logement Disponible
-- Réservations AVANT et APRÈS la période cible
-- → DOIT apparaître dans le résultat
-- ======================================================
INSERT INTO RESERVATION (id_reservation, date_debut_sejour, date_fin_sejour, id_resident, id_logement) VALUES
(501, '2026-01-01', '2026-01-14', 1, 51), -- Finit juste avant
(502, '2026-01-21', '2026-01-30', 1, 51); -- Commence juste après

-- ======================================================
-- Cas 2 : Indisponible (Chevauchement Début)
-- Le séjour finit PENDANT la période cible (le 16)
-- → NE DOIT PAS apparaître
-- ======================================================
INSERT INTO RESERVATION (id_reservation, date_debut_sejour, date_fin_sejour, id_resident, id_logement) VALUES
(503, '2026-01-10', '2026-01-16', 2, 52);

-- ======================================================
-- Cas 3 : Indisponible (Chevauchement Fin)
-- Le séjour commence PENDANT la période cible (le 19)
-- → NE DOIT PAS apparaître
-- ======================================================
INSERT INTO RESERVATION (id_reservation, date_debut_sejour, date_fin_sejour, id_resident, id_logement) VALUES
(504, '2026-01-19', '2026-01-25', 2, 53);

-- ======================================================
-- Cas 4 : Indisponible (Total)
-- Le séjour englobe totalement la période
-- → NE DOIT PAS apparaître
-- ======================================================
INSERT INTO RESERVATION (id_reservation, date_debut_sejour, date_fin_sejour, id_resident, id_logement) VALUES
(505, '2026-01-01', '2026-01-30', 3, 54);
