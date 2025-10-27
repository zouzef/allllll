-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 27, 2025 at 03:05 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `testing`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `id` int(11) NOT NULL,
  `account_type_id` int(11) DEFAULT NULL,
  `file_link` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `other_type` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `slc_use` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_audit`
--

CREATE TABLE `account_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_subject`
--

CREATE TABLE `account_subject` (
  `id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `subject_config_id` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `description` longtext DEFAULT NULL,
  `other_subject` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `releaseToken` tinyint(1) DEFAULT NULL,
  `useToken` varchar(255) DEFAULT NULL,
  `slc_use` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_subject_audit`
--

CREATE TABLE `account_subject_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `group_session_id` int(11) DEFAULT NULL,
  `calander_id` int(11) DEFAULT NULL,
  `payment_session_id` int(11) DEFAULT NULL,
  `is_present` tinyint(1) NOT NULL DEFAULT 0,
  `day` datetime DEFAULT NULL,
  `note` longtext DEFAULT NULL,
  `is_editable` tinyint(1) NOT NULL DEFAULT 1,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `releaseToken` tinyint(1) DEFAULT NULL,
  `useToken` varchar(255) DEFAULT NULL,
  `slc_use` int(11) DEFAULT 0,
  `is_sync` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendance_audit`
--

CREATE TABLE `attendance_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `camera`
--

CREATE TABLE `camera` (
  `id` int(11) NOT NULL,
  `slc_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `mac_id` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'webcam',
  `status` varchar(50) NOT NULL DEFAULT 'Active',
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `camera_audit`
--

CREATE TABLE `camera_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `local`
--

CREATE TABLE `local` (
  `id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `address` longtext NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `gps` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `default_local` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `local_audit`
--

CREATE TABLE `local_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pushed_records_tracking`
--

CREATE TABLE `pushed_records_tracking` (
  `id` int(11) NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `audit_id` int(11) NOT NULL,
  `pushed_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pushed_records_tracking`
--

INSERT INTO `pushed_records_tracking` (`id`, `table_name`, `audit_id`, `pushed_at`) VALUES
(1, 'account_audit', 9991, '2025-10-13 15:30:17'),
(2, 'account_audit', 9992, '2025-10-13 15:30:17'),
(3, 'account_audit', 9993, '2025-10-13 15:30:17'),
(13, 'attendance_audit', 123926, '2025-10-13 16:34:16'),
(14, 'attendance_audit', 123946, '2025-10-14 11:59:39');

-- --------------------------------------------------------

--
-- Table structure for table `relation_calander_group_session`
--

CREATE TABLE `relation_calander_group_session` (
  `id` int(11) NOT NULL,
  `session_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `local_id` int(11) DEFAULT NULL,
  `group_session_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `description` longtext DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `ref` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `refresh` tinyint(1) NOT NULL DEFAULT 0,
  `title` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `teacher_present` tinyint(1) NOT NULL DEFAULT 0,
  `force_teacher_present` tinyint(1) NOT NULL DEFAULT 0,
  `releaseToken` tinyint(1) DEFAULT NULL,
  `useToken` varchar(255) DEFAULT NULL,
  `slc_use` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `relation_calander_group_session_audit`
--

CREATE TABLE `relation_calander_group_session_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0,
  `is_sync` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `relation_group_local_session`
--

CREATE TABLE `relation_group_local_session` (
  `id` int(11) NOT NULL,
  `session_id` int(11) DEFAULT NULL,
  `local_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `capacity` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `special_group` tinyint(1) DEFAULT NULL,
  `access_type` tinyint(1) DEFAULT NULL,
  `releaseToken` tinyint(1) DEFAULT NULL,
  `useToken` varchar(255) DEFAULT NULL,
  `slc_use` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `relation_group_local_session_audit`
--

CREATE TABLE `relation_group_local_session_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `relation_teacher_to_subject_group`
--

CREATE TABLE `relation_teacher_to_subject_group` (
  `id` int(11) NOT NULL,
  `relation_group_local_session_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `releaseToken` tinyint(1) DEFAULT NULL,
  `useToken` varchar(255) DEFAULT NULL,
  `slc_use` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `relation_teacher_to_subject_group_audit`
--

CREATE TABLE `relation_teacher_to_subject_group_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `relation_user_session`
--

CREATE TABLE `relation_user_session` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `relation_group_local_session_id` int(11) DEFAULT NULL,
  `ref` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `releaseToken` tinyint(1) DEFAULT NULL,
  `useToken` varchar(255) DEFAULT NULL,
  `slc_use` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `relation_user_session_audit`
--

CREATE TABLE `relation_user_session_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `id` int(11) NOT NULL,
  `local_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `capacity` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `slc_use` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `room_audit`
--

CREATE TABLE `room_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `formation_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `img_link` varchar(255) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `capacity` varchar(255) NOT NULL,
  `price` varchar(255) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `type_pay` varchar(255) NOT NULL,
  `request_change_group` tinyint(1) DEFAULT NULL,
  `max_group_change` varchar(255) DEFAULT NULL,
  `payment_methode` varchar(255) DEFAULT NULL,
  `number_session_for_pay` varchar(255) DEFAULT NULL,
  `price_student_absent` varchar(255) DEFAULT NULL,
  `user_register_after_start` tinyint(1) NOT NULL DEFAULT 1,
  `public_resource` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `uuid` varchar(255) NOT NULL,
  `price_presence` varchar(255) DEFAULT NULL,
  `price_online` varchar(255) DEFAULT NULL,
  `special_group` tinyint(1) DEFAULT NULL,
  `passage` tinyint(1) DEFAULT NULL,
  `season_id` int(11) DEFAULT NULL,
  `releaseToken` tinyint(1) DEFAULT NULL,
  `useToken` varchar(255) DEFAULT NULL,
  `slc_use` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `session_audit`
--

CREATE TABLE `session_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `slc`
--

CREATE TABLE `slc` (
  `id` int(11) NOT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `slc_username` varchar(255) DEFAULT NULL,
  `slc_password` varchar(255) DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `slc_audit`
--

CREATE TABLE `slc_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `slc_local`
--

CREATE TABLE `slc_local` (
  `id` int(11) NOT NULL,
  `slc_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `local_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `slc_local_audit`
--

CREATE TABLE `slc_local_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subject_config`
--

CREATE TABLE `subject_config` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `releaseToken` tinyint(1) DEFAULT NULL,
  `useToken` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subject_config_audit`
--

CREATE TABLE `subject_config_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sync_status`
--

CREATE TABLE `sync_status` (
  `id` int(11) NOT NULL,
  `last_sync_time` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `is_sync` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sync_status_audit`
--

CREATE TABLE `sync_status_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tablet`
--

CREATE TABLE `tablet` (
  `id` int(11) NOT NULL,
  `slc_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `mac_id` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Active',
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tablet_audit`
--

CREATE TABLE `tablet_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `username` varchar(180) NOT NULL,
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`roles`)),
  `img_link` varchar(255) DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `birth_date` datetime DEFAULT NULL,
  `birth_place` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `grand` varchar(255) DEFAULT NULL,
  `access_type` varchar(255) DEFAULT NULL,
  `access_type_date` datetime DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `uuid` varchar(255) NOT NULL,
  `facebook_id` varchar(255) DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `mastodon_access_token` varchar(255) DEFAULT NULL,
  `general_notification` tinyint(1) NOT NULL DEFAULT 1,
  `message_notification` tinyint(1) NOT NULL DEFAULT 1,
  `calendar_notification` tinyint(1) NOT NULL DEFAULT 1,
  `push_notification` tinyint(1) NOT NULL DEFAULT 1,
  `sms_notification` tinyint(1) NOT NULL DEFAULT 1,
  `login_notification` tinyint(1) NOT NULL DEFAULT 1,
  `horsline` tinyint(1) NOT NULL DEFAULT 0,
  `ref_slc` varchar(255) DEFAULT NULL,
  `apple_id` varchar(255) DEFAULT NULL,
  `open_source_user_name` varchar(255) DEFAULT NULL,
  `rocket_chat_user_id` varchar(255) DEFAULT NULL,
  `fcm_web` varchar(255) DEFAULT NULL,
  `fcm_android` varchar(255) DEFAULT NULL,
  `fcm_ios` varchar(255) DEFAULT NULL,
  `releaseToken` tinyint(1) DEFAULT NULL,
  `useToken` varchar(255) DEFAULT NULL,
  `slc_use` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_audit`
--

CREATE TABLE `user_audit` (
  `audit_id` int(11) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_synced` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_audit`
--
ALTER TABLE `account_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `account_subject_audit`
--
ALTER TABLE `account_subject_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD UNIQUE KEY `unique_user_calendar` (`user_id`,`calander_id`);

--
-- Indexes for table `attendance_audit`
--
ALTER TABLE `attendance_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `camera`
--
ALTER TABLE `camera`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_CAMERA_SLC_ID` (`slc_id`),
  ADD KEY `IDX_CAMERA_ROOM_ID` (`room_id`);

--
-- Indexes for table `camera_audit`
--
ALTER TABLE `camera_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `local_audit`
--
ALTER TABLE `local_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `pushed_records_tracking`
--
ALTER TABLE `pushed_records_tracking`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_push` (`table_name`,`audit_id`);

--
-- Indexes for table `relation_calander_group_session`
--
ALTER TABLE `relation_calander_group_session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_A0BE55CB613FECDF` (`session_id`),
  ADD KEY `IDX_A0BE55CB9B6B5FBA` (`account_id`),
  ADD KEY `IDX_A0BE55CB5D5A2101` (`local_id`),
  ADD KEY `IDX_A0BE55CBB6F28D6D` (`group_session_id`),
  ADD KEY `IDX_A0BE55CB54177093` (`room_id`),
  ADD KEY `IDX_A0BE55CB41807E1D` (`teacher_id`),
  ADD KEY `IDX_A0BE55CB23EDC87` (`subject_id`);

--
-- Indexes for table `relation_calander_group_session_audit`
--
ALTER TABLE `relation_calander_group_session_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `relation_group_local_session_audit`
--
ALTER TABLE `relation_group_local_session_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `relation_teacher_to_subject_group_audit`
--
ALTER TABLE `relation_teacher_to_subject_group_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `relation_user_session_audit`
--
ALTER TABLE `relation_user_session_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `room_audit`
--
ALTER TABLE `room_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `session_audit`
--
ALTER TABLE `session_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `slc`
--
ALTER TABLE `slc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_SLC_UUID` (`uuid`),
  ADD KEY `IDX_SLC_USERNAME` (`username`);

--
-- Indexes for table `slc_audit`
--
ALTER TABLE `slc_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `slc_local`
--
ALTER TABLE `slc_local`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_SLC_LOCAL_SLC_ID` (`slc_id`),
  ADD KEY `IDX_SLC_LOCAL_ACCOUNT_ID` (`account_id`),
  ADD KEY `IDX_SLC_LOCAL_LOCAL_ID` (`local_id`);

--
-- Indexes for table `slc_local_audit`
--
ALTER TABLE `slc_local_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `subject_config_audit`
--
ALTER TABLE `subject_config_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `sync_status`
--
ALTER TABLE `sync_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sync_status_audit`
--
ALTER TABLE `sync_status_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `tablet_audit`
--
ALTER TABLE `tablet_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `user_audit`
--
ALTER TABLE `user_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_audit`
--
ALTER TABLE `account_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=242;

--
-- AUTO_INCREMENT for table `account_subject_audit`
--
ALTER TABLE `account_subject_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=448;

--
-- AUTO_INCREMENT for table `attendance_audit`
--
ALTER TABLE `attendance_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189048;

--
-- AUTO_INCREMENT for table `camera`
--
ALTER TABLE `camera`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `camera_audit`
--
ALTER TABLE `camera_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT for table `local_audit`
--
ALTER TABLE `local_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=267;

--
-- AUTO_INCREMENT for table `pushed_records_tracking`
--
ALTER TABLE `pushed_records_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `relation_calander_group_session_audit`
--
ALTER TABLE `relation_calander_group_session_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99800;

--
-- AUTO_INCREMENT for table `relation_group_local_session_audit`
--
ALTER TABLE `relation_group_local_session_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7323;

--
-- AUTO_INCREMENT for table `relation_teacher_to_subject_group_audit`
--
ALTER TABLE `relation_teacher_to_subject_group_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16469;

--
-- AUTO_INCREMENT for table `relation_user_session_audit`
--
ALTER TABLE `relation_user_session_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77320;

--
-- AUTO_INCREMENT for table `room_audit`
--
ALTER TABLE `room_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1061;

--
-- AUTO_INCREMENT for table `session_audit`
--
ALTER TABLE `session_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=759;

--
-- AUTO_INCREMENT for table `slc`
--
ALTER TABLE `slc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `slc_audit`
--
ALTER TABLE `slc_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `slc_local`
--
ALTER TABLE `slc_local`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `slc_local_audit`
--
ALTER TABLE `slc_local_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `subject_config_audit`
--
ALTER TABLE `subject_config_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22053;

--
-- AUTO_INCREMENT for table `sync_status`
--
ALTER TABLE `sync_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `sync_status_audit`
--
ALTER TABLE `sync_status_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tablet_audit`
--
ALTER TABLE `tablet_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;

--
-- AUTO_INCREMENT for table `user_audit`
--
ALTER TABLE `user_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29371;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
