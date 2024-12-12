-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: GlasbenaZbirka_innoDB
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `avtor`
--

DROP TABLE IF EXISTS `avtor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `avtor` (
  `AvtorID` int(11) NOT NULL,
  `Priimek` varchar(20) NOT NULL,
  `Ime` varchar(20) NOT NULL,
  `Opus` set('opera','kantata','simfonija','koncert','balada','drugo') NOT NULL,
  `letoRojstva` int(11) NOT NULL,
  `DID` int(11) DEFAULT 500,
  PRIMARY KEY (`AvtorID`),
  KEY `avtor_drzava_fk` (`DID`),
  CONSTRAINT `avtor_drzava_fk` FOREIGN KEY (`DID`) REFERENCES `drzava` (`DID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avtor`
--

LOCK TABLES `avtor` WRITE;
/*!40000 ALTER TABLE `avtor` DISABLE KEYS */;
INSERT INTO `avtor` VALUES (10,'Orff','Carl','opera,kantata,drugo',1895,300),(20,'Gounod','Charles','opera,simfonija,drugo',1818,400),(30,'Adams','Brian','balada,drugo',1959,100),(40,'Cohen','Leonard','balada,drugo',1934,100),(50,'Donizetti','Gaetano','opera',1797,200);
/*!40000 ALTER TABLE `avtor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cd`
--

DROP TABLE IF EXISTS `cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cd` (
  `CDID` int(11) NOT NULL,
  `Naslov` varchar(30) NOT NULL,
  `Cena` decimal(3,2) NOT NULL,
  `Opombe` varchar(150) DEFAULT NULL,
  `Lastnik` int(11) NOT NULL,
  `Leto` year(4) NOT NULL,
  PRIMARY KEY (`CDID`),
  KEY `cd_lastnik_fk` (`Lastnik`),
  CONSTRAINT `cd_lastnik_fk` FOREIGN KEY (`lastnik`) REFERENCES `lastnik` (`LID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cd`
--

LOCK TABLES `cd` WRITE;
/*!40000 ALTER TABLE `cd` DISABLE KEYS */;
/*!40000 ALTER TABLE `cd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drzava`
--

DROP TABLE IF EXISTS `drzava`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drzava` (
  `DID` int(11) NOT NULL AUTO_INCREMENT,
  `ImeDrzave` varchar(20) NOT NULL,
  PRIMARY KEY (`DID`)
) ENGINE=InnoDB AUTO_INCREMENT=502 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drzava`
--

LOCK TABLES `drzava` WRITE;
/*!40000 ALTER TABLE `drzava` DISABLE KEYS */;
INSERT INTO `drzava` VALUES (100,'Canada'),(200,'Italia'),(300,'Deutschland'),(400,'France'),(500,'Slovenija'),(501,'Austria');
/*!40000 ALTER TABLE `drzava` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lastnik`
--

DROP TABLE IF EXISTS `lastnik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lastnik` (
  `LID` int(11) NOT NULL,
  `Priimek` varchar(20) NOT NULL,
  `Ime` varchar(20) NOT NULL,
  `Tel` varchar(20) NOT NULL,
  `eMail` varchar(30) NOT NULL,
  PRIMARY KEY (`LID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lastnik`
--

LOCK TABLES `lastnik` WRITE;
/*!40000 ALTER TABLE `lastnik` DISABLE KEYS */;
/*!40000 ALTER TABLE `lastnik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owner`
--

DROP TABLE IF EXISTS `owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `owner` (
  `LID` int(11) NOT NULL,
  `Ime` varchar(20) NOT NULL,
  `Priimek` varchar(20) NOT NULL,
  `Tel` varchar(20) NOT NULL,
  `eMail` varchar(30) NOT NULL,
  PRIMARY KEY (`LID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owner`
--

LOCK TABLES `owner` WRITE;
/*!40000 ALTER TABLE `owner` DISABLE KEYS */;
/*!40000 ALTER TABLE `owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posnetek`
--

DROP TABLE IF EXISTS `posnetek`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posnetek` (
  `PID` int(11) NOT NULL,
  `Naslov` varchar(30) NOT NULL,
  `Genre` enum('klasika','pop','jazz') NOT NULL,
  `Trajanje` time NOT NULL,
  `AvtorID` int(11) DEFAULT NULL,
  PRIMARY KEY (`PID`),
  KEY `posnetek_avtor_fk` (`AvtorID`),
  CONSTRAINT `posnetek_avtor_fk` FOREIGN KEY (`AvtorID`) REFERENCES `avtor` (`AvtorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posnetek`
--

LOCK TABLES `posnetek` WRITE;
/*!40000 ALTER TABLE `posnetek` DISABLE KEYS */;
/*!40000 ALTER TABLE `posnetek` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vsebina`
--

DROP TABLE IF EXISTS `vsebina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vsebina` (
  `CDID` int(11) NOT NULL,
  `PID` int(11) NOT NULL,
  PRIMARY KEY (`CDID`,`PID`),
  KEY `vsebina_posnetek_fk` (`PID`),
  CONSTRAINT `vsebina_cd_fk` FOREIGN KEY (`CDID`) REFERENCES `cd` (`CDID`),
  CONSTRAINT `vsebina_posnetek_fk` FOREIGN KEY (`PID`) REFERENCES `posnetek` (`PID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vsebina`
--

LOCK TABLES `vsebina` WRITE;
/*!40000 ALTER TABLE `vsebina` DISABLE KEYS */;
/*!40000 ALTER TABLE `vsebina` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-06 22:21:25
