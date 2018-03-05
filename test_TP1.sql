 --****************************************************************************************
 --*	RESPECTER LES CONSIGNES :																				*
 --*		- N'enlever aucun commentaire dans ce fichier                    			         *
 --*																													*
 --* 		- les instructions de création d'une vue doivent être écrites dans vues.sql      *
 --* 		- les instructions de suppression d'une vue doivent être écrites dans drop.sql   *
 --* 		- les instructions d'attribution de droits doivent être écrites dans droits.sql  *
 --* 		- les instructions de test doivent être complétées dans ce fichier               *
 --* 		- les instructions de test doivent être complétées dans ce fichier               *
 --*       au fur et à mesure des questions sous le commentaire correspondant					*
 --*																													*
 --*		- l'éxécution des instructions de création d'une vue et d'attribution de droits  *
 --*       seront toujours faites dans la console SOUS VOTRE PROPRE LOGIN                 *
 --*     - les instructions de test seront toujours exécutées dans la console             *
 --*       sous le login indiqué                                                          *
 --*																													*
 --*	SAUVEGARDEZ régulièrement les fichiers :vues.sql, drop.sql, droits.sql et           *
 --*  le fichier test_TP1.sql                                                             *
 --****************************************************************************************


/*_________________________________________________________________________________________

	A - Rappel : vues et manipulations de donénes
___________________________________________________________________________________________*/


--------------------------------------------------------------------------------
-- Q1 - Création et tests de la vue VActivitesFutures
--------------------------------------------------------------------------------

-- écrire les instructions de création de la vue VActivitesFutures dans le fichier vues.sql
-- écrire les instructions de suppression de cette vue dans droits.sql
-- exécuter les instructions de création de cette vue

-------------------
-- TESTS Q1
-------------------

-- Affichage de la vue VActivitesFutures

select * from Vactivitesfutures;

 numact | typeact | datedebut  |  datefin   |   depart   |  arrivee
--------+---------+------------+------------+------------+------------
      8 | rallye  | 2018-06-15 | 2018-06-15 | Toulon     | Toulon
     13 | rallye  | 2018-07-01 | 2018-07-01 | Monaco     | Monaco
     12 | rallye  | 2018-08-01 | 2018-08-01 | Nice       | Cannes
     11 | sortie  | 2018-08-10 | 2018-08-15 | Bastia     | Ajaccio
      6 | sortie  | 2018-09-02 | 2018-09-12 | Toulon     | Toulon
     10 | sortie  | 2018-09-14 | 2018-09-14 | Macinaggio | Centuri
      9 | sortie  | 2018-09-14 | 2018-09-14 | Brest      | Concarneau
      7 | sortie  | 2018-09-14 | 2018-09-14 | Toulon     | Toulon
(8 rows)

-- Insertion à partir de VActivitesFutures d'une nouvelle sortie
-- (numéro 100, de Bastia à Pino, départ et arrivée le 25 fév. 2019)
insert into vactivitesfutures values(100, 'sortie', 'Bastia', 'Pino', '2019-02-25', '2019-02-25');

-- Affichage de la vue VActivitesFutures

select * from Vactivitesfutures;

 numact | typeact |   depart   |  arrivee   | datedebut  |  datefin
--------+---------+------------+------------+------------+------------
      8 | rallye  | Toulon     | Toulon     | 2018-06-15 | 2018-06-15
     13 | rallye  | Monaco     | Monaco     | 2018-07-01 | 2018-07-01
     12 | rallye  | Nice       | Cannes     | 2018-08-01 | 2018-08-01
     11 | sortie  | Bastia     | Ajaccio    | 2018-08-10 | 2018-08-15
      6 | sortie  | Toulon     | Toulon     | 2018-09-02 | 2018-09-12
     10 | sortie  | Macinaggio | Centuri    | 2018-09-14 | 2018-09-14
      7 | sortie  | Toulon     | Toulon     | 2018-09-14 | 2018-09-14
      9 | sortie  | Brest      | Concarneau | 2018-09-14 | 2018-09-14
    100 | sortie  | Bastia     | Pino       | 2019-02-25 | 2019-02-25
(9 rows)


-- Modification à partir de VActivitesFutures de cette activité
-- (départ 2 jours avant la date d'arrivée)

update VActivitesFutures set datedebut = datefin - 2 where numact = 100;

-- Affichage de la vue VActivitesFutures

select * from vactivitesfutures;
 numact | typeact |   depart   |  arrivee   | datedebut  |  datefin
--------+---------+------------+------------+------------+------------
      8 | rallye  | Toulon     | Toulon     | 2018-06-15 | 2018-06-15
     13 | rallye  | Monaco     | Monaco     | 2018-07-01 | 2018-07-01
     12 | rallye  | Nice       | Cannes     | 2018-08-01 | 2018-08-01
     11 | sortie  | Bastia     | Ajaccio    | 2018-08-10 | 2018-08-15
      6 | sortie  | Toulon     | Toulon     | 2018-09-02 | 2018-09-12
     10 | sortie  | Macinaggio | Centuri    | 2018-09-14 | 2018-09-14
      7 | sortie  | Toulon     | Toulon     | 2018-09-14 | 2018-09-14
      9 | sortie  | Brest      | Concarneau | 2018-09-14 | 2018-09-14
    100 | sortie  | Bastia     | Pino       | 2019-02-23 | 2019-02-25
(9 rows)


-- Suppression de cette activité à partir de VActivitesFutures

delete from Vactivitesfutures where numact = 100;

-- Affichage de la vue VActivitesFutures
select * from vactivitesfutures;
 numact | typeact |   depart   |  arrivee   | datedebut  |  datefin
--------+---------+------------+------------+------------+------------
      8 | rallye  | Toulon     | Toulon     | 2018-06-15 | 2018-06-15
     13 | rallye  | Monaco     | Monaco     | 2018-07-01 | 2018-07-01
     12 | rallye  | Nice       | Cannes     | 2018-08-01 | 2018-08-01
     11 | sortie  | Bastia     | Ajaccio    | 2018-08-10 | 2018-08-15
      6 | sortie  | Toulon     | Toulon     | 2018-09-02 | 2018-09-12
     10 | sortie  | Macinaggio | Centuri    | 2018-09-14 | 2018-09-14
      9 | sortie  | Brest      | Concarneau | 2018-09-14 | 2018-09-14
      7 | sortie  | Toulon     | Toulon     | 2018-09-14 | 2018-09-14
(8 rows)

--------------------------------------------------------------------------------
-- Q2 - Création et tests de la vue VParticipations
--------------------------------------------------------------------------------

-- écrire les instructions de création de la vue vue VParticipations dans le fichier vues.sql
-- écrire les instructions de suppression de cette vue dans droits.sql
-- exécuter les instructions de création de cette vue

-------------------
-- TESTS Q2
-------------------

-- Affichage de la vue VParticipations
 id |   nom    | nbfois_equ | nbfois_cdb
----+----------+------------+------------
  1 | aflau    |          0 |          3
  2 | maire    |          3 |          1
  3 | boucher  |          4 |          0
  4 | michal   |          4 |          0
  5 | guy      |          3 |          1
  6 | rousseau |          4 |          0
  7 | frantz   |          4 |          0
  8 | colin    |          4 |          0
  9 | boulle   |          4 |          0
 10 | rondet   |          3 |          1
 11 | garnier  |          3 |          0
 12 | bar      |          3 |          0
 13 | merlu    |          0 |          3
 14 | crevette |          2 |          0
 15 | morue    |          1 |          0
 16 | saumon   |          0 |          0


-- A partir de cette vue : nom des adhérents ayant participé au plus grand nombre d'activités

 select nom  from VParticipations where nbfois_equ + nbfois_cdb = (select max(nbfois_equ+nbfois_cdb) from VParticipations);
   nom
----------
 maire
 boucher
 michal
 guy
 rousseau
 frantz
 colin
 boulle
 rondet
(9 rows)

-- En s'aidant de cette vue : nom des skippers qui ont participé au moins 4 fois à une activité passée, -- soit comme chef de bord, soit comme équipier
select V.nom
from VParticipations v, adherent a
where v.nbfois_equ + v.nbfois_cdb >= 4
and a.skipper = 'oui'
and a.numadh = v.id;
  nom
--------
 maire
 guy
 rondet
(3 rows)


/*_________________________________________________________________________________________

	B1 - Droits sur votre base
___________________________________________________________________________________________*/

--------------------------------------------------------------------------------
-- Q1 - Sécurisation de votre base
--------------------------------------------------------------------------------

-- compléter le fichier droits.sql : modification de votre mot de passe
-- compléter le fichier droits.sql : suppression du droit de connexion à votre base
-- exécuter les instructions correspondantes

-------------------
-- TESTS Q1
-------------------

-- Connexion à votre base avec le login usera100, mot de passe p00

DETAIL:  User does not have CONNECT privilege.
-- Affichage des relations existantes (après s'être reconnecté)

on peut voir toutes les relations.

--------------------------------------------------------------------------------
-- Q2 - Partage de votre base avec tous les adherents de Tourmentin
--------------------------------------------------------------------------------

-- compléter le fichier droits.sql : droits d'accès à votre base pour tous les adhérents
-- exécuter la ou les instructions correspondantes (sous votre login)

-------------------
-- TESTS Q2
-------------------

-- Connexion en tant que aflau, puis affichage des relations existantes
toutes les relations sont visibles

-- Que remarquez-vous ?
rien

-- Tentative d'affichage du contenu de la table agence
la table s'affiche .                                                                              '

/*_________________________________________________________________________________________

	B2 - Droits sur les objets de la base
___________________________________________________________________________________________*/

--------------------------------------------------------------------------------
-- Q1 - Droits du rôle président
--------------------------------------------------------------------------------

-- compléter le fichier droits.sql : droits du rôle president
-- exécuter la ou les instructions correspondantes (sous votre login)

--------------------------------------------------------------------------------
------------------------
-- TESTS Q1
-- connexion : aflau
------------------------

-- Insertion du bateau requin ayant 10 places
succes

-- Suppression de ce bateau
succes

-- Affichage de la table resultat pour l'activité numéro 2
succes

-- Modification de l'adresse de garnier
succes

-- Tentative de suppression de la table resultat
echec

-- Tentative d'ajout d'une colonne caution de type int dans la table loueur
echec

-- Tentative de suppression de la vue VActivitesFutures
echec

-- BILAN ------------------------------------------------------------------------

-- Quels droits n'a pas aflau sur les objets de votre base ?
aflau a le droit d effectuer des opération dans les tables mais pas sur les tables elles-même.

-- Pourquoi ?
parce qu on lui a pas donnés les droits.

--------------------------------------------------------------------------------
-- Q2 - Droits du rôle adherent
--------------------------------------------------------------------------------

-- compléter le fichier droits.sql : premiers droits du rôle adherent
-- exécuter la ou les instructions correspondantes (sous votre login)

-- compléter le fichier vues.sql : instructions de création de la vue VMoi
-- compléter le fichier drop.sql : instructions de suppression de cette vue
-- exécuter les instructions de création de cette vue (sous votre login)
-- compléter le fichier droits.sql : droits du rôle adherent sur cette vue
-- exécuter la ou les instructions correspondantes (sous votre login)

-- compléter le fichier vues.sql : vue VMembres
-- compléter le fichier drop.sql : instructions de suppression de cette vue
-- exécuter les instructions de création de cette vue (sous votre login)
-- compléter le fichier droits.sql : droits du rôle adherent sur cette vue
-- exécuter la ou les instructions correspondantes (sous votre login)

-- compléter le fichier vues.sql : vue VMesCotisations
-- compléter le fichier drop.sql : instructions de suppression de cette vue
-- exécuter les instructions de création de cette vue (sous votre login)
-- compléter le fichier droits.sql : droits du rôle adherent sur cette vue
-- exécuter la ou les instructions correspondantes (sous votre login)


--------------------------------------------------------------------------------
------------------------
-- TESTS Q2
-- connexion : limande
------------------------

-- Affichage des activités futures
select * from VActivitesfutures;
 numact | typeact |   depart   |  arrivee   | datedebut  |  datefin
--------+---------+------------+------------+------------+------------
      8 | rallye  | Toulon     | Toulon     | 2018-06-15 | 2018-06-15
     13 | rallye  | Monaco     | Monaco     | 2018-07-01 | 2018-07-01
     12 | rallye  | Nice       | Cannes     | 2018-08-01 | 2018-08-01
     11 | sortie  | Bastia     | Ajaccio    | 2018-08-10 | 2018-08-15
      6 | sortie  | Toulon     | Toulon     | 2018-09-02 | 2018-09-12
     10 | sortie  | Macinaggio | Centuri    | 2018-09-14 | 2018-09-14
      9 | sortie  | Brest      | Concarneau | 2018-09-14 | 2018-09-14
      7 | sortie  | Toulon     | Toulon     | 2018-09-14 | 2018-09-14
(8 rows)

-- Affichage de ses informations personnelles
select * from VMOI;
 numadh |   nom   | prenom  | fonction | adresse | telephone  | skipper | anneeadh
--------+---------+---------+----------+---------+------------+---------+----------
     17 | limande | thierry | autre    | voiron  | 0476165874 | non     |     2017
(1 row)

-- Tentative de modification de l'adresse de merlu
update adherent set adresse = 'lyon' where nom = 'merlu';
ERROR:  permission denied for relation adherent

-- Modification de sa propre adresse (nouvelle adresse 'lyon')
update Vmoi  set adresse = 'lyon';
UPDATE 1

-- Vérification de l'effet de la modification
select * from vmoi;
 numadh |   nom   | prenom  | fonction | adresse | telephone  | skipper | anneeadh
--------+---------+---------+----------+---------+------------+---------+----------
     17 | limande | thierry | autre    | lyon    | 0476165874 | non     |     2017
(1 row)


-- A partir de VMembres, affichage des informations sur tous les skippers
select * from vmembres where skipper = 'oui';
  nom   |  prenom   | adresse  | telephone  |    fonction    | skipper
--------+-----------+----------+------------+----------------+---------
 aflau  | jean      | grenoble | 0476441250 | president      | oui
 maire  | pierre    | grenoble | 0476501265 | vice-president | oui
 guy    | fabien    | meylan   | 0476441250 | tresorier      | oui
 rondet | audrey    | grenoble | 0476527130 | membre actif   | oui
 merlu  | christian | veurey   | 0476371852 | autre          | oui
(5 rows)

-- Affichage des résultats (N° régate, classement, points)
-- obtenus par le bateau 5 aux régates de l'activité 2
select * from resultat where numbat = 5 and numact = 2;
 numbat | numact | numregate | classement | points
--------+--------+-----------+------------+--------
      5 |      2 |         1 |          2 |      2
      5 |      2 |         2 |          3 |      0
      5 |      2 |         3 |          2 |      2
      5 |      2 |         4 |          1 |      4
(4 rows)

-- Affichage de ses cotisations
select * from Vmescotisations;
  an  | montant | a_jour
------+---------+--------
 2017 |     130 | oui
 2018 |     135 | oui
(2 rows)


--------------------------------------------------------------------------------
-- Q3 - Droits du rôle skipper
--------------------------------------------------------------------------------

-- compléter le fichier vues.sql : vue VMesRespFutures
-- compléter le fichier drop.sql : instructions de suppression de cette vue
-- exécuter les instructions de création de cette vue (sous votre login)
-- compléter le fichier droits.sql : droits dur rôle skipper sur cette vue
-- exécuter la ou les instructions correspondantes (sous votre login)

--------------------------------------------------------------------------------
------------------------
-- TESTS Q3
-- connexion : merlu/aflau
------------------------

-- CONNEXION en tant que merlu
-- Activités futures pour lesquelles merlu est chef de bord
 numact | typeact | datedebut  |  datefin   | depart | arrivee |       nombat       | nbplaces | count

--------+---------+------------+------------+--------+---------+--------------------+----------+------
-
     13 | rallye  | 2018-07-01 | 2018-07-01 | Monaco | Monaco  | rêve des iles      |        8 |     8
     11 | sortie  | 2018-08-10 | 2018-08-15 | Bastia | Ajaccio | cauchemar des mers |        5 |     4
      6 | sortie  | 2018-09-02 | 2018-09-12 | Toulon | Toulon  | évasion            |        7 |    16
      7 | sortie  | 2018-09-14 | 2018-09-14 | Toulon | Toulon  | le renard          |        6 |     5
(4 rows)

-- CONNEXION en tant que aflau
-- Activités futures pour lesquelles aflau est chef de bord
 numact | typeact | datedebut  |  datefin   | depart | arrivee |  nombat   | nbplaces | count
--------+---------+------------+------------+--------+---------+-----------+----------+-------
      8 | rallye  | 2018-06-15 | 2018-06-15 | Toulon | Toulon  | imagine   |        6 |     8
     13 | rallye  | 2018-07-01 | 2018-07-01 | Monaco | Monaco  | imagine   |        6 |     8
     12 | rallye  | 2018-08-01 | 2018-08-01 | Nice   | Cannes  | imagine   |        6 |    12
      6 | sortie  | 2018-09-02 | 2018-09-12 | Toulon | Toulon  | intermède |       10 |    16
      7 | sortie  | 2018-09-14 | 2018-09-14 | Toulon | Toulon  | imagine   |        6 |     5
(5 rows)

--------------------------------------------------------------------------------
-- Q4 - Intermède
--------------------------------------------------------------------------------

------------------------
-- TESTS Q4
-- connexion : vous
------------------------

\du tresorier
            List of roles
 Role name |  Attributes  | Member of
-----------+--------------+-----------
 tresorier | Cannot login | {bureau}

\du guy

                     List of roles
 Role name | Attributes |          Member of
-----------+------------+------------------------------
 guy       |            | {adherent,tresorier,skipper}

-- A quels groupes appartient guy ?
guy appartient aux groupes adherent, tresorier, skipper.

\dp bateau
                                 Access privileges
 Schema |  Name  | Type  |     Access privileges     | Column privileges | Policies
--------+--------+-------+---------------------------+-------------------+----------
 public | bateau | table | userd114=arwdDxt/userd114+|                   |
        |        |       | president=arwd/userd114  +|                   |
        |        |       | adherent=r/userd114       |                   |
(1 row)

-- Quels sont les droits de guy sur la relation bateau ?
guy est un adhérent, il a donc seulement le droit de lecture.

-- suppression des droits de consultation de la relation bateau pour l'adherent guy
REVOKE SELECT ON bateau FROM guy;

-- CONNEXION en tant que guy : affichage de la relation bateau
 numbat |       nombat       | taille |  typebat   | nbplaces
--------+--------------------+--------+------------+----------
      1 | le renard          |  11.80 | pouvreau   |        6
      2 | imagine            |  11.30 | selection  |        6
      3 | rêve des iles      |  14.50 | sun fast   |        8
      4 | intermède          |  11.80 | sun magic  |       10
      5 | évasion            |  12.10 | gypsea 402 |        7
      6 | cauchemar des mers |  11.50 | coulapic   |        5
(6 rows)

-- Quels sont les nouveaux droits de guy sur la relation bateau (pourquoi) ?
guy garde ses droits sur la table grâce à son groupe adhérent.

--------------------------------------------------------------------------------
-- Q5 - Droits du rôle bureau
--------------------------------------------------------------------------------

-- compléter le fichier droits.sql : droits supplémentaires du rôle bureau
-- exécuter la ou les instructions correspondantes (sous votre login)
--------------------------------------------------------------------------------
------------------------
-- TESTS Q5
-- connexion : michal
------------------------

-- Affichage de la table agence
 nomagence | telephone  | fax |  adresse
-----------+------------+-----+-----------
 plaisance | 0494952016 |     | Marseille
 nauticloc | 0494526412 |     | toulon
(2 rows)

-- Affichage de la table cotisation
ERROR:  permission denied for relation cotisation

--------------------------------------------------------------------------------
-- Q6 - Droits du rôle tresorier
--------------------------------------------------------------------------------

-- compléter le fichier vues.sql : création de la vue VAppelCotisation
-- compléter le fichier drop.sql : instructions de suppression de cette vue
-- exécuter les instructions de création de cette vue (sous votre login)

-- compléter le fichier droits.sql : droits supplémentaires du rôle tresorier
-- exécuter la ou les instructions correspondantes (sous votre login)
--------------------------------------------------------------------------------
------------------------
-- TESTS Q6
-- connexion : guy
------------------------

-- Affichage de VAppelCotisation
 numadh | montant | paye
--------+---------+------
      1 |     125 | oui
      2 |     125 | non
      3 |     125 | non
      4 |     125 | oui
      5 |     125 | oui
      6 |     115 | oui
      7 |     115 | oui
      8 |     120 | non
      9 |     125 | non
     10 |     125 | oui
     11 |     125 | oui
     12 |     125 | oui

-- A partir de VAppelCotisation, augmentation de 2€ sur la cotisation de tous les adhérents qui n'ont pas encore payé
based114=> update vappelcotisation
based114-> set montant = montant + 2
based114-> where paye = 'non'
based114-> ;

-- Affichage de VAppelCotisation
 numadh | montant | paye
--------+---------+------
      1 |     125 | oui
      2 |     127 | non
      3 |     127 | non
      4 |     125 | oui
      5 |     125 | oui
      6 |     115 | oui
      7 |     115 | oui
      8 |     122 | non
      9 |     127 | non
     10 |     125 | oui
     11 |     125 | oui
     12 |     125 | oui
:
￼

--------------------------------------------------------------------------------
-- Q7 - Droits du rôle secretaire
--------------------------------------------------------------------------------

-- compléter le fichier droits.sql : droits supplémentaires du rôle secretaire
-- exécuter la ou les instructions correspondantes (sous votre login)
--------------------------------------------------------------------------------
------------------------
-- TESTS Q7
-- connexion : michal
------------------------

-- Insertion d'une nouvelle régate pour l'activité 12
based114=> insert into regate values(5,4);
INSERT 0 1


-- Insertion des lignes correspondantes dans la table résultat
based114=> insert into resultat values(5,5,4);
INSERT 0 1

-- Affichage de la table resultat pour l'activité 12, ordonnée par numéro de régate puis
-- par numéro de bateau
based114=> select * from resultat where numact = 12 order by numregate, numbat;
 numbat | numact | numregate | classement | points
--------+--------+-----------+------------+--------
      1 |     12 |         1 |            |
      2 |     12 |         1 |            |
      3 |     12 |         1 |            |
      1 |     12 |         2 |            |
      2 |     12 |         2 |            |
      3 |     12 |         2 |            |
      1 |     12 |         3 |            |
      2 |     12 |         3 |            |
      3 |     12 |         3 |            |
(9 rows)

-- Création d'une nouvelle sortie pour le réveillon, départ de Marseille le 31 décembre 2018,
-- arrivée à Bastia le 2 janvier 2019
SET DATESTYLE TO european; -- au cas où le format de dates ne soit pas JJ/MM/AAAA
based114=> insert into activite values(14,'sortie','Marseille','Bastia','31/12/2018','02/01/2019');
INSERT 0 1

-- Vérification : affichage des activités futures
 numact | typeact |   depart   |  arrivee   | datedebut  |  datefin
--------+---------+------------+------------+------------+------------
      8 | rallye  | Toulon     | Toulon     | 2018-06-15 | 2018-06-15
     13 | rallye  | Monaco     | Monaco     | 2018-07-01 | 2018-07-01
     12 | rallye  | Nice       | Cannes     | 2018-08-01 | 2018-08-01
     11 | sortie  | Bastia     | Ajaccio    | 2018-08-10 | 2018-08-15
      6 | sortie  | Toulon     | Toulon     | 2018-09-02 | 2018-09-12
     10 | sortie  | Macinaggio | Centuri    | 2018-09-14 | 2018-09-14
      7 | sortie  | Toulon     | Toulon     | 2018-09-14 | 2018-09-14
      9 | sortie  | Brest      | Concarneau | 2018-09-14 | 2018-09-14
     14 | sortie  | Marseille  | Bastia     | 2018-12-31 | 2019-01-02
(9 rows)

-- Inscription de aflau comme chef de bord du bateau évasion pour cette nouvelle sortie
based114=> insert into chefdebord values(14, (select numadh from adherent where nom = 'aflau'),(select
 numbat from bateau where nombat = 'évasion'));
INSERT 0 1

-- Inscription de tous les autres skippers comme équipiers de aflau pour cette nouvelle sortie
based114=> insert into equipage
select 14, numadh, 5
from adherent
where skipper = 'oui';
INSERT 0 5

-- CONNEXION aflau
-- Vérification : affichage de ses responsabilités futures

 numact | typeact | datedebut  |  datefin   |  depart   | arrivee |  nombat   | nbplaces | count
--------+---------+------------+------------+-----------+---------+-----------+----------+-------
      8 | rallye  | 2018-06-15 | 2018-06-15 | Toulon    | Toulon  | imagine   |        6 |     8
     13 | rallye  | 2018-07-01 | 2018-07-01 | Monaco    | Monaco  | imagine   |        6 |     8
     12 | rallye  | 2018-08-01 | 2018-08-01 | Nice      | Cannes  | imagine   |        6 |    12
      6 | sortie  | 2018-09-02 | 2018-09-12 | Toulon    | Toulon  | intermède |       10 |    16
      7 | sortie  | 2018-09-14 | 2018-09-14 | Toulon    | Toulon  | imagine   |        6 |     5
     14 | sortie  | 2018-12-31 | 2019-01-02 | Marseille | Bastia  | évasion   |        7 |     5
(6 rows)
--------------------------------------------------------------------------------
-- Q8 - Droits manquants au rôle president
--------------------------------------------------------------------------------

-- compléter le fichier droits.sql : droits supplémentaires du rôle president
-- exécuter la ou les instructions correspondantes (sous votre login)


le président a automatiquement tous les droits sur toutes les tables du shcéma public.
--------------------------------------------------------------------------------
------------------------
-- TESTS libres
-- connexion : aflau
------------------------
