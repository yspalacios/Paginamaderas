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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-05-09 22:03:18.694655'),(2,'contenttypes','0002_remove_content_type_name','2025-05-09 22:03:18.838783'),(3,'auth','0001_initial','2025-05-09 22:03:19.568383'),(4,'auth','0002_alter_permission_name_max_length','2025-05-09 22:03:19.682219'),(5,'auth','0003_alter_user_email_max_length','2025-05-09 22:03:19.698852'),(6,'auth','0004_alter_user_username_opts','2025-05-09 22:03:19.714333'),(7,'auth','0005_alter_user_last_login_null','2025-05-09 22:03:19.737983'),(8,'auth','0006_require_contenttypes_0002','2025-05-09 22:03:19.744813'),(9,'auth','0007_alter_validators_add_error_messages','2025-05-09 22:03:19.764031'),(10,'auth','0008_alter_user_username_max_length','2025-05-09 22:03:19.782726'),(11,'auth','0009_alter_user_last_name_max_length','2025-05-09 22:03:19.800428'),(12,'auth','0010_alter_group_name_max_length','2025-05-09 22:03:19.957040'),(13,'auth','0011_update_proxy_permissions','2025-05-09 22:03:19.970550'),(14,'auth','0012_alter_user_first_name_max_length','2025-05-09 22:03:19.983809'),(15,'maderas','0001_initial','2025-05-09 22:03:20.761001'),(16,'admin','0001_initial','2025-05-09 22:03:21.006007'),(17,'admin','0002_logentry_remove_auto_add','2025-05-09 22:03:21.025847'),(18,'admin','0003_logentry_add_action_flag_choices','2025-05-09 22:03:21.054405'),(19,'maderas','0002_datos_profile_image','2025-05-09 22:03:21.145607'),(20,'maderas','0003_producto_precio','2025-05-09 22:03:21.189575'),(21,'maderas','0004_product_tipomadera_alter_producto_tipo_madera','2025-05-09 22:03:21.526700'),(22,'maderas','0005_remove_product_description_product_wood_type_and_more','2025-05-09 22:03:21.617188'),(23,'sessions','0001_initial','2025-05-09 22:03:21.690416'),(24,'maderas','0006_calendarevent','2025-06-14 00:46:00.222344'),(25,'maderas','0007_delete_calendarevent','2025-06-14 00:46:00.338978'),(26,'maderas','0008_alter_product_price_alter_product_stock','2025-06-14 00:46:00.359330'),(27,'maderas','0009_alter_producto_precio','2025-06-14 00:46:00.417109'),(28,'maderas','0010_folder_tipo_documento','2025-06-14 01:15:59.108845');
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
INSERT INTO `django_session` VALUES ('4hna591op0igief3c1z6ukhjupjz0q5p','.eJxVjMsOwiAQRf-FtSGFAkNduvcbmhmGkaqBpI-V8d-1SRe6veec-1IjbmsZtyXP48TqrKw6_W6E6ZHrDviO9dZ0anWdJ9K7og-66Gvj_Lwc7t9BwaV8a8OOEFwnpicrGL0MXfaDBDIZOTkrQUKEHsgAYOQuB8DkRezgyRGo9wf3BThw:1uQCu8:UR5QzlUtnf8NHRxG5sDkcMn-2JHjeNrHTt7K5GFp9lI','2025-06-27 22:29:44.836069'),('6mqqhswrsmnoo4v9cjsr1mvhkycdb3yt','.eJxVjMsOwiAQRf-FtSGFAkNduvcbmhmGkaqBpI-V8d-1SRe6veec-1IjbmsZtyXP48TqrKw6_W6E6ZHrDviO9dZ0anWdJ9K7og-66Gvj_Lwc7t9BwaV8a8OOEFwnpicrGL0MXfaDBDIZOTkrQUKEHsgAYOQuB8DkRezgyRGo9wf3BThw:1uOk4w:tRcv5WSsOerXsX_S9_ltEHSq42fpYnD-cWBbESd4a10','2025-06-23 21:30:50.977514'),('9j6olk8oh894xp6hqhg60w1d7cnlmorc','.eJxVjMsOwiAQRf-FtSGFAkNduvcbmhmGkaqBpI-V8d-1SRe6veec-1IjbmsZtyXP48TqrKw6_W6E6ZHrDviO9dZ0anWdJ9K7og-66Gvj_Lwc7t9BwaV8a8OOEFwnpicrGL0MXfaDBDIZOTkrQUKEHsgAYOQuB8DkRezgyRGo9wf3BThw:1uEXHp:Y0R-Z8k5sP5qEi3DnWAa3cNWhc7rC68ljakiJdvkjiE','2025-05-26 17:49:57.770796'),('arsspef5a1uf9ggv5hi8f9h2fqhnt44n','.eJxVjMsOwiAQRf-FtSGFAkNduvcbmhmGkaqBpI-V8d-1SRe6veec-1IjbmsZtyXP48TqrKw6_W6E6ZHrDviO9dZ0anWdJ9K7og-66Gvj_Lwc7t9BwaV8a8OOEFwnpicrGL0MXfaDBDIZOTkrQUKEHsgAYOQuB8DkRezgyRGo9wf3BThw:1uQCu8:UR5QzlUtnf8NHRxG5sDkcMn-2JHjeNrHTt7K5GFp9lI','2025-06-27 22:29:44.132807'),('jrp91cjlcbojhcaespvzuqtbtlngtn6m','.eJxVjMsOwiAQRf-FtSGFAkNduvcbmhmGkaqBpI-V8d-1SRe6veec-1IjbmsZtyXP48TqrKw6_W6E6ZHrDviO9dZ0anWdJ9K7og-66Gvj_Lwc7t9BwaV8a8OOEFwnpicrGL0MXfaDBDIZOTkrQUKEHsgAYOQuB8DkRezgyRGo9wf3BThw:1uQCu8:UR5QzlUtnf8NHRxG5sDkcMn-2JHjeNrHTt7K5GFp9lI','2025-06-27 22:29:44.994372'),('o0vr0g8sldcitqut80lmqyv661wkyhzk','.eJxVjMsOwiAQRf-FtSGFAkNduvcbmhmGkaqBpI-V8d-1SRe6veec-1IjbmsZtyXP48TqrKw6_W6E6ZHrDviO9dZ0anWdJ9K7og-66Gvj_Lwc7t9BwaV8a8OOEFwnpicrGL0MXfaDBDIZOTkrQUKEHsgAYOQuB8DkRezgyRGo9wf3BThw:1uQCu8:UR5QzlUtnf8NHRxG5sDkcMn-2JHjeNrHTt7K5GFp9lI','2025-06-27 22:29:44.122545'),('qiz1dzv4v45wkni1bucvy52vz53darct','.eJxVjMsOwiAQRf-FtSGFAkNduvcbmhmGkaqBpI-V8d-1SRe6veec-1IjbmsZtyXP48TqrKw6_W6E6ZHrDviO9dZ0anWdJ9K7og-66Gvj_Lwc7t9BwaV8a8OOEFwnpicrGL0MXfaDBDIZOTkrQUKEHsgAYOQuB8DkRezgyRGo9wf3BThw:1uOjM5:DIytInnCdDYN4oWMHCX5Koily_OxfmFsXBNJML08v5M','2025-06-23 20:44:29.471925'),('sa7o9d90bj6dy66ocubyz76dsnx6dzks','.eJxVjMsOwiAQRf-FtSGFAkNduvcbmhmGkaqBpI-V8d-1SRe6veec-1IjbmsZtyXP48TqrKw6_W6E6ZHrDviO9dZ0anWdJ9K7og-66Gvj_Lwc7t9BwaV8a8OOEFwnpicrGL0MXfaDBDIZOTkrQUKEHsgAYOQuB8DkRezgyRGo9wf3BThw:1uS13R:aOU-uP-kqP_2yPKKeZ58cRzGiY7NePGD-798Lq1dlek','2025-07-02 22:14:49.345086'),('ur8haxrsyebaxcjzqmppv3n2pt9xwcdf','.eJxVjMsOwiAQRf-FtSGFAkNduvcbmhmGkaqBpI-V8d-1SRe6veec-1IjbmsZtyXP48TqrKw6_W6E6ZHrDviO9dZ0anWdJ9K7og-66Gvj_Lwc7t9BwaV8a8OOEFwnpicrGL0MXfaDBDIZOTkrQUKEHsgAYOQuB8DkRezgyRGo9wf3BThw:1uEzhK:vYUf3Q0ZtyUlXmhqpwT7hiDLwETa5KTbcNYqTNgEhng','2025-05-28 00:10:10.049503'),('vk4zs7y88qihm8aiwod4xdkecx4vsfye','.eJxVjMsOwiAQRf-FtSGFAkNduvcbmhmGkaqBpI-V8d-1SRe6veec-1IjbmsZtyXP48TqrKw6_W6E6ZHrDviO9dZ0anWdJ9K7og-66Gvj_Lwc7t9BwaV8a8OOEFwnpicrGL0MXfaDBDIZOTkrQUKEHsgAYOQuB8DkRezgyRGo9wf3BThw:1uQCkX:SJ8DDzUxRhlnmpksz7wZ17mKXPr5J03wRJVLTULT_kk','2025-06-27 22:19:49.312122'),('x5apmwj8k7x59a02pj75z3o07y3b965t','.eJxVjMsOwiAQRf-FtSGFAkNduvcbmhmGkaqBpI-V8d-1SRe6veec-1IjbmsZtyXP48TqrKw6_W6E6ZHrDviO9dZ0anWdJ9K7og-66Gvj_Lwc7t9BwaV8a8OOEFwnpicrGL0MXfaDBDIZOTkrQUKEHsgAYOQuB8DkRezgyRGo9wf3BThw:1uL4Y7:6KfNcw0xL9LNWUdlaoLzzatxm_Gr82V53y0YF81kUjk','2025-06-13 18:33:47.055160'),('xrng4dwljqky8e3ezkufjh5eftgm1ftq','.eJxVjMsOwiAQRf-FtSGFAkNduvcbmhmGkaqBpI-V8d-1SRe6veec-1IjbmsZtyXP48TqrKw6_W6E6ZHrDviO9dZ0anWdJ9K7og-66Gvj_Lwc7t9BwaV8a8OOEFwnpicrGL0MXfaDBDIZOTkrQUKEHsgAYOQuB8DkRezgyRGo9wf3BThw:1uRxZc:kkBdNHG8YLQUM54HcbLhV4luyhqZguu3DC8Gq4GjVf8','2025-07-02 18:31:48.747275'),('yps6i4xlwhde6ksalsmavr4nu08zmnax','.eJxVjMsOwiAQRf-FtSGFAkNduvcbmhmGkaqBpI-V8d-1SRe6veec-1IjbmsZtyXP48TqrKw6_W6E6ZHrDviO9dZ0anWdJ9K7og-66Gvj_Lwc7t9BwaV8a8OOEFwnpicrGL0MXfaDBDIZOTkrQUKEHsgAYOQuB8DkRezgyRGo9wf3BThw:1uQCu8:UR5QzlUtnf8NHRxG5sDkcMn-2JHjeNrHTt7K5GFp9lI','2025-06-27 22:29:44.955573');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_datos`
--

LOCK TABLES `maderas_datos` WRITE;
/*!40000 ALTER TABLE `maderas_datos` DISABLE KEYS */;
INSERT INTO `maderas_datos` VALUES (2,'pbkdf2_sha256$870000$uFcXcnkd73pf7JcF7XlsPn$6xU74T2OrObH657f+/3Q4CRqUYBjOahwi35j4Qw+ro0=','2025-06-18 22:14:48.668005',0,'susana1@gmail.com','Susan','Barrera','3225958044','ciudad_nacimiento','sogamoso','mariensusanabarrera2005@gmail.com','Activo',1,1,'');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_document`
--

LOCK TABLES `maderas_document` WRITE;
/*!40000 ALTER TABLE `maderas_document` DISABLE KEYS */;
INSERT INTO `maderas_document` VALUES (3,'documents/Documento_casos_de_prueba_Maderas_Isabella.pdf','2025-06-18 19:07:33.068359',7);
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
  `tipo_documento` varchar(2) COLLATE utf8mb3_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_folder`
--

LOCK TABLES `maderas_folder` WRITE;
/*!40000 ALTER TABLE `maderas_folder` DISABLE KEYS */;
INSERT INTO `maderas_folder` VALUES (7,'santi','No definido',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CC'),(8,'juan','No definido',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CC');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_product`
--

LOCK TABLES `maderas_product` WRITE;
/*!40000 ALTER TABLE `maderas_product` DISABLE KEYS */;
INSERT INTO `maderas_product` VALUES (1,'pino',2000.00,20,'2025-06-10 18:51:55.360658','2025-06-10 18:51:55.361669','palanca');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_producto`
--

LOCK TABLES `maderas_producto` WRITE;
/*!40000 ALTER TABLE `maderas_producto` DISABLE KEYS */;
INSERT INTO `maderas_producto` VALUES (8,2,'Tabla','ksjhd','productos/pinus_patula.jpg',0,2000.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_tipomadera`
--

LOCK TABLES `maderas_tipomadera` WRITE;
/*!40000 ALTER TABLE `maderas_tipomadera` DISABLE KEYS */;
INSERT INTO `maderas_tipomadera` VALUES (2,'palanca'),(3,'pino'),(4,'pinoo'),(1,'tabla');
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

-- Dump completed on 2025-06-18 17:20:18
