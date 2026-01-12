-- R6 – Planification Événementielle

-- Étape 1 : Creation d’une vue interets par residence

CREATE VIEW Vue_Interets_Residence AS
SELECT
    l.id_residence,
    e.titre,
    COUNT(DISTINCT pe.id_resident) AS popularite
FROM EVENEMENT e
JOIN PARTICIPATION_EVENEMENT pe 
    ON e.id_evenement = pe.id_evenement
JOIN RESERVATION r 
    ON pe.id_resident = r.id_resident
JOIN LOGEMENT l 
    ON r.id_logement = l.id_logement
WHERE CURRENT_DATE BETWEEN r.date_debut_sejour AND r.date_fin_sejour
GROUP BY l.id_residence, e.titre;


-- Étape 2 : evenement optimal

SELECT
    titre,
    popularite
FROM Vue_Interets_Residence
WHERE id_residence = id_residence
  AND popularite = (
      SELECT MAX(popularite)
      FROM Vue_Interets_Residence
      WHERE id_residence = id_residence
  );


-- Étape 3 : controle d’acces par profil (admin v gestionnaire)

CREATE ROLE gestionnaire;

GRANT SELECT 
ON Vue_Interets_Residence 
TO gestionnaire;


-- Étape 4 : transaction

BEGIN TRANSACTION;

INSERT INTO EVENEMENT (id_evenement, titre, date, lieu, id_residence)
SELECT 101, 'Soirée Pizza', '2026-03-15 19:00', 'Salle commune', 1
WHERE NOT EXISTS (
    SELECT 1 
    FROM EVENEMENT 
    WHERE id_evenement = 101
);

COMMIT;