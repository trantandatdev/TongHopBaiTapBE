-- -------------------------------------------------------------
-- TablePlus 5.6.8(524)
--
-- https://tableplus.com/
--
-- Database: db_capstone
-- Generation Time: 2023-12-31 15:34:02.2520
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


CREATE TABLE `binh_luan` (
  `binh_luan_id` int NOT NULL AUTO_INCREMENT,
  `nguoi_dung_id` int DEFAULT NULL,
  `hinh_id` int DEFAULT NULL,
  `ngay_binh_luan` date DEFAULT NULL,
  `noi_dung` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`binh_luan_id`),
  KEY `hinh_id` (`hinh_id`),
  KEY `nguoi_dung_id` (`nguoi_dung_id`),
  CONSTRAINT `binh_luan_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`nguoi_dung_id`) ON DELETE CASCADE,
  CONSTRAINT `binh_luan_ibfk_2` FOREIGN KEY (`hinh_id`) REFERENCES `hinh_anh` (`hinh_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `hinh_anh` (
  `hinh_id` int NOT NULL AUTO_INCREMENT,
  `ten_hinh` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duong_dan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mo_ta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nguoi_dung_id` int DEFAULT NULL,
  PRIMARY KEY (`hinh_id`),
  KEY `nguoi_dung_id` (`nguoi_dung_id`),
  CONSTRAINT `hinh_anh_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`nguoi_dung_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `luu_anh` (
  `nguoi_dung_id` int NOT NULL,
  `hinh_id` int NOT NULL,
  `ngay_luu` date DEFAULT NULL,
  PRIMARY KEY (`nguoi_dung_id`,`hinh_id`),
  KEY `hinh_id` (`hinh_id`),
  CONSTRAINT `luu_anh_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`nguoi_dung_id`) ON DELETE CASCADE,
  CONSTRAINT `luu_anh_ibfk_2` FOREIGN KEY (`hinh_id`) REFERENCES `hinh_anh` (`hinh_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `nguoi_dung` (
  `nguoi_dung_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mat_khau` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ho_ten` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tuoi` int DEFAULT NULL,
  `anh_dai_dien` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`nguoi_dung_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `hinh_anh` (`hinh_id`, `ten_hinh`, `duong_dan`, `mo_ta`, `nguoi_dung_id`) VALUES
(1, NULL, '1703048087392_Cat.jpg', NULL, 3),
(2, 'mèo méo meo', '1703048541268_Cat.jpg', NULL, 3),
(3, 'undefined', '1703049091004_Cat.jpg', NULL, 3),
(4, 'hahah', '1703049170154_Cat.jpg', NULL, 3),
(5, 'con meo', '1703049275734_Cat.jpg', NULL, 3),
(6, 'con cho', '1703049523141_Cat.jpg', NULL, 3),
(7, 'meo_2', '1703220851873_16cab153397fc070d5369635ba891e8d.jpg', '', 1),
(8, 'meo_2', '1703220853490_16cab153397fc070d5369635ba891e8d.jpg', '', 1),
(9, 'meo_2', '1703220854025_16cab153397fc070d5369635ba891e8d.jpg', '', 1),
(10, 'asdasdasdasd', '1703224129049_Cute Kittens.jpg', 'Sleep cat', 1);

INSERT INTO `nguoi_dung` (`nguoi_dung_id`, `email`, `mat_khau`, `ho_ten`, `tuoi`, `anh_dai_dien`) VALUES
(1, 'tam@123', '$2b$10$ZkQLmuIcC3RCgSmmPWhu0u2RQotJYuVASECvEY5dxkkc6Pbkn7.Ha', 'tam', 999, NULL),
(2, 'tam', '$2b$10$yd9YK0/tgzc8m3iBQCbdoegP5lxBe1lP5jC1qI.aRNKoG47bc/Z56', 'tam', 999, NULL),
(3, 'himynameistama3004@gmail.com', '$2b$10$JDCsSRKIQ16fIF7XqC1FtugXh4OjE6WOGGawnV6FclXnkqmqvcmH2', 'Tam Nguyen', 20, NULL);



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;