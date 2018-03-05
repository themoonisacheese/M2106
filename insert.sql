SET datestyle TO european;

-- insertion dans ADHERENT (numadh,nom,prenom,fonction,adresse,telephone,skipper,anneeadh)
insert into ADHERENT values(1,'aflau','jean','president','grenoble','0476441250','oui',2015);
insert into ADHERENT values(2,'maire','pierre','vice-president','grenoble','0476501265','oui',2015);
insert into ADHERENT values(3,'boucher','anne','vice-president','meylan','0476152360','non',2015);
insert into ADHERENT values(4,'michal','veronique','secretaire','grenoble','0476451252','non',2016);
insert into ADHERENT values(5,'guy','fabien','tresorier','meylan','0476441250','oui',2016);
insert into ADHERENT values(6,'rousseau','julien','membre actif','veurey','0476531256','non',2016);
insert into ADHERENT values(7,'frantz','paul','membre actif','st-égrève','0476531278','non',2016);
insert into ADHERENT values(8,'colin','serge','membre actif','st-ismier','0476531237','non',2016);
insert into ADHERENT values(9,'boulle','yves','membre actif','meylan','0476531586','non',2016);
insert into ADHERENT values(10,'rondet','audrey','membre actif','grenoble','0476527130','oui',2017);
insert into ADHERENT values(11,'garnier','christophe','autre','échirolles','0476852130','non',2017);
insert into ADHERENT values(12,'bar','thierry','autre','st-égrève','0476535678','non',2017);
insert into ADHERENT values(13,'merlu','christian','autre','veurey','0476371852','oui',2017);
insert into ADHERENT values(14,'crevette','sylvie','autre','st-ismier','0476458293','non',2017);
insert into ADHERENT values(15,'morue','dominique','autre','grenoble','0476349725','non',2017);
insert into ADHERENT values(16,'saumon','claude','autre','grenoble','0476482497','non',2017);
insert into ADHERENT values(17,'limande','thierry','autre','voiron','0476165874','non',2017);
insert into ADHERENT values(18,'turbot','pascale','autre','vif','0476462597','non',2017);
insert into ADHERENT values(19,'crabe','sylvie','membre actif','st-ismier','0476452843','non',2017);

-- insertion dans BATEAU (numbat,nombat,taille,typebat,nbplaces)
insert into BATEAU values(1,'le renard',11.80,'pouvreau',6);
insert into BATEAU values(2,'imagine',11.30,'selection',6);
insert into BATEAU values(3,'rêve des iles',14.50,'sun fast',8);
insert into BATEAU values(4,'intermède',11.80,'sun magic',10);
insert into BATEAU values(5,'évasion',12.10,'gypsea 402',7);
insert into BATEAU values(6,'cauchemar des mers',11.50,'coulapic',5);

-- insertion dans ACTIVITE (numact,typeact,depart,arrivee,datedebut,datefin)
insert into ACTIVITE values(1,'sortie','Hyeres','Hyeres','8/06/2017','10/06/2017');
insert into ACTIVITE values(2,'rallye','Hyeres','Hyeres','6/07/2017','8/07/2017');
insert into ACTIVITE values(3,'sortie','Hyeres','Hyeres','8/08/2017','10/08/2017');
insert into ACTIVITE values(4,'sortie','Hyeres','Hyeres','9/08/2017','13/08/2017');
insert into ACTIVITE values(5,'rallye','Hyeres','Hyeres','16/08/2017','16/08/2017');
insert into ACTIVITE values(6,'sortie','Toulon','Toulon','02/09/2018','12/09/2018');
insert into ACTIVITE values(7,'sortie','Toulon','Toulon','14/09/2018','14/09/2018');
insert into ACTIVITE values(8,'rallye','Toulon','Toulon','15/06/2018','15/06/2018');
insert into ACTIVITE values(9,'sortie','Brest','Concarneau','14/09/2018','14/09/2018');
insert into ACTIVITE values(10,'sortie','Macinaggio','Centuri','14/09/2018','14/09/2018');
insert into ACTIVITE values(11,'sortie','Bastia','Ajaccio','10/08/2018','15/08/2018');
insert into ACTIVITE values(12,'rallye','Nice','Cannes','1/08/2018','1/08/2018');
insert into ACTIVITE values(13,'rallye','Monaco','Monaco','1/07/2018','1/07/2018');

-- insertion dans COTISATION (numadh,anneecot,montant,paye)
insert into COTISATION values(1,2015, 100, 'oui');
insert into COTISATION values(1,2016, 110, 'oui');
insert into COTISATION values(1,2017, 120, 'oui');
insert into COTISATION values(1,2018, 125, 'oui');
insert into COTISATION values(2,2015, 100, 'oui');
insert into COTISATION values(2,2016, 110, 'oui');
insert into COTISATION values(2,2017, 120, 'oui');
insert into COTISATION values(2,2018, 125, 'non');
insert into COTISATION values(3,2015, 100, 'oui');
insert into COTISATION values(3,2016, 120, 'oui');
insert into COTISATION values(3,2017, 120, 'oui');
insert into COTISATION values(3,2018, 125, 'non');
insert into COTISATION values(4,2016, 110, 'oui');
insert into COTISATION values(4,2017, 120, 'oui');
insert into COTISATION values(4,2018, 125, 'oui');
insert into COTISATION values(5,2016, 110, 'oui');
insert into COTISATION values(5,2017, 120, 'oui');
insert into COTISATION values(5,2018, 125, 'oui');
insert into COTISATION values(6,2016, 110, 'oui');
insert into COTISATION values(6,2017, 110, 'oui');
insert into COTISATION values(6,2018, 115, 'oui');
insert into COTISATION values(7,2016, 110, 'oui');
insert into COTISATION values(7,2017, 110, 'oui');
insert into COTISATION values(7,2018, 115, 'oui');
insert into COTISATION values(8,2016, 120, 'oui');
insert into COTISATION values(8,2017, 120, 'oui');
insert into COTISATION values(8,2018, 120, 'non');
insert into COTISATION values(9,2016, 110, 'oui');
insert into COTISATION values(9,2017, 120, 'oui');
insert into COTISATION values(9,2018, 125, 'non');
insert into COTISATION values(10,2017, 120, 'oui');
insert into COTISATION values(10,2018, 125, 'oui');
insert into COTISATION values(11,2017, 120, 'oui');
insert into COTISATION values(11,2018, 125, 'oui');
insert into COTISATION values(12,2017, 120, 'oui');
insert into COTISATION values(12,2018, 125, 'oui');
insert into COTISATION values(13,2017, 120, 'oui');
insert into COTISATION values(13,2018, 125, 'oui');
insert into COTISATION values(14,2017, 120, 'oui');
insert into COTISATION values(14,2018, 125, 'oui');
insert into COTISATION values(15,2017, 130, 'oui');
insert into COTISATION values(15,2018, 135, 'non');
insert into COTISATION values(16,2017, 130, 'oui');
insert into COTISATION values(16,2018, 135, 'oui');
insert into COTISATION values(17,2017, 130, 'oui');
insert into COTISATION values(17,2018, 135, 'oui');
insert into COTISATION values(18,2017, 130, 'oui');
insert into COTISATION values(18,2018, 135, 'non');
insert into COTISATION values(19,2017, 130, 'oui');
insert into COTISATION values(19,2018, 130, 'non');

-- insertion dans AGENCE (nomagence,telephone,fax,adresse)
insert into  AGENCE values('plaisance','0494952016',null,'Marseille');
insert into  AGENCE values('nauticloc','0494526412',null,'toulon');

-- insertion dans PROPRIETAIRE (numadh,numbat)
insert into PROPRIETAIRE values(13,1);
insert into PROPRIETAIRE values(17,6);

-- insertion dans LOUEUR (numbat,nomagence)
insert into LOUEUR values(4,'nauticloc');
insert into LOUEUR values(2,'plaisance');
insert into LOUEUR values(3,'plaisance');
insert into LOUEUR values(5,'nauticloc');

-- insertion dans CHEFDEBORD (numact,numadh,numbat)
insert into CHEFDEBORD values(1,1,2);
insert into CHEFDEBORD values(1,10,1);
insert into CHEFDEBORD values(2,1,4);
insert into CHEFDEBORD values(2,13,5);
insert into CHEFDEBORD values(2,2,6);
insert into CHEFDEBORD values(3,13,1);
insert into CHEFDEBORD values(4,5,5);
insert into CHEFDEBORD values(5,1,5);
insert into CHEFDEBORD values(5,13,4);
insert into CHEFDEBORD values(6,1,4);
insert into CHEFDEBORD values(6,13,5);
insert into CHEFDEBORD values(6,2,6);
insert into CHEFDEBORD values(7,13,1);
insert into CHEFDEBORD values(7,1,2);
insert into CHEFDEBORD values(8,5,1);
insert into CHEFDEBORD values(8,1,2);
insert into CHEFDEBORD values(9,2,3);
insert into CHEFDEBORD values(10,10,5);
insert into CHEFDEBORD values(11,13,6);
insert into CHEFDEBORD values(12,1,2);
insert into CHEFDEBORD values(12,5,3);
insert into CHEFDEBORD values(12,10,1);
insert into CHEFDEBORD values(13,1,2);
insert into CHEFDEBORD values(13,13,3);

-- insertion dans EQUIPAGE (numact,numadh,numbat)
insert into EQUIPAGE values(1,2,2);
insert into EQUIPAGE values(1,3,2);
insert into EQUIPAGE values(1,4,2);
insert into EQUIPAGE values(1,5,2);
insert into EQUIPAGE values(1,6,1);
insert into EQUIPAGE values(1,7,1);
insert into EQUIPAGE values(1,8,1);
insert into EQUIPAGE values(1,9,1);
insert into EQUIPAGE values(2,10,4);
insert into EQUIPAGE values(2,3,4);
insert into EQUIPAGE values(2,8,4);
insert into EQUIPAGE values(2,5,4);
insert into EQUIPAGE values(2,9,5);
insert into EQUIPAGE values(2,11,5);
insert into EQUIPAGE values(2,7,5);
insert into EQUIPAGE values(2,6,5);
insert into EQUIPAGE values(2,12,6);
insert into EQUIPAGE values(2,18,6);
insert into EQUIPAGE values(2,19,6);
insert into EQUIPAGE values(2,4,6);
insert into EQUIPAGE values(3,2,1);
insert into EQUIPAGE values(3,12,1);
insert into EQUIPAGE values(3,14,1);
insert into EQUIPAGE values(3,8,1);
insert into EQUIPAGE values(3,6,1);
insert into EQUIPAGE values(4,3,5);
insert into EQUIPAGE values(4,4,5);
insert into EQUIPAGE values(4,7,5);
insert into EQUIPAGE values(4,9,5);
insert into EQUIPAGE values(4,10,5);
insert into EQUIPAGE values(4,11,5);
insert into EQUIPAGE values(5,2,5);
insert into EQUIPAGE values(5,3,5);
insert into EQUIPAGE values(5,4,5);
insert into EQUIPAGE values(5,5,5);
insert into EQUIPAGE values(5,6,5);
insert into EQUIPAGE values(5,7,5);
insert into EQUIPAGE values(5,8,4);
insert into EQUIPAGE values(5,9,4);
insert into EQUIPAGE values(5,10,4);
insert into EQUIPAGE values(5,11,4);
insert into EQUIPAGE values(5,12,4);
insert into EQUIPAGE values(5,14,4);
insert into EQUIPAGE values(5,15,4);
insert into EQUIPAGE values(6,3,4);
insert into EQUIPAGE values(6,14,4);
insert into EQUIPAGE values(6,6,4);
insert into EQUIPAGE values(6,11,4);
insert into EQUIPAGE values(6,10,4);
insert into EQUIPAGE values(6,16,4);
insert into EQUIPAGE values(6,9,4);
insert into EQUIPAGE values(6,4,5);
insert into EQUIPAGE values(6,7,5);
insert into EQUIPAGE values(6,12,5);
insert into EQUIPAGE values(6,17,5);
insert into EQUIPAGE values(6,19,5);
insert into EQUIPAGE values(6,5,6);
insert into EQUIPAGE values(6,8,6);
insert into EQUIPAGE values(6,15,6);
insert into EQUIPAGE values(6,18,6);
insert into EQUIPAGE values(7,17,1);
insert into EQUIPAGE values(7,18,1);
insert into EQUIPAGE values(7,19,1);
insert into EQUIPAGE values(7,14,2);
insert into EQUIPAGE values(7,11,2);
insert into EQUIPAGE values(8,4,1);
insert into EQUIPAGE values(8,3,1);
insert into EQUIPAGE values(8,7,1);
insert into EQUIPAGE values(8,8,1);
insert into EQUIPAGE values(8,14,2);
insert into EQUIPAGE values(8,17,2);
insert into EQUIPAGE values(8,15,2);
insert into EQUIPAGE values(8,18,2);
insert into EQUIPAGE values(9,6,3);
insert into EQUIPAGE values(9,8,3);
insert into EQUIPAGE values(9,9,3);
insert into EQUIPAGE values(10,3,5);
insert into EQUIPAGE values(10,4,5);
insert into EQUIPAGE values(10,5,5);
insert into EQUIPAGE values(10,15,5);
insert into EQUIPAGE values(10,16,5);
insert into EQUIPAGE values(11,1,6);
insert into EQUIPAGE values(11,5,6);
insert into EQUIPAGE values(11,2,6);
insert into EQUIPAGE values(11,6,6);
insert into EQUIPAGE values(12,2,2);
insert into EQUIPAGE values(12,3,2);
insert into EQUIPAGE values(12,4,2);
insert into EQUIPAGE values(12,6,2);
insert into EQUIPAGE values(12,7,3);
insert into EQUIPAGE values(12,8,3);
insert into EQUIPAGE values(12,9,3);
insert into EQUIPAGE values(12,11,3);
insert into EQUIPAGE values(12,12,1);
insert into EQUIPAGE values(12,13,1);
insert into EQUIPAGE values(12,14,1);
insert into EQUIPAGE values(12,15,1);
insert into EQUIPAGE values(13,2,2);
insert into EQUIPAGE values(13,3,2);
insert into EQUIPAGE values(13,4,2);
insert into EQUIPAGE values(13,5,2);
insert into EQUIPAGE values(13,14,3);
insert into EQUIPAGE values(13,15,3);
insert into EQUIPAGE values(13,16,3);
insert into EQUIPAGE values(13,17,3);

-- insertion dans REGATE (numact,numregate,forcevent)
insert into REGATE values(2,1,5);
insert into REGATE values(2,2,3);
insert into REGATE values(2,3,6);
insert into REGATE values(2,4,7);
insert into REGATE values(5,1,5);
insert into REGATE values(5,2,3);
insert into REGATE values(5,3,4);
insert into REGATE values(8,1,null);
insert into REGATE values(8,2,null);
insert into REGATE values(12,1,null);
insert into REGATE values(12,2,null);
insert into REGATE values(12,3,null);
insert into REGATE values(13,1,null);
insert into REGATE values(13,2,null);

-- insertion dans RESULTAT (numbat,numact,numregate,classement,points)
insert into RESULTAT values(4,2,1,3,0);
insert into RESULTAT values(5,2,1,2,2);
insert into RESULTAT values(6,2,1,1,4);
insert into RESULTAT values(4,2,2,2,2);
insert into RESULTAT values(5,2,2,3,0);
insert into RESULTAT values(6,2,2,1,4);
insert into RESULTAT values(4,2,3,1,4);
insert into RESULTAT values(5,2,3,2,2);
insert into RESULTAT values(6,2,3,3,0);
insert into RESULTAT values(4,2,4,2,2);
insert into RESULTAT values(5,2,4,1,4);
insert into RESULTAT values(6,2,4,3,0);
insert into RESULTAT values(4,5,1,null,null);
insert into RESULTAT values(5,5,1,null,null);
insert into RESULTAT values(4,5,2,null,null);
insert into RESULTAT values(5,5,2,null,null);
insert into RESULTAT values(4,5,3,null,null);
insert into RESULTAT values(5,5,3,null,null);
insert into RESULTAT values(2,12,1,null,null);
insert into RESULTAT values(2,12,2,null,null);
insert into RESULTAT values(2,12,3,null,null);
insert into RESULTAT values(3,12,1,null,null);
insert into RESULTAT values(3,12,2,null,null);
insert into RESULTAT values(3,12,3,null,null);
insert into RESULTAT values(1,8,1,null,null);
insert into RESULTAT values(1,8,2,null,null);
insert into RESULTAT values(2,8,1,null,null);
insert into RESULTAT values(2,8,2,null,null);
insert into RESULTAT values(1,12,1,null,null);
insert into RESULTAT values(1,12,2,null,null);
insert into RESULTAT values(1,12,3,null,null);
insert into RESULTAT values(2,13,1,null,null);
insert into RESULTAT values(3,13,1,null,null);
insert into RESULTAT values(2,13,2,null,null);
insert into RESULTAT values(3,13,2,null,null);

