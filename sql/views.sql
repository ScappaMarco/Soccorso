use soccorso;

/*
Implementazione funzionalità 3 - Selezione di tutti gli operatori impegnati una missione in corso
Soluzione implementata tramite view
*/
CREATE VIEW AS select_operatori_non_occupati (
    SELECT *
    FROM operatore o
    WHERE o.occupato = FALSE;
)

CREATE VIEW AS select_operatori_occupati (
    SELECT * 
    FROM operatore o
    WHERE o.occupato = TRUE;
)

CREATE VIEW AS select_richieste_terminate (
    SELECT *
    FROM richiesta r
    WHERE r.stato = 'terminata';
)

CREATE VIEW AS select_richieste_annullate (
    SELECT *
    FROM richiesta r
    WHERE r.stato = 'annullata';
)

CREATE VIEW AS select_richieste_ignorate (
    SELECT *
    FROM richiesta r
    WHERE r.stato = 'ignorata';
)

CREATE VIEW AS select_richieste_in_corso (
    SELECT *
    FROM richiesta r
    WHERE r.stato = 'in_corso';
)

CREATE VIEW AS select_missioni_con_esito_non_totalmente_positivo (
    SELECT m.timestamp_inizio, m.obiettivo, c.livello_successo, c.timestamp_fine
    FROM conclusioni c
    JOIN missione m ON c.ID_missione = m.ID
    WHERE c.livello_successo < 5;
)