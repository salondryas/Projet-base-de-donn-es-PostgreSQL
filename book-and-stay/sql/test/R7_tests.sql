-- ======================================================
-- PRÉPARATION COMPLÈTE : Test R7 Statistiques d'Attractivité
-- Tous les prérequis inclus pour éviter les erreurs FK
-- ======================================================

-- 1. INSERT RESIDENCE (requis pour LOGEMENT)
INSERT INTO RESIDENCE (id_residence, ville, adresse) VALUES
(1, 'Paris', '123 Rue de la Paix'),
(2, 'Lyon', '456 Avenue des Logements');

-- 2. INSERT TYPE_LOGEMENT (requis pour LOGEMENT)
INSERT INTO TYPE_LOGEMENT (id_type, libelle_type, prix_base_nuitee) VALUES
(1, 'Studio', 75.00),
(3, 'Appartement', 120.00);

-- 3. INSERT RESIDENT (requis pour RESERVATION)
INSERT INTO RESIDENT (id_resident, nom, prenom, email, telephone, date_naissance) VALUES
(1, 'Dupont', 'Jean', 'jean.dupont@email.com', '0123456789', '1985-03-15'),
(2, 'Martin', 'Marie', 'marie.martin@email.com', '0987654321', '1990-07-22'),
(3, 'Durand', 'Pierre', 'pierre.durand@email.com', '0112233445', '1988-11-30'),
(4, 'Lefevre', 'Sophie', 'sophie.lefevre@email.com', '0555666777', '1992-01-18');

-- 4. LOGEMENTS pour le test R7
INSERT INTO LOGEMENT (id_logement, nombre_chambres, colocation, id_residence, id_type) VALUES
(81, 1, false, 1, 1), -- Cas 1 : Avec Balcon, forte occupation
(82, 1, false, 1, 1), -- Cas 2 : Avec Balcon, forte occupation
(83, 1, false, 1, 1), -- Cas 3 : Sans Balcon, faible occupation
(84, 1, false, 1, 1), -- Cas 4 : Sans Balcon, faible occupation
(85, 1, false, 2, 3); -- Cas 5 : Sans équipement, pas de réservations

-- 5. EQUIPEMENTS
-- Cas 1-2 : AVEC Balcon (+ WiFi)
INSERT INTO EQUIPEMENT (id_equipement, nom_equipement, id_logement) VALUES
(23, 'Balcon', 81),
(24, 'WiFi', 81),
(25, 'Balcon', 82),
(26, 'WiFi', 82);

-- Cas 3-4 : SANS Balcon (seulement WiFi)
INSERT INTO EQUIPEMENT (id_equipement, nom_equipement, id_logement) VALUES
(27, 'WiFi', 83),
(28, 'WiFi', 84);

-- Cas 5 : AUCUN équipement

-- 6. RESERVATIONS - SYNTAXE CORRIGÉE (ordre des colonnes explicite)
-- Logement 81 : ~200 jours occupés → taux ~55%
INSERT INTO RESERVATION (id_reservation, date_debut_sejour, date_fin_sejour, id_resident, id_logement) VALUES
(801, '2025-02-01', '2025-03-15', 1, 81),
(802, '2025-04-01', '2025-05-20', 2, 81),
(803, '2025-06-10', '2025-07-25', 3, 81),
(804, '2025-09-01', '2025-10-10', 4, 81),
(805, '2025-11-15', '2025-12-31', 1, 81);

-- Logement 82 : ~180 jours occupés → taux ~49%
INSERT INTO RESERVATION (id_reservation, date_debut_sejour, date_fin_sejour, id_resident, id_logement) VALUES
(806, '2025-03-01', '2025-04-10', 2, 82),
(807, '2025-05-15', '2025-06-30', 3, 82),
(808, '2025-08-01', '2025-09-15', 4, 82),
(809, '2025-10-20', '2025-12-10', 1, 82);

-- Logement 83 : ~60 jours occupés → taux ~16%
INSERT INTO RESERVATION (id_reservation, date_debut_sejour, date_fin_sejour, id_resident, id_logement) VALUES
(810, '2025-03-01', '2025-03-20', 1, 83),
(811, '2025-07-10', '2025-07-30', 2, 83),
(812, '2025-11-01', '2025-11-20', 3, 83);

-- Logement 84 : ~50 jours occupés → taux ~14%
INSERT INTO RESERVATION (id_reservation, date_debut_sejour, date_fin_sejour, id_resident, id_logement) VALUES
(813, '2025-04-15', '2025-05-05', 2, 84),
(814, '2025-09-10', '2025-09-30', 4, 84);

-- Logement 85 : 0 réservation → taux 0%
