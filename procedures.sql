/*___________________________________

			PROCEDURES (à compléter)
  ___________________________________*/

-----------------------------------------------------------------------
-- Durée en jours d'une activité
-----------------------------------------------------------------------
CREATE OR REPLACE function NombreJours(in nact numeric) RETURNS numeric AS
--{} => {résultat = durée en jours de l'activité de numéro numact}
$$
declare
deb varchar(10);
fin varchar(10);
begin
  select datedebut
  into deb
  from vactivitesfutures
  where numact = nact;

  select datefin
  into fin
  from vactivitesfutures
  where numact = nact;

  return fin::date - deb::date +1;
end;
$$ LANGUAGE 'plpgsql';


-----------------------------------------------------------------------
-- Non recouvrement de deux plages de dates
-----------------------------------------------------------------------
CREATE OR REPLACE function Disjonction(dd1 date, df1 date, dd2 date, df2 date) RETURNS boolean AS
--{dd1 <= df1, dd2 <= df2} => {résultat = vrai si les plages dd1->df1 et dd2->df2 sont disjointes}
$$
begin
  return dd1 > df2 or dd2 > df1;
end;

$$ LANGUAGE 'plpgsql';


-----------------------------------------------------------------------
-- Disponibilité d'un bateau entre deux dates (comprises)
-----------------------------------------------------------------------
CREATE OR REPLACE function BateauDispo(nbat numeric, dd date, df date) RETURNS boolean AS
--{} => {résultat = vrai si le bateau de numéro nbat est disponible de dd à df (comprises)
--			une exception est levée si df est antérieure à dd}
$$
declare
deb varchar(10);
fin varchar(10);
nact numeric(3);
begin
  if df < dd then
    raise exception 'les dates ne sont pas dans le bon ordre!';
  end if;

  for nact in select numact from chefdebord where numbat = nbat loop
    select datedebut, datefin into deb, fin
      from activite
      where numact = nact;

    if not(Disjonction(dd, df, deb::date, fin::date)) then
      return false;
    end if;
  end loop;
  return true;
end;
$$LANGUAGE 'plpgsql';


-----------------------------------------------------------------------
-- Disponibilité d'un adhérent entre deux dates (comprises)
-----------------------------------------------------------------------
CREATE OR REPLACE function MembreDispo(nadh numeric, dd date, df date) RETURNS boolean AS
--{} => {résultat = vrai si l'adhérent de numéro nadh est disponible de dd à df (comprises)
--			une exception est levée si df est antérieure à dd}
$$
declare
deb varchar(10);
fin varchar(10);
nact numeric(3);
begin
  if df < dd then
    raise exception 'les dates ne sont pas dans le bon ordre!';
  end if;

  for nact in select numact from equipage where numadh = nadh loop
    select datedebut, datefin into deb, fin
      from activite
      where numact = nact;

    if not(Disjonction(dd, df, deb::date, fin::date)) then
      return false;
    end if;
  end loop;

  for nact in select numact from chefdebord where numadh = nadh loop
    select datedebut, datefin into deb, fin
      from activite
      where numact = nact;

    if not(Disjonction(dd,df,deb::date, fin::date)) then
      return false;
    end if;
  end loop;

  return true;
end;
$$LANGUAGE 'plpgsql';
-----------------------------------------------------------------------
-- Possibilité de prévoir une sortie entre deux dates (comprises)
-----------------------------------------------------------------------
CREATE OR REPLACE function SortiePossible(dd date, df date) RETURNS boolean AS
--{} => {résultat = vrai si au moins un bateau, un skipper et 4 autres membres sont
--       disponibles de dd à df (comprises)}
$$
declare
  numequi numeric(4);
begin
  if df < dd then
    raise exception 'les dates ne sont pas dans le bon ordre!';
  end if;
  perform numadh from adherent where skipper = 'oui' and MembreDispo(numadh, dd, df);
  if not found then
    return false;
  end if;

  perform numbat from bateau where BateauDispo(numbat, dd, df);
  if not found then
    return false;
  end if;

  select count(numadh) into numequi from adherent where skipper = 'non' and MembreDispo(numadh, dd, df);

  return numequi >= 4;

end;
$$LANGUAGE 'plpgsql';





-----------------------------------------------------------------------
-- Participations passées d'un membre à une activité
-----------------------------------------------------------------------
CREATE OR REPLACE function Participations(in numa numeric,
														out nbsorties numeric, out nbrallyes numeric) AS
--{numa est le numéro d'un adhérent} =>
--		{nbsorties = nombre de sorties terminées auxquelles numa a participé,
--		 nbrallyes = nombre de rallyes terminés auxquels numa a participé}




-----------------------------------------------------------------------
-- Saisie des résultats des concurrents et calcul automatisé des points
-- obtenus selon le classement, après une régate d'un rallye terminé
-----------------------------------------------------------------------
CREATE OR REPLACE function EnregResultats(numra numeric, numre numeric, numb numeric, place numeric)
		RETURNS VOID AS
--{numra est le numéro d'un rallye, numre est le numéro d'une régate,
-- numb est le numéro d'un bateau, place est le classement supposé de ce bateau
-- si place = 999, le bateau a abandonné lors de la régate numre} =>
--		{si le rallye n'est pas terminé ou s'il a moins de numre régates, ou encore si le bateau numb
-- 	 n'a pas participé à ce rallye, une exception est levée
--		 sinon, les points obtenus sont calculés et affichés et la table résultat est mise à jour}





-----------------------------------------------------------------------
-- Création automatisée de nouvelles régates pour un rallye
-- version 1
-----------------------------------------------------------------------

-- version 1 : aucune régate préalablement créée pour l'activité
CREATE OR REPLACE function Insregates(nact numeric, nbreg numeric) RETURNS void AS
--{nact est le numéro d'une activité, nbreg est le nombre de régates à créer,
-- il n'y a aucune régate déjà créée pour cette activité} =>
--		{si nact est bien le numéro d'un ralllye terminé, nbreg régates ont été créées
--		 sinon des exceptions sont levées}





-- version 2 (BONUS) : il peut exister des régates pour cette activité
CREATE OR REPLACE function Insregates(nact numeric, nbreg numeric) RETURNS void AS
--{nact est le numéro d'une activité, nbreg est le nombre de régates à créer} =>
--		{si nact est bien le numéro d'un ralllye terminé, nbreg régates ont été créées
--		 sinon des exceptions sont levées}






-----------------------------------------------------------------------
-- Information sur les membres inscrits comme équipiers sur un bateau
-- pour une activité donnée
-----------------------------------------------------------------------
CREATE OR REPLACE function InfosEquipiers(numa numeric, numb numeric) RETURNS TABLE(nadh numeric, pr varchar, nm varchar, tel varchar) AS
--{numa est le numéro d'une activité, numb est le numéro d'un bateau} =>
--		{le résultat est une table où dans chaque ligne :
--		 nadh est le numéro, pr est le prénom, nm est le nom, tel est le téléphone d'un membre
--		 inscrit comme équipier du bateau numb pour l'activité numa}




-----------------------------------------------------------------------
-- Numéro des activités commençant entre J+7 et J+13
-----------------------------------------------------------------------
CREATE OR REPLACE function ListActNextWeek() RETURNS SETOF numeric AS
-- {} => {résultat = liste de numéros d'activités dont la date de début est comprise entre J+7 et
--			 J+13 au sens large}





-----------------------------------------------------------------------
-- SUIVI des activités futures
-----------------------------------------------------------------------

----------------------------------------------------------
-- 1 - Contrôle des activités commençant entre J+7 et J+13
----------------------------------------------------------
CREATE OR REPLACE function EtatActNextWeek() RETURNS TABLE
			(num numeric, nature varchar, dd date, df date, etat varchar) AS
-- {} => {résultat = table où, pour chaque ligne :
--				* num est le numéro d'une activité débutant entre J+7 et J+13
--				* nature est son type
--				* dd et df sont ses dates de début et de fin
--				* etat = 'SANS SKIPPER' ou 'RAS' ou 'PBM'
-- SANS SKIPPER => aucun bateau n'est inscrit à l'activité de numéro num
-- RAS => tous les bateaux inscrits à l'activité de numéro num ont au moins 5 membres à leur bord
-- PBM => au moins un bateau inscrit à l'activité de numéro num n'a pas 5 membres à son bord
--
-- La table résultat est triée par ordre chronologique (de date début)}
$$
declare
	act record;
	bat numeric;
	OK boolean;
begin
	FOR act IN SELECT * FROM activite WHERE numact IN (SELECT * FROM ListActNextWeek()) ORDER BY datedebut loop
		if act.numact NOT IN (SELECT numact FROM chefdebord) then
			etat := 'SANS SKIPPER';
		else
			OK := true;
			for bat IN SELECT numbat FROM chefdebord WHERE numact = act.numact loop
				if (SELECT count(*) +1 FROM equipage WHERE numact = act.numact and numbat = bat) < 5 then
					OK := false;
				end if;
			end loop;
			if OK then etat := 'RAS';
			else	etat := 'PBM';
			end if;
		end if;
		SELECT act.numact, act.typeact, act.datedebut, act.datefin INTO num, nature, dd, df;
		RETURN NEXT;
	end loop;
end; $$ language 'plpgsql';

----------------------------------------------------------
-- 2 - Contrôle des bateaux inscrits à des activités
--		 commençant entre J+7 et J+13
----------------------------------------------------------
CREATE OR REPLACE function ControleBat(numa numeric)
	RETURNS TABLE(numb numeric, nbinsc numeric, places numeric, nbdispo numeric, etat varchar) AS
-- {numa est le numéro d'une activité} => {résultat = table où pour chaque ligne :
--				* numb est le numéro d'un bateau inscrit à l'activité numa
--				* nbinsc est le nombre d'inscrits sur ce bateau pour l'activité numa
--				* places est le nombre de places restantes sur ce bateau
--				* nbdispo est le nombre d'adhérents disponibles pour participer à l'activté numa
--				* etat = 'OK' ou 'INCOMPLET'
-- OK => au moins 5 membres sont inscrits sur le bateau numb pour l'activité numa
-- INCOMPLET => moins de 5 membres sont inscrits sur le bateau numb pour l'activité numa}





-----------------------------------------------------------------------
-- Planning d'un adhérent (ses participations futures)
-----------------------------------------------------------------------
CREATE OR REPLACE function MonPlanning() RETURNS void AS
--{} => {affiche les informations sur les activités futures auxquelles le membre connecté est inscrit
--			les informations sont triées par ordre chronologique sur la date de début}





-----------------------------------------------------------------------
-- Préparation de l'annulation d'activités ou de la participation de
-- bateaux à ces activités
-- Activités concernées : celles débutant entre J+7 et J+13 (compris)
-----------------------------------------------------------------------
CREATE OR REPLACE function PrepAnnulation() RETURNS void AS
-- {} => {le numéro, le type, les dates et les ports de chaque activité débutant entre J+7 et J+13
--			 a été affiché ;
--        pour chaque activité :
--			 * un message exprime si l'activité est maintenue, partiellement maintenue ou annulée
--			 * dans le cas d'une activité partiellement maintenue ou annulée :
--				un message est affiché pour chaque bateau dont la participation doit être annulée, il
--				précise le prénom, le nom et le numéro de téléphone du chef de bord ainsi que le prénom, le nom et
--				le numéro de téléphone de chaque membre d'équipage}





-----------------------------------------------------------------------
