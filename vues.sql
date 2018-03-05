---------------------------------------------------------------
-- Vue VActivitesFutures
-- Toutes les informations sur les activités dont la date de départ est ultérieure à la date du jour
-- Vue ordonnée sur la date de départ
---------------------------------------------------------------

create view VActivitesFutures as
select *
from activite
where datedebut > now()
order by datedebut asc;

---------------------------------------------------------------
-- Vue VParticipations(id, nom, nbfois_cdb, nbfois_equ)
-- Pour chaque ligne affichée par la vue
-- id = numéro d'un adhérent
-- nom = nom de cet adhérent
-- nbfois_cdb = nombre de fois où il a été chef de bord par le passé
-- nbfois_equ = nombre de fois où il a été simple équipier par le passé
---------------------------------------------------------------

create view VParticipations as
select numadh as id, a.nom, (select count(equipage.numadh) as nbfois_equ
	from equipage
	where equipage.numadh = a.numadh
	and numact in (select numact from activite where datefin < now())),
(select count(c.numadh) as nbfois_cdb
	from chefdebord c
	where c.numadh = a.numadh
	and numact in (select numact from activite where datefin < now()))
from adherent a;


---------------------------------------------------------------
-- Vue VMoi (pour les adhérents)
---------------------------------------------------------------

create view Vmoi as
select *
from adherent
where nom = (select CURRENT_USER);


---------------------------------------------------------------
-- Vue VMembres (pour les adhérents)
---------------------------------------------------------------

create view VMembres as
select nom, prenom, adresse, telephone, fonction, skipper
from adherent;


---------------------------------------------------------------
-- Vue VMesCotisations (pour les adhérents)
---------------------------------------------------------------

create view VMesCotisations as
select anneecot as an, montant, paye as a_jour
from cotisation
where numadh = (select numadh
								from adherent
								where nom = (select CURRENT_USER));

----------------------------------------------------
-- Vue VMesRespFutures(pour les skippers)
---------------------------------------------------------------
create view VMesRespFutures as
select v.numact, typeact, datedebut, datefin, depart, arrivee, nombat, nbplaces, (select count(numadh) from equipage e where e.numact = c.numact)
from vactivitesfutures v, bateau b, chefdebord c
where c.numact = v.numact
and c.numbat = b.numbat
and c.numadh = (select numadh
								from adherent
								where nom = (select CURRENT_USER))
order by datedebut asc;

---------------------------------------------------------------
-- Vue VAppelCotisation (pour le trésorier)
---------------------------------------------------------------
create view VAppelCotisation as
select numadh, montant, paye
from cotisation
where anneecot = date_part('year', CURRENT_DATE)
order by numadh asc;
