use soccorso;

drop view if exists select_operatori_non_occupati;
drop view if exists select_operatori_occupati;
drop view if exists select_richieste_terminate;
drop view if exists select_richieste_annullate;
drop view if exists select_richieste_ignorate;
drop view if exists select_richieste_in_corso;
drop view if exists select_missioni_con_esito_non_totalmente_positivo;

-- Operatori non occupati
CREATE VIEW select_operatori_non_occupati AS
SELECT *
FROM operatore o
WHERE o.occupato = FALSE;

-- Operatori occupati
CREATE VIEW select_operatori_occupati AS
SELECT *
FROM operatore o
WHERE o.occupato = TRUE;

-- Richieste terminate
CREATE VIEW select_richieste_terminate AS
SELECT *
FROM richiesta r
WHERE r.stato = 'terminata';

-- Richieste annullate
CREATE VIEW select_richieste_annullate AS
SELECT *
FROM richiesta r
WHERE r.stato = 'annullata';

-- Richieste ignorate
CREATE VIEW select_richieste_ignorate AS
SELECT *
FROM richiesta r
WHERE r.stato = 'ignorata';

-- Richieste in corso
CREATE VIEW select_richieste_in_corso AS
SELECT *
FROM richiesta r
WHERE r.stato = 'in_corso';

-- Missioni con esito non totalmente positivo
CREATE VIEW select_missioni_con_esito_non_totalmente_positivo AS
SELECT m.timestamp_inizio, m.obiettivo, c.livello_successo, c.timestamp_fine
FROM conclusioni c
JOIN missione m ON c.ID_missione = m.ID
WHERE c.livello_successo < 5;