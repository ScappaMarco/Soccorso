use soccorso;


drop function if exists inserisci_richiesta_timestamp_corrente;
drop function if exists inserisci_richiesta_timestamp_personalizzato;
drop procedure if exists aggiungi_immagine_richiesta;
drop procedure if exists termina_missione;
drop function if exists crea_missione_associata;
drop procedure if exists conteggio_missioni_terminate_operatore;
drop function if exists aggiungi_aggiornamento;
drop procedure if exists tempo_medio_missione_anno;

/*
Tutte le funzioni che inseriscono una riga in una tabella del DB restituiscono l'ID dell'elemento appena aggiunto
*/

DELIMITER $
-- per l'inserimento della richiesta abbiamo creato 2 funzioni differenti: la prima che inserisce la richiesta con il timestamp di default (che è quello attuale), e la seconda che invece prende in input un dato timestamp aggiuntivo, in modo da poter aggiungere se necessario richieste non arrivate sul momento.
CREATE DEFINER=`root`@`localhost` FUNCTION `inserisci_richiesta_timestamp_corrente`(stringa_convalida varchar(20), indirizzo_ip_origine varchar(12), nome_segnalante varchar(30), 
email_segnalante varchar(40), descrizione text, indirizzo varchar(30), coordinate varchar(20)) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;
			insert into richiesta(stringa_convalida, indirizzo_ip_origine, nome_segnalante, email_segnalante, descrizione, indirizzo, coordinate)
			values (stringa_convalida, indirizzo_ip_origine, nome_segnalante, email_segnalante, descrizione, indirizzo, coordinate);
			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$

CREATE DEFINER=`root`@`localhost` FUNCTION `inserisci_richiesta_timestamp_personalizzato`(stringa_convalida varchar(20), indirizzo_ip_origine varchar(12), nome_segnalante varchar(30), 
email_segnalante varchar(40), timestamp_arrivo timestamp, descrizione text, indirizzo varchar(30), coordinate varchar(20)) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			insert into richiesta(stringa_convalida, indirizzo_ip_origine, nome_segnalante, email_segnalante, timestamp_arrivo, descrizione, indirizzo, coordinate)
			values (stringa_convalida, indirizzo_ip_origine, nome_segnalante, email_segnalante, timestamp_arrivo, descrizione, indirizzo, coordinate);
			
			set ID_toReturn = last_insert_id();
			return ID_toReturn;
		end$
        
CREATE DEFINER=`root`@`localhost` PROCEDURE `aggiungi_immagine_richiesta`(in ID_richiesta INT, in file_immagine blob, in didascalia_immagine varchar(30))
	begin
		update richiesta set file_immagine = file_immagine, didascalia_immagine = didascalia_immagine where ID = ID_richiesta;
	end$
    
CREATE DEFINER=`root`@`localhost` PROCEDURE `termina_missione`(in ID_missione int, in ID_amministratore int, in livello_successo int, in timestamp_fine datetime)
	begin
		insert into conclusioni (ID_missione, ID_amministratore, livello_successo, timestamp_fine) values (ID_missione, ID_amministratore, livello_successo, timestamp_fine);
        -- l'aggiornamento dello stato della richiesta a "terminata" avviene tramite trigger after insert su "conclusioni".
	end $

-- In questo caso (vincolo dovuto dall'aggiunta di trigger specifici) l'id_richiesta deve essere associato ad una richiesta in stato 'convalidata'
CREATE DEFINER=`root`@`localhost` FUNCTION `crea_missione_associata`(timestamp_inizio datetime, obiettivo text, descrizione text, ID_squadra int, ID_richiesta int) RETURNS int
    DETERMINISTIC
		begin
			declare ID_toReturn int unsigned;

			insert into missione (timestamp_inizio, obiettivo, descrizione, ID_squadra, ID_richiesta)
			values (timestamp_inizio, obiettivo, descrizione, ID_squadra, ID_richiesta);

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
    
CREATE DEFINER=`root`@`localhost` PROCEDURE `conteggio_missioni_terminate_operatore`(in ID_operatore int)
	begin
		select count(distinct m.ID) as numero_missioni_terminate
		from squadraOperatore so 
		join missione m on so.ID_squadra = m.ID_squadra
		join richiesta r on m.ID_richiesta = r.ID
		where so.ID_operatore = ID_operatore
		and r.stato = 'terminata';
	end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tempo_medio_missione_anno`(in anno int)
	begin
		select avg (timestampdiff(second, m.timestamp_inizio, c.timestamp_fine)) / 3600
		from missione m 
		join conclusioni c on m.ID = c.ID_missione
		where year (c.timestamp_fine) = anno;
	end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `calcolo_numero_richieste_email_segnalante`(in email_segnalante varchar(40))
	begin
		SELECT count(distinct r.ID)
        FROM richiesta r
        WHERE r.email_segnalante = email_segnalante 
			AND r.timestamp_arrivo >= NOW() - interval 36 HOUR;
	end$

DELIMITER ;
