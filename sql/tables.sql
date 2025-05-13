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
  `stato` enum('non attiva','attiva') DEFAULT 'non attiva',
  `nome_segnalante` varchar(20) DEFAULT NULL,
  `email_segnalante` varchar(40) DEFAULT NULL,
  `timestamp_arrivo` datetime NOT NULL,
  `descrizione` text,
  `indirizzo` varchar(30) NOT NULL,
  `coordinate` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `stringa_convalida` (`stringa_convalida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

