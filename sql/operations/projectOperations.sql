use soccorso;

drop procedure if exists aggiungi_immagine_richiesta;
drop procedure if exists conteggio_missioni_terminate_operatore;
drop procedure if exists convalida_richiesta;
drop procedure if exists tempo_medio_missione_anno;
drop procedure if exists calcolo_numero_richieste_email_segnalante;
drop procedure if exists calcolo_numero_richieste_indirizzo_ip;
drop procedure if exists calcolo_tempo_totale_operatore;
drop procedure if exists missioni_stesso_luogo_last3years;
drop procedure if exists storico_missioni_mezzo;
drop procedure if exists calcolo_tempo_uso_materiale;
drop procedure if exists disattivazione_amministratore;

DELIMITER $
        
CREATE DEFINER=`root`@`localhost` PROCEDURE `aggiungi_immagine_richiesta`(in ID_richiesta INT, in file_immagine blob, in didascalia_immagine varchar(30))
	begin
		update richiesta set file_immagine = file_immagine, didascalia_immagine = didascalia_immagine where ID = ID_richiesta;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `convalida_richiesta`(in ID_richiesta INT, in stringa_convalida varchar(20))
	begin
		update richiesta r set r.stato = 'convalidata' WHERE r.ID = ID_richiesta;
        update richiesta r set r.stringa_convalida = stringa_convalida WHERE r.ID = ID_richiesta;
	end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tempo_medio_missione_anno`(in anno int)
	begin
		select avg (timestampdiff(second, m.timestamp_inizio, c.timestamp_fine)) / 3600 as tempo_medio_missione_in_ore
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `calcolo_numero_richieste_indirizzo_ip`(in indirizzo_ip varchar(15))
	begin
		SELECT count(distinct r.ID)
        FROM richiesta r
        WHERE r.indirizzo_ip_segnalante = indirizzo_ip
			AND r.timestamp_arrivo >= NOW() - interval 36 HOUR;
	end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `calcolo_tempo_totale_operatore`(in id_operatore int)
	begin
		SELECT o.nome, o.cognome, o.matricola, SUM(timestampdiff(SECOND, m.timestamp_inizio, c.timestamp_fine)) / 3600 AS tempo_totale_ore
        FROM missione m	
        JOIN conclusione c ON m.ID = c.ID_missione
        JOIN squadraOperatore so ON so.ID_squadra = m.ID_squadra
		JOIN operatore o ON so.ID_operatore = o.ID
        WHERE so.ID_operatore = id_operatore
		GROUP BY o.ID;
	end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `missioni_stesso_luogo_last3years`(in id_missione int)
	begin
		SELECT m1.*
		FROM missione m1
		JOIN richiesta r1 ON r1.ID = m1.ID_richiesta
		JOIN missione m2 ON m2.ID = id_missione
		JOIN richiesta r2 ON r2.ID = m2.ID_richiesta
		WHERE r1.indirizzo = r2.indirizzo
			AND r1.coordinate = r2.coordinate
			AND m1.timestamp_inizio >= NOW() - INTERVAL 3 YEAR
			AND m1.ID != m2.ID; -- serve as escluderela missione passata in input
	end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `storico_missioni_mezzo`(in id_mezzo int unsigned)
	begin
		select mz.targa, mz.costruttore, mz.modello, m.ID as ID_missione, m.timestamp_inizio, m.obiettivo,
				m.descrizione, r.coordinate, r.indirizzo, r.stato as stato_richiesta
        from mezzo mz
        join missioneMezzo mm on mz.ID = mm.ID_mezzo
        join missione m on mm.ID_missione = m.ID
        join richiesta r on m.ID_richiesta = r.ID
        where mz.ID = id_mezzo;
    end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `calcolo_tempo_uso_materiale`(in id_materiale int)
	begin
		SELECT ma.nome as nome_materiale, SUM(timestampdiff(SECOND, m.timestamp_inizio, c.timestamp_fine)) / 3600 AS tempo_uso_materiale
        FROM missioneMateriale mm	
		JOIN missione m ON mm.ID_missione = m.ID
        JOIN conclusione c ON m.ID = c.ID_missione
		JOIN materiale ma on mm.ID_materiale = ma.ID
        WHERE mm.ID_materiale = id_materiale;
		GROUP BY ma.ID;
	end$

CREATE DEFINER=`root`@`localhost` PROCEDURE `disattivazione_amministratore`(in id_amministratore int)
	begin
		UPDATE amministratore a SET a.attivo = FALSE WHERE a.ID = id_amministratore;
	end$
DELIMITER ;