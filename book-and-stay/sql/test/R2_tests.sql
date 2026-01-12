-- ======================================================
-- PRÉPARATION : Création des références pour le test R2
-- ======================================================
INSERT INTO LOGEMENT (id_logement, nombre_chambres, colocation, id_residence, id_type) VALUES
(71, 1, false, 2, 1), -- Cas 1 : Trou parfait (3 jours)
(72, 1, false, 2, 1), -- Cas 2 : Pas de trou (enchaînement)
(73, 1, false, 2, 1); -- Cas 3 : Trou trop grand (10 jours)

-- ======================================================
-- Jeu de tests – R2 Optimisation
-- Objectif : Repérer les creux de 1 à 5 jours entre
-- deux réservations pour faire des promos.
-- ======================================================

-- ======================================================
-- Cas 1 : Trou Parfait (Cible)
-- Fin le 01/02, Suivante le 05/02
-- → Trou de 3 jours (2, 3, 4 Fev)
-- → DOIT apparaître : Durée = 3
-- ======================================================
INSERT INTO RESERVATION (id_reservation, date_debut_sejour, date_fin_sejour, id_resident, id_logement) VALUES
(701, '2026-01-20', '2026-02-01', 1, 71),
(702, '2026-02-05', '2026-02-10', 2, 71);

-- ======================================================
-- Cas 2 : Pas de trou (Continuité)
-- Fin le 01/02, Suivante le 02/02
-- → 0 jour de battement
-- → NE DOIT PAS apparaître
-- ======================================================
INSERT INTO RESERVATION (id_reservation, date_debut_sejour, date_fin_sejour, id_resident, id_logement) VALUES
(703, '2026-01-20', '2026-02-01', 1, 72),
(704, '2026-02-02', '2026-02-10', 3, 72); -- Notez que le 02 suit le 01 directement

-- ======================================================
-- Cas 3 : Trou trop grand (Hors cible)
-- Fin le 01/02, Suivante le 12/02
-- → Trou de 10 jours (> 5 jours)
-- → NE DOIT PAS apparaître
-- ======================================================
INSERT INTO RESERVATION (id_reservation, date_debut_sejour, date_fin_sejour, id_resident, id_logement) VALUES
(705, '2026-01-20', '2026-02-01', 1, 73),
(706, '2026-02-12', '2026-02-20', 4, 73);
