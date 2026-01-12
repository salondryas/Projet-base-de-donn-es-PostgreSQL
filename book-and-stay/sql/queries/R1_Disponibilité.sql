-- R1 : Logements disponibles (ni réservés, ni en maintenance bloquante sur la période)
SELECT 
    L.id_logement, 
    T.libelle_type, 
    T.prix_base_nuitee
FROM LOGEMENT L
JOIN TYPE_LOGEMENT T ON L.id_type = T.id_type
WHERE L.id_logement NOT IN (
    SELECT id_logement 
    FROM RESERVATION 
    WHERE NOT (date_fin_sejour < '2026-01-15' OR date_debut_sejour > '2026-01-20')
);
