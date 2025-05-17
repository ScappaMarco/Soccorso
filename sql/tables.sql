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
CREATE TABLE `patenteoperatore` (
  `ID_operatore` int unsigned NOT NULL,
  `ID_patente` int unsigned NOT NULL,
  PRIMARY KEY (`ID_operatore`,`ID_patente`),
  KEY `patente_operatore` (`ID_patente`),
  CONSTRAINT `operatore_patente` FOREIGN KEY (`ID_operatore`) REFERENCES `operatore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `patente_operatore` FOREIGN KEY (`ID_patente`) REFERENCES `patente` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
