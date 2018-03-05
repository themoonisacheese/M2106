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


-- Nom et participations passées de tous les adhérents



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


SELECT EnregResultats(2,1,1,1);


SELECT EnregResultats(5,1,4,1);


SELECT EnregResultats(5,1,5,2);


SELECT EnregResultats(5,2,4,2);


SELECT EnregResultats(5,2,5,1);


SELECT EnregResultats(5,3,4,999);


SELECT EnregResultats(5,3,5,1);


-- Vérification : total des points obtenus par chaque bateau ayant concouru aux régates du rallye 5



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


-- Tentative d'insertion de trois régates pour l'activité 5


-- Création d'une nouvelle activité de type rallye se déroulant à Pino sur la journée du 1er octobre 2018


-- Insertion de trois régates pour l'activité 14 (numéro de la nouvelle activité)


-- Vérification : affichage des régates de l'activité 14 (résultats ordonnés sur le numéro de régate)


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


-- Vérification : affichage des régates de l'activité 14 (résultats ordonnés sur le numéro de régate)



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


--------------------------------------------------------------------------------
-- Q3 : Suivi des activités futures
--------------------------------------------------------------------------------
-- exécuter les instructions de création de la fonction EtatActNextWeek
-- compléter le fichier drop.sql avec l'instruction de suppression de cette fonction

-- exécuter l'instruction ci-dessous :
SELECT * FROM EtatActNextWeek();

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


-- Affichage du planning de limande


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


-- Appel de la fonction Prepannulation()



/*__________________________________________________________________________________________________________________________________________________

					FIN des tests !!!
__________________________________________________________________________________________________________________________________________________*/
