/*_________________________________________________________________________________________

		A - Fonctions retournant un seul résultat
___________________________________________________________________________________________*/


------------------------------------------------------------------------------------------
-- Q1 : Nombre de jours d'une activité donnée
--------------------------------------------------------------------------------
-- compléter le fichier procedures.sql avec le code de la fonction NombreJours
-- exécuter les instructions de création de cette fonction
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

------------------------
-- TESTS Q1
-- connexion : limande
------------------------

-- Nombre de jours de l'activité numéro 12
based114=> select NombreJours(12);
 nombrejours
-------------
           1
(1 row)

-- Affichage de la date de début, des ports de départ et d'arrivée et de la durée en jours des activités futures
based114=> select numact, datedebut, datefin, depart, arrivee, NombreJours(numact)
based114-> from vactivitesfutures;
 numact | datedebut  |  datefin   |   depart   |  arrivee   | nombrejours
--------+------------+------------+------------+------------+-------------
      8 | 2018-06-15 | 2018-06-15 | Toulon     | Toulon     |           1
     13 | 2018-07-01 | 2018-07-01 | Monaco     | Monaco     |           1
     12 | 2018-08-01 | 2018-08-01 | Nice       | Cannes     |           1
     11 | 2018-08-10 | 2018-08-15 | Bastia     | Ajaccio    |           6
      6 | 2018-09-02 | 2018-09-12 | Toulon     | Toulon     |          11
     10 | 2018-09-14 | 2018-09-14 | Macinaggio | Centuri    |           1
      9 | 2018-09-14 | 2018-09-14 | Brest      | Concarneau |           1
      7 | 2018-09-14 | 2018-09-14 | Toulon     | Toulon     |           1
(8 rows)

--------------------------------------------------------------------------------
-- Q2 : Non recouvrement de deux plages de dates
--------------------------------------------------------------------------------
-- compléter le fichier procedures.sql avec le code de la fonction disjonction
-- exécuter les instructions de création de cette fonction
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

------------------------
-- TESTS Q2
-- connexion : vous
------------------------
-- exécuter les instructions ci-dessous :
SELECT disjonction(current_date, current_date+2, current_date, current_date+2);
 disjonction
-------------
 f
(1 row)

SELECT disjonction(current_date, current_date+4, current_date+1, current_date+3);
 disjonction
-------------
 f
(1 row)

SELECT disjonction(current_date, current_date+4, current_date+1, current_date+5);
	disjonction
-------------
 f
(1 row)

SELECT disjonction(current_date, current_date+4, current_date-3, current_date+2);
 disjonction
-------------
 f
(1 row)

SELECT disjonction(current_date, current_date+2, current_date-2, current_date);
 disjonction
-------------
 f
(1 row)

SELECT disjonction(current_date, current_date+4, current_date-8, current_date-5);
 disjonction
-------------
 t
(1 row)



--------------------------------------------------------------------------------
-- Q3 : Disponibilité d'un bateau
--------------------------------------------------------------------------------
-- compléter le fichier procedures.sql avec le code de la fonction BateauDispo
-- exécuter les instructions de création de cette fonction
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

------------------------
-- TESTS Q3
-- connexion : michal
------------------------

-- Le bateau 6 est-il disponible pour une activité prévue entre le 3 octobre 2018
-- et le 25 septembre 2018 ?
based114=> select bateaudispo(6,'3/10/2018','25/09/2018');
ERROR:  les dates ne sont pas dans le bon ordre!
CONTEXT:  PL/pgSQL function bateaudispo(numeric,date,date) line 8 at RAISE

-- Le bateau 6 est-il disponible pour une activité prévue entre le 8 et le 15 août 2018 ?
based114=> select bateaudispo(6,'8/08/2018','15/08/2018');
 bateaudispo
-------------
 f
(1 row)

-- Quels sont les bateaux (numéro, nom, nombre de places) disponibles pour une activité prévue entre le 8 et le 15 août 2018 ?

based114=> select numbat, nombat, nbplaces from bateau where bateaudispo(numbat, '08/08/2018','15/08/2018');
 numbat |    nombat     | nbplaces
--------+---------------+----------
      1 | le renard     |        6
      2 | imagine       |        6
      3 | rêve des iles |        8
      4 | intermède     |       10
      5 | évasion       |        7
(5 rows)

--------------------------------------------------------------------------------
-- Q4 : Disponibilité d'un adhérent
--------------------------------------------------------------------------------
-- compléter le fichier procedures.sql avec le code de la fonction MembreDispo
-- exécuter les instructions de création de cette fonction
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

------------------------
-- TESTS Q4
-- connexion : michal
--------------------------

-- Parmi les skippers, qui sera disponible pour encadrer une activité prévue entre le 8 et le 15 août 2108 ?
based114=> select numadh,nom,skipper from adherent where skipper = 'oui'
and membredispo(numadh, '8/8/2018', '15/8/2018');
 numadh |  nom   | skipper
--------+--------+---------
     10 | rondet | oui
(1 row)

-- Quels sont les adhérents (numéro, nom, téléphone) qui pourraient être équipiers de rondet pour une activité prévue entre le 8 et le 15 août 2018?
based114=> select numadh, nom, telephone
from adherent
where membredispo(numadh, '8/8/2018','15/8/2018')
based114-> and skipper = 'non';
 numadh |   nom    | telephone
--------+----------+------------
      3 | boucher  | 0476152360
      4 | michal   | 0476451252
      7 | frantz   | 0476531278
      8 | colin    | 0476531237
      9 | boulle   | 0476531586
     11 | garnier  | 0476852130
     12 | bar      | 0476535678
     14 | crevette | 0476458293
     15 | morue    | 0476349725
     16 | saumon   | 0476482497
     17 | limande  | 0476165874
     18 | turbot   | 0476462597
     19 | cr


--------------------------------------------------------------------------------
-- Q5 : Possibilité de prévoir une sortie
--------------------------------------------------------------------------------
-- compléter le fichier procedures.sql avec le code de la fonction SortiePossible
-- exécuter les instructions de création de cette fonction
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

------------------------
-- TESTS Q5
-- connexion : michal
--------------------------

-- Est-il possible de prévoir une sortie sur la journée du 2 septembre 2018 ?
based114=> select sortiepossible('2/9/2018', '2/9/2018');
 sortiepossible
----------------
 f
(1 row)


-- Est-il possible de prévoir une sortie du 8 au 15 août 2018 ?
based114=> select sortiepossible('8/8/2018', '15/8/2018');
 sortiepossible
----------------
 t
(1 row)




/*_________________________________________________________________________________________

		B - Fonctions ne retournant pas de résultat (paramètres out ou void)
___________________________________________________________________________________________*/

--------------------------------------------------------------------------------
-- Q1 : Nombre de participations d'un membre à une sortie ou un rallye passé
--------------------------------------------------------------------------------
-- compléter le fichier procedures.sql avec le code de la fonction Participations
-- exécuter les instructions de création de cette fonction
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

------------------------
-- TESTS Q1
-- connexion : michal
--------------------------

-- Participations passées de merlu
based114=> select * from participations((select numadh from adherent where nom = 'merlu'));
 nbsorties | nbrallyes
-----------+-----------
         1 |         2
(1 row)


-- Nom et participations passées de tous les adhérents
based114=> select nom, nbrallyes, nbsorties from adherent, participations(numadh);
   nom    | nbrallyes | nbsorties
----------+-----------+-----------
 aflau    |         2 |         1
 maire    |         2 |         2
 boucher  |         2 |         2
 michal   |         2 |         2
 guy      |         2 |         2
 rousseau |         2 |         2
 frantz   |         2 |         2
 colin    |         2 |         2
 boulle   |         2 |         2
 rondet   |         2 |         2
 garnier  |         2 |         1
 bar      |         2 |         1
 merlu    |         2 |         1
 crevette |         1 |         1
 morue    |         1 |         0
 saumon   |         0 |         0
 limande  |         0 |         0
 turbot   |         1 |         0
 crabe    |         1 |         0
(19 rows)



--------------------------------------------------------------------------------
-- Q2 : Saisie des résultats des concurrents d'un rallye terminé avec calcul
--      automatique des points obtenus
--------------------------------------------------------------------------------
-- compléter le fichier procedures.sql avec le code de la fonction EnregResultats
-- exécuter les instructions de création de cette fonction
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

------------------------
-- TESTS Q2
-- connexion : michal
--------------------------

-- Instructions à exécuter (une par une) :
SELECT EnregResultats(2,5,1,1);

based114=> SELECT EnregResultats(2,5,1,1);
ERROR:  Ce rallye ne comporte pas autant de regates
CONTEXT:  PL/pgSQL function enregresultats(numeric,numeric,numeric,numeric) line 13 at RAISE

SELECT EnregResultats(2,1,1,1);
ERROR:  Le bateau 1 n'a pas participe a ce rallye'
CONTEXT:  PL/pgSQL function enregresultats(numeric,numeric,numeric,numeric) line 17 at RAISE


SELECT EnregResultats(5,1,4,1);

NOTICE:  Le bateau 4 a obtenu 5 points a la regate 1 du rallye 5
 enregresultats
----------------

(1 row)

SELECT EnregResultats(5,1,5,2);
NOTICE:  Le bateau 5 a obtenu 3 points a la regate 1 du rallye 5
 enregresultats
----------------

(1 row)



SELECT EnregResultats(5,2,4,2);
NOTICE:  Le bateau 4 a obtenu 3 points a la regate 2 du rallye 5
 enregresultats
----------------

(1 row)


SELECT EnregResultats(5,2,5,1);

NOTICE:  Le bateau 5 a obtenu 5 points a la regate 2 du rallye 5
 enregresultats
----------------

(1 row)

SELECT EnregResultats(5,3,4,999);
NOTICE:  Le bateau 4 a obtenu 0 points a la regate 3 du rallye 5
 enregresultats
----------------

(1 row)

SELECT EnregResultats(5,3,5,1);
NOTICE:  Le bateau 5 a obtenu 5 points a la regate 3 du rallye 5
 enregresultats
----------------

(1 row)


-- Vérification : total des points obtenus par chaque bateau ayant concouru aux régates du rallye 5

based114=> select numbat, sum(points) from resultat where numact = 5
group by numbat;
 numbat | sum
--------+-----
      4 |   8
      5 |  13
(2 rows)


--------------------------------------------------------------------------------
-- Q3 : Création automatisée de nouvelles régates pour un rallye futur
--------------------------------------------------------------------------------
-- compléter le fichier procedures.sql avec le code de la fonction InsRegates
-- exécuter les instructions de création de cette fonction
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

------------------------
-- TESTS Q3
-- connexion : michal
--------------------------

-- Tentative d'insertion de trois régates pour l'activité 11

based114=> select Insregates(11,3);
ERROR:  L'activite 11 n'est pas un rallye
CONTEXT:  PL/pgSQL function insregates(numeric,numeric) line 11 at RAISE
-- Tentative d'insertion de trois régates pour l'activité 5
based114=> select Insregates(5,3);
ERROR:  L'activite 5 est deja passee ou n'existe pas
CONTEXT:  PL/pgSQL function insregates(numeric,numeric) line 7 at RAISE

-- Création d'une nouvelle activité de type rallye se déroulant à Pino sur la journée du 1er octobre 2018
based114=> insert into activite values(14,'rallye','Pino','Pino','2018-10-01');
INSERT 0 1

-- Insertion de trois régates pour l'activité 14 (numéro de la nouvelle activité)
based114=> select InsRegates(14,3);
NOTICE:  regate 1 cree
NOTICE:  regate 2 cree
NOTICE:  regate 3 cree
 insregates
------------

(1 row)

-- Vérification : affichage des régates de l'activité 14 (résultats ordonnés sur le numéro de régate)
based114=> select * from regate where numact = 14 order by numregate asc;
 numact | numregate | forcevent
--------+-----------+-----------
     14 |         1 |
     14 |         2 |
     14 |         3 |
(3 rows)

--------------------------------------
-- Version BONUS
--------------------------------------
-- modifier la fonction InsRegates pour qu'elle puisse ajouter autant de lignes que souhaité dans la
-- table regate, quel que soit le nombre de régates déjà créées pour un rallye futur donné
-- exécuter les instructions de création de cette fonction

------------------------
-- TESTS Q3 - BONUS
-- connexion : michal
--------------------------

-------------------------------------------------------------------------------
-- Tests de la fonction InsRegates version BONUS (ne pas remplir si non traité)
-------------------------------------------------------------------------------
-- Insertion de deux nouvelles régates pour l'activité 14
based114=> select Insregates(14,2);
NOTICE:  regate 4 cree
NOTICE:  regate 5 cree
 insregates
------------

(1 row)

-- Vérification : affichage des régates de l'activité 14 (résultats ordonnés sur le numéro de régate)
based114=> select * from regate where numact = 14 order by numregate asc;
 numact | numregate | forcevent
--------+-----------+-----------
     14 |         1 |
     14 |         2 |
     14 |         3 |
     14 |         4 |
     14 |         5 |
(5 rows)



/*_________________________________________________________________________________________

		C - Fonctions retournant un ensemble de lignes (SETOF, TABLE)
___________________________________________________________________________________________*/

--------------------------------------------------------------------------------
-- Q1 : Informations sur les membres de l'équipage d'un bateau
--------------------------------------------------------------------------------
-- compléter le fichier procedures.sql avec le code de la fonction InfosEquipiers
-- exécuter les instructions de création de cette fonction
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

------------------------
-- TESTS Q1
-- connexion : michal
--------------------------

-- Informations sur les membres d'équipage du bateau 2 pour l'activité 13
based114=> select * from infosequipiers(13,2);
 nadh |    pr     |   nm    |    tel
------+-----------+---------+------------
    1 | jean      | aflau   | 0476441250
    2 | pierre    | maire   | 0476501265
    3 | anne      | boucher | 0476152360
    4 | veronique | michal  | 0476451252
    5 | fabien    | guy     | 0476441250
(5 rows)

--------------------------------------------------------------------------------
-- Q2 : Numéro des activités commençant entre J+7 et J+13
--------------------------------------------------------------------------------
-- compléter le fichier procedures.sql avec le code de la fonction ListActNextWeek
-- exécuter les instructions de création de cette fonction
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

------------------------
-- TESTS Q2
-- connexion : michal
--------------------------

-- Instructions à exécuter :

----------------------------------------
-- Nouvelle sortie à J+8, durée 2 jours
-- chefs de bord : aflau sur le  bateau le renard et merlu sur le bateau imagine
-- équipiers n° 14 à 18 pour aflau et n° 3 à 4 pour merlu
INSERT INTO VActivitesFutures VALUES(
	(SELECT max(numact)+1 FROM activite),'sortie','ici','là',current_date+8,current_date+10);

INSERT INTO chefdebord VALUES((SELECT max(numact) FROM activite),1,1);

INSERT INTO chefdebord VALUES((SELECT max(numact)FROM activite),13,2);

INSERT INTO equipage SELECT
	(SELECT max(numact) FROM activite), numadh, 1 FROM adherent WHERE numadh between 14 and 18;

INSERT INTO equipage SELECT
	(SELECT max(numact) FROM activite), numadh, 2 FROM adherent WHERE numadh between 3 and 4;

----------------------------------------
-- Nouveau rallye à J+10 (1 jour)
-- chefs de bord : maire sur le bateau rêve des iles, rondet sur le bateau intermède
-- et guy sur le bateau imagine
-- équipiers n° 6 à 9 pour rondet et n° 19 pour guy
INSERT INTO VActivitesFutures VALUES(
	(SELECT max(numact)+1 FROM activite),'rallye','ailleurs','autre part',current_date+10,current_date+10);

INSERT INTO chefdebord VALUES((SELECT max(numact) FROM activite),2,3);

INSERT INTO chefdebord VALUES((SELECT max(numact) FROM activite),10,4);

INSERT INTO chefdebord VALUES((SELECT max(numact) FROM activite),5,5);

INSERT INTO equipage SELECT
	(SELECT max(numact) FROM activite), numadh, 3 FROM adherent WHERE numadh between 6 and 9;

INSERT INTO equipage VALUES((SELECT max(numact) FROM activite),19,4);

----------------------------------------
-- Nouvelle sortie à J+12 (1 jour)
INSERT INTO VActivitesFutures VALUES(
	(SELECT max(numact) +1 FROM activite),'sortie','loin','plus loin',current_date+12,current_date+12);

----------------------------------------
-- Nouvelle sortie à J+13 (1 jour)
-- chef de bord : rondet sur le bateau cauchemar des mers
-- équipiers n° 1 à 4
INSERT INTO VActivitesFutures VALUES(
	(SELECT max(numact) +1 FROM activite),'sortie','Brest','Brest',current_date+13,current_date+13);

INSERT INTO chefdebord VALUES((SELECT max(numact) FROM activite),10,6);

INSERT INTO equipage SELECT
	(SELECT max(numact) FROM activite), numadh, 6 FROM adherent WHERE numadh between 1 and 4;

----------------------------------------
-- Numéros des activités commençant entre J+7 et J+13
SELECT * FROM ListActNextWeek();
 listactnextweek
-----------------
              14
              15
              16
              17
(4 rows)

--------------------------------------------------------------------------------
-- Q3 : Suivi des activités futures
--------------------------------------------------------------------------------
-- exécuter les instructions de création de la fonction EtatActNextWeek
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

-- exécuter l'instruction ci-dessous :
SELECT * FROM EtatActNextWeek();
based114=> SELECT * FROM EtatActNextWeek();
 num | nature |     dd     |     df     |     etat
-----+--------+------------+------------+--------------
  14 | sortie | 2018-03-20 | 2018-03-22 | PBM
  15 | rallye | 2018-03-22 | 2018-03-22 | PBM
  16 | sortie | 2018-03-24 | 2018-03-24 | SANS SKIPPER
  17 | sortie | 2018-03-25 | 2018-03-25 | RAS
(4 rows)
-- compléter le fichier procedures.sql avec le code de la fonction ControleBat
-- exécuter les instructions de création de cette fonction
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

------------------------
-- TESTS Q3
-- connexion : michal
--------------------------

-- Etat des bateaux inscrits aux activités commençant entre J+7 et J+13
-- Exécutez l'instruction ci-dessous :
SELECT numact, e.numb, e.nbinsc, e.places, e.nbdispo, e.etat
FROM activite, ControleBat(numact) e
WHERE numact IN (SELECT * FROM ListActNextWeek());

 numact | numb | nbinsc | places | nbdispo |   etat
--------+------+--------+--------+---------+-----------
     14 |    1 |      6 |      0 |       2 | OK
     14 |    2 |      3 |      3 |       2 | INCOMPLET
     15 |    3 |      5 |      3 |       2 | OK
     15 |    4 |      2 |      8 |       2 | INCOMPLET
     15 |    5 |      1 |      6 |       2 | INCOMPLET
     17 |    6 |      5 |      0 |      14 | OK
(6 rows)

/*_________________________________________________________________________________________

	D - fonctions utilisant des CURSEURS explicites (ou pouvant en utiliser...)
  _________________________________________________________________________________________*/

--------------------------------------------------------------------------------
-- Q1 : Planning de l'adhérent connecté
--------------------------------------------------------------------------------
-- compléter le fichier procedures.sql avec le code de la fonction MonPlanning
-- exécuter les instructions de création de cette fonction
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

------------------------
-- TESTS Q1
-- connexion : merlu puis limande
--------------------------

-- Affichage du planning de merlu

based114=> select MonPlanning();
NOTICE:  Planning de 13 au 2018-03-16 08:46:34.411067+01:
NOTICE:  Monaco - Monaco, du 2018-07-01 au 2018-07-01, sur le bateau rêve des iles
NOTICE:  Nice - Cannes, du 2018-08-01 au 2018-08-01, sur le bateau le renard
NOTICE:  Bastia - Ajaccio, du 2018-08-10 au 2018-08-15, sur le bateau cauchemar des mers
NOTICE:  Toulon - Toulon, du 2018-09-02 au 2018-09-12, sur le bateau évasion
NOTICE:  Toulon - Toulon, du 2018-09-14 au 2018-09-14, sur le bateau le renard
 monplanning
-------------

(1 row)

-- Affichage du planning de limande
based114=> select MonPlanning();
NOTICE:  Planning de 17 au 2018-03-16 08:47:17.074944+01:
NOTICE:  Toulon - Toulon, du 2018-06-15 au 2018-06-15, sur le bateau imagine
NOTICE:  Monaco - Monaco, du 2018-07-01 au 2018-07-01, sur le bateau rêve des iles
NOTICE:  Toulon - Toulon, du 2018-09-02 au 2018-09-12, sur le bateau évasion
NOTICE:  Toulon - Toulon, du 2018-09-14 au 2018-09-14, sur le bateau le renard
 monplanning
-------------

(1 row)

--------------------------------------------------------------------------------
-- Q2 : Préparation de l'annulation d'activités ou de la participation de bateaux
--      à des activités
--------------------------------------------------------------------------------
-- compléter le fichier procedures.sql avec le code de la fonction PrepAnnulation
-- exécuter les instructions de création de cette fonction
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

------------------------
-- TESTS Q2
-- connexion : michal
--------------------------

based114=> select prepannulation();
NOTICE:  ======Activites entre le 2018-03-23 13:22:22.720666+01 et le 2018-03-29 13:22:22.720666+02=======
NOTICE:  *************************
NOTICE:  sortie numero 14 de ici a là
NOTICE:  depart le 2018-03-24 - arrivee le 2018-03-26
NOTICE:  MAINTIEN PARTIEL - MOTIF: AU MOINS 1 BATEAU INCOMPLET
NOTICE:  -----------
NOTICE:  Membres a prevenir:
NOTICE:
NOTICE:  membres inscrits sur imagine
NOTICE:  Chef de bord : christian merlu - tel: 0476371852
NOTICE:  Equipage:
NOTICE:  * anne boucher - tel: 0476152360
NOTICE:  * veronique michal - tel: 0476451252
NOTICE:  *************************
NOTICE:  rallye numero 15 de ailleurs a autre part
NOTICE:  depart le 2018-03-26 - arrivee le 2018-03-26
NOTICE:  ANULATION TOTALE - MOTIF: PAS ASSEZ DE BATEAUX PLEINS
NOTICE:  -----------
NOTICE:  Membres a prevenir:
NOTICE:
NOTICE:  membres inscrits sur intermède
NOTICE:  Chef de bord : audrey rondet - tel: 0476527130
NOTICE:  Equipage:
NOTICE:  * sylvie crabe - tel: 0476452843
NOTICE:
NOTICE:  membres inscrits sur évasion
NOTICE:  Chef de bord : fabien guy - tel: 0476441250
NOTICE:  Equipage:
NOTICE:  *************************
NOTICE:  sortie numero 16 de loin a plus loin
NOTICE:  depart le 2018-03-28 - arrivee le 2018-03-28
NOTICE:  ANULATION TOTALE - MOTIF: PAS ASSEZ DE BATEAUX PLEINS
NOTICE:  *************************
NOTICE:  sortie numero 17 de Brest a Brest
NOTICE:  depart le 2018-03-29 - arrivee le 2018-03-29
NOTICE:  MAINTIEN TOTAL
 prepannulation
----------------

(1 row)



/*__________________________________________________________________________________________________________________________________________________

					FIN des tests !!!
__________________________________________________________________________________________________________________________________________________*/
