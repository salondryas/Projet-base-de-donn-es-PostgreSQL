-- =========================
-- STRUCTURE
-- =========================

CREATE TABLE RESIDENCE (
    id_residence INT PRIMARY KEY,
    ville VARCHAR(50) NOT NULL,
    adresse VARCHAR(100) NOT NULL
);

CREATE TABLE TYPE_LOGEMENT (
    id_type INT PRIMARY KEY,
    libelle_type VARCHAR(50) NOT NULL,
    prix_base_nuitee DECIMAL(10,2) NOT NULL
);

CREATE TABLE RESIDENT (
    id_resident INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telephone VARCHAR(20),
    date_naissance DATE
);

CREATE TABLE LOGEMENT (
    id_logement INT PRIMARY KEY,
    nombre_chambres INT NOT NULL,
    colocation BOOLEAN DEFAULT FALSE,
    id_residence INT NOT NULL,
    id_type INT NOT NULL,

    FOREIGN KEY (id_residence) REFERENCES RESIDENCE(id_residence),
    FOREIGN KEY (id_type) REFERENCES TYPE_LOGEMENT(id_type)
);

CREATE TABLE EQUIPEMENT (
    id_equipement INT PRIMARY KEY,
    nom_equipement VARCHAR(50) NOT NULL,
    id_logement INT NOT NULL,

    FOREIGN KEY (id_logement) REFERENCES LOGEMENT(id_logement)
);

-- =========================
-- EVENEMENTS
-- =========================

CREATE TABLE EVENEMENT (
    id_evenement INT PRIMARY KEY,
    titre VARCHAR(100) NOT NULL,
    date TIMESTAMP NOT NULL,
    lieu VARCHAR(100),
    id_residence INT NOT NULL,

    FOREIGN KEY (id_residence) REFERENCES RESIDENCE(id_residence)
);

CREATE TABLE PARTICIPATION_EVENEMENT (
    id_resident INT,
    id_evenement INT,
    avis TEXT,

    PRIMARY KEY (id_resident, id_evenement),
    FOREIGN KEY (id_resident) REFERENCES RESIDENT(id_resident),
    FOREIGN KEY (id_evenement) REFERENCES EVENEMENT(id_evenement)
);

-- =========================
-- RESERVATIONS
-- =========================

CREATE TABLE RESERVATION (
    id_reservation INT,
    id_resident INT,
    id_logement INT NOT NULL,
    date_debut_sejour DATE NOT NULL,
    date_fin_sejour DATE NOT NULL,

    PRIMARY KEY (id_reservation, id_resident),
    FOREIGN KEY (id_resident) REFERENCES RESIDENT(id_resident),
    FOREIGN KEY (id_logement) REFERENCES LOGEMENT(id_logement)
);

-- =========================
-- MAINTENANCE
-- =========================

CREATE TABLE MAINTENANCE (
    id_maintenance INT PRIMARY KEY,
    type_maintenance VARCHAR(50),
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    urgence VARCHAR(10) NOT NULL
        CHECK (urgence IN ('faible', 'elevee')),
    description TEXT,
    id_logement INT NOT NULL,

    FOREIGN KEY (id_logement) REFERENCES LOGEMENT(id_logement)
);

-- =========================
-- CONFLITS
-- =========================

CREATE TABLE CONFLIT (
    id_conflit INT PRIMARY KEY,
    description_conflit TEXT,
    date_signalement DATE NOT NULL,
    gravite INT,
    id_logement INT,

    FOREIGN KEY (id_logement) REFERENCES LOGEMENT(id_logement)
);

CREATE TABLE IMPLICATION_CONFLIT (
    id_conflit INT,
    id_resident INT,

    PRIMARY KEY (id_conflit, id_resident),
    FOREIGN KEY (id_conflit) REFERENCES CONFLIT(id_conflit),
    FOREIGN KEY (id_resident) REFERENCES RESIDENT(id_resident)
);
