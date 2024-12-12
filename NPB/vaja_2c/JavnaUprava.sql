-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: JavnaUprava
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
-- Table structure for table `kraj`
--

DROP TABLE IF EXISTS `kraj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kraj` (
  `KrajID` int(11) NOT NULL,
  `PokrajinaID` int(11) NOT NULL,
  `ImeKraja` varchar(30) NOT NULL,
  `SteviloPrebivalcev` int(11) DEFAULT NULL,
  PRIMARY KEY (`KrajID`),
  KEY `kraj_pokrajina_fk` (`PokrajinaID`),
  CONSTRAINT `kraj_pokrajina_fk` FOREIGN KEY (`PokrajinaID`) REFERENCES `pokrajina` (`PokrajinaID`),
  CONSTRAINT `kraj_st_prebivalcev_ck` CHECK (`SteviloPrebivalcev` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kraj`
--

LOCK TABLES `kraj` WRITE;
/*!40000 ALTER TABLE `kraj` DISABLE KEYS */;
/*!40000 ALTER TABLE `kraj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obcan`
--

DROP TABLE IF EXISTS `obcan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obcan` (
  `EMSO` char(13) NOT NULL,
  `Priimek` varchar(20) NOT NULL,
  `Ime` varchar(20) NOT NULL,
  `DatumRojstva` date NOT NULL,
  `KrajID` int(11) DEFAULT NULL,
  `Spol` enum('M','Z') NOT NULL,
  PRIMARY KEY (`EMSO`),
  KEY `obcan_kraj_fk` (`KrajID`),
  CONSTRAINT `obcan_kraj_fk` FOREIGN KEY (`KrajID`) REFERENCES `kraj` (`KrajID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obcan`
--

LOCK TABLES `obcan` WRITE;
/*!40000 ALTER TABLE `obcan` DISABLE KEYS */;
/*!40000 ALTER TABLE `obcan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obisk`
--

DROP TABLE IF EXISTS `obisk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obisk` (
  `EMSO` char(13) NOT NULL,
  `KrajID` int(11) NOT NULL,
  `DatumObiska` date NOT NULL,
  `Vtisi` varchar(200) NOT NULL DEFAULT 'vse naj',
  PRIMARY KEY (`EMSO`,`KrajID`,`DatumObiska`),
  KEY `obisk_kraj_fk` (`KrajID`),
  CONSTRAINT `obisk_kraj_fk` FOREIGN KEY (`KrajID`) REFERENCES `kraj` (`KrajID`),
  CONSTRAINT `obisk_obcan_fk` FOREIGN KEY (`EMSO`) REFERENCES `obcan` (`EMSO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obisk`
--

LOCK TABLES `obisk` WRITE;
/*!40000 ALTER TABLE `obisk` DISABLE KEYS */;
/*!40000 ALTER TABLE `obisk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pokrajina`
--

DROP TABLE IF EXISTS `pokrajina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pokrajina` (
  `PokrajinaID` int(11) NOT NULL,
  `ImePokrajine` varchar(20) NOT NULL,
  `Opis` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`PokrajinaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokrajina`
--

LOCK TABLES `pokrajina` WRITE;
/*!40000 ALTER TABLE `pokrajina` DISABLE KEYS */;
/*!40000 ALTER TABLE `pokrajina` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-07  0:22:25
