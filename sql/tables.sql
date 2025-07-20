use soccorso;

drop table if exists aggiornamenti;
drop table if exists conclusioni;
drop table if exists missioneMezzo;
drop table if exists missioneMateriale;
drop table if exists missione;
drop table if exists squadraOperatore;
drop table if exists squadra;
drop table if exists abilitaAmministratore;
drop table if exists abilitaOperatore;
drop table if exists patenteOperatore;
drop table if exists operatore;
drop table if exists amministratore;
drop table if exists patente;
drop table if exists richiesta;
drop table if exists abilita;
drop table if exists mezzo;
drop table if exists materiale;
drop table if exists operatore;

drop user if exists 'admin'@'localhost';

create user 'admin'@'localhost' identified by 'pippo';
grant all privileges on soccorso.* to 'admin'@'localhost';

CREATE TABLE `operatore` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) DEFAULT NULL,
  `cognome` varchar(30) DEFAULT NULL,
  `data_nascita` date NOT NULL,
  `occupato` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(40) DEFAULT NULL,
  `matricola` int unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `matricola` (`matricola`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `amministratore` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) DEFAULT NULL,
  `cognome` varchar(30) DEFAULT NULL,
  `data_nascita` date NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `matricola` int unsigned NOT NULL,
  `attivo` boolean NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `matricola` (`matricola`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `abilita` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `patente` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `sigla` varchar(5) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `sigla` (`sigla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `richiesta` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `stringa_convalida` varchar(20) NOT NULL,
  `indirizzo_ip_origine` varchar(12) NOT NULL,
  `stato` enum('in_attesa','convalidata','in_corso','terminata','annullata','ignorata') NOT NULL DEFAULT 'in_attesa',
  `nome_segnalante` varchar(20) NOT NULL,
  `email_segnalante` varchar(40) NOT NULL,
  `timestamp_arrivo` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `file_immagine` blob DEFAULT NULL,
  `didascalia_immagine` varchar(30) DEFAULT NULL,
  `descrizione` text DEFAULT NULL,
  `indirizzo` varchar(30) NOT NULL,
  `coordinate` varchar(30) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `stringa_convalida` (`stringa_convalida`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `squadra` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) DEFAULT NULL,
  `ID_operatore_caposquadra` int unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `operatore_caposquadra` (`ID_operatore_caposquadra`),
  CONSTRAINT `operatore_caposquadra` FOREIGN KEY (`ID_operatore_caposquadra`) REFERENCES `operatore` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `missione` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `timestamp_inizio` datetime NOT NULL,
  `obiettivo` text NOT NULL,
  `descrizione` text,
  `ID_squadra` int unsigned NOT NULL,
  `ID_richiesta` int unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `richiesta_associata` (`ID_richiesta`),
  KEY `squadra_associata` (`ID_squadra`),
  UNIQUE KEY (`timestamp_inizio`, `ID_squadra`),
  CONSTRAINT `richiesta_associata` FOREIGN KEY (`ID_richiesta`) REFERENCES `richiesta` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `squadra_associata` FOREIGN KEY (`ID_squadra`) REFERENCES `squadra` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `mezzo` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `targa` varchar(7) NOT NULL,
  `costruttore` varchar(30) NOT NULL,
  `modello` varchar(30) NOT NULL,
  `tipologia` varchar(30) NOT NULL,
  `descrizione` text DEFAULT NULL,
  `occupato` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `targa` (`targa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `materiale` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  `descrizione` text DEFAULT NULL,
  `quantita_totale` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `abilitaAmministratore` (
  `ID_amministratore` int unsigned NOT NULL,
  `ID_abilita` int unsigned NOT NULL,
  PRIMARY KEY (`ID_amministratore`,`ID_abilita`),
  CONSTRAINT `abilita_amministratore` FOREIGN KEY (`ID_abilita`) REFERENCES `abilita` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `amministratore_abilita` FOREIGN KEY (`ID_amministratore`) REFERENCES `amministratore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `abilitaOperatore` (
  `ID_abilita` int unsigned NOT NULL,
  `ID_operatore` int unsigned NOT NULL,
  PRIMARY KEY (`ID_abilita`,`ID_operatore`),
  CONSTRAINT `abilita_operatore` FOREIGN KEY (`ID_abilita`) REFERENCES `abilita` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operatore_abilita` FOREIGN KEY (`ID_operatore`) REFERENCES `operatore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `patenteOperatore` (
  `ID_operatore` int unsigned NOT NULL,
  `ID_patente` int unsigned NOT NULL,
  `data_conseguimento` date NOT NULL,
  PRIMARY KEY (`ID_operatore`,`ID_patente`),
  CONSTRAINT `operatore_patente` FOREIGN KEY (`ID_operatore`) REFERENCES `operatore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `patente_operatore` FOREIGN KEY (`ID_patente`) REFERENCES `patente` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `squadraOperatore` (
  `ID_operatore` int unsigned NOT NULL,
  `ID_squadra` int unsigned NOT NULL,
  `ruolo` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_operatore`, `ID_squadra`),
  CONSTRAINT `operatore_squadra` FOREIGN KEY (`ID_operatore`) REFERENCES `operatore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `squadra_operatore` FOREIGN KEY (`ID_squadra`) REFERENCES `squadra` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `aggiornamenti` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `ID_amministratore` int unsigned NOT NULL,
  `ID_missione` int unsigned NOT NULL,
  `messaggio_aggiornamento` text NOT NULL,
  `timestamp_immissione` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `amministratore_missione_agg` (`ID_amministratore`),
  KEY `missione_amministratore_agg` (`ID_missione`),
  CONSTRAINT `amministratore_missione_agg` FOREIGN KEY (`ID_amministratore`) REFERENCES `amministratore` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `missione_amministratore_agg` FOREIGN KEY (`ID_missione`) REFERENCES `missione` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `conclusioni` (
  `ID_missione` int unsigned NOT NULL,
  `ID_amministratore` int unsigned NOT NULL,
  `livello_successo` smallint NOT NULL,
  `timestamp_fine` datetime NOT NULL,
  PRIMARY KEY (`ID_missione`,`ID_amministratore`),
  CONSTRAINT `amministratore_missione_conc` FOREIGN KEY (`ID_amministratore`) REFERENCES `amministratore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `missione_amministratore_conc` FOREIGN KEY (`ID_missione`) REFERENCES `missione` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `check_livello_successo` CHECK ((`livello_successo` between 0 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `missioneMezzo` (
  `ID_missione` int unsigned NOT NULL,
  `ID_mezzo` int unsigned NOT NULL,
  PRIMARY KEY (`ID_missione`,`ID_mezzo`),
  CONSTRAINT `mezzo_missione` FOREIGN KEY (`ID_mezzo`) REFERENCES `mezzo` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `missione_mezzo` FOREIGN KEY (`ID_missione`) REFERENCES `missione` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `missioneMateriale` (
  `ID_missione` int unsigned NOT NULL,
  `ID_materiale` int unsigned NOT NULL,
  `quantita` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID_missione`,`ID_materiale`),
  CONSTRAINT `materiale_missione` FOREIGN KEY (`ID_materiale`) REFERENCES `materiale` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `missione_materiale` FOREIGN KEY (`ID_missione`) REFERENCES `missione` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;