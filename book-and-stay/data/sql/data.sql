-- =========================
-- RESIDENCE
-- =========================

INSERT INTO RESIDENCE VALUES
(1, 'Nice', '12 rue de la Paix'),
(2, 'Sophia-Antipolis', '450 route des Lucioles');

-- =========================
-- TYPE_LOGEMENT
-- =========================

INSERT INTO TYPE_LOGEMENT VALUES
(1, 'Chambre simple', 45.00),
(2, 'T2', 30.00),
(3, 'Studio', 60.00);

-- =========================
-- LOGEMENT
-- =========================

INSERT INTO LOGEMENT VALUES
(1, 1, false, 1, 1),
(2, 3, true, 1, 2),
(3, 1, false, 2, 3),
(4, 2, true, 2, 2);

-- =========================
-- EQUIPEMENT
-- =========================

INSERT INTO EQUIPEMENT VALUES
(1, 'Balcon', 1),
(2, 'WiFi', 1),
(3, 'Télévision', 2),
(4, 'WiFi', 2),
(5, 'Balcon', 3),
(6, 'WiFi', 4);

-- =========================
-- RESIDENT
-- =========================

INSERT INTO RESIDENT VALUES
(1, 'Dupont', 'Alice', 'alice.dupont@mail.com', '0600000001', '1998-05-12'),
(2, 'Martin', 'Bob', 'bob.martin@mail.com', '0600000002', '1995-08-22'),
(3, 'Durand', 'Claire', 'claire.durand@mail.com', '0600000003', '2000-01-10'),
(4, 'Bernard', 'David', 'david.bernard@mail.com', '0600000004', '1997-03-18');

-- =========================
-- RESERVATION 
-- =========================

INSERT INTO RESERVATION VALUES
(1, 1, 1, '2026-01-01', '2026-01-10'),
(2, 2, 1, '2026-01-12', '2026-01-20'),
(3, 3, 2, '2026-01-05', '2026-01-25'),
(4, 4, 3, '2026-01-01', '2026-01-15');

-- =========================
-- MAINTENANCE 
-- =========================

INSERT INTO MAINTENANCE VALUES
(1, 'Plomberie', '2026-01-08', '2026-01-12', 'elevee', 'Fuite importante', 1),
(2, 'Electricité', '2026-01-03', '2026-01-04', 'faible', 'Ampoule défectueuse', 3);

-- =========================
-- CONFLIT
-- =========================

INSERT INTO CONFLIT VALUES
(1, 'Conflit de bruit', '2026-01-10', 3, 2);

INSERT INTO IMPLICATION_CONFLIT VALUES
(1, 3),
(1, 4);

-- =========================
-- EVENEMENT 
-- =========================

INSERT INTO EVENEMENT VALUES
(1, 'Soirée Pizza', '2026-01-14 19:00:00', 'Salle commune', 1),
(2, 'Séance Yoga', '2026-01-16 18:00:00', 'Terrasse', 2);

INSERT INTO PARTICIPATION_EVENEMENT VALUES
(1, 1, 'Très sympa'),
(2, 1, 'Bonne ambiance'),
(3, 2, 'Relaxant'),
(4, 2, 'Intéressant');