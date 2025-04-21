--Creation de la table specialiste : regroupe les specialitees des medecins 
CREATE TABLE IF NOT EXISTS specialite (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE
);

--Creation de la table utilisateur ( patients , medecins , accueil) 
CREATE TABLE IF NOT EXISTS utilisateur (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telephone VARCHAR(20),
    role VARCHAR(50) NOT NULL CHECK (role IN ('patient','medecin','accueil')),
    mot_de_passe TEXT,
    specialite_id INT,
    FOREIGN KEY (specialite_id) REFERENCES specialite(id)
);

--Table de la disponibilite des medecins
CREATE TABLE IF NOT EXISTS disponibilite (
    id SERIAL PRIMARY KEY,
    medecin_id INT NOT NULL,
    date DATE NOT NULL,
    heure TIME NOT NULL,
    est_disponible BOOLEAN DEFAULT true,
    FOREIGN KEY (medecin_id) REFERENCES utilisateur(id)
);

--Table des rendez-vous
CREATE TABLE IF NOT EXISTS rendez_vous (
    id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    medecin_id INT,
    date DATE NOT NULL,
    heure TIME NOT NULL,
    description TEXT,
    statut VARCHAR(20) NOT NULL CHECK (statut IN ('en_attente', 'confirme','annule','termine')),
    urgence BOOLEAN DEFAULT false,
    FOREIGN KEY (patient_id) REFERENCES utilisateur(id),
    FOREIGN KEY (medecin_id) REFERENCES utilisateur(id)
);

--Table des notes medicales
CREATE TABLE IF NOT EXISTS note_medicale (
    id SERIAL PRIMARY KEY,
    rendez_vous_id INT NOT NULL,
    contenu TEXT NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (rendez_vous_id) REFERENCES rendez_vous(id)
);