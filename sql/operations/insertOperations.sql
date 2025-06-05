use soccorso;

drop function if exists aggiungi_operatore;
drop function if exists aggiungi_aggiornamento;
drop function if exists aggiungi_richiesta_timestamp_corrente;
drop function if exists aggiungi_richiesta_timestamp_personalizzato;
drop function if exists aggiungi_abilita;
drop function if exists aggiungi_abilitaAmministratore;
drop function if exists aggiungi_abilitaOperatore;
drop function if exists aggiungi_amministratore;
drop function if exists aggiungi_conclusione;
drop function if exists aggiungi_materiale;
drop function if exists aggiungi_mezzo;
drop function if exists aggiungi_missione;
drop function if exists aggiungi_missioneMateriale;
drop function if exists aggiungi_missioneMezzo;
drop function if exists aggiungi_patente;
drop function if exists aggiungi_patenteOperatore;
drop function if exists aggiungi_squadra;
drop function if exists aggiungi_squadraOperatore;

/*
Tutte le funzioni che inseriscono una riga in ogni tabella del DB restituiscono l'ID dell'elemento appena aggiunto
*/

DELIMITER $

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_abilita`(nome varchar(30)) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			INSERT INTO abilita (nome)
            VALUES (nome);

			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_abilitaAmministratore`(id_amministratore int unsigned, id_abilita int unsigned) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			INSERT INTO abilitaAmministratore (ID_amministratore, ID_abilita)
            VALUES (id_amministratore, id_abilita);

			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_abilitaOperatore`(id_abilita int unsigned, id_operatore int unsigned) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			INSERT INTO abilitaOperatore (ID_abilita, ID_operatore)
            VALUES (id_abilita, id_operatore);

			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_aggiornamento`(ID_amministratore INT, ID_missione INT, messaggio_aggiornamento TEXT) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			INSERT INTO aggiornamenti (ID_amministratore, ID_missione, messaggio_aggiornamento) 
			VALUES (ID_amministratore, ID_missione, messaggio_aggiornamento);

			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_amministratore`(nome varchar(30), cognome varchar(30), data_nascita date, email varchar(40), matricola int unsigned) RETURNS int
	DETERMINISTIC
		begin
			declare id_to_return int unsigned;
			INSERT INTO amministratore (nome, cognome, data_nascita, email, matricola)
			VALUES (nome, cognome, data_nascita, email, matricola);

			set id_to_return = last_insert_id();
			return id_to_return;
		end$
    
CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_conclusione`(id_missione int unsigned, id_amministratore int unsigned, livello_successo smallint, timestamp_fine datetime) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			INSERT INTO conclusioni (ID_missione, ID_amministratore, livello_successo, timestamp_fine)
            VALUES (id_mission, id_amministratore, livello_successo, timestamp_fine);

			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_materiale`(nome varchar(20), descrzione text, quantita_totale int) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			INSERT INTO materiale (nome, descrizione quantita_totale)
            VALUES (nome, descrizione, quantita_totale);

			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_mezzo`(targa varchar(7), costruttore varchar(30), modello varchar(30), tipologia varchar(30), descrizione text) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			INSERT INTO mezzo (targa, costruttore, modello, tipologia, descrizione)
            VALUES (targa, costruttore, modello, tipologia, descrizione);

			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_missione`(timestamp_inizio datetime, obiettivo text, descrizione text, ID_squadra int, ID_richiesta int) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			INSERT INTO missione (timestamp_inizio, obiettivo, descrizione, ID_squadra, ID_richiesta)
			VALUES (timestamp_inizio, obiettivo, descrizione, ID_squadra, ID_richiesta);

			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_missioneMateriale`(id_missione int unsigned, id_materiale int unsigned, quantita int) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			INSERT INTO abilitaOperatore (ID_abilita, ID_operatore)
            VALUES (id_abilita, id_operatore);

			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_missioneMezzo`(id_missione int unsigned, id_mezzo int unsigned) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			INSERT INTO missioneMezzo (ID_missione, id_mezzo)
            VALUES (id_missione, id_mezzo);

			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_patente`(sigla varchar(5)) RETURNS int
	DETERMINISTIC
		begin
			declare id_to_return int unsigned;

			INSERT INTO patente (sigla)
            VALUES (sigla);

			set id_to_return = last_insert_id();
			return id_to_return;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_operatore`(nome varchar(30), cognome varchar(30), data_nascita date, email varchar(40), matricola int unsigned) RETURNS int
	DETERMINISTIC
		begin
			declare id_to_return int unsigned;

			INSERT INTO operatore (nome, cognome, data_nascita, email, matricola)
			VALUES (nome, cognome, data_nascita, email, matricola);

			set id_to_return = last_insert_id();
			return id_to_return;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_patenteOperatore`(id_operatore int unsigned, id_patente int unsigned, data_conseguimento date) RETURNS int
	DETERMINISTIC
		begin
			declare id_to_return int unsigned;

			INSERT INTO patenteOperatore(ID_operatore, ID_patente, data_conseguimento)
            VALUES (id_operatore, id_patente, data_conseguimento);

			set id_to_return = last_insert_id();
			return id_to_return;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_squadra`(nome varchar(20), id_operatore_caposquadra int unsigned) RETURNS int
	DETERMINISTIC
		begin
			declare id_to_return int unsigned;

			INSERT INTO squadra (nome, ID_operatore_caposquadra)
            VALUES (nome, id_operatore_caposquadra);

			set id_to_return = last_insert_id();
			return id_to_return;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_squadraOperatore`(id_operatore int unsigned, id_squadra int unsigned, ruolo varchar(20)) RETURNS int
	DETERMINISTIC
		begin
			declare id_to_return int unsigned;

			INSERT INTO squadraOperatore (ID_operatore, ID_squadra, ruolo)
            VALUES (id_operatore, id_squadra, ruolo);

			set id_to_return = last_insert_id();
			return id_to_return;
		end$

-- per l'inserimento della richiesta abbiamo creato 2 funzioni differenti: la prima che inserisce la richiesta con il timestamp di default (che è quello attuale), e la seconda che invece prende in input un dato timestamp aggiuntivo, in modo da poter aggiungere se necessario richieste non arrivate sul momento.
CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_richiesta_timestamp_corrente`(stringa_convalida varchar(20), indirizzo_ip_origine varchar(12), nome_segnalante varchar(30), 
email_segnalante varchar(40), descrizione text, indirizzo varchar(30), coordinate varchar(20)) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			insert into richiesta(stringa_convalida, indirizzo_ip_origine, nome_segnalante, email_segnalante, descrizione, indirizzo, coordinate)
			values (stringa_convalida, indirizzo_ip_origine, nome_segnalante, email_segnalante, descrizione, indirizzo, coordinate);

			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `aggiungi_richiesta_timestamp_personalizzato`(stringa_convalida varchar(20), indirizzo_ip_origine varchar(12), nome_segnalante varchar(30), 
email_segnalante varchar(40), timestamp_arrivo timestamp, descrizione text, indirizzo varchar(30), coordinate varchar(20)) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			insert into richiesta(stringa_convalida, indirizzo_ip_origine, nome_segnalante, email_segnalante, timestamp_arrivo, descrizione, indirizzo, coordinate)
			values (stringa_convalida, indirizzo_ip_origine, nome_segnalante, email_segnalante, timestamp_arrivo, descrizione, indirizzo, coordinate);
			
			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$

DELIMITER ;