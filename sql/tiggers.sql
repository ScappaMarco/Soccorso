use soccorso;
delimiter $

-- trigger utilizzato per fare un aggiornamento a catena anche su richiesta ogni qualvolta venga inserito una conclusione ad una missione
-- testato: funzionante
create trigger termina_richiesta
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

delimiter ;