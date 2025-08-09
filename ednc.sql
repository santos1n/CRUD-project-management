-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 09, 2025 at 07:18 AM
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
-- Database: `ednc`
--

-- --------------------------------------------------------

--
-- Table structure for table `beneficiaries`
--

CREATE TABLE `beneficiaries` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `visible` tinyint(1) DEFAULT 1,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `crud_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `beneficiaries`
--

INSERT INTO `beneficiaries` (`id`, `name`, `age`, `birthdate`, `visible`, `created`, `modified`, `crud_id`) VALUES
(1, 'A-1', 0, '2025-08-07', 1, '2025-08-08 15:26:57', '2025-08-08 15:26:57', 3),
(2, 'B-1', 0, '2025-08-02', 1, '2025-08-08 15:35:38', '2025-08-08 15:35:38', 2);

-- --------------------------------------------------------

--
-- Table structure for table `cruds`
--

CREATE TABLE `cruds` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `character` varchar(255) DEFAULT NULL,
  `status` enum('Pending','Approved','Disapproved') DEFAULT 'Pending',
  `email` varchar(255) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT 1,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `crudStatusId` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cruds`
--

INSERT INTO `cruds` (`id`, `name`, `age`, `birthdate`, `character`, `status`, `email`, `visible`, `created`, `modified`, `crudStatusId`) VALUES
(1, 'A0', 0, '2025-08-07', 'Test', 'Pending', 'a@a.com', 1, '2025-08-08 16:39:03', '2025-08-08 16:39:03', 3),
(2, 'A1', 2, '2023-01-02', 'Test', 'Approved', 'a@a.com', 1, '2025-08-08 15:26:57', '2025-08-08 16:42:31', 1),
(3, 'B', 0, '2022-02-09', 'Test', 'Pending', 'a@a.com', 1, '2025-08-08 15:35:38', '2025-08-08 15:35:38', 1),
(4, 'C', 0, '2022-02-10', 'Test', 'Approved', 'a@a.com', 1, '2025-08-08 15:37:06', '2025-08-08 16:42:14', 2),
(5, 'C', 0, '2025-08-07', 'Test', 'Disapproved', 'a@a.com', 1, '2025-08-08 15:55:02', '2025-08-08 16:42:24', 1);

-- --------------------------------------------------------

--
-- Table structure for table `crud_files`
--

CREATE TABLE `crud_files` (
  `id` int(11) NOT NULL,
  `fileName` varchar(255) DEFAULT NULL,
  `filePath` varchar(255) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT 1,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `crud_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `crud_files`
--

INSERT INTO `crud_files` (`id`, `fileName`, `filePath`, `visible`, `created`, `modified`, `crud_id`) VALUES
(1, 'ednc.sql', 'uploads/6895b80f831d3_ednc.sql', 1, '2025-08-08 16:40:47', '2025-08-08 16:40:47', 1);

-- --------------------------------------------------------

--
-- Table structure for table `crud_statuses`
--

CREATE TABLE `crud_statuses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT 1,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `crud_statuses`
--

INSERT INTO `crud_statuses` (`id`, `name`, `visible`, `created`, `modified`) VALUES
(1, 'Project-based', 1, '2025-08-08 15:15:01', '2025-08-08 15:15:01'),
(2, 'Contract-based', 1, '2025-08-08 15:15:31', '2025-08-08 15:15:31'),
(3, 'Friends and Family', 1, '2025-08-08 16:41:40', '2025-08-08 16:41:40'),
(4, 'Hobby', 1, '2025-08-08 16:41:44', '2025-08-08 16:41:44'),
(5, 'Side Project', 1, '2025-08-08 16:41:50', '2025-08-08 16:41:50'),
(6, 'Government', 1, '2025-08-08 16:41:58', '2025-08-08 16:41:58');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `module` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT 1,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `module`, `action`, `visible`, `created`, `modified`) VALUES
(1, 'customer-logs', 'index', 1, '2017-02-06 12:50:36', '2016-07-11 13:30:07'),
(2, 'customer-logs', 'add', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(3, 'customer-logs', 'edit', 1, '2017-02-06 12:50:36', '2016-07-11 13:29:42'),
(4, 'customer-logs', 'view', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(5, 'customer-logs', 'delete', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(6, 'members', 'index', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(7, 'members', 'add', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(8, 'members', 'edit', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(9, 'members', 'view', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(10, 'members', 'delete', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(11, 'share-capitals', 'index', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(12, 'share-capitals', 'delete', 1, '2017-02-06 12:50:36', '2016-07-12 08:16:04'),
(13, 'share-capitals', 'add', 1, '2017-02-06 12:50:36', '2016-07-12 08:15:52'),
(14, 'share-capitals', 'view', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(15, 'share-capitals', 'edit', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(16, 'membership-types', 'index', 1, NULL, NULL),
(17, 'membership-types', 'add', 1, NULL, NULL),
(18, 'membership-types', 'edit', 1, NULL, NULL),
(19, 'membership-types', 'delete', 1, NULL, NULL),
(20, 'loans', 'index', 1, '2016-07-11 13:06:22', '2016-07-11 13:06:22'),
(21, 'loans', 'add', 1, '2016-07-11 13:07:03', '2016-07-11 13:07:03'),
(22, 'loans', 'edit', 1, '2016-07-11 14:34:10', '2016-07-11 14:34:10'),
(23, 'loans', 'view', 1, '2016-07-12 08:08:54', '2016-07-12 08:08:54'),
(24, 'loans', 'delete', 1, '2016-07-12 08:13:52', '2016-07-12 08:13:52'),
(25, 'loans', 'close-account', 1, '2016-07-12 08:14:24', '2016-07-12 08:14:24'),
(26, 'loans', 'add-schedule', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(27, 'loans', 'add-payment', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(28, 'loan-types', 'add', 1, '2016-07-12 08:20:36', '2016-07-12 08:20:36'),
(29, 'loan-types', 'delete', 1, '2016-07-12 08:21:20', '2016-07-12 08:21:20'),
(30, 'loan-types', 'edit', 1, '2016-07-12 08:22:22', '2016-07-12 08:22:22'),
(31, 'loan-types', 'index', 1, '2016-07-12 08:23:09', '2016-07-12 08:23:09'),
(32, 'loan-fees', 'index', 1, '2016-07-12 08:24:21', '2016-07-12 08:24:21'),
(33, 'daily-payments', 'index', 1, '2016-07-12 08:25:03', '2016-07-12 08:25:03'),
(34, 'daily-payments', 'paid', 1, '2016-07-12 08:28:02', '2016-07-12 08:28:02'),
(35, 'payment-notifications', 'index', 1, '2016-07-12 08:29:11', '2016-07-12 08:29:11'),
(36, 'regular-savings', 'index', 1, '2017-01-25 09:45:46', '2017-01-25 09:45:46'),
(37, 'regular-savings', 'add', 1, '2017-01-25 09:45:57', '2017-01-25 09:45:57'),
(38, 'regular-savings', 'add-transaction', 1, '2017-01-25 09:47:59', '2017-01-25 09:47:59'),
(39, 'regular-savings', 'delete-transaction', 1, '2017-01-25 09:48:51', '2017-01-25 09:48:51'),
(40, 'regular-savings', 'view', 1, '2017-01-25 09:45:57', '2017-01-25 09:45:57'),
(41, 'regular-savings', 'delete-account', 1, '2017-01-25 09:48:51', '2017-01-25 09:48:51'),
(42, 'regular-savings', 'edit-transaction', 1, '2017-01-25 09:47:59', '2017-01-25 09:47:59'),
(43, 'payments', 'index', 1, NULL, NULL),
(44, 'payments', 'new-share-capital', 1, NULL, NULL),
(45, 'payments', 'add-deposit', 1, NULL, NULL),
(46, 'payments', 'view-deposit', 1, NULL, NULL),
(47, 'payments', 'add-loan-payment', 1, NULL, NULL),
(48, 'payments', 'view-loan-payment', 1, NULL, NULL),
(49, 'payments', 'remove-accounting-entry', 1, NULL, NULL),
(50, 'payments', 'add-accounting-entry', 1, NULL, NULL),
(51, 'payments', 'save', 1, NULL, NULL),
(52, 'backups', 'backup', 1, NULL, NULL),
(53, 'backups', 'delete', 1, NULL, NULL),
(251, 'inventory', 'index', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(252, 'inventory', 'view', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(253, 'inventory', 'add', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(254, 'inventory', 'edit', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(255, 'inventory', 'delete', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(261, 'inventory', 'sales', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(262, 'inventory', 'purchases', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(275, 'inventory', 'delete-inventory-items', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(276, 'inventory', 'edit-inventory-items', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(277, 'reports', 'loan-releases-report', 1, NULL, NULL),
(278, 'reports', 'loan-payments-report', 1, NULL, NULL),
(279, 'reports', 'dividends', 1, NULL, NULL),
(280, 'reports', 'patronage-refunds', 1, NULL, NULL),
(281, 'reports', 'savings-deposits-report', 1, NULL, NULL),
(282, 'reports', 'savings-withdrawals-report', 1, NULL, NULL),
(283, 'reports', 'share-capitals-report', 1, NULL, NULL),
(284, 'time-deposit-savings', 'index', 1, NULL, NULL),
(285, 'time-deposit-savings', 'view', 1, NULL, NULL),
(286, 'time-deposit-savings', 'delete-account', 1, NULL, NULL),
(287, 'time-deposit-savings', 'add', 1, NULL, NULL),
(288, 'time-deposit-savings', 'edit', 1, NULL, NULL),
(289, 'time-deposit-savings', 'add-transaction', 1, NULL, NULL),
(290, 'time-deposit-savings', 'delete-transaction', 1, NULL, '2017-10-11 14:04:12'),
(291, 'time-deposit-savings', 'edit-transaction', 1, NULL, '2017-10-11 14:04:22'),
(292, 'settings', 'add', 1, '2016-07-12 09:13:16', '2016-07-12 09:13:16'),
(293, 'settings', 'edit', 1, '2016-07-12 09:13:24', '2016-07-12 09:13:24'),
(294, 'settings', 'index', 1, '2016-07-12 09:13:33', '2016-07-12 09:13:33'),
(295, 'departments', 'add', 1, '2016-07-12 09:14:29', '2016-07-12 09:14:29'),
(296, 'departments', 'edit', 1, '2016-07-12 09:14:34', '2016-07-12 09:14:34'),
(297, 'departments', 'view', 1, '2016-07-12 09:14:42', '2016-07-12 09:14:42'),
(298, 'departments', 'delete', 1, '2016-07-12 09:14:58', '2016-07-12 09:14:58'),
(299, 'departments', 'index', 1, '2016-07-12 09:15:18', '2016-07-12 09:15:18'),
(300, 'income-factors', 'add', 1, '2016-07-12 09:15:54', '2016-07-12 09:15:54'),
(301, 'income-factors', 'edit', 1, '2016-07-12 09:16:03', '2016-07-12 09:16:03'),
(302, 'income-factors', 'index', 1, '2016-07-12 09:16:16', '2016-07-12 09:16:16'),
(303, 'permissions', 'edit', 1, '2016-07-12 09:18:33', '2016-07-12 09:18:33'),
(304, 'permissions', 'add', 1, '2016-07-12 09:19:18', '2016-07-12 09:19:18'),
(305, 'permissions', 'index', 1, '2016-07-12 09:19:24', '2016-07-12 09:19:24'),
(306, 'users', 'add', 1, '2016-07-12 09:19:42', '2016-07-12 09:19:42'),
(307, 'users', 'view', 1, '2016-07-12 09:19:48', '2016-07-12 09:19:48'),
(308, 'users', 'delete', 1, '2016-07-12 09:19:54', '2016-07-12 09:19:54'),
(309, 'users', 'edit', 1, '2016-07-12 09:20:01', '2016-07-12 09:20:01'),
(310, 'users', 'index', 1, '2016-07-12 09:20:08', '2016-07-12 09:20:08'),
(311, 'user-logs', 'index', 1, '2016-07-12 09:20:08', '2016-07-12 09:20:08'),
(312, 'users', 'add-permission', 1, '2016-08-05 14:54:26', '2016-08-05 14:54:26'),
(313, 'users', 'delete-permission', 1, '2016-08-05 14:54:37', '2016-08-05 14:54:37'),
(314, 'inventory-category', 'index', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(315, 'inventory-category', 'add', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(316, 'inventory-category', 'edit', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(317, 'inventory-category', 'delete', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(318, 'inventory-unit', 'index', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(319, 'inventory-unit', 'add', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(320, 'inventory-unit', 'edit', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(321, 'inventory-unit', 'delete', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(322, 'inventory-supplier', 'index', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(323, 'inventory-supplier', 'add', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(324, 'inventory-supplier', 'edit', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(325, 'inventory-supplier', 'delete', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(326, 'inventory-supplier', 'view', 1, '2017-02-06 12:50:36', '2017-02-06 12:50:36'),
(327, 'income-statements', 'search', 1, '2016-07-12 09:07:29', '2016-07-12 09:07:29'),
(328, 'income-statements', 'index', 1, '2016-07-12 09:07:22', '2016-07-12 09:07:22'),
(329, 'income-statements', 'print', 1, '2016-07-12 09:07:06', '2016-07-12 09:07:06'),
(330, 'balance-sheets', 'index', 1, '2016-07-12 09:06:44', '2016-07-12 09:06:44'),
(331, 'balance-sheets', 'advance search', 1, '2016-07-12 09:05:57', '2016-07-12 09:05:57'),
(332, 'balance-sheets', 'print', 1, '2016-07-12 09:05:47', '2016-07-12 09:05:47'),
(333, 'trial-balances', 'index', 1, '2016-07-12 09:01:55', '2016-07-12 09:01:55'),
(334, 'trial-balances', 'search', 1, '2016-07-12 09:01:45', '2016-07-12 09:01:45'),
(335, 'trial-balances', 'print', 1, '2016-07-12 09:01:33', '2016-07-12 09:01:33'),
(336, 'ledgers', 'index', 1, '2016-07-12 09:00:27', '2016-07-12 09:00:27'),
(337, 'ledgers', 'advance search', 1, '2016-07-12 09:00:15', '2016-07-12 09:00:15'),
(338, 'ledgers', 'print', 1, '2016-07-12 08:58:34', '2016-07-12 08:58:34'),
(339, 'ledgers', 'view', 1, '2016-07-12 08:58:20', '2016-07-12 08:58:20'),
(340, 'cash-books', 'index', 1, '2016-07-12 08:57:22', '2016-07-12 08:57:22'),
(341, 'cash-books', 'search', 1, '2016-07-12 08:57:10', '2016-07-12 08:57:10'),
(342, 'cash-books', 'print', 1, '2016-07-12 08:56:30', '2016-07-12 08:56:30'),
(343, 'accounting-entries', 'index', 1, '2016-07-12 08:56:06', '2016-07-12 08:56:06'),
(344, 'accounting-entries', 'print', 1, '2016-07-12 08:55:26', '2016-07-12 08:55:26'),
(345, 'accounting-entries', 'view', 1, '2016-07-12 08:55:07', '2016-07-12 08:55:07'),
(346, 'accounting-entries', 'delete', 1, '2016-07-12 08:54:58', '2016-07-12 08:54:58'),
(347, 'accounting-entries', 'edit', 1, '2016-07-12 08:54:50', '2016-07-12 08:54:50'),
(348, 'accounting-entries', 'TEST02', 1, '2016-07-12 08:54:41', '2016-07-12 08:54:41'),
(349, 'beginning-balances', 'index', 1, '2016-07-12 08:54:14', '2016-07-12 08:54:14'),
(350, 'beginning-balances', 'search', 1, '2016-07-12 08:54:05', '2016-07-12 08:54:05'),
(351, 'beginning-balances', 'filter', 1, '2016-07-12 08:53:35', '2016-07-12 08:53:35'),
(352, 'beginning-balances', 'delete', 1, '2016-07-12 08:53:25', '2016-07-12 08:53:25'),
(353, 'beginning-balances', 'edit', 1, '2016-07-12 08:53:18', '2016-07-12 08:53:18'),
(354, 'server', 'connect', 1, '2017-04-25 11:16:51', '2017-04-25 11:16:51'),
(355, 'front desk', 'add', 1, '2017-05-08 13:17:07', '2017-05-08 13:17:07'),
(356, 'loan-applications', 'view', 1, NULL, NULL),
(357, 'loan-applications', 'index', 1, NULL, NULL),
(358, 'loan-applications', 'delete', 1, NULL, NULL),
(359, 'loan-applications', 'add', 1, NULL, NULL),
(360, 'loan-applications', 'edit', 1, NULL, NULL),
(361, 'accounting-entries', 'ADD', 1, '2020-01-24 11:52:27', '2020-01-24 11:52:27'),
(362, 'settings', 'test', 1, '2020-02-24 09:14:01', '2020-02-24 09:14:01'),
(363, 'Settings', 'Test01', 1, '2020-02-24 09:17:36', '2020-02-24 09:17:36'),
(364, 'Front Desk', 'Exit', 1, '2020-02-29 16:41:49', '2020-02-29 16:41:49'),
(365, 'MAIN', 'ACTION', 1, '2020-03-09 19:21:38', '2020-03-09 19:21:38'),
(366, 'MEMBERS MANAGEMENT', 'INDEX101', 1, '2020-03-10 14:12:20', '2020-03-10 14:12:20'),
(367, 'main', 'main', 1, '2020-03-10 16:58:15', '2020-03-10 16:58:15');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT 1,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `code`, `name`, `description`, `visible`, `created`, `modified`) VALUES
(1, 'superadmin', 'Superadmin', NULL, 1, NULL, NULL),
(2, 'admin', 'Administrator', NULL, 1, NULL, NULL),
(4, 'chairperson', 'Chairperson', NULL, 1, NULL, NULL),
(5, 'general manager', 'General Manager', NULL, 1, NULL, NULL),
(6, 'auditor client', 'Auditor (Client)', NULL, 1, NULL, NULL),
(7, 'loan officer', 'Loan Officer', NULL, 1, NULL, NULL),
(8, 'cashier', 'Cashier', NULL, 1, NULL, NULL),
(9, 'auditor company', 'Auditor (Company)', NULL, 1, NULL, NULL),
(10, 'officer', 'Officer', NULL, 1, NULL, NULL),
(11, 'user', 'User', NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT 1,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `code`, `name`, `value`, `visible`, `created`, `modified`) VALUES
(1, 'system_name', 'System Name', 'EDNC', 1, NULL, '2014-11-14 04:58:14'),
(2, 'address', 'Address', '', 1, NULL, '2014-10-23 04:21:38'),
(4, 'email', 'Email', NULL, 1, NULL, NULL),
(5, 'telephone', 'Telephone', NULL, 1, NULL, '2014-10-23 04:21:53'),
(6, 'fax', 'Fax', NULL, 1, NULL, NULL),
(7, 'chairman', 'Chairman', NULL, 1, NULL, '2015-10-15 08:59:54'),
(8, 'general_manager', 'General Manager', NULL, 1, NULL, NULL),
(12, 'system_title', 'System Title', NULL, 1, NULL, '2014-11-25 01:58:32'),
(13, 'active_year', 'Active Year', '2017', 1, '2014-11-25 00:00:00', '2017-03-23 01:26:23'),
(14, 'branch_name', 'Branch Name', NULL, 1, '2015-10-15 08:56:34', '2015-10-15 08:56:34');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `branchId` int(3) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `verified` tinyint(1) DEFAULT 0,
  `visible` tinyint(1) DEFAULT 1,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `branchId`, `code`, `username`, `password`, `token`, `last_name`, `first_name`, `middle_name`, `gender`, `email`, `image`, `roleId`, `active`, `verified`, `visible`, `created`, `modified`) VALUES
(1, NULL, 'admin', 'admin', '0ec253be453a5b632905c1db7f3a5c0bb2970259', NULL, 'EDNC', 'ADMIN', NULL, NULL, NULL, NULL, 1, 1, 1, 1, '2015-12-05 21:04:59', '2017-03-28 14:34:40'),
(2, NULL, '', 'dev01', '7622ac86d61b3fe751f4a685195d35895cc0824f', NULL, '01', 'Dev', NULL, NULL, NULL, NULL, 2, 1, 1, 1, '2020-07-02 11:25:55', '2020-07-02 11:25:55'),
(3, NULL, '', 'samople', 'b4e25a01fffc4532413960f643a8ea673ed6f78e', NULL, 'Samople', 'Samople', NULL, NULL, NULL, NULL, 2, 1, 1, 1, '2020-07-02 13:20:52', '2020-07-02 13:20:52'),
(4, NULL, '', 'asd', 'aff738433ceaf169dffdef2b6aa0b1ad59e3a47f', NULL, 'Asd', 'Asd', NULL, NULL, NULL, NULL, 2, 1, 1, 1, '2020-07-02 13:24:24', '2020-07-02 13:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `user_logs`
--

CREATE TABLE `user_logs` (
  `id` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_permissions`
--

CREATE TABLE `user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `permission_id` int(11) DEFAULT NULL,
  `permission` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `amount` decimal(11,2) DEFAULT NULL,
  `remarks` int(11) DEFAULT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user_permissions`
--

INSERT INTO `user_permissions` (`id`, `user_id`, `permission_id`, `permission`, `date`, `amount`, `remarks`, `visible`, `created`, `modified`) VALUES
(1, 4, 1, 'customer-logs (index)', '2020-07-01', 1.00, 1, 1, '2020-07-02 13:24:24', '2020-07-02 13:24:24'),
(2, 4, 2, 'customer-logs (add)', '2020-07-02', 2.00, 2, 0, '2020-07-02 13:24:24', '2020-07-02 13:24:24'),
(3, 4, 3, 'customer-logs (edit)', '2020-07-03', 3.00, 3, 1, '2020-07-02 13:24:24', '2020-07-02 13:24:24'),
(4, 4, 4, 'customer-logs (view)', '2020-07-04', 4.00, 4, 0, '2020-07-02 13:24:24', '2020-07-02 13:24:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `beneficiaries`
--
ALTER TABLE `beneficiaries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `beneficiaryId` (`crud_id`);

--
-- Indexes for table `cruds`
--
ALTER TABLE `cruds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `crudStatusId` (`crudStatusId`);

--
-- Indexes for table `crud_files`
--
ALTER TABLE `crud_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `crud_statuses`
--
ALTER TABLE `crud_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_logs`
--
ALTER TABLE `user_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `beneficiaries`
--
ALTER TABLE `beneficiaries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cruds`
--
ALTER TABLE `cruds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `crud_files`
--
ALTER TABLE `crud_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `crud_statuses`
--
ALTER TABLE `crud_statuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=368;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_logs`
--
ALTER TABLE `user_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_permissions`
--
ALTER TABLE `user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
