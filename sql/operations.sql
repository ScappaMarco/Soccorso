use soccorso;
drop function if exists inserisci_richiesta;
drop procedure if exists termina_missione;

DELIMITER $
CREATE DEFINER=`root`@`localhost` FUNCTION `inserisci_richiesta`(stringa_convalida varchar(20), indirizzo_ip_origine varchar(12), stato varchar(12), nome_segnalante varchar(30), 
email_segnalante varchar(40), timestamp_arrivo datetime, file_immagine blob, didascalia_immagine varchar(30), descrizione text, indirizzo varchar(30), coordinate varchar(20)) RETURNS int
    DETERMINISTIC
begin
	declare ID int unsigned;
    if stato not in ('in_attesa','convalidata', 'in_corso', 'terminata') then 
		signal sqlstate '45000'
        set message_text = 'Stato non valido';
	end if;
    insert into richiesta(stringa_convalida, indirizzo_ip_origine, stato, nome_segnalante, email_segnalante, timestamp_arrivo, file_immagine,
    didascalia_immagine, descrizione, indirizzo, coordinate)
    values (stringa_convalida, indirizzo_ip_origine, stato, nome_segnalante, email_segnalante, timestamp_arrivo, file_immagine,
    didascalia_immagine, descrizione, indirizzo, coordinate);
    set ID = last_insert_id();
    return ID;
end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `termina_missione`(in ID_missione int, in ID_amministratore int, in livello_successo int, in timestamp_fine datetime)
begin
	declare ID_richiesta_selezionato int;
    
    -- troviamo l'id della richiesta associato alla missione
    select ID_richiesta into ID_richiesta_selezionato from missione where ID = ID_missione;
    
    insert into conclusioni (ID_missione, ID_amministratore, livello_successo, timestamp_fine) values (ID_missione, ID_amministratore, livello_successo, timestamp_fine);
    
    -- aggiornamento stato della richiesta
    update richiesta 
    set stato = 'terminata'
    where ID = ID_richiesta_selezionato;
end $
DELIMITER ;
