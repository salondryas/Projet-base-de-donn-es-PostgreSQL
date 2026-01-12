-- R4 – Analyse Maintenance

-- Étape 1 : Sélection des maintenances récentes (6 derniers mois)

WITH Maintenance_Recente AS (
    SELECT *
    FROM MAINTENANCE
    WHERE date_debut >= CURRENT_DATE - INTERVAL '6 months'
),

-- Étape 2 : Comptage du nombre d’interventions par logement

Maintenance_Count AS (
    SELECT 
        id_logement,
        COUNT(*) AS nb_interventions
    FROM Maintenance_Recente
    GROUP BY id_logement
),

-- Étape 3 : Identification du type de panne le plus fréquent
-- par logement (gestion des ex æquo avec RANK)

Type_Frequent AS (
    SELECT 
        id_logement,
        type_maintenance,
        COUNT(*) AS nb_type,
        RANK() OVER (
            PARTITION BY id_logement 
            ORDER BY COUNT(*) DESC
        ) AS rang
    FROM Maintenance_Recente
    GROUP BY id_logement, type_maintenance
)

-- Étape 4 : Requête finale
-- Classement des logements par nombre d’interventions
-- et affichage de la panne la plus fréquente

SELECT 
    l.id_logement,
    r.ville,
    r.adresse,
    mc.nb_interventions,
    tf.type_maintenance AS panne_la_plus_frequente
FROM Maintenance_Count mc
JOIN LOGEMENT l 
    ON mc.id_logement = l.id_logement
JOIN RESIDENCE r 
    ON l.id_residence = r.id_residence
JOIN Type_Frequent tf 
    ON tf.id_logement = mc.id_logement
   AND tf.rang = 1
ORDER BY mc.nb_interventions DESC;