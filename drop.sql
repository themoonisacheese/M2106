-- triggers TP3

-- procédures TP2
drop function if exists MembreDispo(nadh numeric, dd date, df date) RETURNS boolean;
drop function if exists BateauDispo(nbat numeric, dd date, df date) RETURNS boolean;
drop function if exists Disjonction(dd1 date, df1 date, dd2 date, df2 date) RETURNS boolean;
drop function if exists NombreJours(in nact numeric) RETURNS numeric;
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
