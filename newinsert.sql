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





INSERT INTO VActivitesFutures values (null,'rallye','Brest','Concarneau','14/08/2019','14/08/2019');
/* NOTICE:  INSERT sur activite
INSERT 0 0 */

-- Inscription de merlu(13) comme chef de bord sur le bateau évasion(5) pour cette activité (18)
INSERT INTO chefdebord VALUES(18,13,5);

-- Inscription de aflau(1) comme chef de bord sur le bateau imagine(2) pour cette activité (18)
INSERT INTO chefdebord VALUES(18,1,2);

-- Inscription des équipiers 2 à 5 sur le bateau de aflau
INSERT INTO equipage
	SELECT 18, numadh, 2 FROM adherent WHERE numadh between 2 and 5;

-- Inscription des équipiers 14 à 17 sur le bateau de merlu
INSERT INTO equipage
	SELECT 18, numadh, 5 FROM adherent WHERE numadh between 14 and 17;

-- Création de 3 régates pour l'activité 18
SELECT * FROM InsRegates(18,3);

-- Insertion des lignes nécessaires dans la table résultat pour cette activité
INSERT INTO resultat
	SELECT numbat, 18, numregate
	FROM chefdebord c, regate r WHERE c.numact= 18 and c.numact = r.numact;
