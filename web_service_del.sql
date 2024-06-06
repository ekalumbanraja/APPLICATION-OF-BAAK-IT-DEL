-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 15, 2023 at 04:14 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `web_service_del`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking_ruangan`
--

CREATE TABLE `booking_ruangan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reason` text NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `approver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `room_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `booking_ruangan`
--

INSERT INTO `booking_ruangan` (`id`, `reason`, `user_id`, `approver_id`, `room_id`, `status`, `start_time`, `end_time`, `created_at`, `updated_at`) VALUES
(7, '1221', 1, NULL, 2, 'rejected', '2023-12-12 12:30:00', '2023-12-12 13:09:00', '2023-12-12 01:09:19', '2023-12-12 23:41:23'),
(8, '122131', 1, NULL, 1, 'approved', '2023-12-01 15:14:00', '2023-12-02 15:14:00', '2023-12-12 01:14:08', '2023-12-12 23:41:27'),
(9, 'tambun', 1, NULL, 1, 'approved', '2023-12-30 15:14:00', '2023-12-31 15:14:00', '2023-12-12 01:14:43', '2023-12-12 21:01:52'),
(10, '1212', 1, NULL, 1, 'approved', '2023-12-12 23:23:00', '2023-12-12 12:23:00', '2023-12-12 01:23:19', '2023-12-12 21:01:48'),
(13, 'tutor', 1, NULL, 5, 'approved', '2023-12-15 21:58:00', '2023-12-13 21:58:00', '2023-12-15 02:58:32', '2023-12-15 09:08:16');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kaos`
--

CREATE TABLE `kaos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ukuran` text NOT NULL,
  `harga` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kaos`
--

INSERT INTO `kaos` (`id`, `ukuran`, `harga`, `created_at`, `updated_at`) VALUES
(1, 'S', 100000, NULL, NULL),
(2, 'M', 110000, NULL, NULL),
(3, 'XL', 120000, NULL, NULL),
(4, 'L', 115000, NULL, NULL),
(5, 'XXL', 150000, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_12_06_022019_create__request_izin_keluar_table', 1),
(6, '2023_12_10_042945_create_request_izin_bermalam_table', 1),
(7, '2023_12_11_010512_create_request_surat_table', 1),
(8, '2023_12_11_023612_create_ruangan_table', 1),
(9, '2023_12_11_024832_create_booking_ruangan_table', 1),
(10, '2023_12_13_091337_create_kaos_table', 2),
(11, '2023_12_13_092604_create_pemesanan_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan`
--

CREATE TABLE `pemesanan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `kaos_id` bigint(20) UNSIGNED NOT NULL,
  `jumlah_pesanan` int(11) NOT NULL,
  `total_harga` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'Personal Access Token', 'ecdaf83cc71fd588877b0a1c6bba7d8536a9ab53cbdf6711da4b43fed264b75b', '[\"*\"]', NULL, NULL, '2023-12-10 21:41:33', '2023-12-10 21:41:33'),
(2, 'App\\Models\\User', 1, 'secret', 'a3f817f8695ed0dc44f83e4d226b3f2bbb368b3764935258b0448f17458213ae', '[\"*\"]', '2023-12-11 00:39:55', NULL, '2023-12-10 23:27:46', '2023-12-11 00:39:55'),
(3, 'App\\Models\\User', 1, 'secret', '7610245c4ab57277a12c9130fd3cc5c9e29d17bd669fab1a1bea84808f0f85ee', '[\"*\"]', '2023-12-10 23:44:43', NULL, '2023-12-10 23:44:39', '2023-12-10 23:44:43'),
(4, 'App\\Models\\User', 1, 'secret', 'c5090d7b926d315ea7a244a49d956a2e6a8bcd069fc36807dca6a45e59741930', '[\"*\"]', '2023-12-10 23:47:03', NULL, '2023-12-10 23:47:02', '2023-12-10 23:47:03'),
(5, 'App\\Models\\User', 1, 'secret', 'fd8041ecb1450991ebc5ddf706edcbe20a67342226c283f45725ffc359f061de', '[\"*\"]', '2023-12-10 23:51:27', NULL, '2023-12-10 23:50:40', '2023-12-10 23:51:27'),
(6, 'App\\Models\\User', 1, 'secret', '578eb2cd62e76e0ef7c83a4132690a656d418b1101c91006e110dec74d811ef2', '[\"*\"]', '2023-12-11 00:12:18', NULL, '2023-12-11 00:12:17', '2023-12-11 00:12:18'),
(7, 'App\\Models\\User', 1, 'secret', '95d2892583527bd582ded18ec007f00da0ac15dc6459663cc83da09df5a61379', '[\"*\"]', '2023-12-11 00:59:32', NULL, '2023-12-11 00:59:29', '2023-12-11 00:59:32'),
(8, 'App\\Models\\User', 1, 'secret', '172ce2f00206ff87dfa8f5ae14919e1a0861c25a637c01deb545aee1a6512357', '[\"*\"]', '2023-12-11 01:51:24', NULL, '2023-12-11 01:51:21', '2023-12-11 01:51:24'),
(9, 'App\\Models\\User', 1, 'secret', '02dffc3d2e56f9c4ab6c2d3ffa5783386eee05780194c6fffba108a2d1887879', '[\"*\"]', '2023-12-11 01:54:00', NULL, '2023-12-11 01:53:57', '2023-12-11 01:54:00'),
(10, 'App\\Models\\User', 1, 'secret', '69ab6539cbe4a0f23e3f008bf9b5b7e7d70f77e08f25f0a11ab803fee774dcb6', '[\"*\"]', '2023-12-11 01:58:50', NULL, '2023-12-11 01:58:47', '2023-12-11 01:58:50'),
(11, 'App\\Models\\User', 1, 'secret', 'd1d384609b48714cd4ea3d5d51105cd84a36e5d4b90131a39ed9ea157240c4f1', '[\"*\"]', '2023-12-11 02:12:59', NULL, '2023-12-11 02:12:38', '2023-12-11 02:12:59'),
(12, 'App\\Models\\User', 1, 'secret', '4d1e7a8a7a56736e2b80dd6c6dfcfd80e491daf622ec204f47c1743632f5038d', '[\"*\"]', '2023-12-11 02:15:27', NULL, '2023-12-11 02:15:25', '2023-12-11 02:15:27'),
(13, 'App\\Models\\User', 1, 'secret', 'd4f9905d271a71c93a233078cd9eaaaf637928fcb770082d263bf1f23d8e6975', '[\"*\"]', '2023-12-11 02:18:09', NULL, '2023-12-11 02:16:48', '2023-12-11 02:18:09'),
(14, 'App\\Models\\User', 1, 'secret', '49c7b1d8d3cdf8f5e1aa515e9416e79acab10a56ab86fd20cbc984632338cda1', '[\"*\"]', '2023-12-11 03:02:53', NULL, '2023-12-11 03:02:41', '2023-12-11 03:02:53'),
(15, 'App\\Models\\User', 1, 'secret', '597f0e3dbd9033c50ebbed1510dfcc4f46c56e733b8c78b29b0c20a7859f2d84', '[\"*\"]', '2023-12-11 03:06:57', NULL, '2023-12-11 03:06:11', '2023-12-11 03:06:57'),
(16, 'App\\Models\\User', 1, 'secret', 'c2c98359c6893eb409e4f8fcc6566ff55e63fb3f2c9de4df29ac4d230bbeb5fc', '[\"*\"]', '2023-12-11 03:08:59', NULL, '2023-12-11 03:08:43', '2023-12-11 03:08:59'),
(17, 'App\\Models\\User', 1, 'secret', '237c329ea5643fd735712c3ea2c58646bfbe7444918b1daf5eab6046284671a5', '[\"*\"]', '2023-12-11 03:12:11', NULL, '2023-12-11 03:10:31', '2023-12-11 03:12:11'),
(18, 'App\\Models\\User', 1, 'secret', 'b0ab6acbe02d39a76bf20522cdc5aa59af4053093debc3475fa9da25fc5734a9', '[\"*\"]', '2023-12-11 03:16:31', NULL, '2023-12-11 03:15:09', '2023-12-11 03:16:31'),
(19, 'App\\Models\\User', 1, 'secret', '593a411639de441d8de5092fd3df77778a0010be8979d94160285314219e1c65', '[\"*\"]', '2023-12-11 03:20:47', NULL, '2023-12-11 03:20:33', '2023-12-11 03:20:47'),
(20, 'App\\Models\\User', 1, 'secret', 'e59bb08205901470b5f5906abb532fb1bd355a0aac9f5a6cf273cae2999c7a3b', '[\"*\"]', '2023-12-11 03:28:19', NULL, '2023-12-11 03:26:51', '2023-12-11 03:28:19'),
(21, 'App\\Models\\User', 1, 'secret', 'f4a0cdcdfd3d9fbed1413174b1a876ce24c9eafc85487e3cebefbeb976fb5e9b', '[\"*\"]', '2023-12-11 03:32:38', NULL, '2023-12-11 03:31:26', '2023-12-11 03:32:38'),
(22, 'App\\Models\\User', 1, 'secret', 'c6719154e8d5d1c35d2de7db6c1c3c317d1d4439bb3b87a01e54120143f5893e', '[\"*\"]', '2023-12-11 03:34:10', NULL, '2023-12-11 03:34:06', '2023-12-11 03:34:10'),
(23, 'App\\Models\\User', 1, 'secret', '5a3c877d8edef13ea3d6eeaba7f9ecf26e7103777cb47d9fbaa54f17c803442b', '[\"*\"]', '2023-12-11 03:36:32', NULL, '2023-12-11 03:36:21', '2023-12-11 03:36:32'),
(24, 'App\\Models\\User', 1, 'secret', '93c8707baf949acbbf9ea42fe0f092a99cca047301a153b6b455b577ecbd93b5', '[\"*\"]', '2023-12-11 03:40:42', NULL, '2023-12-11 03:40:25', '2023-12-11 03:40:42'),
(25, 'App\\Models\\User', 1, 'secret', 'd3b25bc384ad02713f5dadf670597911566647fea959ee6c48cdf4275bd9240f', '[\"*\"]', '2023-12-11 03:43:22', NULL, '2023-12-11 03:42:21', '2023-12-11 03:43:22'),
(26, 'App\\Models\\User', 1, 'secret', '27811f2a8d22a395c850a5436855f775362f475751e296f771813c60b0ef97a1', '[\"*\"]', '2023-12-11 03:44:58', NULL, '2023-12-11 03:44:46', '2023-12-11 03:44:58'),
(27, 'App\\Models\\User', 1, 'secret', '2e72f443da4f1de45202de554ae51b7094d88ad8c9d8b98bf92f9a11508b376f', '[\"*\"]', '2023-12-11 03:49:38', NULL, '2023-12-11 03:49:26', '2023-12-11 03:49:38'),
(28, 'App\\Models\\User', 1, 'secret', 'eafc9194e46610adc3c4bfc3d307e142ba2d33a6eaa5ece11e0eec4c8d032328', '[\"*\"]', '2023-12-11 05:36:49', NULL, '2023-12-11 05:36:46', '2023-12-11 05:36:49'),
(29, 'App\\Models\\User', 1, 'secret', '821e4a18004a93415271e432939963472b05414744c546c1fe6a0eb3b2f837a2', '[\"*\"]', '2023-12-11 05:39:55', NULL, '2023-12-11 05:39:53', '2023-12-11 05:39:55'),
(30, 'App\\Models\\User', 1, 'secret', '04a68d0d8fd3dbde992d2c7d9d1a8950856a2c8a2432a83cd1aedb4d47942e74', '[\"*\"]', '2023-12-11 05:41:50', NULL, '2023-12-11 05:41:38', '2023-12-11 05:41:50'),
(31, 'App\\Models\\User', 1, 'secret', 'cc1ec2845d9dfc5161205acbf2189a9c2274a2224442bdb0cceeb15e9c258d00', '[\"*\"]', '2023-12-11 05:43:21', NULL, '2023-12-11 05:42:39', '2023-12-11 05:43:21'),
(32, 'App\\Models\\User', 1, 'secret', '7db0b16a1868762412e547f2c123fbd3e26d99d2151d3dc85e869f0adc07c424', '[\"*\"]', '2023-12-11 06:00:40', NULL, '2023-12-11 05:56:49', '2023-12-11 06:00:40'),
(33, 'App\\Models\\User', 1, 'secret', 'fd429842cb10693947afa2a5555d96b7c6ce8ff02d3825f992cbf7b6e219c1e1', '[\"*\"]', '2023-12-11 06:01:57', NULL, '2023-12-11 06:01:38', '2023-12-11 06:01:57'),
(34, 'App\\Models\\User', 1, 'secret', '10aa5264095580fa375ccc0ab6751132733c1b14121b694ca45e311bf5dfbc5a', '[\"*\"]', '2023-12-11 06:07:39', NULL, '2023-12-11 06:02:36', '2023-12-11 06:07:39'),
(35, 'App\\Models\\User', 1, 'secret', '1f873a1af3812de6aa29f7422ccbe99ab0542ee0ed97437f7f4b5eee61d176ac', '[\"*\"]', '2023-12-11 06:06:50', NULL, '2023-12-11 06:04:28', '2023-12-11 06:06:50'),
(36, 'App\\Models\\User', 1, 'secret', 'd6cda4de8e281e7e242dbb2980f7f2cfa47e2db4a76f551820b80335912bcede', '[\"*\"]', '2023-12-11 06:30:12', NULL, '2023-12-11 06:29:34', '2023-12-11 06:30:12'),
(37, 'App\\Models\\User', 1, 'secret', '19e88f6f1203995ebc5b76c83555033fa822d2e3fc07ef6883f10ebcd09e7c6f', '[\"*\"]', '2023-12-11 06:31:48', NULL, '2023-12-11 06:30:58', '2023-12-11 06:31:48'),
(38, 'App\\Models\\User', 1, 'secret', 'bb4789c4a1f0203a7960743c501bd9d01c0e52049e337658f216dac37a36227e', '[\"*\"]', '2023-12-11 06:46:57', NULL, '2023-12-11 06:46:55', '2023-12-11 06:46:57'),
(39, 'App\\Models\\User', 1, 'secret', '8380b7924a31b43f55709f2c727751d702ea829ffeb61eb85296cd302a88a655', '[\"*\"]', '2023-12-11 06:49:56', NULL, '2023-12-11 06:49:55', '2023-12-11 06:49:56'),
(40, 'App\\Models\\User', 1, 'secret', 'd9c6a7505bbd0ce22cec3fb4e8621ef85983591a076b931dba25c7cf37b0a4af', '[\"*\"]', '2023-12-11 06:54:27', NULL, '2023-12-11 06:54:25', '2023-12-11 06:54:27'),
(41, 'App\\Models\\User', 1, 'secret', '60254de7def714ca936b774623fed89a4ba6ee0938a05ef8ef0b5563980a3977', '[\"*\"]', '2023-12-11 06:56:13', NULL, '2023-12-11 06:56:12', '2023-12-11 06:56:13'),
(42, 'App\\Models\\User', 1, 'secret', '2babe95e816659e8ed302e6ccec3b57bace6bd57fdb28030b9316e9bb84c7c68', '[\"*\"]', '2023-12-11 06:59:45', NULL, '2023-12-11 06:59:43', '2023-12-11 06:59:45'),
(43, 'App\\Models\\User', 1, 'secret', 'e96d782edb904e5db4b4f97a7ac1d678fdf201241fb2d2b6ef60e2abb4e6ecf2', '[\"*\"]', '2023-12-11 07:01:48', NULL, '2023-12-11 07:01:47', '2023-12-11 07:01:48'),
(44, 'App\\Models\\User', 1, 'secret', '60366f950517082b8313feeb1eb63d64ce56c0ca2987527a6406edff32eb20c9', '[\"*\"]', '2023-12-11 07:05:07', NULL, '2023-12-11 07:05:06', '2023-12-11 07:05:07'),
(45, 'App\\Models\\User', 1, 'secret', 'ff75a4b95c566e78aa736a7f95625cac498823198b7c43c96e9e0ba341b171ba', '[\"*\"]', '2023-12-11 07:08:22', NULL, '2023-12-11 07:08:20', '2023-12-11 07:08:22'),
(46, 'App\\Models\\User', 1, 'secret', '2d96da4892732cb719e70168bf3b8f83c723ca36a98b3588128e629f58129abf', '[\"*\"]', '2023-12-11 07:11:17', NULL, '2023-12-11 07:11:16', '2023-12-11 07:11:17'),
(47, 'App\\Models\\User', 1, 'secret', '752cd7243b07d49fd5b84944f10e0906a05a4f1e91c44da8680beb4b0e56f0e4', '[\"*\"]', '2023-12-11 07:16:50', NULL, '2023-12-11 07:16:49', '2023-12-11 07:16:50'),
(48, 'App\\Models\\User', 1, 'secret', '9d2133c65a5ad3cd842b72eecafdcbdbd5399f294719b2eaa92459d5efefbb61', '[\"*\"]', '2023-12-11 07:25:49', NULL, '2023-12-11 07:25:48', '2023-12-11 07:25:49'),
(49, 'App\\Models\\User', 1, 'secret', '861070d5a95cc6c43f878324d3df34ed08370ce712544b200ed4c2e5072da564', '[\"*\"]', NULL, NULL, '2023-12-11 18:53:03', '2023-12-11 18:53:03'),
(50, 'App\\Models\\User', 1, 'secret', '5dd27a1f84c1154593e85c6389476b0a09c7a8469c773561bf4f4fe76a6ae07b', '[\"*\"]', '2023-12-11 18:53:06', NULL, '2023-12-11 18:53:04', '2023-12-11 18:53:06'),
(51, 'App\\Models\\User', 1, 'secret', 'dc70668c1b304ae62b645229adabbf1841c7d04fae5a5fdef22494500b893426', '[\"*\"]', '2023-12-11 19:03:19', NULL, '2023-12-11 19:03:17', '2023-12-11 19:03:19'),
(52, 'App\\Models\\User', 1, 'secret', 'd9e80375fbe18a7cb242bc12e7bd95876a090dee6c15e1692cbb3d45998f00e5', '[\"*\"]', '2023-12-11 19:06:29', NULL, '2023-12-11 19:06:28', '2023-12-11 19:06:29'),
(53, 'App\\Models\\User', 1, 'secret', '44c3f99d0fac0257a80053339a198ec34d58b0107330a9172a87c57e3ae37a12', '[\"*\"]', '2023-12-11 19:08:26', NULL, '2023-12-11 19:08:25', '2023-12-11 19:08:26'),
(54, 'App\\Models\\User', 1, 'secret', '9641f7bc8924041b6d865fa25bf5f82446157414d76c09caddfa3f329c96ecb7', '[\"*\"]', '2023-12-11 19:10:23', NULL, '2023-12-11 19:10:23', '2023-12-11 19:10:23'),
(55, 'App\\Models\\User', 1, 'secret', '9b27c7c1759d518ea6a556c4d57f8f221777e103d1046312f9d4eb4404f52a9a', '[\"*\"]', '2023-12-11 19:11:47', NULL, '2023-12-11 19:11:46', '2023-12-11 19:11:47'),
(56, 'App\\Models\\User', 1, 'secret', '64968965d915471356c8c66bff2d3a6e268c8bcd93932d969e636e0500dcbf8f', '[\"*\"]', '2023-12-11 19:13:34', NULL, '2023-12-11 19:13:33', '2023-12-11 19:13:34'),
(57, 'App\\Models\\User', 1, 'secret', 'ec5e767f94d497ab8f8db133e6e289743771b716e8e8f1cfece79abb41889d62', '[\"*\"]', '2023-12-11 19:15:55', NULL, '2023-12-11 19:15:54', '2023-12-11 19:15:55'),
(58, 'App\\Models\\User', 1, 'secret', '8e6d59d3ec8f6c817ed4b4adbc0bd374adfc6cfac24e2cc63d706994f9abc066', '[\"*\"]', '2023-12-11 19:18:04', NULL, '2023-12-11 19:18:03', '2023-12-11 19:18:04'),
(59, 'App\\Models\\User', 1, 'secret', '07763d9c503f2b1dc40af2df55352bb9fd04074dd850a4c921d172a87429fa41', '[\"*\"]', '2023-12-11 19:19:34', NULL, '2023-12-11 19:19:33', '2023-12-11 19:19:34'),
(60, 'App\\Models\\User', 1, 'secret', '0c92d46c2ecd26b67d3c1e536381893637edd2a5d031e50fdcd730b70864ab5e', '[\"*\"]', '2023-12-11 19:20:23', NULL, '2023-12-11 19:20:22', '2023-12-11 19:20:23'),
(61, 'App\\Models\\User', 1, 'secret', '43f801b3b555fa75603fec722da889b721deec8af40a2c9472c619617c69ff39', '[\"*\"]', '2023-12-11 19:21:05', NULL, '2023-12-11 19:21:04', '2023-12-11 19:21:05'),
(62, 'App\\Models\\User', 1, 'secret', 'b9acddcdd7655385dc4c05430e0b548200e964c758fb1b53f3087f54eef1de05', '[\"*\"]', '2023-12-11 19:26:16', NULL, '2023-12-11 19:26:15', '2023-12-11 19:26:16'),
(63, 'App\\Models\\User', 1, 'secret', 'a1825bbe8c5644f4c13167db259e71cc7377cdce8bb9215382b421deb50a14f1', '[\"*\"]', '2023-12-11 19:26:50', NULL, '2023-12-11 19:26:35', '2023-12-11 19:26:50'),
(64, 'App\\Models\\User', 1, 'secret', '3da9a429542770ddac06bb9314cd18ed7d8d8b2bd049f05bdeffe8d40e5dbcaf', '[\"*\"]', '2023-12-11 19:36:47', NULL, '2023-12-11 19:36:46', '2023-12-11 19:36:47'),
(65, 'App\\Models\\User', 1, 'secret', 'bdce84f26fc4039c081628c976221521dc842c4cd82de6cd4503c948c0cba603', '[\"*\"]', '2023-12-11 19:37:43', NULL, '2023-12-11 19:37:42', '2023-12-11 19:37:43'),
(66, 'App\\Models\\User', 1, 'secret', '671ff4036048f482e9e99ab42d110661ad2d85ddec77034efb98eeff36f1964f', '[\"*\"]', '2023-12-11 19:39:17', NULL, '2023-12-11 19:39:16', '2023-12-11 19:39:17'),
(67, 'App\\Models\\User', 1, 'secret', 'aeea0077dc7b1be9a7c4f021f0e2da8d3927a7360a19f9216b1e529b3f7a109f', '[\"*\"]', '2023-12-11 19:42:30', NULL, '2023-12-11 19:42:29', '2023-12-11 19:42:30'),
(68, 'App\\Models\\User', 1, 'secret', '1c291de20bac1d082695c56eee22e7c6b01e9d718f61fa432399d94e69da719b', '[\"*\"]', '2023-12-11 19:47:23', NULL, '2023-12-11 19:47:22', '2023-12-11 19:47:23'),
(69, 'App\\Models\\User', 1, 'secret', '7f8de4025d599de6662eba33121d4486c480a51d2704a81713d4a4ce005a3b20', '[\"*\"]', '2023-12-11 19:50:30', NULL, '2023-12-11 19:50:29', '2023-12-11 19:50:30'),
(70, 'App\\Models\\User', 1, 'secret', 'dc0e2d1f2ceed0d8e88d2c9b8e0263760a301101307b5f69455fe6496e685656', '[\"*\"]', '2023-12-11 19:52:21', NULL, '2023-12-11 19:52:20', '2023-12-11 19:52:21'),
(71, 'App\\Models\\User', 1, 'secret', '5daa189247a5d9314c77c38c6cd9cefd96c1f3b55885f4d3b933c0825461bcf1', '[\"*\"]', NULL, NULL, '2023-12-11 19:55:41', '2023-12-11 19:55:41'),
(72, 'App\\Models\\User', 1, 'secret', '0e55aa167629a9e86d57d4657de8f652ab4cad77da71fbbe4cc12c99c890c136', '[\"*\"]', NULL, NULL, '2023-12-11 19:56:45', '2023-12-11 19:56:45'),
(73, 'App\\Models\\User', 1, 'secret', '565de9a744912c08f371928908e29b8388cbc695b2555cd39e75897435040410', '[\"*\"]', '2023-12-11 19:59:03', NULL, '2023-12-11 19:59:02', '2023-12-11 19:59:03'),
(74, 'App\\Models\\User', 1, 'secret', 'b93d53de5700decc956fdeb6bd2692a13738da681a5dd714b08570b6e4f969ef', '[\"*\"]', '2023-12-11 20:04:10', NULL, '2023-12-11 20:04:09', '2023-12-11 20:04:10'),
(75, 'App\\Models\\User', 1, 'secret', '36d93e264b901958794ab00e782ee25fc18470872502b2a97d9a40ac4b06d466', '[\"*\"]', '2023-12-11 20:12:49', NULL, '2023-12-11 20:12:40', '2023-12-11 20:12:49'),
(76, 'App\\Models\\User', 1, 'secret', '528919c74c5c8ae96f8bece81a478768fb5c6c7c93ef3dc2535c8db8766ed085', '[\"*\"]', '2023-12-11 20:20:59', NULL, '2023-12-11 20:20:52', '2023-12-11 20:20:59'),
(77, 'App\\Models\\User', 1, 'secret', '8a50adf831c654d45a6275342854a606334669795cbe8c98a74487b4b2c0e581', '[\"*\"]', '2023-12-11 20:22:19', NULL, '2023-12-11 20:22:15', '2023-12-11 20:22:19'),
(78, 'App\\Models\\User', 1, 'secret', 'a396ed9e13f0bc35e6c7a345083f8e6aa15e8da06fef667b66aa5a3eea6a8719', '[\"*\"]', '2023-12-11 20:24:56', NULL, '2023-12-11 20:24:38', '2023-12-11 20:24:56'),
(79, 'App\\Models\\User', 1, 'secret', '80c06be833b55959595394adfb213d57171b6b6ff081d22c550df96939d81792', '[\"*\"]', '2023-12-11 20:40:42', NULL, '2023-12-11 20:40:28', '2023-12-11 20:40:42'),
(80, 'App\\Models\\User', 1, 'secret', '1e5be3f94704b287a4b91bf565d99c46ad3e9b39fd14cd565d43af08c8c2a286', '[\"*\"]', '2023-12-11 20:41:56', NULL, '2023-12-11 20:41:47', '2023-12-11 20:41:56'),
(81, 'App\\Models\\User', 1, 'secret', 'd773afac4ea23a1cd26e57ef271b50f205338956c2b242f61038ef670f4cf070', '[\"*\"]', '2023-12-11 20:42:57', NULL, '2023-12-11 20:42:47', '2023-12-11 20:42:57'),
(82, 'App\\Models\\User', 1, 'secret', '500a932d0a47b1bc5e7f236e836c7e2a052a3f2861373ec540abcfdc10b92f06', '[\"*\"]', '2023-12-11 20:55:23', NULL, '2023-12-11 20:50:29', '2023-12-11 20:55:23'),
(83, 'App\\Models\\User', 1, 'secret', '7c18031a39b6a5b8ca6aa52e314e69bf77eef577fce2dc4040626a2224359c61', '[\"*\"]', NULL, NULL, '2023-12-11 20:55:24', '2023-12-11 20:55:24'),
(84, 'App\\Models\\User', 1, 'secret', '05ce685a6e6889397aeb87a86e72c8b1eb8041fce76d59b41b38d13f59eae057', '[\"*\"]', NULL, NULL, '2023-12-11 20:55:24', '2023-12-11 20:55:24'),
(85, 'App\\Models\\User', 1, 'secret', '91f39e2276564539404cbf4438ac4409ddeb3a87959eaed072e89a567791632e', '[\"*\"]', NULL, NULL, '2023-12-11 20:55:24', '2023-12-11 20:55:24'),
(86, 'App\\Models\\User', 1, 'secret', '0562e2ba633a35bee6d93921b92241c713cc282cdedb63f6913d531587045e32', '[\"*\"]', '2023-12-11 20:59:31', NULL, '2023-12-11 20:55:38', '2023-12-11 20:59:31'),
(87, 'App\\Models\\User', 1, 'secret', '09a3d2e9dfd0af005ae7cd821d48ad4344d984c44d740a26c841042f4559ab1a', '[\"*\"]', '2023-12-11 21:03:26', NULL, '2023-12-11 21:03:25', '2023-12-11 21:03:26'),
(88, 'App\\Models\\User', 1, 'secret', '407e1c70df458c7236c82ace5e45398f0e712cc0e45bc3bd82759405a6130415', '[\"*\"]', '2023-12-11 21:17:23', NULL, '2023-12-11 21:16:21', '2023-12-11 21:17:23'),
(89, 'App\\Models\\User', 1, 'secret', '7bc9b18580ac2b3bb78d1905bc067340fe1e9199fa9f74e367c30ee4f077778f', '[\"*\"]', '2023-12-11 21:22:11', NULL, '2023-12-11 21:20:27', '2023-12-11 21:22:11'),
(90, 'App\\Models\\User', 1, 'secret', '797bd0ef5577ed99b65d696e724aee24d2f6e005a2645161c08d681031661f9e', '[\"*\"]', '2023-12-11 21:26:02', NULL, '2023-12-11 21:25:22', '2023-12-11 21:26:02'),
(91, 'App\\Models\\User', 1, 'secret', '89383d4bd735054dafe37a772f412b478ff7bd4199bfee70c651813773b4dae4', '[\"*\"]', '2023-12-11 21:28:22', NULL, '2023-12-11 21:28:04', '2023-12-11 21:28:22'),
(92, 'App\\Models\\User', 1, 'secret', '266610d7615956d4febb077c1b2613f1fb52c852f0a1a739e5e3f504f3fd0949', '[\"*\"]', '2023-12-11 21:30:02', NULL, '2023-12-11 21:29:43', '2023-12-11 21:30:02'),
(93, 'App\\Models\\User', 1, 'secret', '78c2aa76313e08d5ea452f5a069082d45c0e8e64de6b24305fa8d58d57992602', '[\"*\"]', '2023-12-11 21:30:29', NULL, '2023-12-11 21:30:17', '2023-12-11 21:30:29'),
(94, 'App\\Models\\User', 1, 'secret', 'dad6c5fae2280ad95ec308330c68daef4e6b60cb309e40e31a123b7ad2c967b3', '[\"*\"]', '2023-12-11 21:34:50', NULL, '2023-12-11 21:32:23', '2023-12-11 21:34:50'),
(95, 'App\\Models\\User', 1, 'secret', '67363867cbd29f6c4b05cf95cfb89f87819f6765a468c5707d8939e59b6c5b6a', '[\"*\"]', '2023-12-11 21:38:04', NULL, '2023-12-11 21:36:09', '2023-12-11 21:38:04'),
(96, 'App\\Models\\User', 1, 'secret', '907f25f2cc1893213d7be5a71b7cbc05d066213b13050f385225706885082cd8', '[\"*\"]', '2023-12-11 21:38:37', NULL, '2023-12-11 21:38:30', '2023-12-11 21:38:37'),
(97, 'App\\Models\\User', 1, 'secret', '8d7c2fb515e10a2fdf95194ce336345b7eb05a300c016aaa702e9bb774c79895', '[\"*\"]', '2023-12-11 21:38:56', NULL, '2023-12-11 21:38:55', '2023-12-11 21:38:56'),
(98, 'App\\Models\\User', 1, 'secret', 'd916be78b3cb77612f7af3c595eb2a84b2d7c7700e8f21d4bd7bb45e9fe010ac', '[\"*\"]', '2023-12-11 21:45:48', NULL, '2023-12-11 21:45:32', '2023-12-11 21:45:48'),
(99, 'App\\Models\\User', 1, 'secret', '79636b88de4b9e8c240563e294ec0da41060fb68a5b1dcb6f43f07cd059287c7', '[\"*\"]', '2023-12-11 21:46:41', NULL, '2023-12-11 21:46:05', '2023-12-11 21:46:41'),
(100, 'App\\Models\\User', 1, 'secret', '7cb6958932093c5a01ba0dfc16de4caa593683bb6721404b7e8a38ed22700ae3', '[\"*\"]', '2023-12-11 21:49:17', NULL, '2023-12-11 21:49:03', '2023-12-11 21:49:17'),
(101, 'App\\Models\\User', 1, 'secret', '31fc69500e38058b8fd404f2a43863b6eb664b35620b75d536493c148e1ab7cf', '[\"*\"]', '2023-12-11 21:50:58', NULL, '2023-12-11 21:50:42', '2023-12-11 21:50:58'),
(102, 'App\\Models\\User', 1, 'secret', 'b545b5d9eb3943d233ae7ccd23e6aebdd0839475d9500d9101475e1509e9abb9', '[\"*\"]', '2023-12-11 21:52:35', NULL, '2023-12-11 21:52:10', '2023-12-11 21:52:35'),
(103, 'App\\Models\\User', 1, 'secret', 'dcf6f472e11ccacaa527b3f197dcaab5a29ec4c5ba91d2cf9cc0762603a0867a', '[\"*\"]', '2023-12-11 21:53:45', NULL, '2023-12-11 21:53:32', '2023-12-11 21:53:45'),
(104, 'App\\Models\\User', 1, 'secret', 'aab89fbfc667133b2f42bc5f665615a28a3c5fa6065d6486145a540a3abe728d', '[\"*\"]', '2023-12-11 21:55:16', NULL, '2023-12-11 21:54:59', '2023-12-11 21:55:16'),
(105, 'App\\Models\\User', 1, 'secret', '7e25341b273e7f9863c76653dcab78912b5d1750a040052b98bf6fc245ae615c', '[\"*\"]', '2023-12-11 21:56:51', NULL, '2023-12-11 21:56:39', '2023-12-11 21:56:51'),
(106, 'App\\Models\\User', 1, 'secret', '9186b0a0f5c61d62611744e358a096e832a2801f6704ac369fcce5addf3ca2aa', '[\"*\"]', '2023-12-11 23:17:46', NULL, '2023-12-11 23:13:04', '2023-12-11 23:17:46'),
(107, 'App\\Models\\User', 1, 'secret', '325b94d92ba5cfcc1931e2d9971d6ec3dafae8063864c83fd46c50f061a8f1e2', '[\"*\"]', '2023-12-11 23:19:53', NULL, '2023-12-11 23:19:13', '2023-12-11 23:19:53'),
(108, 'App\\Models\\User', 1, 'secret', 'ee32309d913406f5c30d3c06594c49b67121cbf5f99574293a92375c35ffda05', '[\"*\"]', '2023-12-11 23:22:20', NULL, '2023-12-11 23:22:03', '2023-12-11 23:22:20'),
(109, 'App\\Models\\User', 1, 'secret', '449f8d5b48d6c4ce57ae450245eaa1dc4bceb1db36b0dab05444ae7d18dd03e5', '[\"*\"]', '2023-12-11 23:24:26', NULL, '2023-12-11 23:24:01', '2023-12-11 23:24:26'),
(110, 'App\\Models\\User', 1, 'secret', 'defefb662b276c1726a5efaa4555056ec256477c532d7244206e05a4c38e5bee', '[\"*\"]', '2023-12-11 23:27:31', NULL, '2023-12-11 23:27:11', '2023-12-11 23:27:31'),
(111, 'App\\Models\\User', 1, 'secret', '782a2c34ae121bfa5fdf83384397c2f715285d54ffd760b20f6282db72c8ce34', '[\"*\"]', '2023-12-11 23:31:32', NULL, '2023-12-11 23:27:50', '2023-12-11 23:31:32'),
(112, 'App\\Models\\User', 1, 'secret', 'e8f512954431129ab1c20002b97fb81739d367f20c066d65de3d9bdcdff41ac4', '[\"*\"]', '2023-12-11 23:33:47', NULL, '2023-12-11 23:33:35', '2023-12-11 23:33:47'),
(113, 'App\\Models\\User', 1, 'secret', '2ac109b41e27151f961b90db803cf559ebdb30dbb2d7e171e06a34b57221adbc', '[\"*\"]', '2023-12-11 23:38:55', NULL, '2023-12-11 23:35:54', '2023-12-11 23:38:55'),
(114, 'App\\Models\\User', 1, 'secret', 'e3a5af2f54ccb1cd3702a08430b0ec66d94a70c7dcc2ea9207b704c5b7114214', '[\"*\"]', '2023-12-11 23:54:32', NULL, '2023-12-11 23:44:34', '2023-12-11 23:54:32'),
(115, 'App\\Models\\User', 1, 'secret', '4f74d3c16f89af6d3acc2221952fe9447ffaec9f2490d33df8986fa96b485396', '[\"*\"]', '2023-12-12 00:01:54', NULL, '2023-12-11 23:54:57', '2023-12-12 00:01:54'),
(116, 'App\\Models\\User', 1, 'secret', 'aeb30fe182176f1909be14afb20c6e7ee9f5a7476ed810073ec2ffe12ccdc189', '[\"*\"]', '2023-12-12 00:04:52', NULL, '2023-12-12 00:02:06', '2023-12-12 00:04:52'),
(117, 'App\\Models\\User', 1, 'secret', 'aaae874fcc9be5b9027d6f7773c5350bd36f66d78959dc37a552c3e3b88ab516', '[\"*\"]', '2023-12-12 00:09:42', NULL, '2023-12-12 00:05:14', '2023-12-12 00:09:42'),
(118, 'App\\Models\\User', 1, 'secret', '2ad71574402cbe20b5cb0206666d6546b0aedda9b8ee8b6ba337815ee5e3b63c', '[\"*\"]', '2023-12-12 00:45:20', NULL, '2023-12-12 00:08:54', '2023-12-12 00:45:20'),
(119, 'App\\Models\\User', 1, 'secret', '632a18e008c9c41c47700c62d870a3cb8ffa69c7eae00440e4897eb0fcdeb117', '[\"*\"]', '2023-12-12 00:15:19', NULL, '2023-12-12 00:15:06', '2023-12-12 00:15:19'),
(120, 'App\\Models\\User', 1, 'secret', '3e87a8501df47911d0f85eeb1e96cddb7748d3b53bbd9b4d0d451ccbcd40b97b', '[\"*\"]', '2023-12-12 00:21:04', NULL, '2023-12-12 00:20:50', '2023-12-12 00:21:04'),
(121, 'App\\Models\\User', 1, 'secret', '8f246b4d115a18177462e3b694f57bafc8a2143d0118b94b8279c4556f9f6608', '[\"*\"]', '2023-12-12 00:27:21', NULL, '2023-12-12 00:27:00', '2023-12-12 00:27:21'),
(122, 'App\\Models\\User', 1, 'secret', '7b1bd0b0cab9be47958b9a4b6e6b3d92af4a1d3b27862a35799020053b583669', '[\"*\"]', '2023-12-12 00:33:49', NULL, '2023-12-12 00:33:37', '2023-12-12 00:33:49'),
(123, 'App\\Models\\User', 1, 'secret', 'ea194dd8c5000b5c3d69455519bc533cbdea6763eeb7dd3f4ac3fe2921d82969', '[\"*\"]', '2023-12-12 00:53:33', NULL, '2023-12-12 00:47:51', '2023-12-12 00:53:33'),
(124, 'App\\Models\\User', 1, 'secret', '6c6437cc429428b009ab329d3b32055ebde19593944699a162fd4ae066321d1f', '[\"*\"]', '2023-12-12 00:56:03', NULL, '2023-12-12 00:55:38', '2023-12-12 00:56:03'),
(125, 'App\\Models\\User', 1, 'secret', '783f8befa846d64a418dc17784f405e46d39db939de5899a2e6d15268da8a42f', '[\"*\"]', '2023-12-12 00:57:03', NULL, '2023-12-12 00:56:54', '2023-12-12 00:57:03'),
(126, 'App\\Models\\User', 1, 'secret', '69c2ea322d88ab13380ab51ac388ce9f2a22a4a2b1ece065971a11b0441ce034', '[\"*\"]', '2023-12-12 00:58:21', NULL, '2023-12-12 00:58:07', '2023-12-12 00:58:21'),
(127, 'App\\Models\\User', 1, 'secret', 'f16672e287d79aebad9b627a4275e245ce9a64f9e042423afbc52210019bd240', '[\"*\"]', '2023-12-12 00:59:47', NULL, '2023-12-12 00:59:35', '2023-12-12 00:59:47'),
(128, 'App\\Models\\User', 1, 'secret', '6b04610c72bfedc7befcbd7e8ad44d1e2a2df74b409de82577198d8f0a4f4977', '[\"*\"]', '2023-12-12 01:01:36', NULL, '2023-12-12 01:00:53', '2023-12-12 01:01:36'),
(129, 'App\\Models\\User', 1, 'secret', '42cbbb1945d2de668d48d9a4cda1a866421604247266e5fa172b8b51ae8eab89', '[\"*\"]', '2023-12-12 01:04:25', NULL, '2023-12-12 01:03:44', '2023-12-12 01:04:25'),
(130, 'App\\Models\\User', 1, 'secret', 'aa4029dbd317fe0c1fe3be630b9dd5e130ff8c6a49f0eed70365739e78146102', '[\"*\"]', '2023-12-12 01:07:30', NULL, '2023-12-12 01:06:00', '2023-12-12 01:07:30'),
(131, 'App\\Models\\User', 1, 'secret', 'ce25df2842308bdfc40622ebb4358ed0565bda9ed12363a55af7a1d0ad875525', '[\"*\"]', '2023-12-12 01:07:50', NULL, '2023-12-12 01:07:46', '2023-12-12 01:07:50'),
(132, 'App\\Models\\User', 1, 'secret', '585cb868d925975188267842c4d970c3dc666bebee55876e40a148ccf4a6739a', '[\"*\"]', '2023-12-12 01:10:01', NULL, '2023-12-12 01:08:45', '2023-12-12 01:10:01'),
(133, 'App\\Models\\User', 1, 'secret', 'ca1f3f12509bf8f8d8d300fe257398d28ead5df42e59c1fea62825da60f379d7', '[\"*\"]', '2023-12-12 01:16:05', NULL, '2023-12-12 01:13:55', '2023-12-12 01:16:05'),
(134, 'App\\Models\\User', 1, 'secret', 'cc2faad68636b621b9097d4e2301d60fb925a77a12273fdcf3fcc7705d0e87ba', '[\"*\"]', NULL, NULL, '2023-12-12 01:22:28', '2023-12-12 01:22:28'),
(135, 'App\\Models\\User', 1, 'secret', '6d28207753baf1a8dfe87e2a4d3fa6b8fad028c039edc541d1e5a2da142f982e', '[\"*\"]', NULL, NULL, '2023-12-12 01:22:28', '2023-12-12 01:22:28'),
(136, 'App\\Models\\User', 1, 'secret', 'c6b27f5e7552f0db1117255b187a74a696c5747853942ef135a4c5c0b230633c', '[\"*\"]', '2023-12-12 01:30:44', NULL, '2023-12-12 01:22:42', '2023-12-12 01:30:44'),
(137, 'App\\Models\\User', 1, 'secret', '0459893915c0ce45afcf3287e1c0ad214fb2d69768bdece70421c1b565aae27d', '[\"*\"]', '2023-12-12 01:42:07', NULL, '2023-12-12 01:41:46', '2023-12-12 01:42:07'),
(138, 'App\\Models\\User', 1, 'secret', '066714c7b42a46aed4a43bd50f9490ff67278c27519adde15856b9da721d3dd2', '[\"*\"]', '2023-12-12 01:43:29', NULL, '2023-12-12 01:43:06', '2023-12-12 01:43:29'),
(139, 'App\\Models\\User', 1, 'secret', 'd8dfe5a6517ab3e4dd0f244d34ae4efbc172e3d089b6e8d5f61afb8fd3b9fcef', '[\"*\"]', '2023-12-12 01:47:10', NULL, '2023-12-12 01:46:09', '2023-12-12 01:47:10'),
(140, 'App\\Models\\User', 1, 'secret', '30335602c3c2bf5ab91ede2cff937bab178041121575b135f9ca9455b48a81df', '[\"*\"]', '2023-12-12 01:49:01', NULL, '2023-12-12 01:48:45', '2023-12-12 01:49:01'),
(141, 'App\\Models\\User', 1, 'secret', '0381763b7a5095cce5fb0f980c79215ff5021cf68a6541f1a93dd8dc8925f03b', '[\"*\"]', '2023-12-12 01:52:19', NULL, '2023-12-12 01:52:13', '2023-12-12 01:52:19'),
(142, 'App\\Models\\User', 1, 'secret', 'b81eae68ada8ec2434d8d8585ec2a9157e658f5cc2165326acd6b0d787798ef6', '[\"*\"]', '2023-12-12 02:00:00', NULL, '2023-12-12 01:59:40', '2023-12-12 02:00:00'),
(143, 'App\\Models\\User', 1, 'secret', '96deef2adecb8cbdd87746674642eb0b70bd415d85d6b3a5689ffd9a2da2c3e7', '[\"*\"]', '2023-12-12 02:05:45', NULL, '2023-12-12 02:03:02', '2023-12-12 02:05:45'),
(144, 'App\\Models\\User', 1, 'secret', 'f8565b16250e8dca2cee05583c9daf256143fb0916060a39122ba1a12afebb95', '[\"*\"]', NULL, NULL, '2023-12-12 02:07:19', '2023-12-12 02:07:19'),
(145, 'App\\Models\\User', 1, 'secret', '8eb20e0e3a8e2353ee5522f897aae5e4ed8c7949bbbf976286e4927cecc897e7', '[\"*\"]', NULL, NULL, '2023-12-12 02:17:06', '2023-12-12 02:17:06'),
(146, 'App\\Models\\User', 1, 'secret', '69ea47737fa5c24f2821b86f506b957b22eae6d9fc0d205cda35339059cc2fda', '[\"*\"]', '2023-12-12 06:04:22', NULL, '2023-12-12 06:04:10', '2023-12-12 06:04:22'),
(147, 'App\\Models\\User', 2, 'Personal Access Token', 'e31723a34d8b544c5abb1de5d6d681ab34e09d80eb7b15283963ec33c3bff3fc', '[\"*\"]', '2023-12-12 06:05:25', NULL, '2023-12-12 06:05:12', '2023-12-12 06:05:25'),
(148, 'App\\Models\\User', 1, 'secret', 'a72434426800dd63b9a5f18dd119a6516435f97b449c1cdb36f84ca064d3090e', '[\"*\"]', '2023-12-12 06:05:39', NULL, '2023-12-12 06:05:38', '2023-12-12 06:05:39'),
(149, 'App\\Models\\User', 2, 'secret', '20bd1e0e389147f589b57c947851a8e4ad036aa820704e614921c347dae83d05', '[\"*\"]', NULL, NULL, '2023-12-12 06:07:51', '2023-12-12 06:07:51'),
(150, 'App\\Models\\User', 2, 'secret', '4a5cccd2e9495d226e09376c94accc0e82c94b00da2c3c65a454f3d2a8a22e84', '[\"*\"]', '2023-12-12 06:37:32', NULL, '2023-12-12 06:34:21', '2023-12-12 06:37:32'),
(151, 'App\\Models\\User', 1, 'secret', '9437bf4668001835d52d8f2d314b5853112f1bf18ad86b5e36b73c98d6c46b94', '[\"*\"]', '2023-12-12 08:30:12', NULL, '2023-12-12 08:30:09', '2023-12-12 08:30:12'),
(152, 'App\\Models\\User', 1, 'secret', 'f6ee6d45c6a0b4e15dd7bf8c2307a7ede7bc43cf8508bd89f222acb0468b5384', '[\"*\"]', '2023-12-12 08:35:32', NULL, '2023-12-12 08:31:16', '2023-12-12 08:35:32'),
(153, 'App\\Models\\User', 1, 'secret', '02f0bcae5dc7c6398b27e24b2ac4d23b1a436a50146d27ea743cfaedeab20bd8', '[\"*\"]', '2023-12-12 08:49:49', NULL, '2023-12-12 08:42:24', '2023-12-12 08:49:49'),
(154, 'App\\Models\\User', 1, 'secret', 'bcea1cf42e02f9f487e20cb172fe905ce152f60242cafea354bc31c3f2a9320e', '[\"*\"]', '2023-12-12 08:58:03', NULL, '2023-12-12 08:57:41', '2023-12-12 08:58:03'),
(155, 'App\\Models\\User', 1, 'secret', '07a933e782a74acd8c81eeec09e438bd69e5ae7815a24db5f6ee2b46c2e13cc9', '[\"*\"]', '2023-12-12 09:03:27', NULL, '2023-12-12 09:03:23', '2023-12-12 09:03:27'),
(156, 'App\\Models\\User', 1, 'secret', '6d61f02c1cdb2de35d1e4dfe138c123e083eb013e3dab78044022d30c01a5073', '[\"*\"]', '2023-12-12 09:05:51', NULL, '2023-12-12 09:05:50', '2023-12-12 09:05:51'),
(157, 'App\\Models\\User', 2, 'secret', 'b3c8ff794efd7ad1f8f7597a8f2fcc3576f15de8970c4cd8ebb382027f145465', '[\"*\"]', '2023-12-12 18:31:24', NULL, '2023-12-12 18:31:04', '2023-12-12 18:31:24'),
(158, 'App\\Models\\User', 2, 'secret', 'b997c2f6d408391d2df2f38d753d3e96fa2e06115d0d5528fe401ff36273e8bb', '[\"*\"]', '2023-12-12 18:32:19', NULL, '2023-12-12 18:32:11', '2023-12-12 18:32:19'),
(159, 'App\\Models\\User', 2, 'secret', '93fbb22a27a43de8d79ce49d2708c0d8dc1a19cf124b99eab8449859b5670388', '[\"*\"]', '2023-12-12 18:34:14', NULL, '2023-12-12 18:34:05', '2023-12-12 18:34:14'),
(160, 'App\\Models\\User', 2, 'secret', 'f1464321504c3c80f7e410893cb5bd58cb915c46447b79234774bdf28336005f', '[\"*\"]', '2023-12-12 18:35:33', NULL, '2023-12-12 18:35:27', '2023-12-12 18:35:33'),
(161, 'App\\Models\\User', 2, 'secret', '6ecdeca25067d6f61f9923e044cd908642f6343c1d1595b405951c85d881bc3d', '[\"*\"]', '2023-12-12 18:39:07', NULL, '2023-12-12 18:39:01', '2023-12-12 18:39:07'),
(162, 'App\\Models\\User', 2, 'secret', 'a10ef6cf9cd506e7e8bb97ec7347629e7a86730c23188a5efe8b8f74fdf32248', '[\"*\"]', '2023-12-12 18:44:16', NULL, '2023-12-12 18:41:50', '2023-12-12 18:44:16'),
(163, 'App\\Models\\User', 1, 'secret', 'f2cc4563b7f38dd97d8708e1888da4fce56913701456c23e859788d204fb0c37', '[\"*\"]', '2023-12-12 18:53:49', NULL, '2023-12-12 18:53:36', '2023-12-12 18:53:49'),
(164, 'App\\Models\\User', 2, 'secret', '3c9ee2d8a81261724215ac42d926d4670d9c7a42d1ef61e3b34a8e85322391fa', '[\"*\"]', '2023-12-12 18:55:06', NULL, '2023-12-12 18:54:02', '2023-12-12 18:55:06'),
(165, 'App\\Models\\User', 2, 'secret', '6857cad26988cd46bdb5b9a16e25329c34bee85aab6751fcfeb95f89509bc6c0', '[\"*\"]', '2023-12-12 19:13:05', NULL, '2023-12-12 19:12:51', '2023-12-12 19:13:05'),
(166, 'App\\Models\\User', 2, 'secret', '2276783afb27a0a9382bd5d7f514e8cc714dfe7a4f78114cd46b967c6d162afa', '[\"*\"]', '2023-12-12 19:17:30', NULL, '2023-12-12 19:17:28', '2023-12-12 19:17:30'),
(167, 'App\\Models\\User', 2, 'secret', '317a20151e62e2ddb8348f8513386a7535704a1d99bf79dd82bb051208901dc8', '[\"*\"]', '2023-12-12 19:18:43', NULL, '2023-12-12 19:18:41', '2023-12-12 19:18:43'),
(168, 'App\\Models\\User', 2, 'secret', '70773caad1fdd88df05b6137c823b67e027133778845e28522d51731ff202cfc', '[\"*\"]', '2023-12-12 19:20:24', NULL, '2023-12-12 19:20:23', '2023-12-12 19:20:24'),
(169, 'App\\Models\\User', 2, 'secret', 'f564d792accbcf8d1ad41a1687894849222bb7be171e69b27079dc54cb5a7b3a', '[\"*\"]', '2023-12-12 19:24:22', NULL, '2023-12-12 19:23:48', '2023-12-12 19:24:22'),
(170, 'App\\Models\\User', 2, 'secret', '2d840966d888ec4bb211d17feb521c68939d826da5668c4d0ce1204a1e9b02d4', '[\"*\"]', '2023-12-12 19:29:48', NULL, '2023-12-12 19:26:35', '2023-12-12 19:29:48'),
(171, 'App\\Models\\User', 1, 'secret', 'e020a745ed67606392338549fb5701f759351e82b76ebd603dd5c32947d74f74', '[\"*\"]', NULL, NULL, '2023-12-12 19:30:45', '2023-12-12 19:30:45'),
(172, 'App\\Models\\User', 1, 'secret', '2fc56a6f5d5e848ff2a59226b888b50fecbe9244fd85ea0683ca2970caada998', '[\"*\"]', '2023-12-12 19:30:47', NULL, '2023-12-12 19:30:46', '2023-12-12 19:30:47'),
(173, 'App\\Models\\User', 2, 'secret', '8f1281496316bd0fc34782f339c4d7ca5594043f86189e953857e402ac3d0947', '[\"*\"]', '2023-12-12 19:53:00', NULL, '2023-12-12 19:52:57', '2023-12-12 19:53:00'),
(174, 'App\\Models\\User', 2, 'secret', '547eec96b8ce0d5e557d451ce75a2de6238d3b365e464f489d1fa506631e0dd4', '[\"*\"]', '2023-12-12 19:53:59', NULL, '2023-12-12 19:53:57', '2023-12-12 19:53:59'),
(175, 'App\\Models\\User', 2, 'secret', 'edd4a4e81e6e988cbc94158f4bfb4fca6063fbcefef2a468a3872dc1a1af4068', '[\"*\"]', '2023-12-12 19:54:54', NULL, '2023-12-12 19:54:54', '2023-12-12 19:54:54'),
(176, 'App\\Models\\User', 2, 'secret', '5539353d473b4fc61423a033d7c9356dc3030a8fe76ace55a6215433d3368091', '[\"*\"]', NULL, NULL, '2023-12-12 19:56:18', '2023-12-12 19:56:18'),
(177, 'App\\Models\\User', 2, 'secret', '325d99f6f5b2ad308cf194c3cfc60af0035411d5fdae889a78d79451256736b9', '[\"*\"]', '2023-12-12 20:04:44', NULL, '2023-12-12 19:58:36', '2023-12-12 20:04:44'),
(178, 'App\\Models\\User', 2, 'secret', 'e40e21604d3c369f9563c6399fdee3d936bdfff1a109e0d43e68dd2722dc9d6d', '[\"*\"]', '2023-12-12 20:16:17', NULL, '2023-12-12 20:16:05', '2023-12-12 20:16:17'),
(179, 'App\\Models\\User', 2, 'secret', 'dd6a418eab21ae913631567d447bfb8c2627327d03b4adcfddea92f47ed623ef', '[\"*\"]', '2023-12-12 20:18:10', NULL, '2023-12-12 20:18:09', '2023-12-12 20:18:10'),
(180, 'App\\Models\\User', 2, 'secret', '17d7ada53a72de63b5eda5a81e4078c342d03a61e11b171bfbd334e5a7a80c96', '[\"*\"]', '2023-12-12 20:19:06', NULL, '2023-12-12 20:19:05', '2023-12-12 20:19:06'),
(181, 'App\\Models\\User', 2, 'secret', 'ae27628a3341652b7327c28fcbf69d32bbe440150079fb3b435f9d2f7ecb080c', '[\"*\"]', '2023-12-12 21:01:48', NULL, '2023-12-12 20:21:02', '2023-12-12 21:01:48'),
(182, 'App\\Models\\User', 2, 'secret', 'a3bcb182a12b65ac12670ece61cbcaa17a9d5ac0b8c72938c2de19c3b2849a8b', '[\"*\"]', '2023-12-12 20:22:19', NULL, '2023-12-12 20:22:18', '2023-12-12 20:22:19'),
(183, 'App\\Models\\User', 2, 'secret', 'b1147063a655e54c2e92c22c6a26633e0542fe0906893ed820410976b1b0a6d6', '[\"*\"]', '2023-12-12 20:25:53', NULL, '2023-12-12 20:25:51', '2023-12-12 20:25:53'),
(184, 'App\\Models\\User', 2, 'secret', '57827ed58bdaf9e4eac21d9fd40c3fccf2096882c4c646e02e8916362e7455f7', '[\"*\"]', '2023-12-12 20:27:10', NULL, '2023-12-12 20:27:09', '2023-12-12 20:27:10'),
(185, 'App\\Models\\User', 1, 'secret', 'd9f15c595b5859d980e2e72b48c10593199c43d732d6a8ccb3e9b775d8fd9321', '[\"*\"]', '2023-12-12 20:28:06', NULL, '2023-12-12 20:27:25', '2023-12-12 20:28:06'),
(186, 'App\\Models\\User', 2, 'secret', '0f5e592eb208cc35d8bc1d7ec3de9f89220df68e5f241cd8909fb1ba7d40817a', '[\"*\"]', '2023-12-12 20:30:33', NULL, '2023-12-12 20:30:32', '2023-12-12 20:30:33'),
(187, 'App\\Models\\User', 1, 'secret', 'c069375b22cacc2e117b716937959e9753e63c5d3a127824e6d4dbb1e997f747', '[\"*\"]', '2023-12-12 20:35:27', NULL, '2023-12-12 20:30:48', '2023-12-12 20:35:27'),
(188, 'App\\Models\\User', 1, 'secret', 'c232b3881646f27584b3593fc6cf33a3bd015e2b6c1c3f01bb8800eca2aaeed3', '[\"*\"]', '2023-12-12 20:37:04', NULL, '2023-12-12 20:37:03', '2023-12-12 20:37:04'),
(189, 'App\\Models\\User', 1, 'secret', '61be8e7436303e5635f823d9df1422ac44e97d764e860f28128c30d7a97574cf', '[\"*\"]', '2023-12-12 20:39:18', NULL, '2023-12-12 20:38:16', '2023-12-12 20:39:18'),
(190, 'App\\Models\\User', 1, 'secret', '9b4e6f06d286f543b0f268da2aa1a9bfd2f9636a6400a054f862fe7609150b1b', '[\"*\"]', '2023-12-12 20:40:23', NULL, '2023-12-12 20:40:22', '2023-12-12 20:40:23'),
(191, 'App\\Models\\User', 2, 'secret', 'bcbb26a6f75cb0076488dab1c44d8138887f4899e86f97c2f756f72a52008d36', '[\"*\"]', '2023-12-12 20:40:43', NULL, '2023-12-12 20:40:42', '2023-12-12 20:40:43'),
(192, 'App\\Models\\User', 2, 'secret', 'b30654c5ecf0a1f4cfcded8414650e549d5bdbbc13a0d91660834fa4d32ab7dc', '[\"*\"]', '2023-12-12 20:43:17', NULL, '2023-12-12 20:42:50', '2023-12-12 20:43:17'),
(193, 'App\\Models\\User', 2, 'secret', '9f74377e3dd0fa9685619f89de0b8b9d1e6a6ea5edb3d84c676f4680d2ab1e21', '[\"*\"]', '2023-12-12 20:59:20', NULL, '2023-12-12 20:46:36', '2023-12-12 20:59:20'),
(194, 'App\\Models\\User', 2, 'secret', '088e2939905a986730592ed542f55860fe6d804b7b839f673c36fad418abf129', '[\"*\"]', '2023-12-12 21:03:15', NULL, '2023-12-12 21:00:06', '2023-12-12 21:03:15'),
(195, 'App\\Models\\User', 1, 'secret', 'ab679f0f4d5c80e7f2c9161ce16c486f35beb1cf8e277163e24d565142cbd221', '[\"*\"]', '2023-12-12 21:03:49', NULL, '2023-12-12 21:03:47', '2023-12-12 21:03:49'),
(196, 'App\\Models\\User', 1, 'secret', '55f4ccf05c2537198226de52c3d47527611f2fd16056a0c1dc546d23e44621bf', '[\"*\"]', '2023-12-12 21:10:43', NULL, '2023-12-12 21:10:40', '2023-12-12 21:10:43'),
(197, 'App\\Models\\User', 1, 'secret', 'ec655c3295f04bb78f867e0dec0fa2a7e0ef1b111db645ff66d493cdb3e2ea09', '[\"*\"]', '2023-12-12 23:31:29', NULL, '2023-12-12 21:17:28', '2023-12-12 23:31:29'),
(198, 'App\\Models\\User', 2, 'secret', '7f53d3822434af47903650ffbf3480d37c0558abb63f98499c3000618cbd8eba', '[\"*\"]', '2023-12-12 21:23:27', NULL, '2023-12-12 21:23:19', '2023-12-12 21:23:27'),
(199, 'App\\Models\\User', 2, 'secret', '9dcad9515a5349a36d86288622494f887a436d0da705c906f8c04eac78907afd', '[\"*\"]', '2023-12-12 21:35:20', NULL, '2023-12-12 21:31:31', '2023-12-12 21:35:20'),
(200, 'App\\Models\\User', 2, 'secret', 'e960b16b0c03598b25cbe864996077555bb8b934b582ce84f3ace0b80c24c43d', '[\"*\"]', '2023-12-12 21:35:50', NULL, '2023-12-12 21:35:49', '2023-12-12 21:35:50'),
(201, 'App\\Models\\User', 2, 'secret', '6e3a4a796ccb2ec933ac653459144e0c5f204fd0a224924befb99d6e07a781b2', '[\"*\"]', '2023-12-12 21:37:04', NULL, '2023-12-12 21:37:03', '2023-12-12 21:37:04'),
(202, 'App\\Models\\User', 2, 'secret', '59817c6623ddb9b400014be0902801d069ac78a511d86833798138b694b0745c', '[\"*\"]', '2023-12-12 21:39:38', NULL, '2023-12-12 21:39:06', '2023-12-12 21:39:38'),
(203, 'App\\Models\\User', 2, 'secret', 'ea32e3778d9bfd90b48d5e515532592afff570e5d0f7885a08beb5b24d12cc89', '[\"*\"]', '2023-12-12 21:40:35', NULL, '2023-12-12 21:40:34', '2023-12-12 21:40:35'),
(204, 'App\\Models\\User', 1, 'secret', '722d0f724aed941679f141fbce4f03e052b93e171ae7d2e56117daa6ad544db1', '[\"*\"]', '2023-12-12 21:40:46', NULL, '2023-12-12 21:40:45', '2023-12-12 21:40:46'),
(205, 'App\\Models\\User', 2, 'secret', 'e66cd383076203cdbb202e1b4d33a649cbe64cfc648dfe5bd99a9c2d53457490', '[\"*\"]', '2023-12-12 21:43:51', NULL, '2023-12-12 21:43:50', '2023-12-12 21:43:51'),
(206, 'App\\Models\\User', 2, 'secret', 'bf86a752660cbe76a1e32b738e45b19803f739703c3caccfdf59458a6885e364', '[\"*\"]', '2023-12-12 21:45:01', NULL, '2023-12-12 21:45:00', '2023-12-12 21:45:01'),
(207, 'App\\Models\\User', 2, 'secret', 'ae3e309a9728578d494058cd4f6fbefbd50ed880d12d4612a84901873e2a036c', '[\"*\"]', '2023-12-12 21:47:18', NULL, '2023-12-12 21:47:17', '2023-12-12 21:47:18'),
(208, 'App\\Models\\User', 2, 'secret', 'f8f4e5f2717cba3604ba76375f5c0b62adfcfde5ed8f706d45f4ac8a7f75248b', '[\"*\"]', '2023-12-12 23:24:53', NULL, '2023-12-12 21:49:24', '2023-12-12 23:24:53'),
(209, 'App\\Models\\User', 2, 'secret', '16704ed689d6b4326df888cdaaa815f429772988264db781907a421ecf93caae', '[\"*\"]', '2023-12-12 23:43:46', NULL, '2023-12-12 23:36:07', '2023-12-12 23:43:46'),
(210, 'App\\Models\\User', 2, 'secret', 'fa2311dec5581306efdf3ad00794f0d1df349a6be46806544d8d94b68f2043e4', '[\"*\"]', '2023-12-13 00:22:39', NULL, '2023-12-13 00:22:36', '2023-12-13 00:22:39'),
(211, 'App\\Models\\User', 2, 'secret', '2fcced0fa1fe0219ff33289413e8a218941b0e5704baaad43e39fabe2385304f', '[\"*\"]', '2023-12-13 00:33:02', NULL, '2023-12-13 00:32:59', '2023-12-13 00:33:02'),
(212, 'App\\Models\\User', 2, 'secret', '805db25b4784e0f2f23c3784de3d2c21854042f682036266bbe25e023024bf91', '[\"*\"]', '2023-12-13 00:43:27', NULL, '2023-12-13 00:41:19', '2023-12-13 00:43:27'),
(213, 'App\\Models\\User', 2, 'secret', '821830f3246d94bbb0c485f748e3ba994073babbfb2e51ab1118a83e1ba9cb8a', '[\"*\"]', '2023-12-13 01:02:07', NULL, '2023-12-13 01:00:34', '2023-12-13 01:02:07'),
(214, 'App\\Models\\User', 2, 'secret', '74c0c496777b6680188804681c655ebeb7d10c4a64049f60e831806b28e91a63', '[\"*\"]', '2023-12-13 01:04:25', NULL, '2023-12-13 01:03:25', '2023-12-13 01:04:25'),
(215, 'App\\Models\\User', 2, 'secret', '29621a636b76ad212c189eaf99dde083b6ce3bbb23654d5f6b596a87693df952', '[\"*\"]', '2023-12-13 01:06:37', NULL, '2023-12-13 01:06:03', '2023-12-13 01:06:37'),
(216, 'App\\Models\\User', 2, 'secret', '99260e847501b11e1871199ec7565fdedbf1041eb818621bbf671f4c0ab544d7', '[\"*\"]', '2023-12-13 01:17:24', NULL, '2023-12-13 01:10:51', '2023-12-13 01:17:24'),
(217, 'App\\Models\\User', 1, 'secret', '2e3eeb949c4d631d605064a4edcc0576917a0935031f9a076e39fc447cfc50e5', '[\"*\"]', '2023-12-13 01:17:51', NULL, '2023-12-13 01:17:41', '2023-12-13 01:17:51'),
(218, 'App\\Models\\User', 1, 'secret', '5da25e4eaced2f1647e089655bf3ca544bf595e66b9dd94b77fd0a06596d88ce', '[\"*\"]', '2023-12-13 01:21:25', NULL, '2023-12-13 01:19:53', '2023-12-13 01:21:25'),
(219, 'App\\Models\\User', 2, 'secret', 'be3934083b0ae0e028a8fe4ca856dc48c59ea0e50783b350b1ed7a4a4d2b3b12', '[\"*\"]', '2023-12-13 01:23:33', NULL, '2023-12-13 01:21:35', '2023-12-13 01:23:33'),
(220, 'App\\Models\\User', 2, 'secret', '5d9d555c1c732b78408215483a7fe1edb06d316c8d1dc2ce8c98986042becb61', '[\"*\"]', '2023-12-13 01:27:17', NULL, '2023-12-13 01:27:09', '2023-12-13 01:27:17'),
(221, 'App\\Models\\User', 2, 'secret', '9b670d1d44ecf8a5c367995fa71352961a185b8cc6bfadc14c7db38f30cff68e', '[\"*\"]', '2023-12-13 01:28:39', NULL, '2023-12-13 01:28:27', '2023-12-13 01:28:39'),
(222, 'App\\Models\\User', 1, 'secret', '1d2f8456ba2c703ca8638e6527267964acbb9c24430c23f9da96f1aadf263888', '[\"*\"]', '2023-12-13 01:32:09', NULL, '2023-12-13 01:31:50', '2023-12-13 01:32:09'),
(223, 'App\\Models\\User', 1, 'secret', '998cd9968e89004f0dccf6e9bea65bd9f4bd1ed67fd77b6e3df7d6a857c2f1d4', '[\"*\"]', '2023-12-13 01:33:35', NULL, '2023-12-13 01:33:32', '2023-12-13 01:33:35'),
(224, 'App\\Models\\User', 1, 'secret', '0b5b178cfcc0ac0f1ea5b3d20a207b8e4963fa05d6bceb7caa81df95d10071bf', '[\"*\"]', '2023-12-13 01:39:34', NULL, '2023-12-13 01:39:32', '2023-12-13 01:39:34'),
(225, 'App\\Models\\User', 1, 'secret', 'd70f1afc96757c005ff9ac486a0b44a7a012c472c45774231d875707179ed2f3', '[\"*\"]', '2023-12-13 01:41:02', NULL, '2023-12-13 01:41:00', '2023-12-13 01:41:02'),
(226, 'App\\Models\\User', 1, 'secret', 'b7f964c0e68ad2f30b9bb1934c3263cd74cb2482b4ac6367f1c8085bc68b9f56', '[\"*\"]', '2023-12-13 01:45:24', NULL, '2023-12-13 01:45:11', '2023-12-13 01:45:24'),
(227, 'App\\Models\\User', 1, 'secret', '37112dbf5c71f103139fd01ec3fd8db3ba74b75014435a1c568b1a8f471bd492', '[\"*\"]', '2023-12-13 01:47:06', NULL, '2023-12-13 01:46:28', '2023-12-13 01:47:06'),
(228, 'App\\Models\\User', 2, 'secret', '3a43cd141983de616f93f68b21fc905aad92290cb764a2e96803d1a77729efa1', '[\"*\"]', '2023-12-13 01:47:31', NULL, '2023-12-13 01:47:28', '2023-12-13 01:47:31'),
(229, 'App\\Models\\User', 1, 'secret', '449ae976bcbe2cb920ee8bb88edc2d9d54f4957993aa2af32839c3453bb81b93', '[\"*\"]', '2023-12-13 21:09:26', NULL, '2023-12-13 21:07:43', '2023-12-13 21:09:26'),
(230, 'App\\Models\\User', 1, 'secret', '0c94c8266c19d059e1c9d95ef15338670ee38e1c72111e80bc11f53b0adc810d', '[\"*\"]', '2023-12-14 02:44:37', NULL, '2023-12-14 02:36:47', '2023-12-14 02:44:37'),
(231, 'App\\Models\\User', 1, 'secret', 'ca7c6f8b938067ef4c0dad2bb6877fbac201c2609ceba98cc010801bae4bac90', '[\"*\"]', NULL, NULL, '2023-12-14 02:53:00', '2023-12-14 02:53:00'),
(232, 'App\\Models\\User', 1, 'secret', '2b98b01f01b5464672b221bc7b62d0a97fdf12cbc550dbdb04b1f720cab5f4d4', '[\"*\"]', '2023-12-14 02:53:03', NULL, '2023-12-14 02:53:02', '2023-12-14 02:53:03'),
(233, 'App\\Models\\User', 1, 'secret', 'd05c02af37daf47a95e567da4fec4259d2dc16b14f256045024798f05aba2d63', '[\"*\"]', '2023-12-14 02:57:45', NULL, '2023-12-14 02:57:42', '2023-12-14 02:57:45'),
(234, 'App\\Models\\User', 1, 'secret', '8393187772ffc919deb6600ac0a7ad5c90d951451184c4bda8927d70d7f1a9d3', '[\"*\"]', '2023-12-14 15:13:20', NULL, '2023-12-14 15:05:02', '2023-12-14 15:13:20'),
(235, 'App\\Models\\User', 1, 'secret', '2c323eb96471cbe72e61ec431f3ffc8d9c94ed4b6131ede49b2600085c31b2dc', '[\"*\"]', '2023-12-14 15:16:33', NULL, '2023-12-14 15:16:29', '2023-12-14 15:16:33'),
(236, 'App\\Models\\User', 1, 'secret', '8bd970974409f97f7442a63ddb0bae756b201b1034c8a4b9f5c41dfedf4b5da8', '[\"*\"]', '2023-12-14 15:28:37', NULL, '2023-12-14 15:27:56', '2023-12-14 15:28:37'),
(237, 'App\\Models\\User', 1, 'secret', '8c8f1504fdbb62fbb4a57f8f711cfd5a4ea9db5272510bd18c6fc471692fc3fb', '[\"*\"]', '2023-12-14 15:44:52', NULL, '2023-12-14 15:31:53', '2023-12-14 15:44:52'),
(238, 'App\\Models\\User', 1, 'secret', 'e3cd6df86182ae976b3c64ac374b8ea91af481d5316ffffdb6aac1d9cbc67fbc', '[\"*\"]', '2023-12-14 15:46:44', NULL, '2023-12-14 15:46:41', '2023-12-14 15:46:44'),
(239, 'App\\Models\\User', 1, 'secret', '2eb0c2bc3195d826d6ee748b2917ef575360cf51f95d5e979d2029d32e96a22e', '[\"*\"]', NULL, NULL, '2023-12-14 15:55:47', '2023-12-14 15:55:47'),
(240, 'App\\Models\\User', 1, 'secret', '5bf5434fa4730021864abde2d6a87231cc129cc98fac4ea2d3190e303d8d25e1', '[\"*\"]', '2023-12-14 16:05:12', NULL, '2023-12-14 15:55:50', '2023-12-14 16:05:12'),
(241, 'App\\Models\\User', 1, 'secret', '7fe62cb320372ceaa8b87dd201ee7ac87c0896826a1a9e6d84aa1e128827229a', '[\"*\"]', '2023-12-14 16:14:58', NULL, '2023-12-14 16:10:08', '2023-12-14 16:14:58'),
(242, 'App\\Models\\User', 1, 'secret', '2a26dc40ace59dfe2f91838b37e53fff9bd72fc9983aeef4f8e8397d8b4bd902', '[\"*\"]', NULL, NULL, '2023-12-14 16:20:56', '2023-12-14 16:20:56'),
(243, 'App\\Models\\User', 1, 'secret', '882a575dc2b62f6852a3f22bc4292a1eaf1a0f015f6333eb714dcd955f94653b', '[\"*\"]', '2023-12-14 16:32:19', NULL, '2023-12-14 16:20:58', '2023-12-14 16:32:19'),
(244, 'App\\Models\\User', 1, 'secret', '967224ffc2c1ded2f1e78e0d5b212f11e1ad64ec4b7e09c54ff099eed4e26b68', '[\"*\"]', '2023-12-14 16:47:15', NULL, '2023-12-14 16:47:05', '2023-12-14 16:47:15'),
(245, 'App\\Models\\User', 2, 'secret', 'f6e8d58c5db0240be4c27c6b371202d4c52ea4681bacd276de9db267400247f8', '[\"*\"]', '2023-12-14 19:03:50', NULL, '2023-12-14 19:03:31', '2023-12-14 19:03:50'),
(246, 'App\\Models\\User', 1, 'secret', 'd1f7472fc87f2144d1b3b25eb2173f00eb7fd40850c5565a956c02ad8bb64223', '[\"*\"]', '2023-12-14 19:36:34', NULL, '2023-12-14 19:04:20', '2023-12-14 19:36:34'),
(247, 'App\\Models\\User', 2, 'secret', '9b10593f9e8c76d55b8683bb62b07d815e6887336d1874e5d2a3feec62a0f8fc', '[\"*\"]', '2023-12-14 19:39:02', NULL, '2023-12-14 19:38:59', '2023-12-14 19:39:02'),
(248, 'App\\Models\\User', 1, 'secret', 'cebe03fb05c113667127f13a371d7187755642d0b9d681fbd11f74810abb7572', '[\"*\"]', '2023-12-14 19:40:15', NULL, '2023-12-14 19:40:12', '2023-12-14 19:40:15'),
(249, 'App\\Models\\User', 1, 'secret', 'b48ff56083d834457dd4256aca812b0e39fb444c3eadc7bd9c344170a4bec0db', '[\"*\"]', '2023-12-14 20:05:21', NULL, '2023-12-14 20:05:00', '2023-12-14 20:05:21'),
(250, 'App\\Models\\User', 1, 'secret', '1c04ab2d115e946c5fa0370f13a23eab7dec474e3c6ac7ea30a025bfc9ae8690', '[\"*\"]', '2023-12-14 20:33:37', NULL, '2023-12-14 20:33:35', '2023-12-14 20:33:37'),
(251, 'App\\Models\\User', 1, 'secret', '95e73173cdfce55f926245b688898f446fcbb08f4e49633f58c504b032857441', '[\"*\"]', '2023-12-14 22:01:49', NULL, '2023-12-14 20:58:58', '2023-12-14 22:01:49'),
(252, 'App\\Models\\User', 1, 'secret', '4c08029aa4d82819adcea6e2fa5fa52267801ddf352c42714631de44b13724f4', '[\"*\"]', NULL, NULL, '2023-12-14 22:04:39', '2023-12-14 22:04:39'),
(253, 'App\\Models\\User', 1, 'secret', '96290426619e9f8fe62174e4d2a725f522e11b759c8791c755050a8fcdb7c6f5', '[\"*\"]', NULL, NULL, '2023-12-14 22:04:44', '2023-12-14 22:04:44'),
(254, 'App\\Models\\User', 1, 'secret', '93d0c4c2b3bc99631c2d85ede0a2864334ad6f8c64029da7de23f2e84bc5d324', '[\"*\"]', '2023-12-14 22:04:57', NULL, '2023-12-14 22:04:51', '2023-12-14 22:04:57'),
(255, 'App\\Models\\User', 1, 'secret', 'dd95fc91fd1373a66c60de524d9f482a878a786eb526262f06a76dcbc74b4c82', '[\"*\"]', '2023-12-14 22:18:28', NULL, '2023-12-14 22:05:10', '2023-12-14 22:18:28'),
(256, 'App\\Models\\User', 1, 'secret', '8c9cf937d2500a8f9fe6ed00bcf44e23ed4e8f45f683ef66285c173684a2ea25', '[\"*\"]', '2023-12-14 22:42:43', NULL, '2023-12-14 22:26:16', '2023-12-14 22:42:43'),
(257, 'App\\Models\\User', 1, 'secret', '1be0355750e9f8b5182cbeb3955eb4de8f51ed54535fba53160d937a50263a73', '[\"*\"]', '2023-12-14 22:51:10', NULL, '2023-12-14 22:43:29', '2023-12-14 22:51:10'),
(258, 'App\\Models\\User', 1, 'secret', 'd29bf1f12717ae16a13b11c8ddb937b5ea4a7c32ac5f8167dc50334053be6b81', '[\"*\"]', '2023-12-15 03:39:11', NULL, '2023-12-15 02:31:21', '2023-12-15 03:39:11'),
(259, 'App\\Models\\User', 2, 'secret', '21913d7cc0ee75505d7be3c2ed32e1c023f7f008a059a64e528efaf8e9461d1c', '[\"*\"]', '2023-12-15 03:39:57', NULL, '2023-12-15 03:39:35', '2023-12-15 03:39:57'),
(260, 'App\\Models\\User', 2, 'secret', 'eabd2000168848870e2729fb7fd600c3a376cf065676bbb1998d9e0e16fe7f23', '[\"*\"]', '2023-12-15 10:02:10', NULL, '2023-12-15 03:49:18', '2023-12-15 10:02:10');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(261, 'App\\Models\\User', 1, 'secret', '0b3952fbd8386be9736b800e92ab10f5bf6e9128d7de484419faf29bb04f1816', '[\"*\"]', '2023-12-15 10:16:28', NULL, '2023-12-15 10:07:12', '2023-12-15 10:16:28'),
(262, 'App\\Models\\User', 2, 'secret', '93356c9ec99cfc7b5009c3fd8a866445c09864172ec7a1bbb520ff72b5539566', '[\"*\"]', '2023-12-15 10:20:48', NULL, '2023-12-15 10:19:44', '2023-12-15 10:20:48'),
(263, 'App\\Models\\User', 2, 'secret', '6adcce119e863aee98810962c264a26e0723ff5817fd5f8d51842bcef0091a95', '[\"*\"]', '2023-12-15 10:39:46', NULL, '2023-12-15 10:39:21', '2023-12-15 10:39:46'),
(264, 'App\\Models\\User', 1, 'secret', 'ed55e2457acb268d335112ac1544a07e741a33b9c7f9d899e7e5a1bae508cf01', '[\"*\"]', '2023-12-15 10:40:24', NULL, '2023-12-15 10:40:09', '2023-12-15 10:40:24'),
(265, 'App\\Models\\User', 2, 'secret', 'f7df793f6b59cb048ba5395875f4b65380af666c61bb5a7000b5184bf229984f', '[\"*\"]', '2023-12-15 10:40:50', NULL, '2023-12-15 10:40:43', '2023-12-15 10:40:50'),
(266, 'App\\Models\\User', 1, 'secret', '2aacc8ef79e4dae42b0125d8ca41ee43c24df7b870a056b8759ade57362210a8', '[\"*\"]', '2023-12-15 14:35:34', NULL, '2023-12-15 14:35:20', '2023-12-15 14:35:34'),
(267, 'App\\Models\\User', 2, 'secret', '3a146f99305d26a4f482cd75aedc1e22f58e5f358680c6bfd1e5f02ef187eb9f', '[\"*\"]', '2023-12-15 14:43:38', NULL, '2023-12-15 14:35:50', '2023-12-15 14:43:38'),
(268, 'App\\Models\\User', 1, 'secret', '6a6d53f78b2a1338d75549bd232f5e797b23e319eb039ab954e7a3dd07f0ef1a', '[\"*\"]', '2023-12-15 14:57:27', NULL, '2023-12-15 14:44:01', '2023-12-15 14:57:27'),
(269, 'App\\Models\\User', 2, 'secret', 'd794de53c72010792bbbd71518ebb353d3e1967d39ff5554aebfae53829c2d9c', '[\"*\"]', '2023-12-15 15:08:05', NULL, '2023-12-15 15:05:42', '2023-12-15 15:08:05');

-- --------------------------------------------------------

--
-- Table structure for table `request_izin_bermalam`
--

CREATE TABLE `request_izin_bermalam` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `approver_role` enum('mahasiswa','baak') NOT NULL,
  `approver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reason` text NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `request_izin_bermalam`
--

INSERT INTO `request_izin_bermalam` (`id`, `user_id`, `approver_role`, `approver_id`, `reason`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`) VALUES
(6, 1, 'mahasiswa', 2, '212122', '2023-12-15 18:19:00', '2023-12-20 13:19:00', 'approved', '2023-12-11 23:19:53', '2023-12-12 19:26:49'),
(7, 1, 'mahasiswa', 2, 'dddddddddddddddddddddddddddddddddddd', '2023-12-15 17:22:00', '2023-12-12 13:22:00', 'rejected', '2023-12-11 23:22:20', '2023-12-12 19:23:55'),
(9, 1, 'mahasiswa', 2, 'wdwdwd', '2023-12-30 15:26:00', '2023-12-31 15:26:00', 'rejected', '2023-12-12 01:27:02', '2023-12-12 19:23:52');

-- --------------------------------------------------------

--
-- Table structure for table `request_izin_keluar`
--

CREATE TABLE `request_izin_keluar` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `approver_role` enum('mahasiswa','baak') NOT NULL,
  `approver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reason` text NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `request_izin_keluar`
--

INSERT INTO `request_izin_keluar` (`id`, `user_id`, `approver_role`, `approver_id`, `reason`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`) VALUES
(21, 1, 'mahasiswa', 2, '22s', '2023-12-12 13:30:00', '2023-12-12 13:31:00', 'approved', '2023-12-11 23:31:03', '2023-12-12 18:41:53'),
(22, 1, 'mahasiswa', 2, 'sddww', '2023-12-12 13:49:00', '2023-12-12 13:49:00', 'approved', '2023-12-11 23:49:53', '2023-12-12 06:37:32'),
(23, 1, 'mahasiswa', 2, '122121', '2023-12-13 08:53:00', '2023-12-13 08:53:00', 'rejected', '2023-12-12 18:53:49', '2023-12-12 18:54:07'),
(30, 1, 'mahasiswa', NULL, 'gh', '2023-12-14 21:48:00', '2023-12-14 21:48:00', 'pending', '2023-12-15 02:48:09', '2023-12-15 02:48:09');

-- --------------------------------------------------------

--
-- Table structure for table `request_surat`
--

CREATE TABLE `request_surat` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `approver_role` enum('mahasiswa','baak') NOT NULL,
  `approver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reason` text NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `request_surat`
--

INSERT INTO `request_surat` (`id`, `user_id`, `approver_role`, `approver_id`, `reason`, `status`, `created_at`, `updated_at`) VALUES
(9, 1, 'mahasiswa', 2, 'wddwtffghgggggffdddrgvcxfjvcvvvgvfdggcc', 'approved', '2023-12-12 01:49:01', '2023-12-15 08:25:14'),
(10, 1, 'mahasiswa', 2, 'zz22', 'rejected', '2023-12-12 01:52:19', '2023-12-12 23:41:38'),
(11, 1, 'mahasiswa', 2, 'qwwdwdq', 'approved', '2023-12-12 01:59:48', '2023-12-12 19:58:41');

-- --------------------------------------------------------

--
-- Table structure for table `ruangan`
--

CREATE TABLE `ruangan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `NamaRuangan` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ruangan`
--

INSERT INTO `ruangan` (`id`, `NamaRuangan`, `created_at`, `updated_at`) VALUES
(1, 'GD577', NULL, NULL),
(2, 'GD422\r\n', NULL, NULL),
(3, 'GD923\r\n', NULL, NULL),
(4, 'GD722', NULL, NULL),
(5, 'GD527\r\n', NULL, NULL),
(6, 'GD833', NULL, NULL),
(7, 'GD511\r\n', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `nomor_ktp` varchar(255) NOT NULL,
  `nim` varchar(255) NOT NULL,
  `role` enum('mahasiswa','baak') NOT NULL DEFAULT 'mahasiswa',
  `nomor_handphone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `nomor_ktp`, `nim`, `role`, `nomor_handphone`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'cristian', '134134134', '1214142143', 'mahasiswa', '314314314134', 'cristian@gmail.com', NULL, '$2y$12$ScD/FEPF2/PCHuIYbNXXZe9x1u9jGQuDTznkXlPckAxqnXWSiRbdO', NULL, '2023-12-10 21:41:33', '2023-12-10 21:41:33'),
(2, 'richard', '1121221123123', '11322010', 'baak', '0812311231', 'richard@gmail.com', NULL, '$2y$12$GFo7kCRxnXf1KoLRvUx5DeE./OPwAyw05y8iZG677mpLLM4fkFgSa', NULL, '2023-12-12 06:05:12', '2023-12-12 06:05:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking_ruangan`
--
ALTER TABLE `booking_ruangan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_ruangan_user_id_foreign` (`user_id`),
  ADD KEY `booking_ruangan_approver_id_foreign` (`approver_id`),
  ADD KEY `booking_ruangan_room_id_foreign` (`room_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `kaos`
--
ALTER TABLE `kaos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pemesanan_user_id_foreign` (`user_id`),
  ADD KEY `pemesanan_kaos_id_foreign` (`kaos_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `request_izin_bermalam`
--
ALTER TABLE `request_izin_bermalam`
  ADD PRIMARY KEY (`id`),
  ADD KEY `request_izin_bermalam_user_id_foreign` (`user_id`),
  ADD KEY `request_izin_bermalam_approver_id_foreign` (`approver_id`);

--
-- Indexes for table `request_izin_keluar`
--
ALTER TABLE `request_izin_keluar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `request_izin_keluar_user_id_foreign` (`user_id`),
  ADD KEY `request_izin_keluar_approver_id_foreign` (`approver_id`);

--
-- Indexes for table `request_surat`
--
ALTER TABLE `request_surat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `request_surat_user_id_foreign` (`user_id`),
  ADD KEY `request_surat_approver_id_foreign` (`approver_id`);

--
-- Indexes for table `ruangan`
--
ALTER TABLE `ruangan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking_ruangan`
--
ALTER TABLE `booking_ruangan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kaos`
--
ALTER TABLE `kaos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `pemesanan`
--
ALTER TABLE `pemesanan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=270;

--
-- AUTO_INCREMENT for table `request_izin_bermalam`
--
ALTER TABLE `request_izin_bermalam`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `request_izin_keluar`
--
ALTER TABLE `request_izin_keluar`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `request_surat`
--
ALTER TABLE `request_surat`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `ruangan`
--
ALTER TABLE `ruangan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking_ruangan`
--
ALTER TABLE `booking_ruangan`
  ADD CONSTRAINT `booking_ruangan_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `booking_ruangan_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `ruangan` (`id`),
  ADD CONSTRAINT `booking_ruangan_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD CONSTRAINT `pemesanan_kaos_id_foreign` FOREIGN KEY (`kaos_id`) REFERENCES `kaos` (`id`),
  ADD CONSTRAINT `pemesanan_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `request_izin_bermalam`
--
ALTER TABLE `request_izin_bermalam`
  ADD CONSTRAINT `request_izin_bermalam_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `request_izin_bermalam_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `request_izin_keluar`
--
ALTER TABLE `request_izin_keluar`
  ADD CONSTRAINT `request_izin_keluar_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `request_izin_keluar_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `request_surat`
--
ALTER TABLE `request_surat`
  ADD CONSTRAINT `request_surat_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `request_surat_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
