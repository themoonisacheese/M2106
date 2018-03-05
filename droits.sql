-----------------------------------------------------------------------------------
-- B1 - Droits sur la base
-----------------------------------------------------------------------------------

-- modification de votre mot de passe
alter user userd114 password 'saucisse';

-- suppression pour tous des droits de connexion à la base
revoke connect on database based114 from public;

-- droits d'accès à la base pour tous les adhérents (rôle adherent)
grant connect on database based114 to adherent;

-----------------------------------------------------------------------------------
-- B2 - Droits sur les objets de la base
-----------------------------------------------------------------------------------

-- 1 - Droits du rôle president
grant select, update, delete, insert on all tables in schema public to president;

-----------------------------------------------------------------------------
-- 2 - Droits du rôle adherent

-- Premiers droits du rôle adherent

grant select on bateau, chefdebord, equipage, resultat, vactivitesfutures to adherent;

-- Droits sur la vue VMoi
grant select on VMoi to adherent;
grant update(telephone, adresse) on vmoi to adherent;
-- Droits sur la vue VMembres
grant select on VMembres to adherent;

-- Droits sur la vue VMesCotisations
grant select on VMesCotisations to adherent;

-----------------------------------------------------------------------------
-- 3 - Droits spécifiques au rôle skipper : droits sur la vue VMesRespFutures
grant select on VMesRespFutures to skipper;

-----------------------------------------------------------------------------
-- 5 - Droits spécifiques au rôle bureau
grant select on all tables in schema public to bureau;
revoke select on cotisation from bureau;

-----------------------------------------------------------------------------
-- 6 - Droits spécifiques au rôle tresorier
grant select, update, insert on VAppelCotisation to tresorier;


----------------------------------------------------------------------------
-- 7 - Droits spécifiques du rôle secretaire
grant select, insert, update on adherent, bateau, agence, proprietaire, loueur to secretaire;
grant select, insert, update, delete on activite, vactivitesfutures to secretaire;
grant select, insert, delete on chefdebord, equipage to secretaire;
grant insert(numact, numregate) on regate to secretaire;
grant insert(numbat, numact, numregate) on resultat to secretaire;
grant update(forcevent) on regate to secretaire;
grant update(classement, points) on resultat to secretaire;

----------------------------------------------------------------------------------------------------------------
-- 8 - Droits manquants au rôle président...
