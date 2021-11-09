CREATE DATABASE IF NOT EXISTS demo_database CHARACTER SET utf8 COLLATE utf8_general_ci;
USE demo_database;
CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `description` text,
  `model` varchar(50) DEFAULT NULL,
  `model_id` bigint(20) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `change` text,
  `ip` varchar(20) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `model_id` (`model_id`),
  KEY `model` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET GLOBAL innodb_strict_mode = 0;
