/*
 Navicat Premium Data Transfer

 Source Server         : tugas
 Source Server Type    : MySQL
 Source Server Version : 100411
 Source Host           : localhost:3306
 Source Schema         : pos_web

 Target Server Type    : MySQL
 Target Server Version : 100411
 File Encoding         : 65001

 Date: 27/07/2023 16:33:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for kategori
-- ----------------------------
DROP TABLE IF EXISTS `kategori`;
CREATE TABLE `kategori`  (
  `id_kategori` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_kategori`) USING BTREE,
  UNIQUE INDEX `kategori_nama_kategori_unique`(`nama_kategori`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of kategori
-- ----------------------------
INSERT INTO `kategori` VALUES (1, 'bunga', '2023-04-01 00:30:00', '2023-03-01 00:30:00');
INSERT INTO `kategori` VALUES (2, 'Woodslice', '2023-04-01 00:30:00', '2023-03-01 00:30:00');
INSERT INTO `kategori` VALUES (3, 'Terarium', '2023-04-01 00:30:00', '2023-03-01 00:30:00');
INSERT INTO `kategori` VALUES (4, 'Pencetakan', '2023-04-01 00:30:00', '2023-03-01 00:30:00');
INSERT INTO `kategori` VALUES (5, 'Frame 3D kayu', '2023-04-01 00:30:00', '2023-03-01 00:30:00');
INSERT INTO `kategori` VALUES (6, 'Frame 3D Motif', '2023-04-01 00:30:00', '2023-03-01 00:30:00');
INSERT INTO `kategori` VALUES (7, 'Frame 2D kayu', '2023-04-01 00:30:00', '2023-03-01 00:30:00');
INSERT INTO `kategori` VALUES (8, 'Tray', '2023-04-01 00:30:00', '2023-03-01 00:30:00');
INSERT INTO `kategori` VALUES (9, 'Bearer', '2023-04-01 00:30:00', '2023-03-01 00:30:00');
INSERT INTO `kategori` VALUES (10, 'Box', '2023-04-01 00:30:00', '2023-03-01 00:30:00');
INSERT INTO `kategori` VALUES (11, 'Aksesoris', '2023-04-01 00:30:00', '2023-03-01 00:30:00');
INSERT INTO `kategori` VALUES (12, 'Jasa Dekor', '2023-04-01 00:30:00', '2023-03-01 00:30:00');
INSERT INTO `kategori` VALUES (13, 'Migrasi Data', '2023-04-01 00:30:00', '2023-03-01 00:30:00');

-- ----------------------------
-- Table structure for list_po
-- ----------------------------
DROP TABLE IF EXISTS `list_po`;
CREATE TABLE `list_po`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_statuses` int NOT NULL,
  `id_penjualan` int NULL DEFAULT NULL,
  `id_user` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `kode_po` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `start_date` date NULL DEFAULT NULL,
  `end_date` date NULL DEFAULT NULL,
  `assigne` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `relasi_status`(`id_statuses`) USING BTREE,
  CONSTRAINT `list_po_ibfk_1` FOREIGN KEY (`id_statuses`) REFERENCES `status` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of list_po
-- ----------------------------
INSERT INTO `list_po` VALUES (3, 1, 11, 1, '2023-07-18 17:16:03', '2023-07-18 17:16:03', 'PO-000001', NULL, NULL, NULL);
INSERT INTO `list_po` VALUES (4, 1, 11, 1, '2023-07-18 17:17:24', '2023-07-18 17:17:24', 'PO-000004', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for list_pos
-- ----------------------------
DROP TABLE IF EXISTS `list_pos`;
CREATE TABLE `list_pos`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_statuses` int NOT NULL,
  `id_penjualan` int NULL DEFAULT NULL,
  `id_user` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `kode_po` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `start_date` date NULL DEFAULT NULL,
  `end_date` date NULL DEFAULT NULL,
  `assigne` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `relasi_status`(`id_statuses`) USING BTREE,
  CONSTRAINT `relasi_status` FOREIGN KEY (`id_statuses`) REFERENCES `status` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of list_pos
-- ----------------------------
INSERT INTO `list_pos` VALUES (1, 3, 1, 1, '2023-04-01 00:30:00', '2023-04-01 00:30:00', 'PO-000001', '2023-04-01', '2023-04-01', '5');
INSERT INTO `list_pos` VALUES (2, 3, 2, 1, '2023-04-01 00:30:00', '2023-04-01 00:30:00', 'PO-000002', '2023-04-01', '2023-04-01', '5');
INSERT INTO `list_pos` VALUES (3, 3, 3, 1, '2023-04-01 00:30:00', '2023-04-01 00:30:00', 'PO-000003', '2023-04-01', '2023-04-01', '5');
INSERT INTO `list_pos` VALUES (4, 3, 4, 1, '2023-04-01 00:30:00', '2023-04-01 00:30:00', 'PO-000004', '2023-04-01', '2023-04-01', '5');
INSERT INTO `list_pos` VALUES (5, 3, 5, 1, '2023-04-01 00:30:00', '2023-04-01 00:30:00', 'PO-000005', '2023-04-01', '2023-04-01', '5');
INSERT INTO `list_pos` VALUES (6, 3, 6, 1, '2023-04-01 00:30:00', '2023-04-01 00:30:00', 'PO-000006', '2023-04-01', '2023-04-01', '5');
INSERT INTO `list_pos` VALUES (7, 3, 7, 1, '2023-04-01 00:30:00', '2023-04-01 00:30:00', 'PO-000007', '2023-04-01', '2023-04-01', '5');
INSERT INTO `list_pos` VALUES (8, 3, 8, 1, '2023-04-01 00:30:00', '2023-04-01 00:30:00', 'PO-000008', '2023-04-01', '2023-04-01', '5');
INSERT INTO `list_pos` VALUES (10, 3, 38, 1, '2023-04-18 05:06:11', '2023-04-20 16:22:14', 'PO000009', '2023-04-20', '2023-04-28', '4');
INSERT INTO `list_pos` VALUES (11, 3, 32, 1, '2023-04-20 16:19:38', '2023-04-26 10:58:45', 'PO000011', '2023-04-26', '2023-04-29', '4');
INSERT INTO `list_pos` VALUES (12, 1, 41, 1, '2023-04-26 04:07:30', '2023-04-26 04:07:30', 'PO000012', NULL, NULL, NULL);
INSERT INTO `list_pos` VALUES (13, 1, 42, 1, '2023-04-26 04:17:38', '2023-04-27 10:50:42', 'PO000013', '2023-04-20', '2023-04-29', '3');
INSERT INTO `list_pos` VALUES (14, 1, 49, 1, '2023-04-27 09:13:58', '2023-04-27 09:18:46', 'PO000014', '2023-04-27', '2023-04-27', '4');
INSERT INTO `list_pos` VALUES (15, 1, 10, 1, '2023-04-28 06:48:28', '2023-04-28 06:48:28', 'PO-000015', NULL, NULL, NULL);
INSERT INTO `list_pos` VALUES (16, 1, 53, 1, '2023-04-28 06:49:57', '2023-04-28 06:49:57', 'PO-000016', NULL, NULL, NULL);
INSERT INTO `list_pos` VALUES (17, 1, 53, 1, '2023-04-28 06:53:33', '2023-04-28 06:53:33', 'PO-000017', NULL, NULL, NULL);
INSERT INTO `list_pos` VALUES (18, 1, 53, 1, '2023-04-28 06:55:04', '2023-04-28 06:55:04', 'PO-000018', NULL, NULL, NULL);
INSERT INTO `list_pos` VALUES (19, 1, 53, 1, '2023-04-28 06:58:25', '2023-04-28 06:58:25', 'PO-000019', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for list_produk
-- ----------------------------
DROP TABLE IF EXISTS `list_produk`;
CREATE TABLE `list_produk`  (
  `id` int NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of list_produk
-- ----------------------------
INSERT INTO `list_produk` VALUES (1, 'KCG');
INSERT INTO `list_produk` VALUES (2, 'KG');
INSERT INTO `list_produk` VALUES (3, 'KC');
INSERT INTO `list_produk` VALUES (4, 'C');
INSERT INTO `list_produk` VALUES (5, 'KK');
INSERT INTO `list_produk` VALUES (7, '123123');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `id_member` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `kode_member` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `telepon` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_member`) USING BTREE,
  UNIQUE INDEX `member_kode_member_unique`(`kode_member`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (1, '00001', 'Ute Juli', 'komplek vijaya kusuma', '081234779987', '2023-03-16 04:22:04', '2023-05-11 04:38:08');
INSERT INTO `member` VALUES (2, '00002', 'Mulki Sukmana', 'Jalan terusan cibaduyut', '081234742453', '2023-03-16 04:41:26', '2023-05-11 04:38:32');

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1);
INSERT INTO `migrations` VALUES (4, '2016_06_01_000001_create_oauth_auth_codes_table', 1);
INSERT INTO `migrations` VALUES (5, '2016_06_01_000002_create_oauth_access_tokens_table', 1);
INSERT INTO `migrations` VALUES (6, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1);
INSERT INTO `migrations` VALUES (7, '2016_06_01_000004_create_oauth_clients_table', 1);
INSERT INTO `migrations` VALUES (8, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1);
INSERT INTO `migrations` VALUES (9, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (10, '2019_12_14_000001_create_personal_access_tokens_table', 1);
INSERT INTO `migrations` VALUES (11, '2021_03_05_194740_tambah_kolom_baru_to_users_table', 1);
INSERT INTO `migrations` VALUES (12, '2021_03_05_195441_buat_kategori_table', 1);
INSERT INTO `migrations` VALUES (13, '2021_03_05_195949_buat_produk_table', 1);
INSERT INTO `migrations` VALUES (14, '2021_03_05_200515_buat_member_table', 1);
INSERT INTO `migrations` VALUES (15, '2021_03_05_200706_buat_supplier_table', 1);
INSERT INTO `migrations` VALUES (16, '2021_03_05_200841_buat_pembelian_table', 1);
INSERT INTO `migrations` VALUES (17, '2021_03_05_200845_buat_pembelian_detail_table', 1);
INSERT INTO `migrations` VALUES (18, '2021_03_05_200853_buat_penjualan_table', 1);
INSERT INTO `migrations` VALUES (19, '2021_03_05_200858_buat_penjualan_detail_table', 1);
INSERT INTO `migrations` VALUES (20, '2021_03_05_200904_buat_setting_table', 1);
INSERT INTO `migrations` VALUES (21, '2021_03_05_201756_buat_pengeluaran_table', 1);
INSERT INTO `migrations` VALUES (22, '2021_03_11_225128_create_sessions_table', 1);
INSERT INTO `migrations` VALUES (23, '2021_03_24_115009_tambah_foreign_key_to_produk_table', 1);
INSERT INTO `migrations` VALUES (24, '2021_03_24_131829_tambah_kode_produk_to_produk_table', 1);
INSERT INTO `migrations` VALUES (25, '2021_05_08_220315_tambah_diskon_to_setting_table', 1);
INSERT INTO `migrations` VALUES (26, '2021_05_09_124745_edit_id_member_to_penjualan_table', 1);

-- ----------------------------
-- Table structure for oauth_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_access_tokens_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oauth_access_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_auth_codes
-- ----------------------------
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_auth_codes_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oauth_auth_codes
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `provider` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `redirect` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_clients_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oauth_clients
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_personal_access_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oauth_personal_access_clients
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_refresh_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_refresh_tokens_access_token_id_index`(`access_token_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oauth_refresh_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for pembelian
-- ----------------------------
DROP TABLE IF EXISTS `pembelian`;
CREATE TABLE `pembelian`  (
  `id_pembelian` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_supplier` int NOT NULL,
  `total_item` int NOT NULL,
  `total_harga` int NOT NULL,
  `diskon` tinyint NOT NULL DEFAULT 0,
  `bayar` int NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_pembelian`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pembelian
-- ----------------------------
INSERT INTO `pembelian` VALUES (1, 1, 30, 3000000, 0, 3000000, '2023-04-27 08:31:36', '2023-04-27 08:32:12');
INSERT INTO `pembelian` VALUES (2, 1, 1, 90000, 0, 90000, '2023-04-27 08:32:57', '2023-04-27 08:33:20');
INSERT INTO `pembelian` VALUES (3, 1, 1, 100000, 0, 100000, '2023-05-20 12:42:23', '2023-05-20 12:42:42');
INSERT INTO `pembelian` VALUES (4, 1, 1, 100000, 0, 100000, '2023-05-20 12:43:25', '2023-05-20 12:43:36');

-- ----------------------------
-- Table structure for pembelian_detail
-- ----------------------------
DROP TABLE IF EXISTS `pembelian_detail`;
CREATE TABLE `pembelian_detail`  (
  `id_pembelian_detail` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_pembelian` int NOT NULL,
  `id_produk` int NOT NULL,
  `harga_beli` int NOT NULL,
  `jumlah` int NOT NULL,
  `subtotal` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_pembelian_detail`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pembelian_detail
-- ----------------------------
INSERT INTO `pembelian_detail` VALUES (1, 1, 48, 100000, 30, 3000000, '2023-04-27 08:31:52', '2023-04-27 08:32:03');
INSERT INTO `pembelian_detail` VALUES (2, 2, 11, 90000, 30, 2700000, '2023-04-27 08:33:13', '2023-04-27 08:33:17');
INSERT INTO `pembelian_detail` VALUES (3, 3, 48, 100000, 10, 1000000, '2023-05-20 12:42:33', '2023-05-20 12:42:41');
INSERT INTO `pembelian_detail` VALUES (4, 4, 48, 100000, 10, 1000000, '2023-05-20 12:43:30', '2023-05-20 12:43:32');

-- ----------------------------
-- Table structure for pengeluaran
-- ----------------------------
DROP TABLE IF EXISTS `pengeluaran`;
CREATE TABLE `pengeluaran`  (
  `id_pengeluaran` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_pengeluaran`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pengeluaran
-- ----------------------------
INSERT INTO `pengeluaran` VALUES (1, 'kuota telkomsel', 20000, '2023-05-20 12:42:01', '2023-06-05 14:21:06');

-- ----------------------------
-- Table structure for penggajian
-- ----------------------------
DROP TABLE IF EXISTS `penggajian`;
CREATE TABLE `penggajian`  (
  `id_gaji` int NOT NULL AUTO_INCREMENT,
  `id_list_po` int NOT NULL,
  `tanggal_selesai` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `harga` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `bonus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `total` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_gaji`, `id_list_po`) USING BTREE,
  INDEX `relasi`(`id_list_po`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of penggajian
-- ----------------------------
INSERT INTO `penggajian` VALUES (1, 1, '2023-05-19 01:35:40', '10000', '0', '10000', '2023-05-19 01:35:40', '2023-05-19 01:35:40');
INSERT INTO `penggajian` VALUES (2, 2, '2023-05-20 12:41:25', '10000', '0', '10000', '2023-05-20 12:41:25', '2023-05-20 12:41:25');
INSERT INTO `penggajian` VALUES (6, 2, '2023-05-21 01:35:37', '10000', '0', '10000', '2023-05-21 01:35:37', '2023-05-21 01:35:37');
INSERT INTO `penggajian` VALUES (7, 2, '2023-05-21 01:35:46', '10000', '0', '10000', '2023-05-21 01:35:46', '2023-05-21 01:35:46');
INSERT INTO `penggajian` VALUES (8, 2, '2023-05-21 02:09:54', '10000', '0', '10000', '2023-05-21 02:09:54', '2023-05-21 02:09:54');
INSERT INTO `penggajian` VALUES (9, 2, '2023-05-23 11:58:02', '10000', '0', '10000', '2023-05-23 11:58:02', '2023-05-23 11:58:02');
INSERT INTO `penggajian` VALUES (10, 2, '2023-05-23 12:00:42', '10000', '0', '10000', '2023-05-23 12:00:42', '2023-05-23 12:00:42');
INSERT INTO `penggajian` VALUES (11, 2, '2023-05-23 19:12:41', '10000', '0', '10000', '2023-05-23 19:12:41', '2023-05-23 19:12:41');

-- ----------------------------
-- Table structure for penggajian_migrasi
-- ----------------------------
DROP TABLE IF EXISTS `penggajian_migrasi`;
CREATE TABLE `penggajian_migrasi`  (
  `id_gaji` int NOT NULL AUTO_INCREMENT,
  `id_list_po` int NOT NULL,
  `tanggal_selesai` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `harga` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `bonus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `total` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_gaji`, `id_list_po`) USING BTREE,
  INDEX `relasi`(`id_list_po`) USING BTREE,
  CONSTRAINT `penggajian_migrasi_ibfk_1` FOREIGN KEY (`id_list_po`) REFERENCES `list_pos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of penggajian_migrasi
-- ----------------------------

-- ----------------------------
-- Table structure for penjualan
-- ----------------------------
DROP TABLE IF EXISTS `penjualan`;
CREATE TABLE `penjualan`  (
  `id_penjualan` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` int NULL DEFAULT NULL,
  `total_item` int NOT NULL,
  `total_harga` int NOT NULL,
  `diskon` tinyint NOT NULL DEFAULT 0,
  `bayar` int NOT NULL DEFAULT 0,
  `diterima` int NOT NULL DEFAULT 0,
  `id_user` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nama_pemesan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `telepon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `harga_bayar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sumber_po` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nama_catalog` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `foto2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_penjualan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of penjualan
-- ----------------------------
INSERT INTO `penjualan` VALUES (1, NULL, 4, 330000, 0, 350000, 350000, 1, '2023-05-19 01:33:04', '2023-05-19 01:34:26', '3', 'jordan', 'Jl. Sukasenang Raya No.22, Cikutra, Kec. Cibeunying Kidul', '081234779987', '350000', 'offline', 'seri magnolia Ring bearer size M', 'pake cincin bahan api', NULL);
INSERT INTO `penjualan` VALUES (5, NULL, 1, 84000, 0, 23000, 23000, 1, '2023-05-20 12:30:05', '2023-05-20 12:41:10', '3', 'jordan', 'Jl. Sukasenang Raya No.22, Cikutra, Kec. Cibeunying Kidul', '081234742453', '230000', 'tokopedia', 'KCD', 'bulat 6', NULL);
INSERT INTO `penjualan` VALUES (6, NULL, 0, 0, 0, 0, 0, 1, '2023-05-29 11:30:37', '2023-05-29 11:30:37', '1', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL);
INSERT INTO `penjualan` VALUES (7, NULL, 0, 0, 0, 0, 0, 1, '2023-05-29 13:26:42', '2023-05-29 13:26:42', '1', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL);
INSERT INTO `penjualan` VALUES (8, NULL, 0, 0, 0, 0, 0, 1, '2023-05-29 13:59:36', '2023-05-29 13:59:36', '1', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL);
INSERT INTO `penjualan` VALUES (9, NULL, 0, 0, 0, 0, 0, 1, '2023-06-05 14:55:10', '2023-06-05 14:55:10', '1', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL);
INSERT INTO `penjualan` VALUES (10, NULL, 1, 120000, 0, 120000, 0, 1, '2023-06-06 13:41:16', '2023-06-06 13:42:46', '1', 'dfdf', 'fdf', '08112025742', '0', 'shopee', 'aafd', 'fdf', NULL);
INSERT INTO `penjualan` VALUES (11, NULL, 2, 108000, 0, 0, 108000, 1, '2023-07-18 17:12:33', '2023-07-18 17:17:24', '3', 'TESSSSSSSSSSSSSSsdfsdfsdfdsfdsdfsf', 'TESSSSSSSSSSSSSSsdfsdfsdfdsfdsdfsf', '08112025742', '0', 'lazada', 'hg', 'nama diabwah dan diatas pakai grafir', NULL);
INSERT INTO `penjualan` VALUES (12, NULL, 1, 60000, 0, 0, 60000, 1, '2023-07-25 15:11:59', '2023-07-25 15:17:15', '1', 'dasdad', 'asdasd', 'adasd', '0', 'tokopedia', 'addas', 'dasdas', NULL);
INSERT INTO `penjualan` VALUES (13, NULL, 1, 84000, 0, 0, 84000, 1, '2023-07-25 15:18:22', '2023-07-25 15:18:47', '1', 'qqqqqqqqq', 'qqqqqqqqqq', '111111111', '0', 'lazada', 'qqqqqqqq', 'qqqqqqqqqq', NULL);
INSERT INTO `penjualan` VALUES (14, NULL, 0, 0, 0, 0, 0, 1, '2023-07-25 15:18:53', '2023-07-25 15:18:53', '1', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL);
INSERT INTO `penjualan` VALUES (15, NULL, 1, 60000, 0, 0, 60000, 1, '2023-07-25 15:20:20', '2023-07-25 15:20:41', '1', 'asdas', 'dadda', 'sdadas', '0', 'tokopedia', 'KCD', 'asdasd', NULL);
INSERT INTO `penjualan` VALUES (16, NULL, 1, 48000, 0, 0, 2000, 1, '2023-07-25 15:21:08', '2023-07-25 15:21:29', '1', 'dada', 'sdad', 'adasd', '0', 'whatsapp', 'adad', 'adas', NULL);

-- ----------------------------
-- Table structure for penjualan_detail
-- ----------------------------
DROP TABLE IF EXISTS `penjualan_detail`;
CREATE TABLE `penjualan_detail`  (
  `id_penjualan_detail` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_penjualan` int NOT NULL,
  `id_produk` int NOT NULL,
  `harga_jual` int NOT NULL,
  `jumlah` int NOT NULL,
  `diskon` tinyint NOT NULL DEFAULT 0,
  `subtotal` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_penjualan_detail`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of penjualan_detail
-- ----------------------------
INSERT INTO `penjualan_detail` VALUES (1, 1, 36, 54000, 1, 0, 54000, '2023-05-19 01:33:10', '2023-05-19 01:33:10');
INSERT INTO `penjualan_detail` VALUES (2, 1, 48, 120000, 1, 0, 120000, '2023-05-19 01:33:16', '2023-05-19 01:33:16');
INSERT INTO `penjualan_detail` VALUES (3, 1, 27, 0, 1, 0, 0, '2023-05-19 01:33:23', '2023-05-19 01:33:23');
INSERT INTO `penjualan_detail` VALUES (4, 1, 20, 156000, 1, 0, 156000, '2023-05-19 01:33:35', '2023-05-19 01:33:35');
INSERT INTO `penjualan_detail` VALUES (7, 5, 47, 84000, 1, 0, 84000, '2023-05-20 12:30:09', '2023-05-20 12:30:09');
INSERT INTO `penjualan_detail` VALUES (8, 10, 48, 120000, 1, 0, 120000, '2023-06-06 13:42:35', '2023-06-06 13:42:35');
INSERT INTO `penjualan_detail` VALUES (9, 11, 45, 36000, 1, 0, 36000, '2023-07-18 17:12:40', '2023-07-18 17:12:40');
INSERT INTO `penjualan_detail` VALUES (10, 11, 37, 72000, 1, 0, 72000, '2023-07-18 17:12:42', '2023-07-18 17:12:42');
INSERT INTO `penjualan_detail` VALUES (11, 12, 46, 60000, 1, 0, 60000, '2023-07-25 15:16:57', '2023-07-25 15:16:57');
INSERT INTO `penjualan_detail` VALUES (12, 13, 47, 84000, 1, 0, 84000, '2023-07-25 15:18:28', '2023-07-25 15:18:28');
INSERT INTO `penjualan_detail` VALUES (13, 15, 46, 60000, 1, 0, 60000, '2023-07-25 15:20:27', '2023-07-25 15:20:27');
INSERT INTO `penjualan_detail` VALUES (14, 16, 35, 48000, 1, 0, 48000, '2023-07-25 15:21:14', '2023-07-25 15:21:14');

-- ----------------------------
-- Table structure for penjualan_detail_migrasi
-- ----------------------------
DROP TABLE IF EXISTS `penjualan_detail_migrasi`;
CREATE TABLE `penjualan_detail_migrasi`  (
  `id_penjualan_detail` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_penjualan` int NOT NULL,
  `id_produk` int NOT NULL,
  `harga_jual` int NOT NULL,
  `jumlah` int NOT NULL,
  `diskon` tinyint NOT NULL DEFAULT 0,
  `subtotal` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_penjualan_detail`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of penjualan_detail_migrasi
-- ----------------------------

-- ----------------------------
-- Table structure for penjualan_migrasi
-- ----------------------------
DROP TABLE IF EXISTS `penjualan_migrasi`;
CREATE TABLE `penjualan_migrasi`  (
  `id_penjualan` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` int NULL DEFAULT NULL,
  `total_item` int NOT NULL,
  `total_harga` int NOT NULL,
  `diskon` tinyint NOT NULL DEFAULT 0,
  `bayar` int NOT NULL DEFAULT 0,
  `diterima` int NOT NULL DEFAULT 0,
  `id_user` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nama_pemesan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `telepon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `harga_bayar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sumber_po` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nama_catalog` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_penjualan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of penjualan_migrasi
-- ----------------------------

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token`) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type`, `tokenable_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for produk
-- ----------------------------
DROP TABLE IF EXISTS `produk`;
CREATE TABLE `produk`  (
  `id_produk` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_kategori` int UNSIGNED NOT NULL,
  `kode_produk` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_produk` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `merk` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `harga_beli` int NOT NULL,
  `diskon` tinyint NOT NULL DEFAULT 0,
  `harga_jual` int NOT NULL,
  `stok` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_produk`) USING BTREE,
  UNIQUE INDEX `produk_nama_produk_unique`(`nama_produk`) USING BTREE,
  UNIQUE INDEX `produk_kode_produk_unique`(`kode_produk`) USING BTREE,
  INDEX `produk_id_kategori_foreign`(`id_kategori`) USING BTREE,
  CONSTRAINT `produk_id_kategori_foreign` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of produk
-- ----------------------------
INSERT INTO `produk` VALUES (1, 2, 'W000001', 'Woodslice 15', 'wangi project', 18000, 0, 21600, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (2, 2, 'W000002', 'Woodslice 17', 'wangi project', 20000, 0, 24000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (3, 2, 'W000003', 'Woodslice 19', 'wangi project', 25000, 0, 30000, 19, '2023-04-01 00:30:00', '2023-04-27 08:45:42');
INSERT INTO `produk` VALUES (4, 2, 'W000004', 'Woodslice 22', 'wangi project', 28000, 0, 33600, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (5, 2, 'W000005', 'Woodslice 25', 'wangi project', 30000, 0, 36000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (6, 2, 'W000006', 'Woodslice 30', 'wangi project', 38000, 0, 45600, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (7, 2, 'W000007', 'Woodslice 13-14', 'wangi project', 15000, 0, 18000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (8, 2, 'W000008', 'Woodslice Nest', 'wangi project', 30000, 0, 36000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (9, 3, 'T000001', 'Terarium Small', 'wangi project', 65000, 0, 78000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (10, 3, 'T000002', 'Terarium Medium', 'wangi project', 80000, 0, 96000, 19, '2023-04-01 00:30:00', '2023-04-27 08:45:42');
INSERT INTO `produk` VALUES (11, 3, 'T000003', 'Terarium Large', 'wangi project', 90000, 0, 108000, 50, '2023-04-01 00:30:00', '2023-04-27 08:33:20');
INSERT INTO `produk` VALUES (12, 3, 'T000004', 'Terarium X-Large', 'wangi project', 120000, 0, 144000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (13, 3, 'T000005', 'Terarium X-Small', 'wangi project', 50000, 0, 60000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (14, 4, 'PC00001', 'Grafir', 'wangi project', 10000, 0, 12000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (15, 4, 'PC00002', 'Cutting Biasa', 'wangi project', 15000, 0, 18000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (16, 4, 'PC00003', 'Cutting Nama', 'wangi project', 15000, 0, 18000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (17, 4, 'PC00004', 'Cutting Grafo', 'wangi project', 20000, 0, 24000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (18, 4, 'PC00005', 'Costumize', 'wangi project', 30000, 0, 36000, 19, '2023-04-01 00:30:00', '2023-04-27 08:45:42');
INSERT INTO `produk` VALUES (19, 5, 'FK00001', 'Frame 3D kayu 30x30', 'wangi project', 100000, 0, 120000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (20, 5, 'FK00002', 'Frame 3D kayu 30x40', 'wangi project', 130000, 0, 156000, 19, '2023-04-01 00:30:00', '2023-05-19 01:34:08');
INSERT INTO `produk` VALUES (21, 6, 'FM00001', 'Frame 3D motif 30x30', 'wangi project', 100000, 0, 120000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (22, 6, 'FM00002', 'Frame 3D motif 30x40', 'wangi project', 130000, 0, 156000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (23, 7, 'FD00001', 'Frame 2D kayu 8 R', 'wangi project', 0, 0, 0, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (24, 7, 'FD00002', 'Frame 2D kayu 8 Rp', 'wangi project', 0, 0, 0, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (25, 7, 'FD00003', 'Frame 2D kayu 16 R', 'wangi project', 0, 0, 0, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (26, 7, 'FD00004', 'Frame 2D kayu 16 Rp', 'wangi project', 0, 0, 0, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (27, 7, 'FD00005', 'Frame 2D kayu 20 R', 'wangi project', 0, 0, 0, 19, '2023-04-01 00:30:00', '2023-05-19 01:34:08');
INSERT INTO `produk` VALUES (28, 7, 'FD00006', 'Frame 2D kayu 20 Rp', 'wangi project', 0, 0, 0, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (29, 8, 'TR00001', 'Tray 20x20', 'wangi project', 20000, 0, 24000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (30, 8, 'TR00002', 'Tray 30x20', 'wangi project', 30000, 0, 36000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (31, 8, 'TR00003', 'Tray Circle 15', 'wangi project', 10000, 0, 12000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (32, 8, 'TR00004', 'Tray Circle 20', 'wangi project', 15000, 0, 18000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (33, 8, 'TR00005', 'Tray Circle 30', 'wangi project', 18000, 0, 21600, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (34, 9, 'B000001', 'Bearer 8 cm', 'wangi project', 35000, 0, 42000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (35, 9, 'B000002', 'Bearer 10 cm', 'wangi project', 40000, 0, 48000, 19, '2023-04-01 00:30:00', '2023-07-25 15:21:29');
INSERT INTO `produk` VALUES (36, 10, 'BO00001', 'Box 10x10', 'wangi project', 45000, 0, 54000, 18, '2023-04-01 00:30:00', '2023-05-19 01:34:08');
INSERT INTO `produk` VALUES (37, 10, 'BO00002', 'Box 12x12', 'wangi project', 60000, 0, 72000, 19, '2023-04-01 00:30:00', '2023-07-18 17:13:02');
INSERT INTO `produk` VALUES (38, 10, 'BO00003', 'Box 15x15', 'wangi project', 89000, 0, 106800, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (39, 10, 'BO00004', 'Box 17x17', 'wangi project', 103000, 0, 123600, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (40, 10, 'BO00005', 'Box 20x20', 'wangi project', 95000, 0, 114000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (41, 10, 'BO00006', 'Box 15x12', 'wangi project', 66000, 0, 79200, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (42, 10, 'BO00007', 'Box Hexa', 'wangi project', 50000, 0, 60000, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (43, 10, 'BO00008', 'Box 17x12', 'wangi project', 67000, 0, 80400, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (44, 10, 'BO00009', 'Box 19x12', 'wangi project', 76000, 0, 91200, 20, '2023-04-01 00:30:00', '2023-04-01 00:30:00');
INSERT INTO `produk` VALUES (45, 11, 'A000001', 'Aksesoris Small', 'wangi project', 30000, 0, 36000, 18, '2023-04-01 00:30:00', '2023-07-18 17:13:02');
INSERT INTO `produk` VALUES (46, 11, 'A000002', 'Aksesoris Large', 'wangi project', 50000, 0, 60000, 13, '2023-04-01 00:30:00', '2023-07-25 15:20:41');
INSERT INTO `produk` VALUES (47, 11, 'A000003', 'Aksesoris X-Large', 'wangi project', 70000, 0, 84000, 18, '2023-04-01 00:30:00', '2023-07-25 15:18:47');
INSERT INTO `produk` VALUES (48, 11, 'A000004', 'Aksesoris frame', 'wangi project', 100000, 0, 120000, 61, '2023-04-01 00:30:00', '2023-06-06 13:42:46');
INSERT INTO `produk` VALUES (49, 12, 'J000001', 'Jasa Dekor', 'wangi project', 10000, 0, 12000, 999999, '2023-04-01 00:30:00', '2023-04-27 08:45:42');
INSERT INTO `produk` VALUES (50, 13, 'Migrasi', 'Migrasi Data', 'wangi project', 0, 0, 0, 999999, '2023-04-01 00:30:00', '2023-04-27 08:45:42');

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id`) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('4BwVHOTRWWdZfnTMXHKPmNm2Ly0U0aBIQ1WY24Uz', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiZG8zY2JyQkwwelY3bmlXU0hiMXAzUURlTk40eUdTSllWeEpHczIyQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9saXN0cG8iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMmEkMTIkZWQ0eVVxVTlhME1neEtISHF0OExwdXlHSmJnNi5vWE1TTGhRQnkvek1hRnVRSWVLbXlTRGEiO3M6MTI6ImlkX3Blbmp1YWxhbiI7aToxNjt9', 1690274133);

-- ----------------------------
-- Table structure for setting
-- ----------------------------
DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting`  (
  `id_setting` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nama_perusahaan` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `telepon` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipe_nota` tinyint NOT NULL,
  `diskon` smallint NOT NULL DEFAULT 0,
  `path_logo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path_kartu_member` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_setting`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of setting
-- ----------------------------
INSERT INTO `setting` VALUES (1, 'Wangi Project', 'Kp.Sindang Tengah Rt 05/07, Limbangan Tengah, Kec. Balubur Limbangan, Kabupaten Garut, Jawa Barat 44186', '08112025742', 1, 0, '/img/logo-20230410041830.png', '/img/logo-2023-03-16040333.png', NULL, '2023-04-28 03:56:38');

-- ----------------------------
-- Table structure for status
-- ----------------------------
DROP TABLE IF EXISTS `status`;
CREATE TABLE `status`  (
  `id` int NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of status
-- ----------------------------
INSERT INTO `status` VALUES (1, 'Pengerjaan');
INSERT INTO `status` VALUES (2, 'Decor');
INSERT INTO `status` VALUES (3, 'Design');
INSERT INTO `status` VALUES (4, 'Grafir');
INSERT INTO `status` VALUES (5, 'Revisi');
INSERT INTO `status` VALUES (6, 'Selesai');

-- ----------------------------
-- Table structure for sumber_po
-- ----------------------------
DROP TABLE IF EXISTS `sumber_po`;
CREATE TABLE `sumber_po`  (
  `id` int NOT NULL,
  `nama_sumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sumber_po
-- ----------------------------
INSERT INTO `sumber_po` VALUES (1, 'WA');
INSERT INTO `sumber_po` VALUES (2, 'Shope');
INSERT INTO `sumber_po` VALUES (3, 'Tokopedia');
INSERT INTO `sumber_po` VALUES (4, 'Lazada');
INSERT INTO `sumber_po` VALUES (5, 'Offline');

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `id_supplier` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nama` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `telepon` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_supplier`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES (1, 'CV BUNGA SENTOSA', 'jalan sukamenak no 38', '08734433443', '2023-03-24 04:24:13', '2023-04-27 03:53:54');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `alamat` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `no_telp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `level` tinyint NOT NULL DEFAULT 0,
  `two_factor_secret` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `two_factor_recovery_codes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `current_team_id` bigint UNSIGNED NULL DEFAULT NULL,
  `profile_photo_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Admin WP', 'admin@gmail.com', NULL, '$2a$12$ed4yUqU9a0MgxKHHqt8LpuyGJbg6.oXMSLhQBy/zMaFuQIeKmySDa', '/img/logo-20230410042119.png', 'limbangan tengah', '089618369515', 1, NULL, NULL, NULL, NULL, NULL, '2023-03-08 07:37:48', '2023-05-11 12:43:02');
INSERT INTO `users` VALUES (2, 'asep update', 'orbetbernat@gmail.com', NULL, '$2y$10$xb5laJvRl3YckRsnw8wWOu05KmPe4RXqXyXL30NsNKtF4RfTE7x.u', '/img/user.jpg', 'cibaduyut update', '00000000', 2, NULL, NULL, NULL, NULL, NULL, '2023-03-08 07:37:48', '2023-06-20 10:39:28');
INSERT INTO `users` VALUES (3, 'Deviana Amartha', 'devi@gmail.com', NULL, '$2a$12$ed4yUqU9a0MgxKHHqt8LpuyGJbg6.oXMSLhQBy/zMaFuQIeKmySDa', '/img/user.jpg', 'limbangan tengah', '0897652454265', 2, NULL, NULL, NULL, NULL, NULL, '2023-03-08 07:37:48', '2023-05-11 04:48:44');
INSERT INTO `users` VALUES (4, 'Ikbal Daud', 'daud@gmail.com', NULL, '$2a$12$ed4yUqU9a0MgxKHHqt8LpuyGJbg6.oXMSLhQBy/zMaFuQIeKmySDa', '/img/user.jpg', 'limbangan tengah', '089618369515', 2, NULL, NULL, NULL, NULL, NULL, '2023-04-18 02:23:32', '2023-05-11 04:49:14');
INSERT INTO `users` VALUES (5, 'migrasi', 'migrasi@gmail.com', NULL, '$2a$12$ed4yUqU9a0MgxKHHqt8LpuyGJbg6.oXMSLhQBy/zMaFuQIeKmySDa', '/img/logo-20230410042119.png', 'jalan jacatra', '908008778083', 1, NULL, NULL, NULL, NULL, NULL, '2023-04-18 02:23:32', '2023-04-18 02:23:32');
INSERT INTO `users` VALUES (6, 'wawan gunawan', 'wawan@gmail.com', NULL, '$2a$12$ed4yUqU9a0MgxKHHqt8LpuyGJbg6.oXMSLhQBy/zMaFuQIeKmySDa', '/img/user.jpg', 'limbangan tengah', '0897652525657', 2, NULL, NULL, NULL, NULL, NULL, '2023-05-11 04:48:28', '2023-05-11 04:48:28');
INSERT INTO `users` VALUES (7, 'sarah', 'sarah@gmail.com', NULL, '$2a$12$ed4yUqU9a0MgxKHHqt8LpuyGJbg6.oXMSLhQBy/zMaFuQIeKmySDa', '/img/user.jpg', 'limbangan tengah', '086524625752', 2, NULL, NULL, NULL, NULL, NULL, '2023-05-11 04:49:40', '2023-05-11 04:49:40');

SET FOREIGN_KEY_CHECKS = 1;
