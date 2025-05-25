use soccorso;

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

delimiter $
-- trigger utilizzato per fare un aggiornamento a catena anche su richiesta ogni qualvolta venga inserito una conclusione ad una missione
-- testato: funzionante
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

-- I seguenti trigger si occupano di convertire la mail in minuscolo, per operatore, amministratore e email segnalante (in richiesta)
create trigger email_minuscula_operatore_on_insert
before insert on operatore
for each row
    begin
        SET NEW.email = LOWER(NEW.email);
    end $

create trigger email_minuscola_amministratore_on_insert
before insert on amministratore
for each row
    begin
        SET NEW.email = LOWER(NEW.email);
    end $

create trigger email_minuscula_operatore_on_update
before update on operatore
for each row
    begin
        SET NEW.email = LOWER(NEW.email);
    end $

create trigger email_minuscola_amministratore_on_update
before update on amministratore
for each row
    begin
        SET NEW.email = LOWER(NEW.email);
    end $

create trigger email_segnalante_minuscola_on_insert
before insert on richiesta
for each row
    begin
        SET NEW.email_segnalante = LOWER(NEW.email_segnalante);
    end $

create trigger email_segnalante_minuscola_on_update
before update on richiesta
for each row
    begin
        SET NEW.email_segnalante = LOWER(NEW.email_segnalante);
    end $

-- I seguenti trigger sono utilizzati per verificare che l'età degli amministratori ed operatori sia compresa tra 18 e 70
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

delimiter ;