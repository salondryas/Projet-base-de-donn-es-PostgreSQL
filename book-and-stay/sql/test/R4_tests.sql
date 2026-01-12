-- ======================================================
-- Jeu de tests – R4 Analyse Maintenance
-- Objectif :
-- Valider l’identification des logements nécessitant
-- le plus d’interventions de maintenance sur les
-- 6 derniers mois et du type de panne dominant.
-- ======================================================


-- ======================================================
-- Cas 1 : Logement avec plusieurs maintenances
-- Type dominant = Plomberie
-- ======================================================

INSERT INTO MAINTENANCE VALUES
(3, 'Plomberie',   '2026-01-20', '2026-01-21', 'faible', 'Robinet défectueux', 1),
(4, 'Plomberie',   '2026-02-05', '2026-02-06', 'faible', 'Fuite évier',         1),
(5, 'Electricité', '2026-02-10', '2026-02-10', 'faible', 'Prise HS',            1);


-- ======================================================
-- Cas 2 : Logement sans maintenance récente
-- → ne doit PAS apparaître dans le résultat
-- ======================================================
-- Logement 2 : aucun INSERT


-- ======================================================
-- Cas 3 : Égalité entre plusieurs types de maintenance
-- ======================================================

INSERT INTO MAINTENANCE VALUES
(6, 'Electricité', '2026-01-18', '2026-01-18', 'faible', 'Interrupteur', 3),
(7, 'Plomberie',   '2026-01-22', '2026-01-23', 'elevee', 'Canalisation', 3);


-- ======================================================
-- Cas 4 : Maintenance hors période (plus de 6 mois)
-- → doit être ignorée
-- ======================================================

INSERT INTO MAINTENANCE VALUES
(8, 'Chauffage', '2025-01-10', '2025-01-12', 'elevee', 'Radiateur cassé', 4);
