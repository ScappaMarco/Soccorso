use soccorso;

drop procedure if exists select_all_abilita;
drop procedure if exists select_all_abilitaAmministratore;
drop procedure if exists select_all_abilitaOperatore;
drop procedure if exists select_all_aggiornamenti;
drop procedure if exists select_all_amministratori;
drop procedure if exists select_all_conclusioni;
drop procedure if exists select_all_materiali;
drop procedure if exists select_all_mezzi;
drop procedure if exists select_all_missioni;
drop procedure if exists select_all_missioneMateriale;
drop procedure if exists select_all_missioneMezzo;
drop procedure if exists select_all_operatori;
drop procedure if exists select_all_patenti;
drop procedure if exists select_all_patenteOperatore;
drop procedure if exists select_all_richieste;
drop procedure if exists select_all_squadre;
drop procedure if exists select_all_squadraOperatore;

/* 
funzioni che selezionano tutte le righe di una tabella
*/

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_abilita`()
    begin
        SELECT * FROM abilita;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_abilitaAmministratore`()
    begin
        SELECT * FROM abilitaAmministratore;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_abilitaOperatore`()
    begin
        SELECT * FROM abilitaOperatore;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_aggiornamenti`()
    begin
        SELECT * FROM aggiornamenti;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_amministratori`()
    begin
        SELECT * FROM amministratore;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_conclusioni`()
    begin
        SELECT * FROM conclusioni;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_materiali`()
    begin
        SELECT * FROM materiale;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_mezzi`()
    begin
        SELECT * FROM mezzo;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_missioni`()
    begin
        SELECT * FROM missione;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_missioneMateriale`()
    begin
        SELECT * FROM missioneMateriale;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_missioneMezzo`()
    begin
        SELECT * FROM missioneMezzo;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_operatori`()
    begin
        SELECT * FROM operatore;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_patenti`()
    begin
        SELECT * FROM patente;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_patenteOperatore`()
    begin
        SELECT * FROM patenteOperatore;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_richieste`()
    begin
        SELECT * FROM richiesta;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_squadre`()
    begin
        SELECT * FROM squadra;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_squadraOperatore`()
    begin
        SELECT * FROM squadraOperatore;
    end$

/*---------------------------------------------------------------------------*/

drop procedure if exists select_abilita_on_id;
drop procedure if exists select_aggiornamento_on_id;
drop procedure if exists select_amministratore_on_id;
drop procedure if exists select_materiale_on_id;
drop procedure if exists select_mezzo_on_id;
drop procedure if exists select_missione_on_id;
drop procedure if exists select_operatore_on_id;
drop procedure if exists select_patente_on_id;
drop procedure if exists select_richiesta_on_id;
drop procedure if exists select_squadra_on_id;

/*
funzioni che restituiscono una specifiga riga di una tabella
*/

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_abilita_on_id`(in id_abilita int unsigned)
    begin
        SELECT * FROM abilita a WHERE a.ID = id_abilita;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_aggiornamento_on_id`(in id_agg int unsigned)
    begin
        SELECT * FROM aggiornamenti a WHERE a.ID = id_agg;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_amministratore_on_id`(in id_admin int unsigned)
    begin
        SELECT * FROM amministratore a WHERE a.ID = id_admin;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_materiale_on_id`(in id_materiale int unsigned)
    begin
        SELECT * FROM materiale m WHERE m.ID = id_materiale;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_mezzo_on_id`(in id_mezzo int unsigned)
    begin
        SELECT * FROM mezzo m WHERE m.ID = id_mezzo;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_missione_on_id`(in id_missione int unsigned)
    begin
        SELECT * FROM missione m WHERE m.ID = id_missione;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_operatore_on_id`(in id_operatore int unsigned)
    begin
        SELECT * FROM operatore o WHERE o.ID = id_operatore;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_patente_on_id`(in id_patente int unsigned)
    begin
        SELECT * FROM patente p WHERE p.ID = id_patente;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_richiesta_on_id`(in id_richiesta int unsigned)
    begin
        SELECT * FROM richiesta r WHERE r.ID = id_richiesta;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_squadra_on_id`(in id_squadra int unsigned)
    begin
        SELECT * FROM squadra sq WHERE sq.ID = id_squadra;
    end$

/*---------------------------------------------------------------------------*/