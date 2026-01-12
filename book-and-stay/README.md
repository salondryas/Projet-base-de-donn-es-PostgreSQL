# Book & Stay — Projet BDR (SI3)

Projet réalisé dans le cadre du cours **Bases de Données Relationnelles (BDR)**.  
Le projet vise à concevoir et interroger une base de données permettant la gestion d’un réseau de logements en co-living : réservations, résidents, maintenance, événements et interactions.

---

## Équipe

- BEN SLAMA Rafia 
- EL HADI Ilias
- LAHJOMRI Aya 
- TAMEHMACHT Florian

---

## Description des dossiers

### `docs/`
Contient les documents du rapport :
- **cahier_des_charges.pdf** : reformulation complète du besoin et définitions fonctionnelles
- **modele_EA.pdf** : modèle Entité/Association avec justification des choix de modélisation

---

### `sql/schema/`
- **schema.sql** : schéma relationnel SQL de la base de données  
  (tables, clés primaires, clés étrangères, contraintes)

---

### `sql/data/`
- **data.sql** : jeu de données **minimal commun** servant à initialiser la base  
  (résidences, logements, types de logements, résidents)

> Ce jeu de données est volontairement réduit

---

### `sql/queries/`
Contient les requêtes SQL correspondant aux fonctionnalités demandées.

---

### `sql/test/`
Contient les **jeux de tests fonctionnels** associés aux requêtes.

Chaque jeu de tests couvre des **cas fonctionnels typiques et des cas limites** afin de valider la complétude des requêtes.

