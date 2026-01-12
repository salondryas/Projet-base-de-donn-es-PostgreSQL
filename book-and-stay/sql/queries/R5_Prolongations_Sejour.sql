-- R5 – Impact des Prolongations de Séjour

-- Étape 1 : ordonner les réservations par résident et logement

WITH Reservations_Ordonnees AS (
    SELECT
        r.id_resident,
        r.id_logement,
        r.date_debut_sejour,
        r.date_fin_sejour,
        LAG(r.date_fin_sejour) OVER (
            PARTITION BY r.id_resident, r.id_logement
            ORDER BY r.date_debut_sejour
        ) AS date_fin_precedente
    FROM RESERVATION r
),

-- Étape 2 : détection des prolongations
-- (réservations consécutives sans interruption)

Prolongations AS (
    SELECT
        id_resident,
        id_logement,
        date_debut_sejour,
        date_fin_sejour,
        (date_fin_sejour - date_fin_precedente) AS jours_prolonges
    FROM Reservations_Ordonnees
    WHERE date_fin_precedente IS NOT NULL
      AND date_debut_sejour = date_fin_precedente + INTERVAL '1 day'
),

-- Étape 3 : impact des prolongations par résident

Impact_Prolongations AS (
    SELECT
        id_resident,
        COUNT(*) AS nb_prolongations,
        SUM(jours_prolonges) AS jours_indisponibles_generes
    FROM Prolongations
    GROUP BY id_resident
)

-- Étape 4 : Requête finale

SELECT
    res.id_resident,
    res.nom,
    res.prenom,
    ip.nb_prolongations,
    ip.jours_indisponibles_generes
FROM Impact_Prolongations ip
JOIN RESIDENT res
    ON ip.id_resident = res.id_resident
ORDER BY ip.jours_indisponibles_generes DESC;
