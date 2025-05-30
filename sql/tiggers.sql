use soccorso;

/*TRIGGER*/

/*drop if exists*/
drop trigger if exists termina_richiesta_su_aggiunta;
drop trigger if exists email_minuscula_operatore_on_insert;
drop trigger if exists email_minuscola_amministratore_on_insert;
drop trigger if exists email_minuscula_operatore_on_update;
drop trigger if exists email_minuscola_amministratore_on_update;
drop trigger if exists email_segnalante_minuscola_on_insert;
drop trigger if exists email_segnalante_minuscola_on_update;
drop trigger if exists vincolo_eta_operatore_on_insert;
drop trigger if exists vincolo_eta_amministratore_on_insert;
drop trigger if exists vincolo_eta_operatore_on_update;
drop trigger if exists vincolo_eta_amministratore_on_update;
drop trigger if exists vincolo_data_conclusione_on_insert;
drop trigger if exists vincolo_data_conclusione_on_update;
drop trigger if exists vincolo_data_aggiornamenti_on_insert;
drop trigger if exists vincolo_data_aggiornamenti_on_update;
drop trigger if exists vincolo_data_missione_on_insert;
drop trigger if exists vincolo_data_missione_on_update;
drop trigger if exists vincolo_stato_richiesta;
drop trigger if exists avanza_stato_richiesta;
drop trigger if exists operatore_caposquadra_duplicato_on_insert;
drop trigger if exists operatore_caposquadra_duplicato_on_update;
drop trigger if exists settaggio_stato_operatori_on_insert_missione;
drop trigger if exists settaggio_stato_operatori_on_insert_conclusione;
drop trigger if exists vincolo_data_conseguimento_patante_on_insert;
drop trigger if exists vincolo_data_conseguimento_patante_on_update;
drop trigger if exists vincolo_aggiornamento_quantita_totale_materiale;
drop trigger if exists restituzione_materiali_e_mezzi_missione;
drop trigger if exists vincolo_conclusione_missione_terminata;
drop trigger if exists eliminazione_missione_in_corso;
drop trigger if exists aggiunta_operatore_squadra_impegnata;
drop trigger if exists aggiunta_operatore_caposquadra_squadra_occupata;
drop trigger if exists settaggio_mezzo_occupato;
drop trigger if exists modifica_materiali_assegnati_missione_in_corso;
drop trigger if exists eliminazione_materiali_assegnati_missione_in_corso;
drop trigger if exists modifica_mezzi_assegnati_missione_in_corso;
drop trigger if exists eliminazione_mezzi_assegnati_missione_in_corso;
drop trigger if exists vincolo_assegnazione_materiali_missione_conclusa;
drop trigger if exists vincolo_assegnazione_mezzi_missione_conclusa;

delimiter $
/*
AZIONE: after insert on conclusioni
Il seguente trigger successivamente a un inserimento sulla tabella conclusioni si occupa di settare lo stato della 
richiesta associata alla missione conclusa a "terminata"
*/
create trigger termina_richiesta_su_aggiunta
after insert on conclusioni
for each row
	begin
		declare rid INT;
        declare stato_corrente enum("in_attesa", "convalidata", "in_corso", "terminata");
        
        select m.ID_richiesta into rid
        from missione m
        where ID = NEW.ID_missione;
        
        select r.stato into stato_corrente
        from richiesta r
        where r.ID = rid;
        
        if stato_corrente <> "terminata" then
			update richiesta set stato = "terminata" where ID = rid;
		end if;
	end $
/*---------------------------------------------------------*/

/*
AZIONE: before insert on operatore
I seguenti trigger si occupa di convertire l'email degli operatori e amministratori che sta per essere inserito a minuscola, 
così da avere uno standard sulla sintassi delle email
*/
create trigger email_minuscula_operatore_on_insert
before insert on operatore
for each row
    begin
        SET NEW.email = LOWER(NEW.email);
    end $
/*---------------------------------------------------------*/

/*
AZIONE: before insert on amministratore
*/
create trigger email_minuscola_amministratore_on_insert
before insert on amministratore
for each row
    begin
        SET NEW.email = LOWER(NEW.email);
    end $
/*---------------------------------------------------------*/

/*
AZIONE: before update on operatore
*/
create trigger email_minuscula_operatore_on_update
before update on operatore
for each row
    begin
        SET NEW.email = LOWER(NEW.email);
    end $
/*---------------------------------------------------------*/

/*
AZIONE: before update on amministratore
*/
create trigger email_minuscola_amministratore_on_update
before update on amministratore
for each row
    begin
        SET NEW.email = LOWER(NEW.email);
    end $
/*---------------------------------------------------------*/

/*
AZIONE: before insert on richiesta
I seguenti trigger si occupano di convertire l'email del segnalante a minuscolo (insert e update)
*/
create trigger email_segnalante_minuscola_on_insert
before insert on richiesta
for each row
    begin
        SET NEW.email_segnalante = LOWER(NEW.email_segnalante);
    end $
/*---------------------------------------------------------*/

/*
AZIONE: before update on richiesta
*/
create trigger email_segnalante_minuscola_on_update
before update on richiesta
for each row
    begin
        SET NEW.email_segnalante = LOWER(NEW.email_segnalante);
    end $
/*---------------------------------------------------------*/

/*
AZIONE: before insert on operatore
I seguenti trigger si occupano di verificare che l'età degli amministratori / operatori inseriti sia di almeno 18 anni
e massimo 70 anni (insert e update)
*/
create trigger vincolo_eta_operatore_on_insert
before insert on operatore
for each row
    begin
        DECLARE eta INT;

        SET eta = TIMESTAMPDIFF(YEAR, NEW.data_nascita, CURDATE());

        IF eta < 18 OR eta > 70 then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "Gli operatori possono avere età compresa tra 18 e 70 anni.";
        END IF;
    end $
/*---------------------------------------------------------*/

/*
AZIONE: before insert on amministratore
*/
create trigger vincolo_eta_amministratore_on_insert
before insert on amministratore
for each row
    begin
        DECLARE eta INT;

        SET eta = TIMESTAMPDIFF(YEAR, NEW.data_nascita, CURDATE());

        IF eta < 18 OR eta > 70 then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "Gli amministratori possono avere età compresa tra 18 e 70 anni.";
        END IF;
    end $
/*---------------------------------------------------------*/

/*
AZIONE: before update on operatore
*/
create trigger vincolo_eta_operatore_on_update
before update on operatore
for each row
    begin
        DECLARE eta INT;

        SET eta = TIMESTAMPDIFF(YEAR, NEW.data_nascita, CURDATE());

        IF eta < 18 OR eta > 70 then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "Gli operatori possono avere età compresa tra 18 e 70 anni.";
        END IF;
    end $
/*---------------------------------------------------------*/

/*
AZIONE: before update on amministratore
*/
create trigger vincolo_eta_amministratore_on_update
before update on amministratore
for each row
    begin
        DECLARE eta INT;

        SET eta = TIMESTAMPDIFF(YEAR, NEW.data_nascita, CURDATE());

        IF eta < 18 OR eta > 70 then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "Gli amministratori possono avere età compresa tra 18 e 70 anni.";
        END IF;
    end $
/*---------------------------------------------------------*/

/*
AZIONE: before insert on conclusioni
I seguenti trigger prevengono l'inserimento di conclusioni con data maggiore di quella odierna (insert e update)
*/
create trigger vincolo_data_conclusione_on_insert
before insert on conclusioni
for each row
    begin
        declare timestamp_inizio_missione datetime;

        SELECT m.timestamp_inizio INTO timestamp_inizio_missione
        FROM missione m
        WHERE m.ID = NEW.ID_missione;

        IF NEW.timestamp_fine < timestamp_inizio_missione THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Data immissione conclusione missione invalida, dato che la data di conclusione viene prima della data di inizio missione';
        END IF;
        
        IF NEW.timestamp_fine > NOW() then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La data di fine missione deve essere nel passato.';
        END IF;
    end $
/*---------------------------------------------------------*/

/*
AZIONE: before update on conclusioni
*/
create trigger vincolo_data_conclusione_on_update
before update on conclusioni
for each row
    begin
        IF NEW.timestamp_fine > NOW() then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La data di fine missione deve essere nel passato.';
        END IF;
    end $

create trigger vincolo_data_aggiornamenti_on_insert
before insert on aggiornamenti
for each row
    begin
        declare timestamp_inizio_missione_associata datetime;
        declare stato_missione_associata enum("in_attesa", "convalidata", "in_corso", "terminata");

        SELECT r.stato INTO stato_missione_associata
        FROM richiesta r
        JOIN missione m ON m.ID_richiesta = r.ID
        WHERE m.ID = NEW.ID_missione;

        SELECT m.timestamp_inizio INTO timestamp_inizio_missione_associata
        FROM missione m
        WHERE m.ID = NEW.ID_missione;

        IF stato_missione_associata = "terminata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = "Impossibile aggiungere un aggiornamento a questa missione dato che è terminata.";
        END IF;

        IF NEW.timestamp_immissione < timestamp_inizio_missione_associata THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Non puoi immettere un aggiornamneto con questa data: la data selezionata viene prima della data di inizio della missione assocista';
        END IF;

        IF NEW.timestamp_immissione > NOW() THEN 
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La data di immissione di un aggiornamento deve essere nel passato.';
        END IF;
    end $

create trigger vincolo_data_aggiornamenti_on_update
before update on aggiornamenti
for each row
    begin
        declare timestamp_inizio_missione_associata datetime;
        declare stato_missione_associata enum("in_attesa", "convalidata", "in_corso", "terminata");

        SELECT r.stato INTO stato_missione_associata
        FROM richiesta r
        JOIN missione m ON m.ID_richiesta = r.ID
        WHERE m.ID = NEW.ID_missione;

        SELECT m.timestamp_inizio INTO timestamp_inizio_missione_associata
        FROM missione m
        WHERE m.ID = NEW.ID_missione;

        IF stato_missione_associata = "terminata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = "Impossibile aggiungere un aggiornamento a questa missione dato che è terminata.";
        END IF;

        IF NEW.timestamp_immissione < timestamp_inizio_missione_associata THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Non puoi immettere un aggiornamneto con questa data: la data selezionata viene prima della data di inizio della missione assocista';
        END IF;

        IF NEW.timestamp_immissione > NOW() THEN 
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La data di immissione di un aggiornamento deve essere nel passato.';
        END IF;
    end $

-- I seguenti trigger hanno il compito di verificre che la data di inizio missione sia più nel futuro rispetto alla data di arrivo della richiesta associata, oppure se la data di inizio missione non sia nel futuro
create trigger vincolo_data_missione_on_insert
before insert on missione
for each row
    begin
        DECLARE timestamp_arrivo_r timestamp;

        SELECT r.timestamp_arrivo INTO timestamp_arrivo_r
        from richiesta r
        WHERE r.ID = NEW.ID_richiesta;

        IF NEW.timestamp_inizio <= timestamp_arrivo_r THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La data di inizio missione non può essere minore della data di arrivo della richiesta associata';
        END IF;

        IF NEW.timestamp_inizio > NOW() THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'La data di inizio missione non è valida: data futura immessa.';
        END IF;
    end $

create trigger vincolo_data_missione_on_update
before update on missione
for each row
    begin
        DECLARE timestamp_arrivo_r timestamp;

        SELECT r.timestamp_arrivo INTO timestamp_arrivo_r
        from richiesta r
        WHERE r.ID = NEW.ID_richiesta;

        IF NEW.timestamp_inizio <= timestamp_arrivo_r OR NEW.timestamp_inizio > NOW() THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La data di inizio missione non può essere minore della data di arrivo della richiesta associata oppure nel passato.';
        END IF;
    end $

-- Il seguente trigger previene la creazione di missioni associate a richieste non ancora convalidate
create trigger vincolo_stato_richiesta
before insert on missione 
for each row
    begin
        declare stato_richiesta enum ('in_attesa', 'convalidata', 'in_corso', 'terminata', 'annullata', 'ignorata');
        
        select r.stato into stato_richiesta from richiesta r where ID = new.ID_richiesta;
        
        if stato_richiesta = 'in_attesa' then 
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = "Non puoi creare una missione associata a questa richiesta, dato che non è ancora stata convalidata.";
        end if;

        IF stato_richiesta = 'ignorata' THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Non puoi creare una missione associata a questa richiesta dato che è stata ignorata.';
        END IF;

        IF stato_richiesta = 'annullata' THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Non puoi creare una missione associata a questa richiesta dato che è stata annullata.';
        END IF;

        if stato_richiesta = 'in_corso' or stato_richiesta = 'terminata' then
        SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = "Non puoi creare una missione associata a questa richiesta, dato che la missione è già stata creata.";
        end if;
    end$

create trigger avanza_stato_richiesta
after insert on missione
for each row
    begin
        update richiesta set stato = "in_corso" where ID = NEW.ID_richiesta;
    end $

-- I seguenti trigger si occupano di prevenire che un operatore caposquadra venga inserito di nuovo nella suadra che comanda (insert e update)
create trigger operatore_caposquadra_duplicato_on_insert
before insert on squadraOperatore
for each row
    begin
        declare var_id_caposquadra INT;

        SELECT s.ID_operatore_caposquadra INTO var_id_caposquadra
        FROM squadra s 
        WHERE ID = NEW.ID_squadra;

        IF var_id_caposquadra = NEW.ID_operatore THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = "Non puoi inserire questo operatore all'interno della squadra in quanto è il caposquadra.";
        END IF;
    end $

create trigger operatore_caposquadra_duplicato_on_update
before update on squadraOperatore
for each row
    begin
        declare var_id_caposquadra INT;

        SELECT s.ID_operatore_caposquadra INTO var_id_caposquadra
        FROM squadra s 
        WHERE ID = NEW.ID_squadra;

        IF var_id_caposquadra = NEW.ID_operatore THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = "Non puoi inserire questo operatore all'interno della squadra in quanto è il caposquadra.";
        END IF;
    end $

create trigger settaggio_stato_operatori_on_insert_missione
after insert on missione
for each row
    begin
        declare var_id_op_caposquadra INT;

        UPDATE operatore o
        JOIN squadraOperatore sqo ON o.ID = sqo.ID_operatore
        SET o.occupato = True
        WHERE sqo.ID_squadra = NEW.ID_squadra;

        SELECT sq.ID_operatore_caposquadra into var_id_op_caposquadra
        FROM squadra sq
        WHERE sq.ID = NEW.ID_squadra;

        UPDATE operatore o
        SET o.occupato = TRUE
        WHERE o.ID = var_id_op_caposquadra;
    end$

create trigger settaggio_stato_operatori_on_insert_conclusione
after insert on conclusioni
for each row
    begin
        declare id_squadra_missione INT;
        declare id_operatore_caposquadra INT;

        SELECT m.ID_squadra INTO id_squadra_missione
        FROM missione m
        WHERE m.ID = NEW.ID_missione;

        UPDATE operatore o
        JOIN squadraOperatore sqo ON o.ID = sqo.ID_operatore
        SET o.occupato = FALSE
        WHERE sqo.ID_squadra = id_squadra_missione; 

        SELECT s.ID_operatore_caposquadra INTO id_operatore_caposquadra
        FROM squadra s
        WHERE s.ID = id_squadra_missione;

        UPDATE operatore o
        SET o.occupato = FALSE
        WHERE o.ID = id_operatore_caposquadra;
    end$

create trigger vincolo_data_conseguimento_patante_on_insert
before insert on patenteOperatore
for each row
    begin
        declare data_conseguimento_patente date;
        declare data_nascita_operatore date;

        SET data_conseguimento_patente = NEW.data_conseguimento;

        SELECT o.data_nascita INTO data_nascita_operatore
        FROM operatore o
        WHERE o.ID = NEW.ID_operatore;

        IF data_conseguimento_patente > NOW() THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'La data di conseguimento della patente non è valida: riportare una data nel passato.';
        END IF;

        IF data_conseguimento_patente < data_nascita_operatore THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'La data di conseguimento della patente non è valida: impostare una data successiva alla data di nascita ';
        END IF;
    end$

create trigger vincolo_data_conseguimento_patante_on_update
before update on patenteOperatore
for each row
    begin
        declare data_conseguimento_patente date;
        declare data_nascita_operatore date;

        SET data_conseguimento_patente = NEW.data_conseguimento;

        SELECT o.data_nascita INTO data_nascita_operatore
        FROM operatore o
        WHERE o.ID = NEW.ID_operatore;

        IF data_conseguimento_patente > NOW() THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'La data di conseguimento della patente non è valida: riportare una data nel passato.';
        END IF;

        IF data_conseguimento_patente <= data_nascita_operatore THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'La data di conseguimento della patente non è valida: impostare una data successiva alla data di nascita ';
        END IF;
    end$

create trigger vincolo_aggiornamento_quantita_totale_materiale
before insert on missioneMateriale
for each row
    begin
        declare quantita_totale_materiale INT;

        SELECT m.quantita_totale INTO quantita_totale_materiale
        FROM materiale m
        WHERE m.ID = NEW.ID_materiale;
        IF quantita_totale_materiale = 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'La quantità del materiale selezionata non è valida: quantità totale pari a 0.';
        END IF;

        IF NEW.quantita > quantita_totale_materiale THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'La quantità del materiale selezionata non è valida: eccede la massima disponibilità.';
        ELSE
            UPDATE materiale
            SET quantita_totale = quantita_totale - NEW.quantita
            WHERE ID = NEW.ID_materiale;
        END IF;
    end$

create trigger restituzione_materiali_e_mezzi_missione
after insert on conclusioni
for each row
    begin
        UPDATE materiale m
        JOIN missioneMateriale mm ON mm.ID_materiale = m.ID
        SET m.quantita_totale = m.quantita_totale + mm.quantita
        WHERE mm.ID_missione = NEW.ID_missione;

        UPDATE mezzo m
        JOIN missioneMezzo mm ON mm.ID_mezzo = m.ID
        SET m.occupato = FALSE
        WHERE mm.ID_missione = NEW.ID_missione;
    end$

create trigger vincolo_conclusione_missione_terminata
before insert on conclusioni
for each row
    begin
        declare stato_richiesta enum("in_attesa", "convalidata", "in_corso", "terminata", "annullata", "ignorata");

        SELECT r.stato INTO stato_richiesta
        FROM missione m
        JOIN richiesta r ON m.ID_richiesta = r.ID
        Where m.id = NEW.ID_missione;

        IF stato_richiesta = "terminata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile concludere questa richiesta: la missione è già conclusa.';
        END IF;
    end$

create trigger eliminazione_missione_in_corso
before delete on missione
for each row
    begin
        declare stato_richiesta enum("in_attesa", "convalidata", "in_corso", "terminata", "annullata", "ignorata");

        SELECT r.stato INTO stato_richiesta
        FROM richiesta r 
        WHERE r.ID = OLD.ID_richiesta;
        
        IF stato_richiesta = "in_corso" THEN
            UPDATE richiesta SET stato = 'annullata' WHERE ID = OLD.ID_richiesta;

            UPDATE materiale m
            JOIN missioneMateriale mm ON m.ID = mm.ID_materiale
            SET m.quantita_totale = m.quantita_totale + mm.quantita
            WHERE mm.ID_missione = OLD.ID;

            UPDATE mezzo m
            JOIN missioneMezzo mm ON m.ID = mm.ID_mezzo
            SET m.occupato = FALSE
            WHERE mm.ID_missione = OLD.ID;

            UPDATE operatore o
            JOIN squadraOperatore sqo ON o.ID = sqo.ID_operatore
            SET o.occupato = FALSE
            WHERE sqo.ID_squadra = OLD.ID_squadra;

            UPDATE operatore SET occupato = FALSE WHERE ID = 
                (SELECT sq.ID_operatore_caposquadra FROM squadra sq WHERE sq.ID = OLD.ID_squadra);
                -- utilizzo sottoquery
        END IF;
    end$

create trigger aggiunta_operatore_squadra_impegnata
before insert on squadraOperatore
for each row
    begin
        IF EXISTS (
            SELECT 1
            FROM missione m
            JOIN richiesta r on m.ID_richiesta = r.ID
            WHERE m.ID_squadra = NEW.ID_squadra AND r.stato = 'in_corso'
        ) THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile aggiungere un operatore a questa squadra in quanto questa è impegnata in una missione in corso.';
        END IF;
    end$

create trigger modifica_operatore_squadra_impegnata
before update on squadraOperatore
for each row


create trigger aggiunta_operatore_caposquadra_squadra_occupata
before update on squadra
for each row
    begin
        IF OLD.ID_operatore_caposquadra <> NEW.ID_operatore_caposquadra THEN
            IF EXISTS (
                SELECT 1
                FROM missione m
                JOIN richiesta r ON m.ID_richiesta = r.ID
                WHERE m.ID_squadra = OLD.ID AND r.stato = 'in_corso'
            ) THEN 
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Impossibile cambiare operatore caposquadra dato che la squadra è impegnata in una missione in corso.';
            END IF;
        END IF;
    end $

create trigger settaggio_mezzo_occupato
before insert on missioneMezzo
for each row
    begin
        declare stato_mezzo boolean;

        SELECT m.occupato INTO stato_mezzo
        FROM mezzo m
        WHERE m.ID = NEW.iD_mezzo;

        IF stato_mezzo = TRUE THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Il mezzo che si vuo,le utilizzare risulta occupato in una missione in corso.';
        END IF;

        UPDATE mezzo SET occupato = TRUE WHERE ID = NEW.ID_mezzo;
    end$

create trigger modifica_materiali_assegnati_missione_in_corso
before update on missioneMateriale
for each row
    begin
        declare stato_richiesta enum("in_attesa", "convalidata", "in_corso", "terminata", "annullata", "ignorata");

        SELECT r.stato INTO stato_richiesta
        FROM richiesta r
        JOIN missione m ON m.ID_richiesta = r.ID
        WHERE m.ID = NEW.ID_missione;

        IF stato_richiesta = "in_corso" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile modificare questo campo: la missione associata è attualmente in corso.';
        END IF;

        IF stato_richiesta = "terminata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile modificare questo campo: la missione associata è terminata.';
        END IF;

        IF stato_richiesta = "annullata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile modificare questo campo: la missione associata è annullata.';
        END IF;
    end$

create trigger eliminazione_materiali_assegnati_missione_in_corso
before delete on missioneMateriale
for each row
    begin
        declare stato_richiesta enum("in_attesa", "convalidata", "in_corso", "terminata", "annullata", "ignorata");

        SELECT r.stato INTO stato_richiesta
        FROM richiesta r
        JOIN missione m ON m.ID_richiesta = r.ID
        WHERE m.ID = OLD.ID_missione;

        IF stato_richiesta = "in_corso" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile modificare questo campo: la missione associata è attualmente in corso.';
        END IF;

        IF stato_richiesta = "terminata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile modificare questo campo: la missione associata è terminata.';
        END IF;

        IF stato_richiesta = "annullata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile modificare questo campo: la missione associata è annullata.';
        END IF;
    end$

create trigger modifica_mezzi_assegnati_missione_in_corso
before update on missioneMezzo
for each row
    begin
        declare stato_richiesta enum("in_attesa", "convalidata", "in_corso", "terminata", "annullata", "ignorata");

        SELECT r.stato INTO stato_richiesta
        FROM richiesta r
        JOIN missione m ON m.ID_richiesta = r.ID
        WHERE m.ID = NEW.ID_missione;

        IF stato_richiesta = "in_corso" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile modificare questo campo: la missione associata è attualmente in corso.';
        END IF;

        IF stato_richiesta = "terminata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile modificare questo campo: la missione associata è terminata.';
        END IF;

        IF stato_richiesta = "annullata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile modificare questo campo: la missione associata è annullata.';
        END IF;
    end$

create trigger eliminazione_mezzi_assegnati_missione_in_corso
before delete on missioneMezzo
for each row
    begin
        declare stato_richiesta enum("in_attesa", "convalidata", "in_corso", "terminata", "annullata", "ignorata");

        SELECT r.stato INTO stato_richiesta
        FROM richiesta r
        JOIN missione m ON m.ID_richiesta = r.ID
        WHERE m.ID = OLD.ID_missione;

        IF stato_richiesta = "in_corso" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile modificare questo campo: la missione associata è attualmente in corso.';
        END IF;

        IF stato_richiesta = "terminata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile modificare questo campo: la missione associata è terminata.';
        END IF;

        IF stato_richiesta = "annullata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile modificare questo campo: la missione associata è annullata.';
        END IF;
    end$

create trigger vincolo_assegnazione_materiali_missione_conclusa
before insert on missioneMateriale
for each row
    begin
        declare stato_richiesta enum("in_attesa", "convalidata", "in_corso", "terminata", "annullata", "ignorata");

        SELECT r.stato INTO stato_richiesta
        FROM richiesta r
        JOIN missione m ON m.ID_richiesta = r.ID
        WHERE m.ID = NEW.ID_missione;

        IF stato_richiesta = "terminata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile aggiungere materiali a una missione terminata.';
        END IF;

        IF stato_richiesta = "annullata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile aggiungere materiali a una missione annullata';
        END IF;
    end$

create trigger vincolo_assegnazione_mezzi_missione_conclusa
before insert on missioneMezzo
for each row
    begin
        declare stato_richiesta enum("in_attesa", "convalidata", "in_corso", "terminata", "annullata", "ignorata");

        SELECT r.stato INTO stato_richiesta
        FROM richiesta r
        JOIN missione m ON m.ID_richiesta = r.ID
        WHERE m.ID = NEW.ID_missione;

        IF stato_richiesta = "terminata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile aggiungere mezzi a una missione terminata.';
        END IF;

        IF stato_richiesta = "annullata" THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Impossibile aggiungere mezzi a una missione annullata';
        END IF;
    end$

delimiter ;