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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add folder',6,'add_folder'),(22,'Can change folder',6,'change_folder'),(23,'Can delete folder',6,'delete_folder'),(24,'Can view folder',6,'view_folder'),(25,'Can add producto',7,'add_producto'),(26,'Can change producto',7,'change_producto'),(27,'Can delete producto',7,'delete_producto'),(28,'Can view producto',7,'view_producto'),(29,'Can add datos',8,'add_datos'),(30,'Can change datos',8,'change_datos'),(31,'Can delete datos',8,'delete_datos'),(32,'Can view datos',8,'view_datos'),(33,'Can add document',9,'add_document'),(34,'Can change document',9,'change_document'),(35,'Can delete document',9,'delete_document'),(36,'Can view document',9,'view_document'),(37,'Can add product',10,'add_product'),(38,'Can change product',10,'change_product'),(39,'Can delete product',10,'delete_product'),(40,'Can view product',10,'view_product'),(41,'Can add tipo madera',11,'add_tipomadera'),(42,'Can change tipo madera',11,'change_tipomadera'),(43,'Can delete tipo madera',11,'delete_tipomadera'),(44,'Can view tipo madera',11,'view_tipomadera');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(8,'maderas','datos'),(9,'maderas','document'),(6,'maderas','folder'),(10,'maderas','product'),(7,'maderas','producto'),(11,'maderas','tipomadera'),(5,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-06-03 10:51:10.132315'),(2,'contenttypes','0002_remove_content_type_name','2025-06-03 10:51:10.214128'),(3,'auth','0001_initial','2025-06-03 10:51:10.519279'),(4,'auth','0002_alter_permission_name_max_length','2025-06-03 10:51:10.590668'),(5,'auth','0003_alter_user_email_max_length','2025-06-03 10:51:10.596249'),(6,'auth','0004_alter_user_username_opts','2025-06-03 10:51:10.603116'),(7,'auth','0005_alter_user_last_login_null','2025-06-03 10:51:10.610689'),(8,'auth','0006_require_contenttypes_0002','2025-06-03 10:51:10.614249'),(9,'auth','0007_alter_validators_add_error_messages','2025-06-03 10:51:10.620440'),(10,'auth','0008_alter_user_username_max_length','2025-06-03 10:51:10.632990'),(11,'auth','0009_alter_user_last_name_max_length','2025-06-03 10:51:10.639611'),(12,'auth','0010_alter_group_name_max_length','2025-06-03 10:51:10.711462'),(13,'auth','0011_update_proxy_permissions','2025-06-03 10:51:10.718435'),(14,'auth','0012_alter_user_first_name_max_length','2025-06-03 10:51:10.724756'),(15,'maderas','0001_initial','2025-06-03 10:51:11.142062'),(16,'admin','0001_initial','2025-06-03 10:51:11.289633'),(17,'admin','0002_logentry_remove_auto_add','2025-06-03 10:51:11.296828'),(18,'admin','0003_logentry_add_action_flag_choices','2025-06-03 10:51:11.306997'),(19,'maderas','0002_datos_profile_image','2025-06-03 10:51:11.343579'),(20,'maderas','0003_producto_precio','2025-06-03 10:51:11.367277'),(21,'maderas','0004_product_tipomadera_alter_producto_tipo_madera','2025-06-03 10:51:11.531104'),(22,'maderas','0005_remove_product_description_product_wood_type_and_more','2025-06-03 10:51:11.567014'),(23,'maderas','0006_calendarevent','2025-06-03 10:51:11.588458'),(24,'maderas','0007_delete_calendarevent','2025-06-03 10:51:11.600244'),(25,'sessions','0001_initial','2025-06-03 10:51:11.642365');
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
INSERT INTO `django_session` VALUES ('27eix7cgb9wkjfuxf3cpvw25l91jwp9j','.eJxVjEEOwiAQRe_C2pCBVgou3fcMZGaYStVAUtqV8e7apAvd_vfef6mI25rj1mSJc1IXZdTpdyPkh5QdpDuWW9Vcy7rMpHdFH7TpsSZ5Xg_37yBjy9-aQMgmdsZD300yGDpDMiZYJzwhDgETewgAIgGotyKWvbjA5Ds25NX7A_aaOIM:1uMPKG:12REHMjKCe-dwlsqe0TMw75JtasXQZdfKqAV1FZsles','2025-06-17 10:57:00.795788'),('43b8ua84pmk499hstz0pc8zmmpjfedvh','.eJxVjEEOwiAQRe_C2pCBVgou3fcMZGaYStVAUtqV8e7apAvd_vfef6mI25rj1mSJc1IXZdTpdyPkh5QdpDuWW9Vcy7rMpHdFH7TpsSZ5Xg_37yBjy9-aQMgmdsZD300yGDpDMiZYJzwhDgETewgAIgGotyKWvbjA5Ds25NX7A_aaOIM:1uMPVU:5lfLQVoPD_-cBgkky7kFZZCEIoPZQ9I9CtbCnLqyhEs','2025-06-17 11:08:36.257973'),('c2n67w1mfhcf7ge61nzm6n5mt2g41wx2','.eJxVjEEOwiAQRe_C2pCBVgou3fcMZGaYStVAUtqV8e7apAvd_vfef6mI25rj1mSJc1IXZdTpdyPkh5QdpDuWW9Vcy7rMpHdFH7TpsSZ5Xg_37yBjy9-aQMgmdsZD300yGDpDMiZYJzwhDgETewgAIgGotyKWvbjA5Ds25NX7A_aaOIM:1uMQQP:jtUZhzHe9ZPR0SjDQYDL39MkTK3HBmNX5bPGDJ1KWxM','2025-06-17 12:07:25.366057'),('xfft7ilvttl3ua1agorrvbc3mfc0afl3','.eJxVjEEOwiAQRe_C2hAoDKBL9z0DmWFAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERWpx-N8L0yG0HfMd2m2Wa27pMJHdFHrTLceb8vB7u30HFXr-1s2hcTimhBYVDKBlsAU2FjVLecDjbEAwSDuSINYPzCKE4AgzeZRTvD_QqOGE:1uMTy9:-ruc1cfdpqJEEW-bFqswL5AmY-5VmSrgFMtvWgVbdmI','2025-06-17 15:54:29.387418');
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
  `profile_image` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_datos`
--

LOCK TABLES `maderas_datos` WRITE;
/*!40000 ALTER TABLE `maderas_datos` DISABLE KEYS */;
INSERT INTO `maderas_datos` VALUES (1,'pbkdf2_sha256$870000$eeHNYrCMyazOA98AsUSb5g$Sc9lN2rnR6jz8VeFdr9SNE4cbltQ70zPFnoQkApQRSI=','2025-06-03 15:54:29.382491',0,'krotinxremaster@gmail.com','yahir','palacios','3344556677','ciudad_nacimiento','sogamoso','cyahirstiven@gmail.com','Activo',1,0,''),(3,'pbkdf2_sha256$870000$6pzQNwFfQMwg9lk5jbuS0S$6/iiDRJOPwki3VaG7BddfgN73wEoXSUc8pqpFpasudE=',NULL,0,'prueba@gmail.com','Marien','Barrera','2233445566','ciudad_nacimiento','sogamoso','cyahirstiven@gmail.com','No Activo',1,0,'');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_document`
--

LOCK TABLES `maderas_document` WRITE;
/*!40000 ALTER TABLE `maderas_document` DISABLE KEYS */;
INSERT INTO `maderas_document` VALUES (2,'documents/inventario_2_Itv1OVx.pdf','2025-06-03 12:05:14.715241',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_folder`
--

LOCK TABLES `maderas_folder` WRITE;
/*!40000 ALTER TABLE `maderas_folder` DISABLE KEYS */;
INSERT INTO `maderas_folder` VALUES (1,'Yahir palacios','Contratado','2025-06-12','Leñador','65000','7','2025-12-18','1007554567','42287558415','nueva eps','porvenir',''),(3,'sebastian','No definido',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `maderas_folder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maderas_product`
--

DROP TABLE IF EXISTS `maderas_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maderas_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `wood_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `maderas_product_chk_1` CHECK ((`stock` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_product`
--

LOCK TABLES `maderas_product` WRITE;
/*!40000 ALTER TABLE `maderas_product` DISABLE KEYS */;
INSERT INTO `maderas_product` VALUES (1,'Tabla 1.60',10000.00,30,'2025-06-03 11:45:59.318875','2025-06-03 11:45:59.318904','Eucalipto Pellita'),(2,'Tabla 2 m',12000.00,30,'2025-06-03 11:46:17.383953','2025-06-03 11:46:17.383980','Eucalipto Pellita'),(3,'Repisa 1.40',7000.00,40,'2025-06-03 11:46:35.866979','2025-06-03 11:46:35.867006','Eucalipto Pellita'),(4,'Tablilla',2000.00,27,'2025-06-03 11:46:55.808646','2025-06-03 11:46:55.808679','Eucalipto Pellita'),(5,'Pellita',35000.00,42,'2025-06-03 11:47:16.136736','2025-06-03 11:47:16.136761','Eucalipto Pellita'),(6,'Taco',10000.00,38,'2025-06-03 11:47:32.166389','2025-06-03 11:47:32.166415','Eucalipto Pellita'),(7,'palanca',25000.00,19,'2025-06-03 11:47:52.566531','2025-06-03 11:47:52.566558','Eucalipto Pellita'),(8,'Limaton',16500.00,48,'2025-06-03 11:48:09.673944','2025-06-03 11:48:09.673970','Eucalipto Pellita'),(9,'palanquilla',19000.00,35,'2025-06-03 11:48:24.787708','2025-06-03 11:48:24.787734','Eucalipto Pellita'),(10,'Pilote',28000.00,29,'2025-06-03 11:48:41.695875','2025-06-03 11:48:41.695905','Eucalipto Pellita'),(11,'Palanca especial',32000.00,48,'2025-06-03 11:49:08.821693','2025-06-03 11:49:08.821719','Eucalipto Globulus'),(12,'Palanca pareja',30000.00,28,'2025-06-03 11:49:31.492282','2025-06-03 11:49:31.492307','Eucalipto Globulus'),(13,'Palanquilla',20000.00,24,'2025-06-03 11:49:45.788811','2025-06-03 11:49:45.788842','Eucalipto Globulus'),(14,'Taco',12000.00,47,'2025-06-03 11:50:00.530723','2025-06-03 11:50:00.530751','Eucalipto Globulus'),(15,'Palanca pareja',36500.00,78,'2025-06-03 11:50:38.101356','2025-06-03 11:50:38.101383','Eucalipto Globulus'),(16,'Palanca pareja',0.01,1,'2025-06-03 15:50:45.387537','2025-06-03 15:50:45.387575','Eucalipto Globulus');
/*!40000 ALTER TABLE `maderas_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maderas_producto`
--

DROP TABLE IF EXISTS `maderas_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maderas_producto` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tipo_madera_id` bigint NOT NULL,
  `nombre_producto` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `descripcion` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `imagen` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `publicado` tinyint(1) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `maderas_producto_tipo_madera_id_b06b13e0` (`tipo_madera_id`),
  CONSTRAINT `maderas_producto_tipo_madera_id_b06b13e0_fk_maderas_t` FOREIGN KEY (`tipo_madera_id`) REFERENCES `maderas_tipomadera` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_producto`
--

LOCK TABLES `maderas_producto` WRITE;
/*!40000 ALTER TABLE `maderas_producto` DISABLE KEYS */;
INSERT INTO `maderas_producto` VALUES (1,1,'Tabla 1.60','Diametro de 15*4 cm','productos/Imagen1.png',1,10000.00),(2,1,'Tabla 2m','Diametro de 15*4 cm','productos/Imagen2.jpg',0,12000.00),(3,1,'Repisa 1.40','Diametro de 4*8','productos/Imagen3.jpg',0,7000.00),(4,1,'Tablilla','Diametro de 2*5 cm con longitud de 70 cm','productos/Imagen4.jpg',0,2000.00),(5,1,'Taco','Diametro de 10-8 cm una longitud de 2.40','productos/Imagen6.jpg',0,10000.00),(6,1,'Palanca pareja','Diametro de 14-16 cm una longitud de 2.4 m','productos/Imagen7.jpg',0,25000.00),(7,1,'Limaton','Diametro de 10cm una longitud de 2.50m','productos/Imagen8.jpg',1,16500.00),(8,1,'palanquilla','Diametro 12cm longitud de 2.40m','productos/Imagen9.jpg',1,19000.00),(9,1,'pilote','Diametro 16cm longitud 3m','productos/Imagen10.jpg',1,28000.00),(10,2,'Palanca especial','Diametro de 16-18cm longitud de 2.40m','productos/Imagen1_8h13JUI.png',1,32000.00),(11,2,'Palanca pareja','Diametro de 14-16cm longitud de 2.40cm','productos/Imagen12.png',0,30000.00),(12,2,'Palanquilla','Diametro de 12cm con longitud de 2.40m','productos/Imagen13.jpg',0,20000.00),(13,2,'Taco','Diametro de 12cm Longitud de 2.40m','productos/Imagen14.jpg',0,12000.00),(14,2,'Palanca pareja','Diametro de 14cm Longitud de 2.70m','productos/Imagen15.jpg',0,36500.00),(15,2,'Riel','Diametro de 8*8cm con longitud de 2m','productos/Imagen16.jpg',0,18000.00),(16,2,'Tabla 2m','Diametro de 4*16cm longitud de 2m','productos/Imagen17.jpg',1,12000.00),(17,2,'Tabla 1.60','Diametro de 4*16cm longitud de 1.60m','productos/Imagen18.jpg',1,10000.00),(18,3,'12*12','Diametro de 12*12cm longitud 3m','productos/Imagen19.jpg',1,38000.00),(19,2,'10*!0','Diametro de 10*10 cm Longitud de 2m','productos/Imagen20.jpg',1,30000.00),(20,3,'10*10 de 3m','Diametro de 10*100 cm Longitud de 3m','productos/Imagen21.jpg',0,30000.00),(21,3,'Repisa','Diametro de 4*16cm longitud de 2m','productos/Imagen22.jpg',0,7000.00),(22,3,'Repisa','Diametro de 4*16 Longitud de 1.60m','productos/Imagen23.jpg',0,15000.00),(23,3,'Tabla','Diametro de 25*2cm Longitud de 3m','productos/Imagen24.jpg',0,25000.00),(24,3,'6*6','Diametro de 4*16cm Longitud de 2m','productos/Imagen25.jpg',0,12000.00),(25,3,'Camilla','Diametro de 70cm Longitud de 1.4m','productos/Imagen26.jpg',1,30000.00),(26,3,'4*4','Diametro de 4*4cm Longitud de 3m','productos/Imagen27.jpg',1,8000.00),(27,3,'3*3','Diametro de 3¨3 cm Longitud de 3m','productos/Imagen28.jpg',1,6000.00),(28,2,'tabla','diametro 15*6  longitud 5m','productos/Imagen8_INJCTNe.jpg',0,2000.00),(29,2,'tabla','diametro 12*3 longitud 4m','productos/Imagen8_lhftraB.jpg',0,5000.00);
/*!40000 ALTER TABLE `maderas_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maderas_tipomadera`
--

DROP TABLE IF EXISTS `maderas_tipomadera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maderas_tipomadera` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_tipomadera`
--

LOCK TABLES `maderas_tipomadera` WRITE;
/*!40000 ALTER TABLE `maderas_tipomadera` DISABLE KEYS */;
INSERT INTO `maderas_tipomadera` VALUES (2,'Eucalipto Globulus'),(1,'Eucalipto Pellita'),(3,'Pinus patula');
/*!40000 ALTER TABLE `maderas_tipomadera` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-03 11:01:11
