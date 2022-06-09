CREATE DATABASE  IF NOT EXISTS `morgana` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `morgana`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: morgana
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `department_id` int NOT NULL,
  `procedure_id` int NOT NULL,
  `current_date` date NOT NULL,
  `appointment_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_patientID_idx` (`patient_id`),
  KEY `FK3_departmentID_idx` (`department_id`),
  KEY `FK3_procedureID_idx` (`procedure_id`),
  CONSTRAINT `FK3_departmentID` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK3_procedureID` FOREIGN KEY (`procedure_id`) REFERENCES `procedures` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK_patientID` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (2,5,15,2,4,'2022-06-02','2022-06-16'),(3,6,16,2,5,'2022-06-02','2022-06-16'),(10,6,23,4,12,'2022-06-04','2022-06-18'),(12,13,26,5,15,'2022-06-04','2022-06-18');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `department` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Surgery'),(2,'Dentistry'),(3,'Gynacology'),(4,'Cancer Treatment'),(5,'Radiology'),(6,'Nursing');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `procedure_id` int NOT NULL,
  `department_id` int NOT NULL,
  `title` varchar(45) NOT NULL,
  `first_nm` varchar(45) NOT NULL,
  `last_nm` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_departmentID_idx` (`department_id`),
  KEY `FK_procedureID_idx` (`procedure_id`),
  CONSTRAINT `FK_departmentID` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  CONSTRAINT `FK_procedureID` FOREIGN KEY (`procedure_id`) REFERENCES `procedures` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,1,1,'Dr','Morris','Matthew'),(2,2,1,'Dr','Willis','Brown'),(14,3,1,'Dr','Shantell','Matthews'),(15,4,2,'Dr','Shannel','Grant'),(16,5,2,'Dr','Rayanna','Wellignton'),(17,6,2,'Dr','Tyrese','Morgan'),(18,7,3,'Dr ','Chris-Ann','Miller'),(19,8,3,'Dr','Yanique','Maclean'),(20,9,3,'Dr','Donte','Patterson'),(21,10,4,'Dr','Roshane','Johnson'),(22,11,4,'Dr','Aldaine','Clarke'),(23,12,4,'Dr','Kevin','Danvers'),(24,13,5,'Dr','Osheen','Stepheson'),(25,14,5,'Dr','Desricka','Stephenson'),(26,15,5,'Dr','Krissan','Gordon'),(27,16,6,'Nurse','Alyica','Rowe'),(28,17,6,'Nurse','Anita','Baker'),(29,18,6,'Nurse','Xante','Graham');
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_nm` varchar(95) NOT NULL,
  `last_nm` varchar(95) NOT NULL,
  `gender` varchar(45) NOT NULL,
  `address` varchar(145) NOT NULL,
  `phone_num` varchar(45) NOT NULL,
  `email` varchar(145) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (5,'serena','morgan','Female','            1/2 morrislane','876-455-3751','serenaMorgan@gmail.com'),(6,'Tyrone','Moris','Male','  1/2 rainford rd kgn 11','876-842-7815','tyronemoris@gmail.com'),(13,'Andrea','Willy','Female','   23 canary drive','876-456-7817','Andrea Willison'),(14,'Alison','Morgan','Female',' 123twety','876-865-7815','somethin@gmail.com');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedures`
--

DROP TABLE IF EXISTS `procedures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedures` (
  `id` int NOT NULL,
  `department_id` int NOT NULL,
  `procedure` varchar(225) NOT NULL,
  `estimated_cost` double(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2_departmentID_idx` (`department_id`),
  CONSTRAINT `FK2_departmentID` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedures`
--

LOCK TABLES `procedures` WRITE;
/*!40000 ALTER TABLE `procedures` DISABLE KEYS */;
INSERT INTO `procedures` VALUES (1,1,'Appendectomy',200.00),(2,1,'Breast biopsy',300.00),(3,1,'Cataract surgery',400.00),(4,2,'Teeth cleaning',50.00),(5,2,'Teeth whitening',30.00),(6,2,'Teeth extraction',80.00),(7,3,'Cervical Biopsy',125.00),(8,3,'Colposcopy',225.00),(9,3,'Infection Screening',40.00),(10,4,'chemotherapy',40.00),(11,4,'Marrow Transplant',150.00),(12,4,'Harmone Therapy',200.00),(13,5,'Ultrasound',115.00),(14,5,'Magnetic Resonance Imaging (MRI)',85.00),(15,5,'X-Ray',90.00),(16,6,'Family Nurse',112.00),(17,6,'Pediatric Nurse',110.00),(18,6,'ER Nurse',130.00);
/*!40000 ALTER TABLE `procedures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(145) NOT NULL,
  `password` varchar(145) NOT NULL,
  `user_type` varchar(80) NOT NULL,
  `last_nm` varchar(45) NOT NULL,
  `first_nm` varchar(85) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jrackfinn@gmail.com','tyrese123','Doc','Morgan','Tyrese');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-08 23:07:47
