-- par sécurité : format pour les dates
SET datestyle to european;
-- destruction préalable des triggers, fonctions, vues et tables de la base (fichier de drop complété de TP en TP)
\i drop.sql
-- regénération du schéma de la base
\i create.sql
-- insertion des données
\i insert.sql
-- création des vues (TP1)
\i vues.sql
-- attribution des droits (TP1)
\i droits.sql
-- création de fonctions (TP2)
\i procedures.sql
-- création de triggers (TP3)
\i triggers.sql

\i newinsert.sql
