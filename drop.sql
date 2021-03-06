-- triggers TP3
drop trigger if exists t_afterMAJCdb on chefdebord;
drop function if exists f_afterMAJCdb();
drop trigger if exists t_beforeMAJCdb on chefdebord;
drop function if exists f_beforeMAJCdb();
drop trigger if exists t_DelAct on VActivitesFutures;
drop function if exists f_DelAct();
drop trigger if exists t_UpdAct on VActivitesFutures;
drop function if exists f_UpdAct();
drop trigger if exists t_NewAct on VActivitesFutures;
drop function if exists f_NewAct();
drop trigger if exists t_InscriptionCdb on chefdebord;
drop function if exists f_inscriptionsCdb();
drop trigger if exists t_InscriptionEqu on equipage;
drop function if exists f_inscriptionsEqu();
drop trigger if exists t_skipperforlife on adherent;
drop function if exists f_skipfl();
drop trigger if exists t_notification on adherent;
drop trigger if exists t_notification on activite;
drop trigger if exists t_notification on equipage;
drop trigger if exists t_notification on chefdebord;
drop trigger if exists t_notification on regate;
drop trigger if exists t_notification on resultat;
drop function if exists f_notif();
-- procédures TP2
drop function if exists PrepAnnulation();
drop function if exists MonPlanning();
drop function if exists ControleBat(numa numeric);
drop function if exists EtatActNextWeek();
drop function if exists ListActNextWeek();
drop function if exists InfosEquipiers(numa numeric, numb numeric);
drop function if exists Insregates(nact numeric, nbreg numeric);
drop function if exists EnregResultats(numra numeric, numre numeric, numb numeric, place numeric);
drop function if exists Participations(in numa numeric,out nbsorties numeric, out nbrallyes numeric);
drop function if exists SortiePossible(dd date, df date);
drop function if exists MembreDispo(nadh numeric, dd date, df date);
drop function if exists BateauDispo(nbat numeric, dd date, df date);
drop function if exists Disjonction(dd1 date, df1 date, dd2 date, df2 date);
drop function if exists NombreJours(in nact numeric);
-- vues TP1

drop view if exists VAppelCotisation;
drop view if exists VMesRespFutures;

drop view if exists vmescotisations;

drop view if exists vmembres;

drop view if exists VMoi;

drop view if exists VParticipations;

drop view if exists Vactivitesfutures;


-- tables initiales
drop table if exists RESULTAT;
drop table if exists REGATE;
drop table if exists EQUIPAGE;
drop table if exists CHEFDEBORD;
drop table if exists LOUEUR;
drop table if exists PROPRIETAIRE;
drop table if exists AGENCE;
drop table if exists COTISATION;
drop table if exists ACTIVITE;
drop table if exists BATEAU;
drop table if exists ADHERENT;
