CREATE DATABASE  IF NOT EXISTS `soccorso` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `soccorso`;
-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: soccorso
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `abilita`
--

DROP TABLE IF EXISTS `abilita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abilita` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abilita`
--

LOCK TABLES `abilita` WRITE;
/*!40000 ALTER TABLE `abilita` DISABLE KEYS */;
/*!40000 ALTER TABLE `abilita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abilitaAmministratore`
--

DROP TABLE IF EXISTS `abilitaAmministratore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abilitaAmministratore` (
  `ID_amministratore` int unsigned NOT NULL,
  `ID_abilita` int unsigned NOT NULL,
  PRIMARY KEY (`ID_amministratore`,`ID_abilita`),
  CONSTRAINT `abilita_amministratore` FOREIGN KEY (`ID_abilita`) REFERENCES `abilita` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `amministratore_abilita` FOREIGN KEY (`ID_amministratore`) REFERENCES `amministratore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abilitaAmministratore`
--

LOCK TABLES `abilitaAmministratore` WRITE;
/*!40000 ALTER TABLE `abilitaAmministratore` DISABLE KEYS */;
/*!40000 ALTER TABLE `abilitaAmministratore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abilitaOperatore`
--

DROP TABLE IF EXISTS `abilitaOperatore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abilitaOperatore` (
  `ID_abilita` int unsigned NOT NULL,
  `ID_operatore` int unsigned NOT NULL,
  PRIMARY KEY (`ID_abilita`,`ID_operatore`),
  CONSTRAINT `abilita_operatore` FOREIGN KEY (`ID_abilita`) REFERENCES `abilita` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operatore_abilita` FOREIGN KEY (`ID_operatore`) REFERENCES `operatore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abilitaOperatore`
--

LOCK TABLES `abilitaOperatore` WRITE;
/*!40000 ALTER TABLE `abilitaOperatore` DISABLE KEYS */;
/*!40000 ALTER TABLE `abilitaOperatore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aggiornamenti`
--

DROP TABLE IF EXISTS `aggiornamenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aggiornamenti` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `ID_amministratore` int unsigned NOT NULL,
  `ID_missione` int unsigned NOT NULL,
  `messaggio_aggiornamento` text NOT NULL,
  `timestamp_immissione` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `amministratore_missione_agg` (`ID_amministratore`),
  KEY `missione_amministratore_agg` (`ID_missione`),
  CONSTRAINT `amministratore_missione_agg` FOREIGN KEY (`ID_amministratore`) REFERENCES `amministratore` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `missione_amministratore_agg` FOREIGN KEY (`ID_missione`) REFERENCES `missione` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aggiornamenti`
--

LOCK TABLES `aggiornamenti` WRITE;
/*!40000 ALTER TABLE `aggiornamenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `aggiornamenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amministratore`
--

DROP TABLE IF EXISTS `amministratore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amministratore` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) DEFAULT NULL,
  `cognome` varchar(30) DEFAULT NULL,
  `data_nascita` date NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `matricola` int unsigned DEFAULT NULL,
  `attivo` boolean DEFAULT TRUE,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `matricola` (`matricola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amministratore`
--

LOCK TABLES `amministratore` WRITE;
/*!40000 ALTER TABLE `amministratore` DISABLE KEYS */;
/*!40000 ALTER TABLE `amministratore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conclusioni`
--

DROP TABLE IF EXISTS `conclusioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conclusioni`
--

LOCK TABLES `conclusioni` WRITE;
/*!40000 ALTER TABLE `conclusioni` DISABLE KEYS */;
/*!40000 ALTER TABLE `conclusioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materiale`
--

DROP TABLE IF EXISTS `materiale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materiale` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  `descrizione` text DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materiale`
--

LOCK TABLES `materiale` WRITE;
/*!40000 ALTER TABLE `materiale` DISABLE KEYS */;
/*!40000 ALTER TABLE `materiale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mezzo`
--

DROP TABLE IF EXISTS `mezzo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mezzo` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `targa` varchar(7) NOT NULL,
  `costruttore` varchar(30) NOT NULL,
  `modello` varchar(30) NOT NULL,
  `tipologia` varchar(30) NOT NULL,
  `descrizione` text DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `targa` (`targa`),
  CONSTRAINT `mezzo_chk_1` CHECK (regexp_like(`targa`,_utf8mb4'^[A-Z]{2}[0-9]{3}[A-Z]{2}$'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mezzo`
--

LOCK TABLES `mezzo` WRITE;
/*!40000 ALTER TABLE `mezzo` DISABLE KEYS */;
/*!40000 ALTER TABLE `mezzo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `missione`
--

DROP TABLE IF EXISTS `missione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  CONSTRAINT `richiesta_associata` FOREIGN KEY (`ID_richiesta`) REFERENCES `richiesta` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `squadra_associata` FOREIGN KEY (`ID_squadra`) REFERENCES `squadra` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `missione`
--

LOCK TABLES `missione` WRITE;
/*!40000 ALTER TABLE `missione` DISABLE KEYS */;
/*!40000 ALTER TABLE `missione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `missioneMateriale`
--

DROP TABLE IF EXISTS `missioneMateriale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `missioneMateriale` (
  `ID_missione` int unsigned NOT NULL,
  `ID_materiale` int unsigned NOT NULL,
  PRIMARY KEY (`ID_missione`,`ID_materiale`),
  CONSTRAINT `materiale_missione` FOREIGN KEY (`ID_materiale`) REFERENCES `materiale` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `missione_materiale` FOREIGN KEY (`ID_missione`) REFERENCES `missione` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `missioneMateriale`
--

LOCK TABLES `missioneMateriale` WRITE;
/*!40000 ALTER TABLE `missioneMateriale` DISABLE KEYS */;
/*!40000 ALTER TABLE `missioneMateriale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `missioneMezzo`
--

DROP TABLE IF EXISTS `missioneMezzo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `missioneMezzo` (
  `ID_missione` int unsigned NOT NULL,
  `ID_mezzo` int unsigned NOT NULL,
  PRIMARY KEY (`ID_missione`,`ID_mezzo`),
  CONSTRAINT `mezzo_missione` FOREIGN KEY (`ID_mezzo`) REFERENCES `mezzo` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `missione_mezzo` FOREIGN KEY (`ID_missione`) REFERENCES `missione` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `missioneMezzo`
--

LOCK TABLES `missioneMezzo` WRITE;
/*!40000 ALTER TABLE `missioneMezzo` DISABLE KEYS */;
/*!40000 ALTER TABLE `missioneMezzo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operatore`
--

DROP TABLE IF EXISTS `operatore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operatore`
--

LOCK TABLES `operatore` WRITE;
/*!40000 ALTER TABLE `operatore` DISABLE KEYS */;
/*!40000 ALTER TABLE `operatore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patente`
--

DROP TABLE IF EXISTS `patente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patente` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `sigla` varchar(5) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `sigla` (`sigla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patente`
--

LOCK TABLES `patente` WRITE;
/*!40000 ALTER TABLE `patente` DISABLE KEYS */;
/*!40000 ALTER TABLE `patente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patenteOperatore`
--

DROP TABLE IF EXISTS `patenteOperatore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patenteOperatore` (
  `ID_operatore` int unsigned NOT NULL,
  `ID_patente` int unsigned NOT NULL,
  PRIMARY KEY (`ID_operatore`,`ID_patente`),
  CONSTRAINT `operatore_patente` FOREIGN KEY (`ID_operatore`) REFERENCES `operatore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `patente_operatore` FOREIGN KEY (`ID_patente`) REFERENCES `patente` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patenteOperatore`
--

LOCK TABLES `patenteOperatore` WRITE;
/*!40000 ALTER TABLE `patenteOperatore` DISABLE KEYS */;
/*!40000 ALTER TABLE `patenteOperatore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `richiesta`
--

DROP TABLE IF EXISTS `richiesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `richiesta` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `stringa_convalida` varchar(20) NOT NULL,
  `indirizzo_ip_origine` varchar(12) NOT NULL,
  `stato` enum('in_attesa','convalidata','in_corso','terminata') NOT NULL DEFAULT 'in_attesa',
  `nome_segnalante` varchar(30) DEFAULT NULL,
  `email_segnalante` varchar(40) DEFAULT NULL,
  `timestamp_arrivo` datetime NOT NULL,
  `file_immagine` blob DEFAULT NULL,
  `didascalia_immagine` varchar(30) DEFAULT NULL,
  `descrizione` text DEFAULT NULL,
  `indirizzo` varchar(30) NOT NULL,
  `coordinate` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `stringa_convalida` (`stringa_convalida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `richiesta`
--

LOCK TABLES `richiesta` WRITE;
/*!40000 ALTER TABLE `richiesta` DISABLE KEYS */;
/*!40000 ALTER TABLE `richiesta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `squadra`
--

DROP TABLE IF EXISTS `squadra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `squadra` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) DEFAULT NULL,
  `ID_operatore_caposquadra` int unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `operatore_caposquadra` (`ID_operatore_caposquadra`),
  CONSTRAINT `operatore_caposquadra` FOREIGN KEY (`ID_operatore_caposquadra`) REFERENCES `operatore` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `squadra`
--

LOCK TABLES `squadra` WRITE;
/*!40000 ALTER TABLE `squadra` DISABLE KEYS */;
/*!40000 ALTER TABLE `squadra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `squadraOperatore`
--

DROP TABLE IF EXISTS `squadraOperatore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `squadraOperatore` (
  `ID_operatore` int unsigned NOT NULL,
  `ID_squadra` int unsigned NOT NULL,
  `ruolo` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_operatore`,`ID_squadra`),
  CONSTRAINT `operatore_squadra` FOREIGN KEY (`ID_operatore`) REFERENCES `operatore` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `squadra_operatore` FOREIGN KEY (`ID_squadra`) REFERENCES `squadra` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `squadraOperatore`
--

LOCK TABLES `squadraOperatore` WRITE;
/*!40000 ALTER TABLE `squadraOperatore` DISABLE KEYS */;
/*!40000 ALTER TABLE `squadraOperatore` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-19 18:03:35