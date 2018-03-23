﻿/*_________________________________________________________________________________________

		A - Trigger AFTER (FOR EACH STATEMENT)
___________________________________________________________________________________________*/

-- compléter le fichier triggers.sql avec les instructions de création
-- du trigger t_Notification
-- exécuter ces instructions
-- compléter le fichier drop.sql avec les instructions nécessaires à la supression
-- de ce trigger

--------------------------
-- TESTS
-- connexion : vous-mêmes
--------------------------

-- insertion d'un nouvel adhérent
INSERT INTO adherent(numadh, nom, prenom, skipper)
 	VALUES ((SELECT max(numadh) FROM adherent)+1,'poulpe','lucien','non');
NOTICE:  INSERT sur adherent
INSERT 0 1
-- vérification
SELECT * FROM adherent WHERE nom = 'poulpe';
 numadh |  nom   | prenom | fonction | adresse | telephone | skipper | anneeadh
--------+--------+--------+----------+---------+-----------+---------+----------
     20 | poulpe | lucien | autre    |         |           | non     |     2018
(1 row)

-- suppression de cet adhérent
DELETE FROM adherent WHERE nom = 'poulpe';
NOTICE:  DELETE sur adherent
DELETE 1

﻿/*_________________________________________________________________________________________

		B - Triggers FOR EACH ROW sur des tables
___________________________________________________________________________________________*/

--------------------------------------------------------------------------------
-- Q1 : Contrôler la pérennité de l'agrément d'un skipper
--------------------------------------------------------------------------------
-- compléter le fichier triggers.sql avec les instructions de création
-- du trigger t_InscriptionEqu
-- exécuter ces instructions
-- compléter le fichier drop.sql avec les instructions nécessaires à la supression
-- de ce trigger

-------------------------
-- TESTS Q1
-- connexion : michal
--------------------------

-- Tentative de modification de l'agrément de Merlu
UPDATE adherent SET skipper = 'non' WHERE nom = 'merlu';

-- Pourquoi le trigger t_Notification ne s'est-il pas déclenché ?
-- A COMPLETER...



-- Félicitations : Morue a reçu son agrément de skipper !!!
UPDATE adherent SET skipper = 'oui' WHERE nom = 'morue';


-- Merlu a changé d'adresse : nouvelle adresse "bord de mer'
UPDATE adherent SET adresse = 'bord de mer' WHERE nom = 'merlu';

-- Limande a changé de numéro dé téléphone
UPDATE adherent SET telephone = '0607080910' WHERE nom = 'limande';


-- Vérifications :
SELECT * FROM adherent WHERE nom in ('merlu', 'morue', 'limande');

--------------------------------------------------------------------------------
-- Q2 : Contrôler l'inscription d'un adhérent comme membre d'équipage
--------------------------------------------------------------------------------
-- compléter le fichier triggers.sql avec les instructions de création
-- du trigger t_InscriptionEqu
-- exécuter ces instructions
-- compléter le fichier drop.sql avec les instructions nécessaires à la supression
-- de ce trigger

------------------------
-- TESTS Q2
-- connexion : michal
------------------------

-- Tentative d'inscription de crabe(19) sur le bateau 1 pour la sortie 1
INSERT INTO equipage values(1,19,1);

-- Inscription de crabe(19) sur le bateau 2 pour le rallye 12
INSERT INTO equipage values(12,19,2);

-- Tentative d'inscription de guy(5) comme membre d'équipage sur le bateau 3 pour la sortie 9
INSERT INTO equipage values(9,5,3);

-- Tentative d'inscription de frantz (7) sur le bateau 6 pour la sortie 11
INSERT INTO equipage values(11,7,6);

-- Création d'une nouvelle activité pour le réveillon 2018
SET datestyle TO european;
INSERT INTO VactivitesFutures VALUES ((SELECT max(numact) FROM activite) + 1, 'sortie','Marseille','Marseille','31/12/2018','1/01/2019');

-- Inscription de merlu(13) comme chef de bord sur le bateau 4
INSERT INTO chefdebord VALUES ((SELECT max(numact) FROM activite),13,4);

-- Inscription des équipiers 10 à 17 sur le bateau de merlu
INSERT INTO equipage
	SELECT (SELECT max(numact) FROM activite), numadh, 4 FROM adherent WHERE numadh between 10 and 17;

/*
 OUPS!!! Effectivement, l'adhérent 13, c'est merlu et il est déjà inscrit comme chef de bord pour cette activité !
 Mais est-ce que les autres membres ont été inscrits ?
*/
SELECT * FROM equipage WHERE numact = 14;

-- Apparemment non... Pourquoi ?
-- A COMPLETER...



-- Rectification : inscription des équipiers 1 à 8 sur le bateau de merlu
INSERT INTO equipage
	SELECT (SELECT max(numact) FROM activite), numadh, 4 FROM adherent WHERE numadh between 1 and 8;


-- Inscription de l'équipier 10
INSERT INTO equipage VALUES ((SELECT max(numact) FROM activite), 10, 4);


--------------------------------------------------------------------------------
-- Q3 : Contrôler l'inscription d'un adhérent comme chef de bord
--------------------------------------------------------------------------------
-- compléter le fichier triggers.sql avec les instructions de création
-- du trigger t_InscriptionCdb
-- exécuter ces instructions
-- compléter le fichier drop.sql avec les instructions nécessaires à la supression
-- de ce trigger

------------------------
-- TESTS Q3
-- connexion : michal
------------------------

-- Tentative d'inscription de guy (5) comme chef de bord du bateau 3 pour la sortie 1
INSERT INTO chefdebord values(1,5,3);

-- Tentative d'inscription de guy (5) comme chef de bord du bateau 4 pour le rallye 13
INSERT INTO chefdebord values(13,5,4);


-- Tentative d'inscription de frantz (7) comme chef de bord du bateau 4 pour le rallye 13
INSERT INTO chefdebord values(13,7,4);

-- Tentative d'inscription de rondet (10) comme chef de bord du bateau 6 pour l'activité 11
INSERT INTO chefdebord values(11,10,6);

-- Inscription de rondet (10) comme chef de bord du bateau 5 pour l'activité 11
INSERT INTO chefdebord values(11,10,5);


/*_________________________________________________________________________________________

		C - Triggers INSTEAD OF sur une vue
___________________________________________________________________________________________*/

--------------------------------------------------------------------------------
-- Q1 : Contrôler la possibilité de créer une activité future
--------------------------------------------------------------------------------
-- exécuter sous votre propre login les instructions de création de la fonction
-- RallyePossible donnée dans le fichier triggers.sql (Partie C / Q1)

-- compléter le fichier triggers.sql avec les instructions de création du
-- trigger t_NewAct
-- exécuter ces instructions
-- compléter le fichier drop.sql avec les instructions nécessaires à la supression
-- de la fonction RallyePossible et celles nécessaires à la suppression de ce trigger

------------------------
-- TESTS Q1
-- connexion : michal
------------------------

-- Tentative d'insertion dans la table VActivitesFutures d'une sortie au départ de Brest et arrivant à Concarneau sur la journée du 1/01/2018
INSERT INTO VActivitesFutures values(null,'sortie','Brest','Concarneau','1/01/2018','1/01/2018');


-- Insertion d'un rallye au départ de Brest et arrivant à Concarneau sur la journée du 14/09/2018
SET DATESTYLE TO european;
INSERT INTO VActivitesFutures values (null,'rallye','Brest','Concarneau','14/09/2018','14/09/2018');


-- Insertion d'un rallye au départ de Brest et arrivant à Concarneau sur la journée du 14/08/2019
INSERT INTO VActivitesFutures values (null,'rallye','Brest','Concarneau','14/08/2019','14/08/2019');


-- Inscription de merlu(13) comme chef de bord sur le bateau évasion(5) pour cette activité (15)
INSERT INTO chefdebord VALUES(15,13,5);

-- Inscription de aflau(1) comme chef de bord sur le bateau imagine(2) pour cette activité (15)
INSERT INTO chefdebord VALUES(15,1,2);

-- Inscription des équipiers 2 à 5 sur le bateau de aflau
INSERT INTO equipage
	SELECT 15, numadh, 2 FROM adherent WHERE numadh between 2 and 5;

-- Inscription des équipiers 14 à 17 sur le bateau de merlu
INSERT INTO equipage
	SELECT 15, numadh, 5 FROM adherent WHERE numadh between 14 and 17;

-- Création de 3 régates pour l'activité 15
SELECT * FROM InsRegates(15,3);

-- Insertion des lignes nécessaires dans la table résultat pour cette activité
INSERT INTO resultat
	SELECT numbat, 15, numregate
	FROM chefdebord c, regate r WHERE c.numact= 15 and c.numact = r.numact;

-- Vérifications : utiles pour la question C3
-- * affichage de la vue VActivitesFutures
SELECT * FROM VActivitesFutures;

-- * affichage de chefdebord pour l'activité 15
SELECT * FROM chefdebord WHERE numact = 15;

-- * affichage de equipage pour l'activité 15

-- * affichage de regate pour l'activité 15
SELECT * FROM regate WHERE numact = 15;

-- * affichage de resultat pour l'activité 15
SELECT * FROM resultat WHERE numact = 15;



--------------------------------------------------------------------------------
-- Q2 : Contrôler la mise à jour d'une activité future
--------------------------------------------------------------------------------

-- compléter le fichier triggers.sql avec les instructions de création du
-- trigger t_UpdAct
-- exécuter ces instructions
-- compléter le fichier drop.sql avec les instructions nécessaires à la supression
-- de ce trigger

------------------------
-- TESTS Q2
-- connexion : michal
------------------------

-- Modification du port d'arrivée de l'activité 14
UPDATE VActivitesFutures SET arrivee = 'Brest' WHERE numact = 14;


-- Vérification : affichage de la vue VActivitesFutures
SELECT * FROM VActivitesFutures WHERE numact = 14;

-- Modification des dates du rallye 15 : report d'une semaine
UPDATE VActivitesFutures SET datedebut = datedebut+7, datefin = datefin+7
WHERE numact = 15;


-- Les membres prévus pour l'activité "réveillon" ne sont pas d'accord pour arriver à Brest : ils se désinscrivent
-- en masse (chef de bord compris)
DELETE FROM equipage WHERE numact = 14;

DELETE FROM chefdebord WHERE numact = 14;

-- Tentative de reprogrammer l'activité 14 pour la fin du carnaval de Dunkerque qui a lieu cette année
-- jusqu'au 8 avril
UPDATE VActivitesFutures SET datedebut = current_date+5, datefin = '8/04/2018' WHERE numact = 14;

-- Nouvelle tentative de reprogrammation du 13 au 16 septembre
UPDATE VActivitesFutures SET datedebut = '13/09/2018', datefin = '16/09/2018' WHERE numact = 14;

-- Ultime tentative de reprogrommation du 13 au 16 août 2018
UPDATE VActivitesFutures SET datedebut = '13/08/2018', datefin = '16/08/2018' WHERE numact = 14;



--------------------------------------------------------------------------------
-- Q3 : Contrôler la suppression d'une activité future
--------------------------------------------------------------------------------

-- compléter le fichier triggers.sql avec les instructions de création du
-- trigger t_DelAct
-- exécuter ces instructions
-- compléter le fichier drop.sql avec les instructions nécessaires à la supression
-- de ce trigger

------------------------
-- TESTS Q3
-- connexion : michal
------------------------

-- Annulation du rallye 15
DELETE FROM VActivitesFutures WHERE numact = 15;


-- Vérification : affichage des activités futures
SELECT * FROM VActivitesFutures;



/*_________________________________________________________________________________________

		D - Couple de triggers BEFORE et AFTER
___________________________________________________________________________________________*/


------------------------------------------------------------------------------------------
-- 1 : Contrôles et actions effecutés AVANT mise à jour dans chefdebord
--	NOUS NE TRAITONS PAS LE CHANGEMENT DU NUMERO D'ACTIVITE !!!

-- SI la mise à jour concerne une activité passée : interdiction de la modification
-- SINON
--		Si la mise à jour concerne le numéro du chef de bord :
--					* contrôle de la disponbilité du remplaçant
--					* contrôle de son agrément de skipper
--		Si la mise à jour concerne le numéro du bateau :
--			(1) contrôles :
--					* de la disponibilité du bateau remplaçant
--					* de sa capacité à accueillir l'équipage prévu pour le bateau remplacé
--			(2) dans le cas où le remplacement peut se faire :
--					* sauvegarde des numéros des équipiers inscrits sur le bateau remplacé
--					* suppression dans equipage des lignes relatives au bateau
--					  et à l'activité concernés
--					* suppression dans resultat des lignes relatives au bateau
--					  et à l'activité concernés
--------------------------------------------------------------------------------------------
-- exécuter les instructions permettant de céer le trigger t_BeforeMAJCdb donné dans
-- le fichier triggers.sql (Partie D)
-- compléter le fichier drop.sql avec les instructions nécessaires à la supression
-- de ce trigger

--------------------------------------------------------------------------------------------
-- 2 : Actions effectués APRES mise à jour d'un numéro de bateau dans chef de bord
--------------------------------------------------------------------------------------------*/
-- compléter le fichier triggers.sql avec les instructions de création du
-- trigger t_AfterMAJCdb
-- exécuter ces instructions
-- compléter le fichier drop.sql avec les instructions nécessaires à la supression
-- de ce trigger

------------------------
-- TESTS
-- connexion : michal
------------------------

-- A - Remplacement d'un chef de bord : merlu marie sa fille...

-- rondet(10) peut-il remplacer merlu(13) pour l'activité 6 ?
UPDATE chefdebord set numadh = 10 WHERE numact = 6 and numadh = 13;


-- Le mariage de la fille de merlu est avancé au 15 août
-- Est-ce que limande (17) pourrait remplacer merlu pour l'activité 11 qui se déroule du 8 au 15 août ?
UPDATE chefdebord set numadh = 17 WHERE numact = 11 and numadh = 13;


-- Est-ce que morue pourrait le remplacer ?
UPDATE chefdebord set numadh = (SELECT numadh FROM adherent WHERE nom = 'morue')
WHERE numact = 11 and numadh = 13;


-- B - Remplacement d'un bateau : avarie du bateau imagine(2) qui ne pourra pas naviguer avant l'hiver...

-- Le bateau 2 est-il prévu pour des activités futures ?
SELECT * FROM VActivitesFutures WHERE numact in (SELECT numact FROM chefdebord WHERE numbat = 2);

-- Quels sont les chefs de bord inscrits sur le bateau 2 pour le rallye 13 ?
SELECT numadh FROM chefdebord WHERE numact = 13 and numbat = 2;

-- Quels sont les équipiers inscrits sur le bateau 2 pour le rallye 13 ?
SELECT numadh FROM equipage WHERE numact = 13 and numbat = 2 ORDER BY numadh;

-- Y a-t-il des lignes dans la table résultat pour le rallye 13 ?
SELECT * FROM resultat WHERE numact = 13 ORDER BY numregate, numbat;

-- Tentative de remplacement du bateau 2 par le bateau 3 pour le rallye 13
UPDATE chefdebord set numbat = 3 WHERE numact = 13 and numbat = 2;

-- Nouvel essai avec le bateau 1
UPDATE chefdebord set numbat = 1 WHERE numact = 13 and numbat = 2;

-- L'équipage initialement inscrit sur le bateau 3 est-il maintenant inscrit sur le bateau 1 pour le rallye 13 ?
SELECT numadh FROM equipage WHERE numact = 13 and numbat = 1 ORDER BY numadh;

-- Vérification du contenu de la table resultat pour le rallye 13...
SELECT * FROM resultat WHERE numact = 13 ORDER BY numregate, numbat;

-- Remplacement du bateau 2 par le bateau 4 pour l'activité 7
UPDATE chefdebord set numbat = 4 WHERE numact = 7 and numbat = 2;


-- THE END!!!
