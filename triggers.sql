/*_________________________________________________________________________________________

		A - Trigger FOR EACH STATEMENT
___________________________________________________________________________________________*/


--------------------------------------------------------------------------------
-- Notifier l'utilisateur pour toute action ayant eu lieu sur
-- adherent, activite, equipage, chefdebord, regate et resultat
-- trigger t_notification
--------------------------------------------------------------------------------
create function f_notif() returns trigger
as $$
	begin
		raise notice '% sur %', TG_OP, TG_TABLE_NAME;
		return new;
	end;
$$LANGUAGE 'plpgsql';

create trigger t_notification after update or insert or delete
	on adherent
	for each statement
	execute procedure f_notif();
create trigger t_notification after update or insert or delete
	on activite
	for each statement
	execute procedure f_notif();
create trigger t_notification after update or insert or delete
	on equipage
	for each statement
	execute procedure f_notif();
create trigger t_notification after update or insert or delete
	on chefdebord
	for each statement
	execute procedure f_notif();
create trigger t_notification after update or insert or delete
	on regate
	for each statement
	execute procedure f_notif();
create trigger t_notification after update or insert or delete
	on resultat
	for each statement
	execute procedure f_notif();
/*_________________________________________________________________________________________

		B - Triggers FOR EACH ROW sur des tables
___________________________________________________________________________________________*/

--------------------------------------------------------------------------------
-- Q1 : Contrôler la pérennité de l'agrément d'un skipper
--	trigger t_SkiperForLife
--------------------------------------------------------------------------------
create function f_skipfl() returns trigger
as $$
	begin
		if old.skipper = 'oui' and new.skipper = 'non' then
			raise exception '(t_skipperforlife) Un skipper ne peut pas perdre son agrement!';
		else
			return new;
		end if;
	end;
$$LANGUAGE 'plpgsql';


create trigger t_SkipperForLife before UPDATE
	on adherent
	for each row
	execute procedure f_skipfl();

--------------------------------------------------------------------------------
-- Q2 : Contrôler l'inscription d'un adhérent comme membre d'équipage
-- trigger t_InscriptionEqu
--------------------------------------------------------------------------------
create or replace function f_inscriptionsEqu() returns trigger as
$$
	declare
	dd date;
	df date;
	begin
		select datedebut,datefin into dd, df from VActivitesFutures
			where numact = new.numact;
		if not found then
			raise exception '(t_InscriptionEqu) l''activite a deja commence ou est terminee.';
		end if;
		if not membredispo(new.numadh,dd, df) then
			raise exception '(t_InscriptionEqu) l''adherent % est soit deja inscrit soit indisponible entre le % et le %', new.numadh, dd, df;
		end if;
		if (select places from controlebat(new.numact) where numb = new.numbat) = 0	then
			raise exception '(t_InscriptionEqu) le bateau % est complet pour l''activite %', new.numbat, new.numact;
		end if;
		return new;
	end;
$$LANGUAGE 'plpgsql';

create trigger t_InscriptionEqu before insert on equipage
	for each row
	execute procedure f_inscriptionsEqu();


--------------------------------------------------------------------------------
-- Q3 : Contrôler l'inscription d'un adhérent comme chef de bord
-- trigger t_InscriptionCdb
--------------------------------------------------------------------------------
create function f_inscriptionsCdb() returns trigger
as  $$
declare
dd date;
df date;
begin
	select datedebut,datefin into dd, df from VActivitesFutures
		where numact = new.numact;
	if not found then
		raise exception '(t_InscriptionCdb) l''activite a deja commence ou est terminee.';
	end if;
	if not membredispo(new.numadh,dd, df) then
		raise exception '(t_InscriptionCdb) l''adherent % est soit deja inscrit soit indisponible entre le % et le %', new.numadh, dd, df;
	end if;
	if not bateaudispo(new.numbat, dd, df)	then
		raise exception '(t_InscriptionCdb) le bateau % n''est pas disponible pour l''activite %', new.numbat, new.numact;
	end if;
	if (select skipper from adherent where numadh = new.numadh) = 'non' then
		raise exception '(t_InscriptionCdb) l''adherent % n''est pas skipper.', new.numadh;
	end if;
	return new;
end;
$$LANGUAGE 'plpgsql';

create trigger t_InscriptionCdb before insert on chefdebord
	for each row
	execute procedure f_inscriptionsCdb();

/*_________________________________________________________________________________________

		C - Triggers INSTEAD OF sur une vue
___________________________________________________________________________________________*/


--------------------------------------------------------------------------------
-- fonction RallyePossible (à exécuter sous votre propre login)
--------------------------------------------------------------------------------
CREATE OR REPLACE function RallyePossible(dd date, df date) returns boolean AS
$$
declare
	nb_bat numeric;
	nb_skip numeric;
	nb_eq numeric;
begin
	nb_bat := (SELECT count(*) FROM bateau WHERE bateaudispo(numbat,dd,df));
	nb_skip := (SELECT count(*) FROM adherent WHERE skipper = 'oui' and membredispo(numadh, dd, df));
	nb_eq := (SELECT count(*) FROM adherent WHERE membredispo(numadh, dd, df)) -2; -- on enlève les skippers...
	return nb_bat >= 2 and nb_skip >= 2 and nb_eq >= 8;
end $$ language 'plpgsql';

-----------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Q1 : Contrôler la possibilité de créer une activité future
-- trigger t_NewAct
--------------------------------------------------------------------------------
create function f_NewAct() returns trigger as
$$
begin

	if new.typeact = 'sortie' then
		if not(SortiePossible(new.datedebut, new.datefin)) then
			raise exception '(t_NewAct) impossible de prevoir une sortie du % au %', new.datedebut, new.datefin;
		end if;
	else
		if not(RallyePossible(new.datedebut, new.datefin)) then
			raise exception '(t_NewAct) impossible de prevoir un rallye du % au %', new.datedebut, new.datefin;
		end if;
	end if;

	if new.datedebut < now() + interval '7 days' then
		raise exception '(t_NewAct) on ne peut pas creer une activite debutant dans moins de 7 jours!';
	end if;

	select count(*)+1 into new.numact from activite;

	insert into activite select new.*;
	return null;
end;
$$LANGUAGE 'plpgsql';

create trigger t_NewAct instead of insert on VActivitesFutures
	for each row
	execute procedure f_NewAct();

--------------------------------------------------------------------------------
-- Q2 : Contrôler la mise à jour d'une activité future
-- trigger t_UpdAct
--------------------------------------------------------------------------------
create function f_UpdAct() returns trigger as
$$
begin

	if new.datedebut <> old.datedebut or new.datefin <> old.datefin then
		if (select count(*) from chefdebord where numact = old.numact)>0 then
			raise exception '(t_UpdAct) impossible de modifier: des membres sont inscrits';
		end if;
		if new.typeact = 'sortie' then
			if not(SortiePossible(new.datedebut, new.datefin)) then
				raise exception '(t_UpdAct) impossible de prevoir une sortie du % au %', new.datedebut, new.datefin;
			end if;
		else
			if not(RallyePossible(new.datedebut, new.datefin)) then
				raise exception '(t_UpdAct) impossible de prevoir un rallye du % au %', new.datedebut, new.datefin;
			end if;
		end if;
	end if;

	if new.datedebut < now() + interval '7 days' then
		raise exception '(t_UpdAct) on ne peut pas modifier une activite debutant dans moins de 7 jours!';
	end if;

	update activite set
		typeact = new.typeact, depart = new.depart,
		arrivee = new.arrivee, datedebut = new.datedebut,
		datefin = new.datefin
		where numact = old.numact;

	return null;
end;
$$LANGUAGE 'plpgsql';

create trigger t_UpdAct instead of update on VActivitesFutures
	for each row
	execute procedure f_UpdAct();



--------------------------------------------------------------------------------
-- Q3 : Contrôler la suppression d'une activité future
-- triggre t_DelAct
--------------------------------------------------------------------------------
create function f_DelAct() returns trigger as
$$
begin
	delete from resultat where numact = old.numact;
	delete from regate where numact = old.numact;
	delete from equipage where numact = old.numact;
	delete from chefdebord where numact = old.numact;
	delete from activite where numact = old.numact;
	return null;
end;
$$LANGUAGE 'plpgsql';

create trigger t_DelAct instead of delete on VActivitesFutures
	for each row
	execute procedure f_DelAct();






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
CREATE OR REPLACE function f_beforeMAJCdb() returns trigger AS $$
declare
	dd date := (SELECT datedebut FROM activite WHERE numact = old.numact);
	df date := (SELECT datefin FROM activite WHERE numact = old.numact);
	nbequ numeric := (SELECT count(*) FROM equipage WHERE numact = old.numact and numbat = old.numbat);
	nbpl numeric := (SELECT nbplaces FROM bateau WHERE numbat = new.numbat);
begin
	-- ATTENTION : ce trigger ne traite pas les modifications portant sur le numéro d'activité
	if dd > current_date then
		-- Modification du chef de bord ?
		if new.numadh != old.numadh then
			-- Contrôler si le nouveau membre proposé comme chef de bord est skipper
			if (SELECT skipper FROM adherent WHERE numadh = new.numadh) != 'oui' then
				RAISE EXCEPTION '(trigger t_beforeMAJCdb) L''adhérent numéro % n''est pas skipper, il ne peut donc pas être chef de bord',new.numadh;
			end if;
			-- Contrôler si le nouveau membre proposé comme chef de bord est disponible
			if not membredispo(new.numadh,dd,df) then
				RAISE EXCEPTION '(trigger t_beforeMAJCdb) L''adhérent numéro % est soit déjà inscrit, soit non disponible entre le % et le %',new.numadh, dd, df;
			end if;
		end if;
		-- Modification du bateau ?
		if new.numbat != old.numbat then
			-- Contrôler si le nouveau bateau proposé est disponible
			if not bateaudispo(new.numbat,dd,df) then
				RAISE EXCEPTION '(trigger t_beforeMAJCdb) Le bateau % est soit déjà utilisé, soit non disponible entre le % et le %',new.numbat,dd,df;
			end if;
			-- Contrôler si le nouveau bateau proposé a la capacité d'accueillir les membres inscrits sur l'ancien
			if nbpl < nbequ+1 then
				RAISE EXCEPTION '(trigger t_beforeMAJCdb) Le bateau % n''a pas assez de places pour l''équipage et son chef de bord',new.numbat;
			end if;
			-- Dans le cas favorable où tous les contrôles sont positifs
			-- (1) sauvegarder l'équipage de l'ancien bateau, puis supprimer les lignes correspondantes dans equipage
			-- création d'une table pour sauvegarder les numéros des membres de l'équipage
			CREATE TABLE SauvEquipiers(numeq numeric);
			-- insertion dans la table temporaire des numéros des équipiers du bateau remplacé
			INSERT INTO SauvEquipiers SELECT numadh FROM Equipage WHERE (numact,numbat) = (old.numact, old.numbat);
			-- suppression des lignes de equipage faisant référence à ces équipiers pour l'activité concernée
			DELETE FROM equipage WHERE numact = old.numact and numbat = old.numbat;
			--	(2) supprimer les lignes de resultat faisant référence au bateau remplacé pour l'activité concernée
			--     NOTE : si l'activité est une sortie, le DELETE sera sans effet
			--           (numact ne pouvant alors pas être présent dans la table resultat)
			DELETE FROM resultat WHERE numact = old.numact and numbat = old.numbat;
		end if;
	else -- la modification demandée porte sur une activité antérieure à la date du jour
		RAISE EXCEPTION '(trigger t_beforeMAJCdb) MODIFICATION IMPOSSIBLE : l''activité % est terminée',old.numact;
	end if;
	return new;
end; $$ language 'plpgsql';

CREATE trigger t_beforeMAJCdb
BEFORE UPDATE ON chefdebord
FOR EACH ROW execute procedure f_beforeMAJCdb();

--------------------------------------------------------------------------------------------
-- 2 : Actions effectuées APRES mise à jour d'un numéro de bateau dans chef de bord
-- trigger t_afterMAJCdb
--------------------------------------------------------------------------------------------*/
create function f_afterMAJCdb() returns trigger as
$$
declare
	equ int;
begin
	if old.numbat <> new.numbat then
		for equ in (select * from SauvEquipiers) loop
			insert into equipage values(new.numact, equ, new.numbat);
			if (select typeact from activite where numact = new.numact) = 'rallye' then
				/* INSERT INTO resultat -- CET INSERT N'EST APPAREMMENT PAS NECESSAIRE
					SELECT new.numbat, new.numact, numregate
					from regate
					where numact = new.numact; */
			end if;
		end loop;
		drop table SauvEquipiers;
	end if;
	return new;
end;
$$LANGUAGE 'plpgsql';

create trigger t_afterMAJCdb after update on chefdebord
	for each row
	execute procedure f_afterMAJCdb();
