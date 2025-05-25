use soccorso;

drop function if exists inserisci_richiesta_timestamp_corrente;
drop function if exists inserisci_richiesta_timestamp_personalizzato;
drop procedure if exists aggiungi_immagine_richiesta;
drop procedure if exists termina_missione;

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
        
DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `aggiungi_immagine_richiesta`(in ID_richiesta INT, in file_immagine blob, in didascalia_immagine varchar(30))
	begin
		update richiesta set file_immagine = file_immagine, didascalia_immagine = didascalia_immagine where ID = ID_richiesta;
	end$
    
CREATE DEFINER=`root`@`localhost` PROCEDURE `termina_missione`(in ID_missione int, in ID_amministratore int, in livello_successo int, in timestamp_fine datetime)
	begin
		insert into conclusioni (ID_missione, ID_amministratore, livello_successo, timestamp_fine) values (ID_missione, ID_amministratore, livello_successo, timestamp_fine);
        -- l'aggiornamento dello stato della richiesta a "terminata" avviene tramite trigger after insert su "conclusioni".
	end $
DELIMITER ;
