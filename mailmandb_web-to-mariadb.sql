-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mailman3_web
-- ------------------------------------------------------
-- Server version	10.11.6-MariaDB-0+deb12u1

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
-- Table structure for table `account_emailaddress`
--

DROP TABLE IF EXISTS `account_emailaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_emailaddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `email` varchar(254) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `account_emailaddress_user_id_idx` (`user_id`),
  CONSTRAINT `fk_account_emailaddress_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_emailconfirmation`
--

DROP TABLE IF EXISTS `account_emailconfirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_emailconfirmation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `sent` datetime DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirmation_email_address_id_idx` (`email_address_id`),
  CONSTRAINT `fk_account_emailconfirmation_email_address_id` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_idx` (`group_id`),
  KEY `auth_group_permissions_permission_id_idx` (`permission_id`),
  CONSTRAINT `fk_auth_group_permissions_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `fk_auth_group_permissions_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_idx` (`content_type_id`),
  CONSTRAINT `fk_auth_permission_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  `first_name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_idx` (`user_id`),
  KEY `auth_user_groups_group_id_idx` (`group_id`),
  CONSTRAINT `fk_auth_user_groups_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `fk_auth_user_groups_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_idx` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_idx` (`permission_id`),
  CONSTRAINT `fk_auth_user_user_permissions_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `fk_auth_user_user_permissions_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` text DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `change_message` text NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_idx` (`content_type_id`),
  KEY `django_admin_log_user_id_idx` (`user_id`),
  CONSTRAINT `fk_django_admin_log_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `fk_django_admin_log_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_mailman3_maildomain`
--

DROP TABLE IF EXISTS `django_mailman3_maildomain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_mailman3_maildomain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_domain` varchar(255) NOT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mail_domain` (`mail_domain`),
  KEY `django_mailman3_maildomain_site_id_idx` (`site_id`),
  CONSTRAINT `fk_django_mailman3_maildomain_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_mailman3_profile`
--

DROP TABLE IF EXISTS `django_mailman3_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_mailman3_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timezone` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_django_mailman3_profile_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_q_ormq`
--

DROP TABLE IF EXISTS `django_q_ormq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_q_ormq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(100) NOT NULL,
  `payload` text NOT NULL,
  `lock` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_q_schedule`
--

DROP TABLE IF EXISTS `django_q_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_q_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `func` varchar(256) NOT NULL,
  `hook` varchar(256) DEFAULT NULL,
  `args` text DEFAULT NULL,
  `kwargs` text DEFAULT NULL,
  `schedule_type` varchar(1) NOT NULL,
  `repeats` int(11) NOT NULL,
  `next_run` datetime DEFAULT NULL,
  `task` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `minutes` smallint(5) unsigned DEFAULT NULL CHECK (`minutes` >= 0),
  `cron` varchar(100) DEFAULT NULL,
  `cluster` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_q_task`
--

DROP TABLE IF EXISTS `django_q_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_q_task` (
  `name` varchar(100) NOT NULL,
  `func` varchar(256) NOT NULL,
  `hook` varchar(256) DEFAULT NULL,
  `args` text DEFAULT NULL,
  `kwargs` text DEFAULT NULL,
  `result` text DEFAULT NULL,
  `started` datetime NOT NULL,
  `stopped` datetime NOT NULL,
  `success` tinyint(1) NOT NULL,
  `id` varchar(32) NOT NULL,
  `group` varchar(100) DEFAULT NULL,
  `attempt_count` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` text NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_idx` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `domain` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_attachment`
--

DROP TABLE IF EXISTS `hyperkitty_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `counter` smallint(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type` varchar(255) NOT NULL,
  `encoding` varchar(255) DEFAULT NULL,
  `content` longblob DEFAULT NULL,
  `email_id` int(11) NOT NULL,
  `size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hyperkitty_attachment_email_id_counter_uniq` (`email_id`,`counter`),
  KEY `hyperkitty_attachment_email_id_idx` (`email_id`),
  CONSTRAINT `fk_hyperkitty_attachment_email_id` FOREIGN KEY (`email_id`) REFERENCES `hyperkitty_email` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6209 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_email`
--

DROP TABLE IF EXISTS `hyperkitty_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` varchar(255) NOT NULL,
  `message_id_hash` varchar(255) NOT NULL,
  `subject` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `date` datetime NOT NULL,
  `timezone` smallint(6) NOT NULL,
  `in_reply_to` varchar(255) DEFAULT NULL,
  `archived_date` datetime NOT NULL,
  `thread_depth` int(11) NOT NULL,
  `thread_order` int(11) DEFAULT NULL,
  `mailinglist_id` int(11) NOT NULL,
  `sender_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `thread_id` int(11) NOT NULL,
  `sender_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hyperkitty_email_mailinglist_id_message_id_uniq` (`mailinglist_id`,`message_id`),
  KEY `hyperkitty_email_message_id_idx` (`message_id`),
  KEY `hyperkitty_email_message_id_hash_idx` (`message_id_hash`),
  KEY `hyperkitty_email_subject_idx` (`subject`),
  KEY `hyperkitty_email_date_idx` (`date`),
  KEY `hyperkitty_email_in_reply_to_idx` (`in_reply_to`),
  KEY `hyperkitty_email_archived_date_idx` (`archived_date`),
  KEY `hyperkitty_email_thread_order_idx` (`thread_order`),
  KEY `hyperkitty_email_mailinglist_id_idx` (`mailinglist_id`),
  KEY `hyperkitty_email_sender_id_idx` (`sender_id`),
  KEY `hyperkitty_email_thread_id_idx` (`thread_id`),
  KEY `hyperkitty_email_parent_id_idx` (`parent_id`),
  CONSTRAINT `fk_hyperkitty_email_mailinglist_id` FOREIGN KEY (`mailinglist_id`) REFERENCES `hyperkitty_mailinglist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_hyperkitty_email_sender_id` FOREIGN KEY (`sender_id`) REFERENCES `hyperkitty_sender` (`address`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_hyperkitty_email_thread_id` FOREIGN KEY (`thread_id`) REFERENCES `hyperkitty_thread` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=161261 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_favorite`
--

DROP TABLE IF EXISTS `hyperkitty_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_favorite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hyperkitty_favorite_thread_id_idx` (`thread_id`),
  KEY `hyperkitty_favorite_user_id_idx` (`user_id`),
  CONSTRAINT `fk_hyperkitty_favorite_thread_id` FOREIGN KEY (`thread_id`) REFERENCES `hyperkitty_thread` (`id`),
  CONSTRAINT `fk_hyperkitty_favorite_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_lastview`
--

DROP TABLE IF EXISTS `hyperkitty_lastview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_lastview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `view_date` datetime NOT NULL,
  `thread_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hyperkitty_lastview_thread_id_idx` (`thread_id`),
  KEY `hyperkitty_lastview_user_id_idx` (`user_id`),
  CONSTRAINT `fk_hyperkitty_lastview_thread_id` FOREIGN KEY (`thread_id`) REFERENCES `hyperkitty_thread` (`id`),
  CONSTRAINT `fk_hyperkitty_lastview_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_mailinglist`
--

DROP TABLE IF EXISTS `hyperkitty_mailinglist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_mailinglist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `subject_prefix` varchar(255) NOT NULL,
  `archive_policy` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `list_id` varchar(254) DEFAULT NULL,
  `archive_rendering_mode` varchar(255) DEFAULT NULL,
  `name` varchar(254) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `list_id` (`list_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_mailinglist_moderators`
--

DROP TABLE IF EXISTS `hyperkitty_mailinglist_moderators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_mailinglist_moderators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mailinglist_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hyperkitty_mailinglist_moderators_mailinglist_id_user_id_uniq` (`mailinglist_id`,`user_id`),
  KEY `hyperkitty_mailinglist_moderators_mailinglist_id_idx` (`mailinglist_id`),
  KEY `hyperkitty_mailinglist_moderators_user_id_idx` (`user_id`),
  CONSTRAINT `fk_hyperkitty_mailinglist_moderators_mailinglist_id` FOREIGN KEY (`mailinglist_id`) REFERENCES `hyperkitty_mailinglist` (`id`),
  CONSTRAINT `fk_hyperkitty_mailinglist_moderators_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_mailinglist_owners`
--

DROP TABLE IF EXISTS `hyperkitty_mailinglist_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_mailinglist_owners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mailinglist_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hyperkitty_mailinglist_owners_mailinglist_id_user_id_uniq` (`mailinglist_id`,`user_id`),
  KEY `hyperkitty_mailinglist_owners_mailinglist_id_idx` (`mailinglist_id`),
  KEY `hyperkitty_mailinglist_owners_user_id_idx` (`user_id`),
  CONSTRAINT `fk_hyperkitty_mailinglist_owners_mailinglist_id` FOREIGN KEY (`mailinglist_id`) REFERENCES `hyperkitty_mailinglist` (`id`),
  CONSTRAINT `fk_hyperkitty_mailinglist_owners_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_profile`
--

DROP TABLE IF EXISTS `hyperkitty_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `karma` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_hyperkitty_profile_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_sender`
--

DROP TABLE IF EXISTS `hyperkitty_sender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_sender` (
  `address` varchar(255) NOT NULL,
  `mailman_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`address`),
  KEY `hyperkitty_sender_mailman_id_idx` (`mailman_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_tag`
--

DROP TABLE IF EXISTS `hyperkitty_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_tagging`
--

DROP TABLE IF EXISTS `hyperkitty_tagging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_tagging` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL,
  `thread_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hyperkitty_tagging_tag_id_idx` (`tag_id`),
  KEY `hyperkitty_tagging_thread_id_idx` (`thread_id`),
  KEY `hyperkitty_tagging_user_id_idx` (`user_id`),
  CONSTRAINT `fk_hyperkitty_tagging_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `hyperkitty_tag` (`id`),
  CONSTRAINT `fk_hyperkitty_tagging_thread_id` FOREIGN KEY (`thread_id`) REFERENCES `hyperkitty_thread` (`id`),
  CONSTRAINT `fk_hyperkitty_tagging_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_thread`
--

DROP TABLE IF EXISTS `hyperkitty_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_thread` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thread_id` varchar(255) NOT NULL,
  `date_active` datetime NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `starting_email_id` int(11) DEFAULT NULL,
  `mailinglist_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hyperkitty_thread_mailinglist_id_thread_id_uniq` (`mailinglist_id`,`thread_id`),
  UNIQUE KEY `starting_email_id` (`starting_email_id`),
  KEY `hyperkitty_thread_thread_id_idx` (`thread_id`),
  KEY `hyperkitty_thread_date_active_idx` (`date_active`),
  KEY `hyperkitty_thread_category_id_idx` (`category_id`),
  KEY `hyperkitty_thread_mailinglist_id_idx` (`mailinglist_id`),
  CONSTRAINT `fk_hyperkitty_thread_category_id` FOREIGN KEY (`category_id`) REFERENCES `hyperkitty_threadcategory` (`id`),
  CONSTRAINT `fk_hyperkitty_thread_mailinglist_id` FOREIGN KEY (`mailinglist_id`) REFERENCES `hyperkitty_mailinglist` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93340 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_threadcategory`
--

DROP TABLE IF EXISTS `hyperkitty_threadcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_threadcategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `color` varchar(7) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperkitty_vote`
--

DROP TABLE IF EXISTS `hyperkitty_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperkitty_vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` smallint(6) NOT NULL,
  `email_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hyperkitty_vote_email_id_user_id_uniq` (`email_id`,`user_id`),
  KEY `hyperkitty_vote_value_idx` (`value`),
  KEY `hyperkitty_vote_email_id_idx` (`email_id`),
  KEY `hyperkitty_vote_user_id_idx` (`user_id`),
  CONSTRAINT `fk_hyperkitty_vote_email_id` FOREIGN KEY (`email_id`) REFERENCES `hyperkitty_email` (`id`),
  CONSTRAINT `fk_hyperkitty_vote_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postorius_emailtemplate`
--

DROP TABLE IF EXISTS `postorius_emailtemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postorius_emailtemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `data` text NOT NULL,
  `modified_at` datetime NOT NULL,
  `context` varchar(50) NOT NULL,
  `identifier` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL,
  `language` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `postorius_emailtemplate_name_identifier_language_uniq` (`name`,`identifier`,`language`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `socialaccount_socialaccount`
--

DROP TABLE IF EXISTS `socialaccount_socialaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialaccount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `extra_data` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_uid_uniq` (`provider`,`uid`),
  KEY `socialaccount_socialaccount_user_id_idx` (`user_id`),
  CONSTRAINT `fk_socialaccount_socialaccount_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `socialaccount_socialapp`
--

DROP TABLE IF EXISTS `socialaccount_socialapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `socialaccount_socialapp_sites`
--

DROP TABLE IF EXISTS `socialaccount_socialapp_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialapp_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `socialapp_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_site_id_uniq` (`socialapp_id`,`site_id`),
  KEY `socialaccount_socialapp_sites_socialapp_id_idx` (`socialapp_id`),
  KEY `socialaccount_socialapp_sites_site_id_idx` (`site_id`),
  CONSTRAINT `fk_socialaccount_socialapp_sites_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`),
  CONSTRAINT `fk_socialaccount_socialapp_sites_socialapp_id` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `socialaccount_socialtoken`
--

DROP TABLE IF EXISTS `socialaccount_socialtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialtoken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` text NOT NULL,
  `token_secret` text NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_socialtoken_account_id_idx` (`account_id`),
  KEY `socialaccount_socialtoken_app_id_idx` (`app_id`),
  CONSTRAINT `fk_socialaccount_socialtoken_account_id` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `fk_socialaccount_socialtoken_app_id` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-01 10:43:31
