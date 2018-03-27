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
