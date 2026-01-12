-- R2 : Détection des "creux" de moins de 5 jours entre deux réservations
WITH AnalyseCreneaux AS (
    SELECT 
        id_logement,
        date_fin_sejour AS date_dispo_debut,
        LEAD(date_debut_sejour) OVER (PARTITION BY id_logement ORDER BY date_debut_sejour) AS date_dispo_fin
    FROM RESERVATION
)
SELECT 
    id_logement,
    date_dispo_debut,
    date_dispo_fin,
    (date_dispo_fin - date_dispo_debut) AS duree_creux
FROM AnalyseCreneaux
WHERE (date_dispo_fin - date_dispo_debut) BETWEEN 1 AND 5;
