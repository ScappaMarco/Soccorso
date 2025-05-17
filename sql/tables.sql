use soccorso;

drop table if exists operatore;
CREATE TABLE `operatore` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) DEFAULT NULL,
  `cognome` varchar(30) DEFAULT NULL,
  `data_nascita` date NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `matricola` int unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `matricola` (`matricola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists amministratore;
CREATE TABLE `amministratore` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) DEFAULT NULL,
  `cognome` varchar(30) DEFAULT NULL,
  `data_nascita` date NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `matricola` int unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `matricola` (`matricola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists abilita;
CREATE TABLE `abilita` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists patente;
CREATE TABLE `patente` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `sigla` varchar(5) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `sigla` (`sigla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists richiesta;
CREATE TABLE `richiesta` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `stringa_convalida` varchar(20) NOT NULL,
  `indirizzo_ip_origine` varchar(12) NOT NULL,
  `stato` enum('non_attiva','attiva','in_corso','chiusa') DEFAULT 'non_attiva',
  `nome_segnalante` varchar(20) DEFAULT NULL,
  `email_segnalante` varchar(40) DEFAULT NULL,
  `timestamp_arrivo` datetime NOT NULL,
  `file_immagine` blob,
  `didascalia_immagine` varchar(30) DEFAULT NULL,
  `descrizione` text,
  `indirizzo` varchar(30) NOT NULL,
  `coordinate` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `stringa_convalida` (`stringa_convalida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists squadra;
CREATE TABLE `squadra` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) DEFAULT NULL,
  `ID_operatore_caposquadra` int unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `operatore_caposquadra` FOREIGN KEY (`ID_operatore_caposquadra`) REFERENCES `operatore` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists missione;
CREATE TABLE `missione` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `timestamp_inizio` datetime NOT NULL,
  `obiettivo` text NOT NULL,
  `descrizione` text,
  `ID_squadra` int unsigned NOT NULL,
  `ID_richiesta` int unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `richiesta_associata` FOREIGN KEY (`ID_richiesta`) REFERENCES `richiesta` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `squadra_associata` FOREIGN KEY (`ID_squadra`) REFERENCES `squadra` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists mezzo;
CREATE TABLE `mezzo` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `targa` varchar(7) NOT NULL,
  `costruttore` varchar(30) NOT NULL,
  `modello` varchar(30) NOT NULL,
  `tipologia` varchar(30) NOT NULL,
  `descrizione` text,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `targa` (`targa`),
  CONSTRAINT `mezzo_chk_1` CHECK (regexp_like(`targa`,_utf8mb4'^[A-Z]{2}[0-9]{3}[A-Z]{2}$'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists materiale;
CREATE TABLE `materiale` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  `descrizione` text,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists abilitaAmministratore;
CREATE TABLE `abilitaAmministratore` (
  `ID_amministratore` int unsigned NOT NULL,
  `ID_abilita` int unsigned NOT NULL,
  PRIMARY KEY (`ID_amministratore`,`ID_abilita`),
  CONSTRAINT `abilita_amministratore` FOREIGN KEY (`ID_abilita`) REFERENCES `abilita` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `amministratore_abilita` FOREIGN KEY (`ID_amministratore`) REFERENCES `amministratore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists abilitaOperatore;
CREATE TABLE `abilitaOperatore` (
  `ID_abilita` int unsigned NOT NULL,
  `ID_operatore` int unsigned NOT NULL,
  PRIMARY KEY (`ID_abilita`,`ID_operatore`),
  CONSTRAINT `abilita_operatore` FOREIGN KEY (`ID_abilita`) REFERENCES `abilita` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operatore_abilita` FOREIGN KEY (`ID_operatore`) REFERENCES `operatore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists patenteOperatore;
CREATE TABLE `patenteOperatore` (
  `ID_operatore` int unsigned NOT NULL,
  `ID_patente` int unsigned NOT NULL,
  PRIMARY KEY (`ID_operatore`,`ID_patente`),
  CONSTRAINT `operatore_patente` FOREIGN KEY (`ID_operatore`) REFERENCES `operatore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `patente_operatore` FOREIGN KEY (`ID_patente`) REFERENCES `patente` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists squadraOperatore;
CREATE TABLE `squadraOperatore` (
  `ID_operatore` int unsigned NOT NULL,
  `ID_squadra` int unsigned NOT NULL,
  `ruolo` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_operatore`,`ID_squadra`),
  CONSTRAINT `operatore_squadra` FOREIGN KEY (`ID_operatore`) REFERENCES `operatore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `squadra_operatore` FOREIGN KEY (`ID_squadra`) REFERENCES `squadra` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists aggiornamenti;
CREATE TABLE `aggiornamenti` (
  `ID_amministratore` int unsigned NOT NULL,
  `ID_missione` int unsigned NOT NULL,
  `messaggio_aggiornamento` text NOT NULL,
  `timestamp_immissione` datetime NOT NULL,
  PRIMARY KEY (`ID_amministratore`,`ID_missione`),
  CONSTRAINT `amministratore_missione_agg` FOREIGN KEY (`ID_amministratore`) REFERENCES `amministratore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE, -- da cambiare
  CONSTRAINT `missione_amministratore_agg` FOREIGN KEY (`ID_missione`) REFERENCES `missione` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists conclusioni;
CREATE TABLE `conclusioni` (
  `ID_missione` int unsigned NOT NULL,
  `ID_amministratore` int unsigned NOT NULL,
  `livello_successo` smallint NOT NULL,
  `timestamp_fine` datetime NOT NULL,
  PRIMARY KEY (`ID_missione`,`ID_amministratore`),
  CONSTRAINT `amministratore_missione_conc` FOREIGN KEY (`ID_amministratore`) REFERENCES `amministratore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `missione_amministratore_conc` FOREIGN KEY (`ID_missione`) REFERENCES `missione` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `check_livello_successo` CHECK ((`livello_successo` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists missioneMezzo;
CREATE TABLE `missioneMezzo` (
  `ID_missione` int unsigned NOT NULL,
  `ID_mezzo` int unsigned NOT NULL,
  PRIMARY KEY (`ID_missione`,`ID_mezzo`),
  CONSTRAINT `mezzo_missione` FOREIGN KEY (`ID_mezzo`) REFERENCES `mezzo` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `missione_mezzo` FOREIGN KEY (`ID_missione`) REFERENCES `missione` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop table if exists missioneMateriale;
CREATE TABLE `missioneMateriale` (
  `ID_missione` int unsigned NOT NULL,
  `ID_materiale` int unsigned NOT NULL,
  PRIMARY KEY (`ID_missione`,`ID_materiale`),
  CONSTRAINT `materiale_missione` FOREIGN KEY (`ID_missione`) REFERENCES `materiale` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `missione_materiale` FOREIGN KEY (`ID_missione`) REFERENCES `missione` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;