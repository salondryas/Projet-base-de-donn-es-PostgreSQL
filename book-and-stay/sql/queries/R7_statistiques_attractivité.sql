-- R7 – Statistiques d'Attractivité

-- Étape 1 : Vue analytique pour calculer le taux d'occupation par logement

CREATE VIEW Vue_Taux_Occupation AS
WITH Occupation_Logements AS (
    SELECT 
        l.id_logement,
        l.id_type,
        t.libelle_type,
        COUNT(DISTINCT r.id_reservation) AS nb_reservations,
        COALESCE(SUM(r.date_fin_sejour - r.date_debut_sejour + 1), 0) AS jours_reserves
    FROM LOGEMENT l
    JOIN TYPE_LOGEMENT t ON l.id_type = t.id_type
    LEFT JOIN RESERVATION r ON l.id_logement = r.id_logement
        AND r.date_debut_sejour >= CURRENT_DATE - INTERVAL '12 months'
    GROUP BY l.id_logement, l.id_type, t.libelle_type
)
SELECT 
    id_logement,
    id_type,
    libelle_type,
    nb_reservations,
    jours_reserves,
    CASE 
        WHEN jours_reserves > 0 THEN 
            ROUND((jours_reserves::NUMERIC / 365) * 100, 2)
        ELSE 0
    END AS taux_occupation_pct
FROM Occupation_Logements;


-- Étape 2 : Analyse de l'impact des équipements
-- Comparer le taux moyen des logements AVEC un équipement
-- vs le taux moyen des logements SANS cet équipement

WITH Equipements_Distincts AS (
    SELECT DISTINCT nom_equipement
    FROM EQUIPEMENT
),
Taux_Avec_Equipement AS (
    SELECT 
        e.nom_equipement,
        ROUND(AVG(v.taux_occupation_pct), 2) AS taux_moyen_avec,
        COUNT(DISTINCT v.id_logement) AS nb_logements_avec
    FROM Equipements_Distincts e
    JOIN EQUIPEMENT eq ON e.nom_equipement = eq.nom_equipement
    JOIN Vue_Taux_Occupation v ON eq.id_logement = v.id_logement
    GROUP BY e.nom_equipement
),
Taux_Sans_Equipement AS (
    SELECT 
        e.nom_equipement,
        ROUND(AVG(v.taux_occupation_pct), 2) AS taux_moyen_sans,
        COUNT(DISTINCT v.id_logement) AS nb_logements_sans
    FROM Equipements_Distincts e
    CROSS JOIN Vue_Taux_Occupation v
    WHERE NOT EXISTS (
        SELECT 1
        FROM EQUIPEMENT eq
        WHERE eq.id_logement = v.id_logement
          AND eq.nom_equipement = e.nom_equipement
    )
    GROUP BY e.nom_equipement
)

-- Étape 3 : Requête finale
-- Calcul du delta d'impact pour chaque équipement

SELECT 
    a.nom_equipement,
    a.nb_logements_avec,
    a.taux_moyen_avec,
    COALESCE(s.nb_logements_sans, 0) AS nb_logements_sans,
    COALESCE(s.taux_moyen_sans, 0) AS taux_moyen_sans,
    (a.taux_moyen_avec - COALESCE(s.taux_moyen_sans, 0)) AS delta_impact,
    CASE 
        WHEN (a.taux_moyen_avec - COALESCE(s.taux_moyen_sans, 0)) >= 15 THEN 'Installation recommandée'
        WHEN (a.taux_moyen_avec - COALESCE(s.taux_moyen_sans, 0)) >= 5 THEN 'Impact positif'
        WHEN (a.taux_moyen_avec - COALESCE(s.taux_moyen_sans, 0)) >= 0 THEN 'Impact neutre'
        ELSE 'Impact négatif'
    END AS recommandation
FROM Taux_Avec_Equipement a
LEFT JOIN Taux_Sans_Equipement s ON a.nom_equipement = s.nom_equipement
ORDER BY delta_impact DESC;