--R3:Interactions et conflits

--Étape 1 : colocataires actuels

CREATE VIEW Vue_Colocataires_Actuels AS
SELECT
r.id_logement,
res.id_resident,
res.nom,
res.prenom
FROM RESERVATION r
JOIN RESIDENT res ON r.id_resident = res.id_resident
JOIN LOGEMENT l ON r.id_logement = l.id_logement
WHERE l.colocation = TRUE
AND CURRENT_DATE BETWEEN r.date_debut_sejour AND r.date_fin_sejour;

--Étape 2: détection de conflits entre deux résidents

CREATE OR REPLACE FUNCTION conflit_existe_actuel (
    p_resident1 INT,
    p_resident2 INT,
    p_logement  INT
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1
        FROM CONFLIT c
        JOIN IMPLICATION_CONFLIT ic1 ON c.id_conflit = ic1.id_conflit
        JOIN IMPLICATION_CONFLIT ic2 ON c.id_conflit = ic2.id_conflit
        JOIN RESERVATION r ON c.id_reservation = r.id_reservation
        WHERE ic1.id_resident = p_resident1
          AND ic2.id_resident = p_resident2
          AND r.id_logement = p_logement
          AND CURRENT_DATE BETWEEN r.date_debut_sejour AND r.date_fin_sejour
    );
END;
$$;

--Etape 3 : Requete princiale 

SELECT
    c1.id_logement,
    c1.nom AS resident_1,
    c2.nom AS resident_2,
    CASE
        WHEN conflit_existe_actuel(
            c1.id_resident,
            c2.id_resident,
            c1.id_logement
        )
        THEN 'Conflit existant'
        ELSE 'Aucun conflit'
    END AS etat_relation
FROM Vue_Colocataires_Actuels c1
JOIN Vue_Colocataires_Actuels c2
  ON c1.id_logement = c2.id_logement
 AND c1.id_resident < c2.id_resident;


