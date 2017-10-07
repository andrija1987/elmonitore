-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Gostitelj: 127.0.0.1
-- Čas nastanka: 07. nov 2015 ob 16.38
-- Različica strežnika: 5.6.24
-- Različica PHP: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Zbirka podatkov: `elmonitore`
--

-- --------------------------------------------------------

--
-- Struktura tabele `monitor_config`
--

CREATE TABLE IF NOT EXISTS `monitor_config` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Odloži podatke za tabelo `monitor_config`
--

INSERT INTO `monitor_config` (`key`, `value`) VALUES
('language', 'en_US'),
('email_status', '1'),
('email_from_email', 'monitor@example.org'),
('email_from_name', 'Server Monitor'),
('email_smtp', ''),
('email_smtp_host', ''),
('email_smtp_port', ''),
('email_smtp_security', ''),
('email_smtp_username', ''),
('email_smtp_password', ''),
('sms_status', '0'),
('sms_gateway', 'mollie'),
('sms_gateway_username', 'username'),
('sms_gateway_password', 'password'),
('sms_from', '1234567890'),
('pushover_status', '0'),
('pushover_api_token', ''),
('alert_type', 'status'),
('log_status', '1'),
('log_email', '1'),
('log_sms', '1'),
('log_pushover', '1'),
('log_retention_period', '365'),
('version', '3.1.1'),
('version_update_check', '3.1.1'),
('auto_refresh_servers', '0'),
('show_update', '1'),
('last_update_check', '1446894644'),
('cron_running', '0'),
('cron_running_time', '0');

-- --------------------------------------------------------

--
-- Struktura tabele `monitor_log`
--

CREATE TABLE IF NOT EXISTS `monitor_log` (
  `log_id` int(11) unsigned NOT NULL,
  `server_id` int(11) unsigned NOT NULL,
  `type` enum('status','email','sms','pushover') NOT NULL,
  `message` varchar(255) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabele `monitor_servers`
--

CREATE TABLE IF NOT EXISTS `monitor_servers` (
  `server_id` int(11) unsigned NOT NULL,
  `ip` varchar(100) NOT NULL,
  `port` int(5) unsigned NOT NULL,
  `label` varchar(255) NOT NULL,
  `type` enum('service','website') NOT NULL DEFAULT 'service',
  `pattern` varchar(255) NOT NULL,
  `status` enum('on','off') NOT NULL DEFAULT 'on',
  `error` varchar(255) DEFAULT NULL,
  `rtime` float(9,7) DEFAULT NULL,
  `last_online` datetime DEFAULT NULL,
  `last_check` datetime DEFAULT NULL,
  `active` enum('yes','no') NOT NULL DEFAULT 'yes',
  `email` enum('yes','no') NOT NULL DEFAULT 'yes',
  `sms` enum('yes','no') NOT NULL DEFAULT 'no',
  `pushover` enum('yes','no') NOT NULL DEFAULT 'yes',
  `warning_threshold` mediumint(1) unsigned NOT NULL DEFAULT '1',
  `warning_threshold_counter` mediumint(1) unsigned NOT NULL DEFAULT '0',
  `timeout` smallint(1) unsigned DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Odloži podatke za tabelo `monitor_servers`
--

INSERT INTO `monitor_servers` (`server_id`, `ip`, `port`, `label`, `type`, `pattern`, `status`, `error`, `rtime`, `last_online`, `last_check`, `active`, `email`, `sms`, `pushover`, `warning_threshold`, `warning_threshold_counter`, `timeout`) VALUES
(2, 'smtp.gmail.com', 465, 'Gmail SMTP', 'service', '', 'on', '', 0.0594029, '2015-11-07 16:35:08', '2015-11-07 16:35:08', 'yes', 'yes', 'yes', 'yes', 1, 0, NULL),
(3, 'http://91.185.193.101', 80, 'andrija1987.eu', 'website', '', 'on', '', 0.0309601, '2015-11-07 15:03:42', '2015-11-07 15:03:42', 'yes', 'no', 'no', 'no', 1, 0, 3);

-- --------------------------------------------------------

--
-- Struktura tabele `monitor_servers_history`
--

CREATE TABLE IF NOT EXISTS `monitor_servers_history` (
  `servers_history_id` int(11) unsigned NOT NULL,
  `server_id` int(11) unsigned NOT NULL,
  `date` date NOT NULL,
  `latency_min` float(9,7) NOT NULL,
  `latency_avg` float(9,7) NOT NULL,
  `latency_max` float(9,7) NOT NULL,
  `checks_total` int(11) unsigned NOT NULL,
  `checks_failed` int(11) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabele `monitor_servers_uptime`
--

CREATE TABLE IF NOT EXISTS `monitor_servers_uptime` (
  `servers_uptime_id` int(11) unsigned NOT NULL,
  `server_id` int(11) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `status` tinyint(1) unsigned NOT NULL,
  `latency` float(9,7) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Odloži podatke za tabelo `monitor_servers_uptime`
--

INSERT INTO `monitor_servers_uptime` (`servers_uptime_id`, `server_id`, `date`, `status`, `latency`) VALUES
(1, 1, '2015-11-07 15:03:36', 1, 0.8795278),
(2, 2, '2015-11-07 15:03:36', 1, 0.0605850),
(3, 3, '2015-11-07 15:03:36', 1, 0.0234661),
(4, 1, '2015-11-07 15:03:42', 1, 0.6931720),
(5, 2, '2015-11-07 15:03:42', 1, 0.0602610),
(6, 3, '2015-11-07 15:03:42', 1, 0.0309601),
(7, 1, '2015-11-07 16:35:08', 1, 0.8332980),
(8, 2, '2015-11-07 16:35:08', 1, 0.0594029);

-- --------------------------------------------------------

--
-- Struktura tabele `monitor_users`
--

CREATE TABLE IF NOT EXISTS `monitor_users` (
  `user_id` int(11) unsigned NOT NULL,
  `user_name` varchar(64) NOT NULL COMMENT 'user''s name, unique',
  `password` varchar(255) NOT NULL COMMENT 'user''s password in salted and hashed format',
  `password_reset_hash` char(40) DEFAULT NULL COMMENT 'user''s password reset code',
  `password_reset_timestamp` bigint(20) DEFAULT NULL COMMENT 'timestamp of the password reset request',
  `rememberme_token` varchar(64) DEFAULT NULL COMMENT 'user''s remember-me cookie token',
  `level` tinyint(2) unsigned NOT NULL DEFAULT '20',
  `name` varchar(255) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `pushover_key` varchar(255) NOT NULL,
  `pushover_device` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Odloži podatke za tabelo `monitor_users`
--

INSERT INTO `monitor_users` (`user_id`, `user_name`, `password`, `password_reset_hash`, `password_reset_timestamp`, `rememberme_token`, `level`, `name`, `mobile`, `pushover_key`, `pushover_device`, `email`) VALUES
(1, 'admin', '$2y$10$J5SgClASXFstrbfFtpgHTexDvBXZPKUmFe/JUSxVcG7iu5pC04ry2', NULL, NULL, NULL, 10, 'admin', '', '', '', 'admin@demo.com');

-- --------------------------------------------------------

--
-- Struktura tabele `monitor_users_preferences`
--

CREATE TABLE IF NOT EXISTS `monitor_users_preferences` (
  `user_id` int(11) unsigned NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Odloži podatke za tabelo `monitor_users_preferences`
--

INSERT INTO `monitor_users_preferences` (`user_id`, `key`, `value`) VALUES
(1, 'status_layout', '1');

-- --------------------------------------------------------

--
-- Struktura tabele `monitor_users_servers`
--

CREATE TABLE IF NOT EXISTS `monitor_users_servers` (
  `user_id` int(11) unsigned NOT NULL,
  `server_id` int(11) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Odloži podatke za tabelo `monitor_users_servers`
--

INSERT INTO `monitor_users_servers` (`user_id`, `server_id`) VALUES
(1, 1),
(1, 2),
(1, 3);

--
-- Indeksi zavrženih tabel
--

--
-- Indeksi tabele `monitor_config`
--
ALTER TABLE `monitor_config`
  ADD PRIMARY KEY (`key`);

--
-- Indeksi tabele `monitor_log`
--
ALTER TABLE `monitor_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indeksi tabele `monitor_servers`
--
ALTER TABLE `monitor_servers`
  ADD PRIMARY KEY (`server_id`);

--
-- Indeksi tabele `monitor_servers_history`
--
ALTER TABLE `monitor_servers_history`
  ADD PRIMARY KEY (`servers_history_id`), ADD UNIQUE KEY `server_id_date` (`server_id`,`date`);

--
-- Indeksi tabele `monitor_servers_uptime`
--
ALTER TABLE `monitor_servers_uptime`
  ADD PRIMARY KEY (`servers_uptime_id`), ADD KEY `server_id` (`server_id`);

--
-- Indeksi tabele `monitor_users`
--
ALTER TABLE `monitor_users`
  ADD PRIMARY KEY (`user_id`), ADD UNIQUE KEY `unique_username` (`user_name`);

--
-- Indeksi tabele `monitor_users_preferences`
--
ALTER TABLE `monitor_users_preferences`
  ADD PRIMARY KEY (`user_id`,`key`);

--
-- Indeksi tabele `monitor_users_servers`
--
ALTER TABLE `monitor_users_servers`
  ADD PRIMARY KEY (`user_id`,`server_id`);

--
-- AUTO_INCREMENT zavrženih tabel
--

--
-- AUTO_INCREMENT tabele `monitor_log`
--
ALTER TABLE `monitor_log`
  MODIFY `log_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT tabele `monitor_servers`
--
ALTER TABLE `monitor_servers`
  MODIFY `server_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT tabele `monitor_servers_history`
--
ALTER TABLE `monitor_servers_history`
  MODIFY `servers_history_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT tabele `monitor_servers_uptime`
--
ALTER TABLE `monitor_servers_uptime`
  MODIFY `servers_uptime_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT tabele `monitor_users`
--
ALTER TABLE `monitor_users`
  MODIFY `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
