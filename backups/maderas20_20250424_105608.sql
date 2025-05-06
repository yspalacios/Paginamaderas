-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: maderas20
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add folder',6,'add_folder'),(22,'Can change folder',6,'change_folder'),(23,'Can delete folder',6,'delete_folder'),(24,'Can view folder',6,'view_folder'),(25,'Can add producto',7,'add_producto'),(26,'Can change producto',7,'change_producto'),(27,'Can delete producto',7,'delete_producto'),(28,'Can view producto',7,'view_producto'),(29,'Can add datos',8,'add_datos'),(30,'Can change datos',8,'change_datos'),(31,'Can delete datos',8,'delete_datos'),(32,'Can view datos',8,'view_datos'),(33,'Can add document',9,'add_document'),(34,'Can change document',9,'change_document'),(35,'Can delete document',9,'delete_document'),(36,'Can view document',9,'view_document');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci,
  `object_repr` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_maderas_datos_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_maderas_datos_id` FOREIGN KEY (`user_id`) REFERENCES `maderas_datos` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(8,'maderas','datos'),(9,'maderas','document'),(6,'maderas','folder'),(7,'maderas','producto'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-04-02 18:05:42.192045'),(2,'contenttypes','0002_remove_content_type_name','2025-04-02 18:05:42.289910'),(3,'auth','0001_initial','2025-04-02 18:05:42.655690'),(4,'auth','0002_alter_permission_name_max_length','2025-04-02 18:05:42.841760'),(5,'auth','0003_alter_user_email_max_length','2025-04-02 18:05:42.850226'),(6,'auth','0004_alter_user_username_opts','2025-04-02 18:05:42.860174'),(7,'auth','0005_alter_user_last_login_null','2025-04-02 18:05:42.871152'),(8,'auth','0006_require_contenttypes_0002','2025-04-02 18:05:42.874564'),(9,'auth','0007_alter_validators_add_error_messages','2025-04-02 18:05:42.884802'),(10,'auth','0008_alter_user_username_max_length','2025-04-02 18:05:42.893028'),(11,'auth','0009_alter_user_last_name_max_length','2025-04-02 18:05:42.902139'),(12,'auth','0010_alter_group_name_max_length','2025-04-02 18:05:42.985979'),(13,'auth','0011_update_proxy_permissions','2025-04-02 18:05:42.995695'),(14,'auth','0012_alter_user_first_name_max_length','2025-04-02 18:05:43.004685'),(15,'maderas','0001_initial','2025-04-02 18:05:43.559576'),(16,'admin','0001_initial','2025-04-02 18:05:43.756525'),(17,'admin','0002_logentry_remove_auto_add','2025-04-02 18:05:43.768428'),(18,'admin','0003_logentry_add_action_flag_choices','2025-04-02 18:05:43.783115'),(19,'sessions','0001_initial','2025-04-02 18:05:43.840041');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1hdvsr5dlkq15wv1axzwino83wprpnbf','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4L1C:pWOdg3HyEHOB1M-wjbHkm5LTuAZ10PYRXxdZQjkX2I4','2025-04-28 14:42:38.038636'),('1xtl0pp2qlrl60yx4iic8hbuwd50aeoq','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1Iw0:l0O0aZoYwzt05aoIhi0l6ol2hDYCDO9o5SDrjXaSCmw','2025-04-20 05:52:44.811492'),('1yu1d763a2n3ocn5z971x5ifyrg8gb2j','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1GCw:h3EXVb7wDibMkpOH07C4vGi3r3ToPdVB07Ai1QYn3FA','2025-04-20 02:58:02.997119'),('3148dzeaw0kpwzz4b28fhod66g6jt26e','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u7ZZY:LON7eJ79lV94OhYBx-z0CWWhWolEb5x7wIY7PfDVkhk','2025-05-07 12:51:28.232304'),('5jbyb72jhje4o68y5kc246rv2n587tkj','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1Ekb:nyE3Ff3ewaXRCDTFFz4fgrS2wbNSv78RRJIFaBIzI7o','2025-04-20 01:24:41.531893'),('5xi46rwoekeq0f2cb1vy82ry9tuntwll','eyJyZXNldF9lbWFpbCI6Imtyb3RpbnhyZW1hc3RlckBnbWFpbC5jb20ifQ:1u1HnN:VC8ExlyeYsjgh07zNjR7J1gqUWPRMMVZfzq1fprsdgM','2025-04-20 04:39:45.793826'),('6qqzskh2mdwwalpa1gw3xyevye96mchu','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1FCv:KK_N0vz5DsFWPRA_lGQNFFp_RmDOw-LIJ2UPssc0eRc','2025-04-20 01:53:57.851712'),('7t2ncoogqtma3lfyqpzo6m34hf5oqg1f','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u5QX0:tPF6rL2jVQHVB4owctlXA2FNZNkRbu8sbOjKJqGF_m4','2025-05-01 14:47:58.089373'),('83ijmkbjynrcoidtbir93rchsvk4sz5y','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4LP3:2kYx7pD8Ds5QxY0Anzzf5yNLnOGJ3q1LD3iAk2YzbhE','2025-04-28 15:07:17.891084'),('8sayixaz9qm8yhtebobtoinogppuqxnx','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u3GYT:K_kQffj1wlYGBlAsdvCo8_Ons6FfV1QAqT0lXd18bf8','2025-04-25 15:44:33.354332'),('90isbqe4nno5auzk7j8ndloq728e95ls','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u5Oky:9RXlXhunNPGlmppeSU9Qi4kAdg_pzjsyy-Gm6CYwKPI','2025-05-01 12:54:16.441985'),('95bys8lslygbmkm53ahi31eebc22cbw5','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1Ir1:oQkaAqCnvt4UXQ2lwyFaj73KK9Es0cGAZmxLAMaap_0','2025-04-20 05:47:35.370276'),('9cgywvt1cxfli3ezuqz95txla3umrpp9','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4LgY:Ow5_YdPBhfVd93csyBcnaaF8HV1lzCiNeo7rTGEU074','2025-04-28 15:25:22.168674'),('awdk382a7yxs03fwkyyal3ihryoec8cn','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4LgX:S1h0LG8pkmJn4Ldpv7Jf5lFWYTprs82hyJYJ5MgJzsA','2025-04-28 15:25:21.128799'),('b3r7ti2ws997w5yxsn1hvghjtahv1o13','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1Ima:hnfcKzwAFs6wbI_Wvauv8okm5hgxznKYDfhduaiIjgs','2025-04-20 05:43:00.017611'),('bqvhfhejbckqp9t88qncj6b6hgqb2yjs','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u13rs:kATPj843LnY5RhPz3l5TVsVFuluU-t2wD5v4eQc-HUU','2025-04-19 13:47:28.614405'),('crnuayhshf4kuw3ze998f6on6nqfgznn','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4LMk:wFYR2DJOSQ8pZi-qnnQCIOGZxFNaf6eJ2liIlUoVzM0','2025-04-28 15:04:54.915195'),('dzp05mn1sik68lpk40ci640oya9fwf9i','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1GSN:kHIvbXQ3ahkNKFWhxiCTB6Xr2wgkREeBk-Juym5r09c','2025-04-20 03:13:59.449753'),('e4yrotlda5u669n8ezbwjyde4fzm525u','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4ITe:gsXvPw1E_x_XTcC5nqDXgFjKlIJy6CvZCtyZvuSZ1Mw','2025-04-28 11:59:50.248421'),('eeau07sg7y4uyrsvfrb0kejxy7cyhlzs','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1JDT:9zB3mLZcSTGa5Mhkllrp6o4didxjGRreKAc2hkKr38I','2025-04-20 06:10:47.326951'),('f6e4pat8tlfuwkl20qhr5uiu0pcsb9na','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4OXr:UnctxMZtH-Q-vl2-SMS9s-WjGn6ZLCcO_WVEx6xKo3s','2025-04-28 18:28:35.667946'),('fat5z0h4yfku539cstsgkod88b9rzkz1','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1IJq:zeA7ubqCFFBh70lA8BuyrJLuI-zIrznch4FViXTdI3Q','2025-04-20 05:13:18.167686'),('fha39o3mfpaasxrcu8g28sto0t0zmt1y','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u5Q1Q:p4YPGj7edYRlX5GubSQGh2AD3gaOsDvt5RNex5emETE','2025-05-01 14:15:20.382558'),('fljtos2nuq414brmb5xwuowrifl61bfk','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u5OAW:ow_YNL9OKkDV1y5V-9U5mtuyDY1H6PZ7eLTMXWAC6Dk','2025-05-01 12:16:36.322127'),('g02onfcvlo1b1cf9o03gash30hrg69lj','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u13lw:jqWX1FXC88xsf_6pjJ65o_YqalXSLr7UTk_96eknCuo','2025-04-19 13:41:20.359105'),('g06zzp2hvozx35zvbqtzyq0jjl760a6x','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u6hvz:8nNZy5e04SGatZYZfBDk80XUanBadEJ8oA0AJsIJnCE','2025-05-05 03:35:03.922650'),('go2o0j5vy7lhsx3x9wkv2h7emog3q9ew','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1Izk:CLiHfYNJPjBVUQqaZa_SwHO7zxpYHLh6MJsihK6etyQ','2025-04-20 05:56:36.955469'),('gphfp5xdni4g0vxy2zmzfaihmwuwp2zr','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u5OpL:7dKlYzyF1xf8WoXq2EEdfA0I7ELCdVNAVih9o_utFdI','2025-05-01 12:58:47.530251'),('hkvb7rvnwdhgxz9umeafjwilrufeg0j5','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4O1s:q3fWgKx3nktzrkujjy-u94F0EGTT48508ZNfYXOfZKg','2025-04-28 17:55:32.782591'),('hual0ol0z6u6z25vg665dx2bchsu7baz','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4KeB:qTqlL7iNwAIknJO55suozybb9osbPgPj5lesh0dceUI','2025-04-28 14:18:51.792845'),('if1g3wtggvfwn7t80e3h2yset5fcmkcv','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u13xy:94Z9OLDDMCIGxEgaXUVJ4HMgXesi5Yg_en3gifqsigk','2025-04-19 13:53:46.034771'),('jqelnrtl90i1rb051udkraxdkiqr1bye','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4MSP:igpORFR8XUntq-M7CS8SoEGHajniq0OT9QOcIau7AtQ','2025-04-28 16:14:49.689048'),('jz7d7gdag9pc9jwg5nizal749ed8c661','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1F1R:VzUTtcQoqz9z6k4L5gAsp7qVo3w1FTq8JlFT_qvKVhU','2025-04-20 01:42:05.709375'),('mo8sy1nct823qqtq5q8zobqopk1k1ylh','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u5Q6B:CCUypOonTsYcAp8ZtCwjqwRrhb4O_NL63g5nhOsLlMw','2025-05-01 14:20:15.962792'),('nib9hvwit2yngwmooqaeijpt7h70d2g4','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1Har:2U3f-HgGMIny4aJhP18u_E3rnNuWJJHJLB3yDyzTUfY','2025-04-20 04:26:49.807541'),('pisqltkjt8ziffp6sxul35oxj65vd4rq','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4OTK:YNCAsX4OIAySrmiB7n-WfP8jkiB4FNwEomU0ibRrEgE','2025-04-28 18:23:54.150427'),('qq9e0gh07jyy9zeg04txjj0o08nt0qwg','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4Oaw:P9Vp_iqgDiIKh2BuIhisI-YFIqWddWA6sNX9yGhzXk4','2025-04-28 18:31:46.238491'),('rl2wz132zlfspm00zk58z78v6rxtb9fi','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1GJE:8XG9_p_lltSxWMdLCNLefv4R4oP-9gVay_grQMgL8_8','2025-04-20 03:04:32.991394'),('s5csnd438kih0dzyy5k1iee55x3hsyao','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u2f1m:jNFktVcPLcOJoWgsnwTRJuRupFQqJbIO5gTtgNMYSXM','2025-04-23 23:40:18.991396'),('soehbodijfvp5y8wl1agfdddq2w6hywn','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u2Uyz:UsmgtZ6AulwAkPfeP5tZo_j6i-JaEEdVOtb3ymd_0RE','2025-04-23 12:56:45.586491'),('tas27f6c7fhjltmud5evlokm9bicv4kd','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4Mbv:ujMWP4IEJrvX-bsQT3G04NvUsbw7IT1d5-ZgRo6_27g','2025-04-28 16:24:39.834286'),('tcpofz23s6sq1jp0ckqk6v76rld86z7c','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u2VBE:iNFY3Mp0XKiqKTjToCk9xZsdOVuqDSDh-lifTjHqABg','2025-04-23 13:09:24.854805'),('tmfwaossmx6m2fi107e9hhpy119o67i6','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4LIi:uGeqOcntM3j8zi6O1vluouzasdF9FrZnzWsP6yobt8Y','2025-04-28 15:00:44.843927'),('u3k2ej6v504q1mlir4k4npzgcgcy52br','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4Lkm:ohx0r-kfZ0Ee15IMQn9LKmk7rL_owEKobpgxwY88SaM','2025-04-28 15:29:44.951288'),('unwijr5f5wk05p5htecmikdv8mz6b8lj','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u5Por:-XJrokmgRscSQ7TJ3sA8cyXc-Y_REA1qnejz0SWT0WY','2025-05-01 14:02:21.063882'),('uyd31wbcf7qz0zhgsh78cdnju22hdlre','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u5QAr:ePcEzEOpyI1M1iXwXpGDPVYCqLU-N0L-qhA6XNKRov8','2025-05-01 14:25:05.668712'),('w2zm68su6tnsb9znmd83cm8igpcgz7eq','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1Idw:NDXu6LHhaVIXAT8pz8YbJk8zLXooe4Ol_eUIpagkChU','2025-04-20 05:34:04.716445'),('w67980dzbewa1ztfydmllm00hqtqogtq','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u1FIZ:FVw0ymUvXqgQxy7-Ud5cmnX2SHQVdfBaSCUngmDx7GA','2025-04-20 01:59:47.889799'),('wr5hxlrtyhysniq4c81unxigbszct1ub','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4JGp:S443UeTIuQbo66X2FWkppcBSsrFmLupJnsJO2_9eW7A','2025-04-28 12:50:39.254557'),('yaufikyg5lofl1a9i0ckq6th3fjuxvfe','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u5Pr5:DcSvA9QgJOgvM-5uuefFG6MU5GLhheDqcTWv_1dJufU','2025-05-01 14:04:39.810486'),('yfd6iyqkhmvjkykrt1yj6b1bvbhhd7uc','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u7yu7:9Zznz9fsJ3y9vhaqzF3OdYomgEsB3Aqn9VGFM6mKjAY','2025-05-08 15:54:23.825041'),('z143c3qmw3thhjka104lbjo9ft9e6t3p','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u2VJN:uFPQW-So01tGMt7pD2R9E2R3FO248ALb2wcfo51C2CE','2025-04-23 13:17:49.285408'),('z8yez3wjoulsbu702mor8ixojehw3kq9','.eJxVjk0KwyAQhe_iuoRkNKl2VbrvGWSiY2KTKqiBQundayCLdvn-Pt6badzKrLdMSXvLLqxjp19vRLNQ2AP7wDDFxsRQkh-bvdIcaW7u0dJ6O7p_gBnzXNdcEghww4AKJFjqz9YhOjcaB8TJKiuNUMYIKVsE5EIa5UQPLXZcAXcVmihT0fREv1bgkmLx4ZWqzoXSddr9-u7JPl-NakgR:1u0iCx:f9Wd30wUh5hfxxdh2gjO1EXf_Zs_fCjGAga9RpCCy2c','2025-04-18 14:39:47.174174'),('zsr64v7iei8fa63o47g55cevsmg615k5','.eJxVjMsOgjAQRf-la9PAtODUpXu-oRnmIaiBhMLK-O9KwkK395xzXy7Ttg55K7rkUdzF1e70u_XED512IHeabrPneVqXsfe74g9afDeLPq-H-3cwUBm-dUCFCNa2lABBtDmLEZn1bKBBJQlyTMwRsSKgEJGTxQYqqkOCYO79AQNSOHA:1u4KzH:FrIaDcW9GkqN_OnMHnBPOTIXXVD_0ycHRiRmbbzMnts','2025-04-28 14:40:39.007020');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maderas_datos`
--

DROP TABLE IF EXISTS `maderas_datos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maderas_datos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `nombres` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `apellidos` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `phone` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `security_question` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `security_answer` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `recovery_email` varchar(254) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_datos`
--

LOCK TABLES `maderas_datos` WRITE;
/*!40000 ALTER TABLE `maderas_datos` DISABLE KEYS */;
INSERT INTO `maderas_datos` VALUES (1,'pbkdf2_sha256$870000$RleJ9BR1O2VhvMU1ZGqx7K$SLh8Dbfa6mZg9QxxTJKbCJTR09TYjiajS7SPAgu+nhk=','2025-04-24 15:54:23.816695',0,'krotinxremaster@gmail.com','yahir','palacios','3134337180','ciudad_nacimiento','sogamoso','cyahirstiven@gmail.com','Activo',1,0),(2,'pbkdf2_sha256$870000$bWxEJgDZROpITpuXLe1zCN$zqr0s/d/ttPlQSZNKlBuaZw0K4dn45CcQ0NDGx+zrTc=','2025-04-08 12:05:41.287635',0,'prueba@gmail.com','yahir','stiv','3134337180','ciudad_nacimiento','sogamoso','cyahirpalacios@gmail.com','Activo',1,0),(8,'pbkdf2_sha256$870000$20ikAcLceWTG88dH9Oen0y$Feis8oIZ0hFbvbqQgoT/7twiool6jg54gPdj1dSWGso=',NULL,0,'sus@gmail.com','Marien','Barrera','3134337180','ciudad_nacimiento','sogamoso','krotinx11@gmail.com','Activo',1,0),(9,'pbkdf2_sha256$870000$Egj7ydrRz6ZzaJ3tVcPJ22$i4x15ihGEnb28OO3T1RxVv9hCCWvtEHLOmEIMPS1edQ=',NULL,0,'susana@gmail.com','Sara','castañeda','3134337190','nombre_mascota','sogamoso','krotinx11@gmail.com','No Activo',1,0);
/*!40000 ALTER TABLE `maderas_datos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maderas_datos_groups`
--

DROP TABLE IF EXISTS `maderas_datos_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maderas_datos_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `datos_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `maderas_datos_groups_datos_id_group_id_41b08b55_uniq` (`datos_id`,`group_id`),
  KEY `maderas_datos_groups_group_id_f44eeb9b_fk_auth_group_id` (`group_id`),
  CONSTRAINT `maderas_datos_groups_datos_id_170f1036_fk_maderas_datos_id` FOREIGN KEY (`datos_id`) REFERENCES `maderas_datos` (`id`),
  CONSTRAINT `maderas_datos_groups_group_id_f44eeb9b_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_datos_groups`
--

LOCK TABLES `maderas_datos_groups` WRITE;
/*!40000 ALTER TABLE `maderas_datos_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `maderas_datos_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maderas_datos_user_permissions`
--

DROP TABLE IF EXISTS `maderas_datos_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maderas_datos_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `datos_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `maderas_datos_user_permi_datos_id_permission_id_14fa0753_uniq` (`datos_id`,`permission_id`),
  KEY `maderas_datos_user_p_permission_id_27a5eca3_fk_auth_perm` (`permission_id`),
  CONSTRAINT `maderas_datos_user_p_datos_id_a534c784_fk_maderas_d` FOREIGN KEY (`datos_id`) REFERENCES `maderas_datos` (`id`),
  CONSTRAINT `maderas_datos_user_p_permission_id_27a5eca3_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_datos_user_permissions`
--

LOCK TABLES `maderas_datos_user_permissions` WRITE;
/*!40000 ALTER TABLE `maderas_datos_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `maderas_datos_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maderas_document`
--

DROP TABLE IF EXISTS `maderas_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maderas_document` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `folder_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `maderas_document_folder_id_d67f7f7d_fk_maderas_folder_id` (`folder_id`),
  CONSTRAINT `maderas_document_folder_id_d67f7f7d_fk_maderas_folder_id` FOREIGN KEY (`folder_id`) REFERENCES `maderas_folder` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_document`
--

LOCK TABLES `maderas_document` WRITE;
/*!40000 ALTER TABLE `maderas_document` DISABLE KEYS */;
INSERT INTO `maderas_document` VALUES (3,'documents/PRESTACIONES_SOCIALES.pdf','2025-04-17 12:56:41.676097',7),(4,'documents/MODAL_VERBS_ADSO_YAHIR_PALACIOS.pdf','2025-04-17 15:56:45.007817',7);
/*!40000 ALTER TABLE `maderas_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maderas_folder`
--

DROP TABLE IF EXISTS `maderas_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maderas_folder` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `fecha_inicio` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `puesto_designado` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `salario_actual` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `horas_trabajo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `tiempo_contrato` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `numero_identidad` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `numero_seguro_social` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `eps` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `fondo_pensiones` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `arl` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_folder`
--

LOCK TABLES `maderas_folder` WRITE;
/*!40000 ALTER TABLE `maderas_folder` DISABLE KEYS */;
INSERT INTO `maderas_folder` VALUES (7,'yahir','No admitido','10-01-2023','dasd','asdasd','asdasd','asdasd','','','','kkjsksks',''),(9,'andres','En revisión',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,'yahir aplacios','No definido',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `maderas_folder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maderas_producto`
--

DROP TABLE IF EXISTS `maderas_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maderas_producto` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tipo_madera` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `nombre_producto` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `descripcion` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `imagen` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `publicado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_producto`
--

LOCK TABLES `maderas_producto` WRITE;
/*!40000 ALTER TABLE `maderas_producto` DISABLE KEYS */;
INSERT INTO `maderas_producto` VALUES (26,'pino','palo de lopes :v','sdasdasdasd','productos/Se_acerca_una_lluvia_de_estrellas_Mira_este_espectáculo_natural_ESTE_fin_de_semana.jpg',1),(27,'pino','sadasdadsad','asdasdasdadasd','productos/__ᴬⁱ_ᴬʳᵗ_1.jpeg',1),(30,'roble','esteripido','ksajdjsadkad','productos/Tanjiro_Kamado.jpeg',1),(31,'roble','eitopeus','sdasdadsasdasd','productos/____sᴏʟᴏ_ʟᴇᴠᴇʟɪɴɢ.jpeg',1),(32,'roble','lkajoakajka',',sndkjajlksda','productos/๑Akatsuki__.jpeg',1),(34,'cedro','sadawa','kkskjsjsjkksks','productos/e74fb03e-a3aa-4554-b078-e92ff06c3198.jpg',1),(35,'cedro','sadwasdwa','asdawasdw','productos/1bcb5e87-0769-4d3a-b41c-08ae2cef6cb9.jpg',1),(37,'cedro','alfredo','sadasdawdwdaw','productos/80a1524a-cd15-4147-b719-830a08ae9fc3_oB8UjQR.jpg',1),(39,'nogal','qwqweqwe','qweqeyquytrkljh','productos/46d401be-4338-44d4-b46c-e8506d835cd3.jpeg',1),(41,'nogal','tabla','ñlnsdovhidsjf','productos/1a758013-81ca-4a7d-a92c-8c5335b4607b.jpeg',1),(42,'nogal','esteripido','ñdñ´slxñdpkx','productos/46d401be-4338-44d4-b46c-e8506d835cd3_mux228D.jpeg',1),(43,'pino','nlnnacnasncasnc','lkanscklnascnasnc','productos/33625d7f-d45c-43b7-9ff9-85f08a3819a2_vLsS5JU.jpeg',0);
/*!40000 ALTER TABLE `maderas_producto` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-24 10:56:09
