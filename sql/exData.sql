USE soccorso;

-- add amministratore
INSERT INTO `soccorso`.`amministratore`
(`ID`, `nome`, `cognome`, `data_nascita`, `email`, `matricola`, `attivo`)
VALUES
(1, "admin", "admin", "1998-11-11", "admin@admin.com", 000001, TRUE),
(2, "admin2", "admin2", "1998-11-11", "admin2@admin.com", 000002, TRUE);

-- add operatori
INSERT INTO `soccorso`.`operatore`
(`ID`, `nome`, `cognome`, `data_nascita`, `occupato`, `email`, `matricola`)
VALUES
(1, "marco", "scappa", "2002-10-01", FALSE, "marco.scappa@student.univaq.it", 279487),
(2, "leonardo", "candeloro", "2000-10-21", FALSE, "laonardo.candeloro@student.univaq.it", 281112),
(3, "pippo", "rossi", "1998-11-11", FALSE, "pippo.rossi@ex.com", 111222),
(4, "maria", "bianchi", "1997-06-30", FALSE, "maria.bianchi@ex.com", 998997),
(5, "valentina", "mazzilli", "1974-11-11", FALSE, "valentina.mazzilli@ex.com", 553776),
(6, "luigi", "rinaldi", "1988-11-6", FALSE, "luigi.rinaldi@ex.com", 116117);

-- add abilità
INSERT INTO `soccorso`.`abilita`
(`ID`, `nome`)
VALUES
(1, "abilità_1"),
(2, "abilità_2"),
(3, "abilità_3"),
(4, "abilità_4");

-- add patenti
INSERT INTO `soccorso`.`patente`
(`ID`, `sigla`)
VALUES
(1, "A"),
(2, "B"),
(3, "C"),
(4, "An"),
(5, "V");

-- add mezzi
INSERT INTO `soccorso`.`mezzo`
(`ID`, `targa`, `costruttore`, `modello`, `tipologia`, `descrizione`, `occupato`)
VALUES
(1, "EW335WT", "Mercedes-Benz", "c220", "sorveglianza", "Veicolo di sorveglianza", FALSE),
(2, "GT682DZ", "FIAT", "Panda", "Soccorso", "Veicolo di soccorso generico", FALSE),
(3, "EB553NV", "FIAT", "Ducato", "Ambulanza", "Veicolo ambulanza", FALSE);

-- add materiali
INSERT INTO `soccorso`.`materiale`
(`ID`, `nome`, `descrizione`, `quantita_totale`)
VALUES
(1, "Scala", "Slaca antincendio", 16),
(2, "Estintore", "Estintore", 29),
(3, "Bombola ossigeno", "Bombola ossigneo da 15L", 8),
(4, "GLOCK 17", "GLOCK 17 calibro 9mm", 3),
(5, "Maschera antigas", "Maschera antigas", 7);

-- add squadre
INSERT INTO `soccorso`.`squadra`
(`ID`, `nome`, `ID_operatore_caposquadra`)
VALUES
(1, "squadra1", 1),
(2, "squadra2", 2);

-- popolamento squadre
INSERT INTO `soccorso`.`squadraOperatore`
(`ID_operatore`, `ID_squadra`, `ruolo`)
VALUES
(3, 1, "ruolo_1"),
(4, 1, "ruolo_2"),
(5, 2, "ruolo_3"),
(6, 2, "ruolo_4");

-- assegnamento abilità amministratore
INSERT INTO `soccorso`.`abilitaAmministratore`
(`ID_amministratore`, `ID_abilita`)
VALUES
(1, 1),
(1, 2),
(1, 4);

-- assegnamento abilità operatore
INSERT INTO `soccorso`.`abilitaOperatore`
(`ID_abilita`, `ID_operatore`)
VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(2, 4);

-- assegnamento patenti operatori
INSERT INTO `soccorso`.`patenteOperatore`
(`ID_operatore`, `ID_patente`, `data_conseguimento`)
VALUES
(1, 2, "2021-04-07"),
(2, 1, "2020-11-09"),
(2, 2, "2018-07-15"),
(2, 3, "2021-08-09");
/*
Si noti che non appena si inserisce una squadra, un trigger aggiunge l'operatore contrassegnato coime caposquadra in squadraOperatore con ruolo "caposquadra"
*/

-- add richieste
INSERT INTO `soccorso`.`richiesta`
(`ID`, `stringa_convalida`, `indirizzo_ip_origine`, `stato`, `nome_segnalante`, `email_segnalante`, `descrizione`, `indirizzo`, `coordinate`)
VALUES
(1, "aZ7mQp2#LfXv9sBt1WdE", "242.189.7.65", "convalidata", "pippo", "pippo@ex.com", "Incendio in casa", "Via XX Settembre, 43", "23.6544 65.9989"),
(2, "kT8#vM1zPq!RbX6dJw2C", "199.112.225.2", "convalidata", "peppo", "peppo@ex.com", "Gattino su un albero", "Via Vetoio, 1", "87.44467 98.5546"),
(3, "Gx!7pV#r2LkMd89TqW@z", "176.177.221.6", "convalidata", "peppa", "peppa@ex.com", "Ladro in casa", "Via Croce Rossa, 122", "89.665 98.6654"),
(4, "Z3r@vLm#8PqTc!nW5XyB", "89.222.166.6", "convalidata", "pino", "pino@ex.com", "Furto", "Via Comunità Europea, 76", "-76.99877 65.2298");

-- add missioni
INSERT INTO `soccorso`.`missione`
(`ID`, `timestamp_inizio`, `obiettivo`, `descrizione`, `ID_squadra`, `ID_richiesta`)
VALUES
(1, "2025-06-11 18:16:20", "Spegnere l'incendio", "Missione di salvataggio", 1, 1),
(2, "2025-06-11 18:10:15", "Salvare il gattino dall'albero", "Salvataggio micetto", 2, 2),
(3, "2025-06-11 18:19:00", "Scovare il ladro", "Missione di salvataggio", 1, 3),
(4, "2025-06-11 18:18:18", "Ritrovare la refurtiva", "Missione di salvataggio", 2, 4);

-- add materiali missioni
INSERT INTO `soccorso`.`missioneMateriale`
(`ID_missione`, `ID_materiale`, `quantita`)
VALUES
(1, 2, 10),
(1, 3, 2),
(2, 1, 1),
(3, 4, 1),
(4, 5, 2);

-- add mezzi missioni
INSERT INTO `soccorso`.`missioneMezzo`
(`ID_missione`, `ID_mezzo`)
VALUES
(1, 2),
(2, 3),
(3, 1);

-- add aggiornamenti
INSERT INTO `soccorso`.`aggiornamenti`
(`ID`, `ID_amministratore`, `ID_missione`, `messaggio_aggiornamento`)
VALUES
(1, 1, 1, "Incendio peggiorato"),
(2, 1, 2, "Il gattino ha cambiato posto"),
(3, 1, 3, "Il ladro ha lasciato delle tracce"),
(4, 1, 4, "Parte della refurtiva è stata trovata");

-- add conclusioni
INSERT INTO `soccorso`.`conclusioni`
(`ID_missione`, `ID_amministratore`, `livello_successo`, `timestamp_fine`)
VALUES
(1, 1, 5, "2025-06-11 18:35:00"),
(2, 1, 4, "2025-06-11 18:30:44");
