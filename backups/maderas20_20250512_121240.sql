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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-05-08 14:53:53.376421'),(2,'contenttypes','0002_remove_content_type_name','2025-05-08 14:53:53.474978'),(3,'auth','0001_initial','2025-05-08 14:53:53.815366'),(4,'auth','0002_alter_permission_name_max_length','2025-05-08 14:53:53.906206'),(5,'auth','0003_alter_user_email_max_length','2025-05-08 14:53:53.915501'),(6,'auth','0004_alter_user_username_opts','2025-05-08 14:53:53.924813'),(7,'auth','0005_alter_user_last_login_null','2025-05-08 14:53:53.935293'),(8,'auth','0006_require_contenttypes_0002','2025-05-08 14:53:53.937891'),(9,'auth','0007_alter_validators_add_error_messages','2025-05-08 14:53:53.945274'),(10,'auth','0008_alter_user_username_max_length','2025-05-08 14:53:53.954078'),(11,'auth','0009_alter_user_last_name_max_length','2025-05-08 14:53:53.962514'),(12,'auth','0010_alter_group_name_max_length','2025-05-08 14:53:54.034656'),(13,'auth','0011_update_proxy_permissions','2025-05-08 14:53:54.044213'),(14,'auth','0012_alter_user_first_name_max_length','2025-05-08 14:53:54.052685'),(15,'maderas','0001_initial','2025-05-08 14:53:54.596686'),(16,'admin','0001_initial','2025-05-08 14:53:54.798789'),(17,'admin','0002_logentry_remove_auto_add','2025-05-08 14:53:54.811515'),(18,'admin','0003_logentry_add_action_flag_choices','2025-05-08 14:53:54.826368'),(19,'maderas','0002_datos_profile_image','2025-05-08 14:53:54.873706'),(20,'maderas','0003_producto_precio','2025-05-08 14:53:54.907355'),(21,'sessions','0001_initial','2025-05-08 14:53:54.954448'),(22,'maderas','0004_product_tipomadera_alter_producto_tipo_madera','2025-05-08 21:48:35.808780'),(23,'maderas','0005_remove_product_description_product_wood_type_and_more','2025-05-09 14:14:45.556629');
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
INSERT INTO `django_session` VALUES ('0mqkci4u6s4og7pc27wwf95h1yxievc1','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uDPDV:_Gd6_wi8JZzt6i7zktGTMro12M8H85y0xmYEP6E8qWQ','2025-05-23 15:00:49.557565'),('0qwzy8innfqgq88vspbw1j3zr84ckns5','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uE5O1:QDYyK0id-E01IesYiAaOB_75bz47Gi7zwf7F3lAyYGU','2025-05-25 12:02:29.470334'),('11svwk0xgjzjgyo16321a032oi0nhrz5','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uEWgy:JgZD2YHrn5B4sJlSk9Yg_cVzDxE6RgTq5mcyysCbVVs','2025-05-26 17:11:52.433181'),('2soyobvnlpufmy58mv76pilqqzp48vgm','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uE5c0:zTSwzGafJmCljN5JWdUk3EePYZXsLZBY9bm7ce9qfWg','2025-05-25 12:16:56.820062'),('3cbust0thcwg5akg12cgtgnb5q9hy25s','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uDTCf:sLuXe_IOkXC6fBryHXDZszhBZ5qfdo3u6j-BZY1bFYc','2025-05-23 19:16:13.694232'),('a74ekqx1jfaibh3ao3252wpqor1przw7','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uDTN9:o8qxBiVh8lrEUOK0i_tDzLa1deP8qIwswatjDcbxrbU','2025-05-23 19:27:03.562365'),('eat6augpqh0sdrvorod4egt7fl1y96tb','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uDOYE:rnVDNQOHXbuJJyN9wn0Up09COOGI307Sjs5AO7wM-_8','2025-05-23 14:18:10.779061'),('fh1e28f7uui5hk12b67bjdijht2ib06n','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uD9CR:PizSlSu6hfj-gaK2geaiM1YuwlvZRFLlJRrj9D_HtWs','2025-05-22 21:54:39.564193'),('glxnvgdjtvcedpycl47xe89fuj1md3f4','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uDTPm:2cuAin6yCC0x1DpwaqCkmJwFbX0lTd290MNXlMx6164','2025-05-23 19:29:46.561014'),('hdy57f28pltefne0ovk0ytn647dkc7fe','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uDSFU:VAjKAEGMTcyrJ_XTHCDJz2yp94PZkd3_iKg9SNurUOM','2025-05-23 18:15:04.722995'),('hwxsaii5ofj9768fvsr0zd8m0pznn9cq','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uDTic:2MvdERobla2iEKM6IWmLVgxMSaKRh6Kbsf41_foW8-k','2025-05-23 19:49:14.017435'),('jwtkv318daz8c17o4n6hv52zl89kj7f7','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uEJCi:IINUgsh1kFeGjEEFGiXHdhurlqZayOD33397kuYxqcU','2025-05-26 02:47:44.073104'),('k0u202537su1shkolzsn5csh9qic9axl','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uDUBz:ETcaQIKKeZsC7dEW9atnWDcVlQ8XBeEncA9kQde4hP8','2025-05-23 20:19:35.868368'),('mibnwu7rua7fkueu41jqbnskxgrjylem','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uDTUT:04MTYNNIrULiX9Hgjz2IWUBTz9IVTrQ3bv1GGloJkcQ','2025-05-23 19:34:37.275818'),('pub0wkdq43vpnorqxbsst6t6y04k0yh9','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uEK07:MoXFpexTq2WX9cCorEzpJ9vcPq3YpVU06P6ItHW-VBU','2025-05-26 03:38:47.519631'),('qjet4fqqqqzvsao8z653h6wwa3y1z8ci','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uEKnc:CsLEHFLaBtHoAXJjvunwuCDmKoiMe2LBMgFIwrIxdtw','2025-05-26 04:29:56.949574'),('uiizog0r9gwampazck94j4v6ymf23pqq','.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdhcITiKQjF1FuXtsyUVSjTTvzbxZgG0tYetpCXNkVybZ5bdDoGeqB4gPqPfGqdV1mZEfCj9p51OL6XU73b-DAr3saxoFWXBOW8qD88JYaeRghPDKKTHmBGAzDRG1UtqhFDJKr7JRe0ZExz5fue03Aw:1uEJWO:SqWQA35zyNTlydUPh9VBkY3tFNFugr1urdGPuwV1SQM','2025-05-26 03:08:04.090692');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_datos`
--

LOCK TABLES `maderas_datos` WRITE;
/*!40000 ALTER TABLE `maderas_datos` DISABLE KEYS */;
INSERT INTO `maderas_datos` VALUES (1,'pbkdf2_sha256$870000$Je92LLihPEx0CQvvdlDwDO$OIWZKZ5cGcmzhf8Q5kK8HNaltLJSN9HgmIsWAYEewrI=','2025-05-12 17:11:52.423362',0,'krotinxremaster@gmail.com','yahir','palacios','3134337180','ciudad_nacimiento','sogamoso','cyahirpalacios@gmail.com','Activo',1,0,'profile_images/avatar_1NyZg21.png'),(4,'pbkdf2_sha256$870000$GBDyaaJ3n6Bj3XxSomjg60$nZ724td9zKc8bygzkwSS37oVQYMyR5pteC9hyVOD86E=','2025-05-09 21:18:04.484662',0,'prueba@gmail.com','yahiro','melapel','3134337190','ciudad_nacimiento','sogamoso','cyahirstiven@gmail.com','Activo',1,0,'');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_document`
--

LOCK TABLES `maderas_document` WRITE;
/*!40000 ALTER TABLE `maderas_document` DISABLE KEYS */;
INSERT INTO `maderas_document` VALUES (1,'documents/EJERCICIO_DE_LOS_DERECHOS_FUNDAMENTALES_EN_EL_TRABAJO_Yahir_stiven_chiguasuque_utUcpu5.pdf','2025-05-09 21:20:24.637966',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_folder`
--

LOCK TABLES `maderas_folder` WRITE;
/*!40000 ALTER TABLE `maderas_folder` DISABLE KEYS */;
INSERT INTO `maderas_folder` VALUES (2,'stiven','No definido',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'jjj','No definido',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'daniel','No definido','10-01-2023','sadasd','asdasd','asdasd','asdasd','','','','','');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_product`
--

LOCK TABLES `maderas_product` WRITE;
/*!40000 ALTER TABLE `maderas_product` DISABLE KEYS */;
INSERT INTO `maderas_product` VALUES (1,'tronco',2000.00,30,'2025-05-09 15:33:13.344650','2025-05-09 15:33:13.344694','pino'),(3,'vara',5000.00,2,'2025-05-09 17:10:32.082670','2025-05-09 17:10:32.082722','pinno'),(4,'pala',2000.00,30,'2025-05-09 17:11:38.702558','2025-05-09 17:11:38.702606','pino'),(5,'sdasd',8000.00,20,'2025-05-09 18:53:47.618181','2025-05-09 18:53:47.618220','asdasd'),(6,'sgdg',8000.00,40,'2025-05-09 21:24:25.619953','2025-05-09 21:24:25.620010','dhdsfhsfhdfh');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_producto`
--

LOCK TABLES `maderas_producto` WRITE;
/*!40000 ALTER TABLE `maderas_producto` DISABLE KEYS */;
INSERT INTO `maderas_producto` VALUES (1,1,'sdfdsfds','adsfdsfdsfds','productos/๑Akatsuki___ui0IMQW.jpeg',1,2000.00),(2,1,'assad','saksakjd','productos/6ba6e2bc-bc22-4094-bcfa-2493ba38c4eb.jpeg',1,6000.00),(3,2,'ljoi{hoi','kndoihcodihcoi','productos/____sᴏʟᴏ_ʟᴇᴠᴇʟɪɴɢ_6TaRQwq.jpeg',1,2000.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maderas_tipomadera`
--

LOCK TABLES `maderas_tipomadera` WRITE;
/*!40000 ALTER TABLE `maderas_tipomadera` DISABLE KEYS */;
INSERT INTO `maderas_tipomadera` VALUES (2,'Eucalipto'),(1,'Pino');
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

-- Dump completed on 2025-05-12 12:12:41
