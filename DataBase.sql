-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 15, 2025 at 04:17 PM
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
-- Database: `lexverdict`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `Address_ID` int(11) NOT NULL,
  `Street` varchar(255) DEFAULT NULL,
  `Barangay` varchar(100) DEFAULT NULL,
  `Municipality` varchar(100) DEFAULT NULL,
  `Province` varchar(100) DEFAULT NULL,
  `Region` varchar(100) DEFAULT NULL,
  `PERSON_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`Address_ID`, `Street`, `Barangay`, `Municipality`, `Province`, `Region`, `PERSON_ID`) VALUES
(200, 'Rizal Ave. #56', 'San Vicente', 'Palayan', 'Nueva Ecija', 'Region III', 200),
(201, 'A. Santos St. #2', 'San Roque', 'Palayan', 'Nueva Ecija', 'Region III', 201),
(202, 'A. Santos St. #93', 'Halang', 'Aliaga', 'Nueva Ecija', 'Region III', 202),
(203, 'Rizal Ave. #98', 'Mabini', 'Aliaga', 'Nueva Ecija', 'Region III', 203),
(204, 'Rizal Ave. #44', 'Bayanihan', 'Aliaga', 'Nueva Ecija', 'Region III', 204),
(205, 'Del Pilar St. #84', 'Poblacion', 'Aliaga', 'Nueva Ecija', 'Region III', 205),
(206, 'Purok 3 #55', 'Bagong Bayan', 'Aliaga', 'Nueva Ecija', 'Region III', 206),
(207, 'Malvar St. #41', 'Santa Cruz', 'Gapan', 'Nueva Ecija', 'Region III', 207),
(208, 'Mabini St. #30', 'Bayanihan', 'Gapan', 'Nueva Ecija', 'Region III', 208),
(209, 'A. Santos St. #129', 'San Roque', 'Gapan', 'Nueva Ecija', 'Region III', 209),
(210, 'National Highway #136', 'Poblacion', 'Gapan', 'Nueva Ecija', 'Region III', 210),
(211, 'Malvar St. #68', 'Bayanihan', 'San Jose', 'Nueva Ecija', 'Region III', 211),
(212, 'Purok 3 #113', 'Bayanihan', 'San Jose', 'Nueva Ecija', 'Region III', 212),
(213, 'National Highway #59', 'Halang', 'San Jose', 'Nueva Ecija', 'Region III', 213),
(214, 'Rizal Ave. #132', 'San Vicente', 'San Jose', 'Nueva Ecija', 'Region III', 214),
(215, 'Mabini St. #26', 'Poblacion', 'San Isidro', 'Nueva Ecija', 'Region III', 215),
(216, 'Malvar St. #109', 'San Roque', 'San Isidro', 'Nueva Ecija', 'Region III', 216),
(217, 'National Highway #4', 'San Juan', 'San Isidro', 'Nueva Ecija', 'Region III', 217),
(218, 'Brgy. Road #40', 'San Vicente', 'Aliaga', 'Nueva Ecija', 'Region III', 218),
(219, 'Mabini St. #13', 'Halang', 'Aliaga', 'Nueva Ecija', 'Region III', 219),
(220, 'Rizal Ave. #18', 'San Vicente', 'Aliaga', 'Nueva Ecija', 'Region III', 220),
(221, 'A. Santos St. #118', 'Santo Niño', 'San Jose', 'Nueva Ecija', 'Region III', 221),
(222, 'Del Pilar St. #130', 'Mabini', 'San Jose', 'Nueva Ecija', 'Region III', 222),
(223, 'National Highway #78', 'Halang', 'San Jose', 'Nueva Ecija', 'Region III', 223),
(224, 'National Highway #40', 'Mabini', 'San Jose', 'Nueva Ecija', 'Region III', 224),
(225, 'Malvar St. #114', 'Bayanihan', 'Gapan', 'Nueva Ecija', 'Region III', 225),
(226, 'Mabini St. #95', 'Halang', 'Gapan', 'Nueva Ecija', 'Region III', 226),
(227, 'Malvar St. #46', 'Santa Cruz', 'Cabanatuan', 'Nueva Ecija', 'Region III', 227),
(228, 'A. Santos St. #41', 'San Juan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 228),
(229, 'Del Pilar St. #58', 'Poblacion', 'Cabanatuan', 'Nueva Ecija', 'Region III', 229),
(230, 'National Highway #103', 'Bayanihan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 230),
(231, 'A. Santos St. #12', 'Santa Cruz', 'Aliaga', 'Nueva Ecija', 'Region III', 231),
(232, 'Purok 3 #81', 'San Juan', 'Aliaga', 'Nueva Ecija', 'Region III', 232),
(233, 'National Highway #33', 'San Vicente', 'Aliaga', 'Nueva Ecija', 'Region III', 233),
(234, 'Mabini St. #78', 'Mabini', 'Aliaga', 'Nueva Ecija', 'Region III', 234),
(235, 'A. Santos St. #58', 'San Vicente', 'San Jose', 'Nueva Ecija', 'Region III', 235),
(236, 'Brgy. Road #107', 'Halang', 'San Jose', 'Nueva Ecija', 'Region III', 236),
(237, 'Mabini St. #28', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 237),
(238, 'Brgy. Road #35', 'Bagong Bayan', 'San Jose', 'Nueva Ecija', 'Region III', 238),
(239, 'A. Santos St. #113', 'San Juan', 'Gapan', 'Nueva Ecija', 'Region III', 239),
(240, 'Malvar St. #60', 'Santa Cruz', 'Gapan', 'Nueva Ecija', 'Region III', 240),
(241, 'Blk 12 Lot 4 #16', 'San Vicente', 'Gapan', 'Nueva Ecija', 'Region III', 241),
(242, 'Purok 3 #77', 'Santa Cruz', 'Gapan', 'Nueva Ecija', 'Region III', 242),
(243, 'Blk 12 Lot 4 #125', 'Poblacion', 'Gapan', 'Nueva Ecija', 'Region III', 243),
(244, 'Blk 12 Lot 4 #84', 'San Vicente', 'San Jose', 'Nueva Ecija', 'Region III', 244),
(245, 'Brgy. Road #5', 'Bayanihan', 'San Jose', 'Nueva Ecija', 'Region III', 245),
(246, 'Del Pilar St. #52', 'Poblacion', 'San Jose', 'Nueva Ecija', 'Region III', 246),
(247, 'Blk 12 Lot 4 #102', 'San Vicente', 'Palayan', 'Nueva Ecija', 'Region III', 247),
(248, 'McArthur Hwy #31', 'Halang', 'Palayan', 'Nueva Ecija', 'Region III', 248),
(249, 'Purok 3 #4', 'Santa Cruz', 'Palayan', 'Nueva Ecija', 'Region III', 249),
(250, 'McArthur Hwy #69', 'Santo Niño', 'Cabanatuan', 'Nueva Ecija', 'Region III', 250),
(251, 'Blk 12 Lot 4 #87', 'Poblacion', 'Cabanatuan', 'Nueva Ecija', 'Region III', 251),
(252, 'Purok 3 #72', 'Halang', 'Cabanatuan', 'Nueva Ecija', 'Region III', 252),
(253, 'Blk 12 Lot 4 #126', 'Bayanihan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 253),
(254, 'Blk 12 Lot 4 #63', 'Mabini', 'Cabanatuan', 'Nueva Ecija', 'Region III', 254),
(255, 'Purok 3 #91', 'Bagong Bayan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 255),
(256, 'Del Pilar St. #76', 'San Vicente', 'San Isidro', 'Nueva Ecija', 'Region III', 256),
(257, 'Mabini St. #14', 'Bayanihan', 'San Isidro', 'Nueva Ecija', 'Region III', 257),
(258, 'McArthur Hwy #14', 'San Roque', 'Gapan', 'Nueva Ecija', 'Region III', 258),
(259, 'McArthur Hwy #58', 'Bayanihan', 'Gapan', 'Nueva Ecija', 'Region III', 259),
(260, 'McArthur Hwy #16', 'Halang', 'Gapan', 'Nueva Ecija', 'Region III', 260),
(261, 'A. Santos St. #117', 'San Juan', 'San Jose', 'Nueva Ecija', 'Region III', 261),
(262, 'Malvar St. #69', 'San Roque', 'San Jose', 'Nueva Ecija', 'Region III', 262),
(263, 'Mabini St. #111', 'Santo Niño', 'Aliaga', 'Nueva Ecija', 'Region III', 263),
(264, 'A. Santos St. #148', 'Poblacion', 'Aliaga', 'Nueva Ecija', 'Region III', 264),
(265, 'Brgy. Road #24', 'Bagong Bayan', 'Aliaga', 'Nueva Ecija', 'Region III', 265),
(266, 'Purok 3 #106', 'Bagong Bayan', 'Aliaga', 'Nueva Ecija', 'Region III', 266),
(267, 'Purok 3 #30', 'Santa Cruz', 'Aliaga', 'Nueva Ecija', 'Region III', 267),
(268, 'Brgy. Road #32', 'Poblacion', 'Talavera', 'Nueva Ecija', 'Region III', 268),
(269, 'Del Pilar St. #30', 'Bagong Bayan', 'Talavera', 'Nueva Ecija', 'Region III', 269),
(270, 'Brgy. Road #121', 'San Vicente', 'Talavera', 'Nueva Ecija', 'Region III', 270),
(271, 'Malvar St. #18', 'Mabini', 'Talavera', 'Nueva Ecija', 'Region III', 271),
(272, 'McArthur Hwy #149', 'Bagong Bayan', 'Talavera', 'Nueva Ecija', 'Region III', 272),
(273, 'Blk 12 Lot 4 #99', 'San Roque', 'Talavera', 'Nueva Ecija', 'Region III', 273),
(274, 'Brgy. Road #26', 'Bayanihan', 'Talavera', 'Nueva Ecija', 'Region III', 274),
(275, 'A. Santos St. #87', 'Halang', 'Talavera', 'Nueva Ecija', 'Region III', 275),
(276, 'Brgy. Road #139', 'Poblacion', 'Talavera', 'Nueva Ecija', 'Region III', 276),
(277, 'A. Santos St. #92', 'Santo Niño', 'Aliaga', 'Nueva Ecija', 'Region III', 277),
(278, 'Malvar St. #45', 'San Juan', 'Aliaga', 'Nueva Ecija', 'Region III', 278),
(279, 'A. Santos St. #118', 'Mabini', 'Aliaga', 'Nueva Ecija', 'Region III', 279),
(280, 'McArthur Hwy #77', 'Santa Cruz', 'Aliaga', 'Nueva Ecija', 'Region III', 280),
(281, 'Mabini St. #128', 'Mabini', 'San Jose', 'Nueva Ecija', 'Region III', 281),
(282, 'Malvar St. #25', 'Poblacion', 'San Jose', 'Nueva Ecija', 'Region III', 282),
(283, 'A. Santos St. #84', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 283),
(284, 'Malvar St. #66', 'Bagong Bayan', 'San Jose', 'Nueva Ecija', 'Region III', 284),
(285, 'Blk 12 Lot 4 #143', 'Santo Niño', 'San Jose', 'Nueva Ecija', 'Region III', 285),
(286, 'Purok 3 #57', 'San Juan', 'Palayan', 'Nueva Ecija', 'Region III', 286),
(287, 'Brgy. Road #30', 'San Juan', 'Palayan', 'Nueva Ecija', 'Region III', 287),
(288, 'National Highway #108', 'Halang', 'Palayan', 'Nueva Ecija', 'Region III', 288),
(289, 'Purok 3 #56', 'Bagong Bayan', 'Palayan', 'Nueva Ecija', 'Region III', 289),
(290, 'Purok 3 #16', 'Santa Cruz', 'Palayan', 'Nueva Ecija', 'Region III', 290),
(291, 'Del Pilar St. #85', 'San Roque', 'Aliaga', 'Nueva Ecija', 'Region III', 291),
(292, 'Rizal Ave. #7', 'San Roque', 'Aliaga', 'Nueva Ecija', 'Region III', 292),
(293, 'Mabini St. #33', 'Santa Cruz', 'Aliaga', 'Nueva Ecija', 'Region III', 293),
(294, 'Mabini St. #123', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 294),
(295, 'Malvar St. #17', 'San Roque', 'San Jose', 'Nueva Ecija', 'Region III', 295),
(296, 'National Highway #76', 'Bagong Bayan', 'San Jose', 'Nueva Ecija', 'Region III', 296),
(297, 'Blk 12 Lot 4 #87', 'Bagong Bayan', 'San Jose', 'Nueva Ecija', 'Region III', 297),
(298, 'Purok 3 #40', 'Bagong Bayan', 'San Jose', 'Nueva Ecija', 'Region III', 298),
(299, 'Mabini St. #74', 'Halang', 'San Jose', 'Nueva Ecija', 'Region III', 299),
(300, 'Brgy. Road #58', 'San Juan', 'San Jose', 'Nueva Ecija', 'Region III', 300),
(301, 'National Highway #143', 'Poblacion', 'San Jose', 'Nueva Ecija', 'Region III', 301),
(302, 'Mabini St. #47', 'San Roque', 'San Jose', 'Nueva Ecija', 'Region III', 302),
(303, 'Blk 12 Lot 4 #108', 'Bagong Bayan', 'San Jose', 'Nueva Ecija', 'Region III', 303),
(304, 'Mabini St. #40', 'San Roque', 'San Jose', 'Nueva Ecija', 'Region III', 304),
(305, 'McArthur Hwy #125', 'Bayanihan', 'San Jose', 'Nueva Ecija', 'Region III', 305),
(306, 'A. Santos St. #55', 'San Roque', 'San Jose', 'Nueva Ecija', 'Region III', 306),
(307, 'Malvar St. #34', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 307),
(308, 'Mabini St. #112', 'Poblacion', 'San Jose', 'Nueva Ecija', 'Region III', 308),
(309, 'Del Pilar St. #112', 'Halang', 'Aliaga', 'Nueva Ecija', 'Region III', 309),
(310, 'Purok 3 #44', 'San Juan', 'Aliaga', 'Nueva Ecija', 'Region III', 310),
(311, 'Malvar St. #61', 'San Juan', 'Aliaga', 'Nueva Ecija', 'Region III', 311),
(312, 'Rizal Ave. #121', 'Bagong Bayan', 'San Isidro', 'Nueva Ecija', 'Region III', 312),
(313, 'Brgy. Road #116', 'Poblacion', 'San Isidro', 'Nueva Ecija', 'Region III', 313),
(314, 'National Highway #99', 'Bagong Bayan', 'San Isidro', 'Nueva Ecija', 'Region III', 314),
(315, 'Malvar St. #16', 'Bagong Bayan', 'San Isidro', 'Nueva Ecija', 'Region III', 315),
(316, 'Mabini St. #86', 'San Juan', 'San Jose', 'Nueva Ecija', 'Region III', 316),
(317, 'McArthur Hwy #39', 'Santo Niño', 'San Jose', 'Nueva Ecija', 'Region III', 317),
(318, 'Blk 12 Lot 4 #34', 'Halang', 'San Jose', 'Nueva Ecija', 'Region III', 318),
(319, 'National Highway #24', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 319),
(320, 'McArthur Hwy #34', 'Halang', 'Cabanatuan', 'Nueva Ecija', 'Region III', 320),
(321, 'Brgy. Road #12', 'Santa Cruz', 'Cabanatuan', 'Nueva Ecija', 'Region III', 321),
(322, 'National Highway #136', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 322),
(323, 'Purok 3 #142', 'San Juan', 'San Jose', 'Nueva Ecija', 'Region III', 323),
(324, 'Blk 12 Lot 4 #24', 'San Vicente', 'San Jose', 'Nueva Ecija', 'Region III', 324),
(325, 'Del Pilar St. #99', 'San Juan', 'San Jose', 'Nueva Ecija', 'Region III', 325),
(326, 'Del Pilar St. #39', 'Bayanihan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 326),
(327, 'Blk 12 Lot 4 #118', 'San Juan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 327),
(328, 'Del Pilar St. #37', 'Mabini', 'Cabanatuan', 'Nueva Ecija', 'Region III', 328),
(329, 'Rizal Ave. #135', 'Santo Niño', 'Cabanatuan', 'Nueva Ecija', 'Region III', 329),
(330, 'Malvar St. #12', 'Santo Niño', 'Talavera', 'Nueva Ecija', 'Region III', 330),
(331, 'Rizal Ave. #118', 'Poblacion', 'Talavera', 'Nueva Ecija', 'Region III', 331),
(332, 'Blk 12 Lot 4 #140', 'Bagong Bayan', 'Talavera', 'Nueva Ecija', 'Region III', 332),
(333, 'Purok 3 #133', 'Mabini', 'Talavera', 'Nueva Ecija', 'Region III', 333),
(334, 'Purok 3 #27', 'San Juan', 'Talavera', 'Nueva Ecija', 'Region III', 334),
(335, 'Brgy. Road #90', 'Bagong Bayan', 'Talavera', 'Nueva Ecija', 'Region III', 335),
(336, 'Rizal Ave. #104', 'Santo Niño', 'Talavera', 'Nueva Ecija', 'Region III', 336),
(337, 'Brgy. Road #95', 'Santo Niño', 'Cabanatuan', 'Nueva Ecija', 'Region III', 337),
(338, 'A. Santos St. #64', 'San Juan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 338),
(339, 'A. Santos St. #115', 'San Vicente', 'Cabanatuan', 'Nueva Ecija', 'Region III', 339),
(340, 'Brgy. Road #23', 'Santo Niño', 'Cabanatuan', 'Nueva Ecija', 'Region III', 340),
(341, 'McArthur Hwy #95', 'Bagong Bayan', 'San Isidro', 'Nueva Ecija', 'Region III', 341),
(342, 'Brgy. Road #135', 'Santa Cruz', 'San Isidro', 'Nueva Ecija', 'Region III', 342),
(343, 'Brgy. Road #133', 'Santo Niño', 'San Isidro', 'Nueva Ecija', 'Region III', 343),
(344, 'Rizal Ave. #133', 'San Roque', 'San Isidro', 'Nueva Ecija', 'Region III', 344),
(345, 'Malvar St. #149', 'San Roque', 'Talavera', 'Nueva Ecija', 'Region III', 345),
(346, 'Rizal Ave. #12', 'Halang', 'Talavera', 'Nueva Ecija', 'Region III', 346),
(347, 'National Highway #75', 'Mabini', 'Talavera', 'Nueva Ecija', 'Region III', 347),
(348, 'Malvar St. #113', 'Santa Cruz', 'Talavera', 'Nueva Ecija', 'Region III', 348),
(349, 'Purok 3 #89', 'Santa Cruz', 'Talavera', 'Nueva Ecija', 'Region III', 349),
(350, 'Rizal Ave. #69', 'Bagong Bayan', 'Talavera', 'Nueva Ecija', 'Region III', 350),
(351, 'Brgy. Road #6', 'San Juan', 'San Isidro', 'Nueva Ecija', 'Region III', 351),
(352, 'Mabini St. #73', 'Bagong Bayan', 'San Isidro', 'Nueva Ecija', 'Region III', 352),
(353, 'Purok 3 #104', 'Santo Niño', 'San Isidro', 'Nueva Ecija', 'Region III', 353),
(354, 'A. Santos St. #19', 'Santa Cruz', 'San Isidro', 'Nueva Ecija', 'Region III', 354),
(355, 'Rizal Ave. #101', 'Santo Niño', 'San Isidro', 'Nueva Ecija', 'Region III', 355),
(356, 'Purok 3 #82', 'San Roque', 'Aliaga', 'Nueva Ecija', 'Region III', 356),
(357, 'National Highway #126', 'Halang', 'Aliaga', 'Nueva Ecija', 'Region III', 357),
(358, 'Mabini St. #150', 'Bagong Bayan', 'San Jose', 'Nueva Ecija', 'Region III', 358),
(359, 'McArthur Hwy #29', 'San Vicente', 'San Jose', 'Nueva Ecija', 'Region III', 359),
(360, 'Blk 12 Lot 4 #129', 'Halang', 'San Jose', 'Nueva Ecija', 'Region III', 360),
(361, 'Brgy. Road #135', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 361),
(362, 'A. Santos St. #124', 'San Vicente', 'San Jose', 'Nueva Ecija', 'Region III', 362),
(363, 'Del Pilar St. #126', 'Santo Niño', 'San Jose', 'Nueva Ecija', 'Region III', 363),
(364, 'Brgy. Road #55', 'San Vicente', 'San Isidro', 'Nueva Ecija', 'Region III', 364),
(365, 'Del Pilar St. #63', 'Poblacion', 'San Isidro', 'Nueva Ecija', 'Region III', 365),
(366, 'Rizal Ave. #36', 'Poblacion', 'San Isidro', 'Nueva Ecija', 'Region III', 366),
(367, 'Mabini St. #102', 'Bagong Bayan', 'Talavera', 'Nueva Ecija', 'Region III', 367),
(368, 'Purok 3 #73', 'Bagong Bayan', 'Talavera', 'Nueva Ecija', 'Region III', 368),
(369, 'Purok 3 #42', 'Bagong Bayan', 'Talavera', 'Nueva Ecija', 'Region III', 369),
(370, 'Malvar St. #104', 'Santa Cruz', 'Talavera', 'Nueva Ecija', 'Region III', 370),
(371, 'A. Santos St. #93', 'San Vicente', 'Aliaga', 'Nueva Ecija', 'Region III', 371),
(372, 'A. Santos St. #31', 'Mabini', 'Aliaga', 'Nueva Ecija', 'Region III', 372),
(373, 'McArthur Hwy #96', 'Santa Cruz', 'Aliaga', 'Nueva Ecija', 'Region III', 373),
(374, 'National Highway #39', 'San Roque', 'Gapan', 'Nueva Ecija', 'Region III', 374),
(375, 'Brgy. Road #24', 'Bayanihan', 'Gapan', 'Nueva Ecija', 'Region III', 375),
(376, 'Mabini St. #144', 'Bagong Bayan', 'Gapan', 'Nueva Ecija', 'Region III', 376),
(377, 'Rizal Ave. #12', 'Santa Cruz', 'Gapan', 'Nueva Ecija', 'Region III', 377),
(378, 'Blk 12 Lot 4 #47', 'San Roque', 'Gapan', 'Nueva Ecija', 'Region III', 378),
(379, 'Del Pilar St. #1', 'Poblacion', 'Aliaga', 'Nueva Ecija', 'Region III', 379),
(380, 'Del Pilar St. #118', 'Santo Niño', 'Aliaga', 'Nueva Ecija', 'Region III', 380),
(381, 'Mabini St. #62', 'San Vicente', 'Aliaga', 'Nueva Ecija', 'Region III', 381),
(382, 'Mabini St. #63', 'Poblacion', 'Aliaga', 'Nueva Ecija', 'Region III', 382),
(383, 'A. Santos St. #60', 'Halang', 'Aliaga', 'Nueva Ecija', 'Region III', 383),
(384, 'National Highway #57', 'Santa Cruz', 'Aliaga', 'Nueva Ecija', 'Region III', 384),
(385, 'Brgy. Road #62', 'San Vicente', 'Palayan', 'Nueva Ecija', 'Region III', 385),
(386, 'National Highway #35', 'Santa Cruz', 'Palayan', 'Nueva Ecija', 'Region III', 386),
(387, 'Rizal Ave. #138', 'San Vicente', 'Palayan', 'Nueva Ecija', 'Region III', 387),
(388, 'Del Pilar St. #144', 'San Vicente', 'Palayan', 'Nueva Ecija', 'Region III', 388),
(389, 'Rizal Ave. #123', 'San Vicente', 'Palayan', 'Nueva Ecija', 'Region III', 389),
(390, 'Brgy. Road #82', 'San Vicente', 'Gapan', 'Nueva Ecija', 'Region III', 390),
(391, 'Mabini St. #67', 'Bayanihan', 'Gapan', 'Nueva Ecija', 'Region III', 391),
(392, 'Del Pilar St. #128', 'Bayanihan', 'Gapan', 'Nueva Ecija', 'Region III', 392),
(393, 'Malvar St. #36', 'Bayanihan', 'Gapan', 'Nueva Ecija', 'Region III', 393),
(394, 'Mabini St. #2', 'Santa Cruz', 'Gapan', 'Nueva Ecija', 'Region III', 394),
(395, 'Purok 3 #16', 'Halang', 'Gapan', 'Nueva Ecija', 'Region III', 395),
(396, 'Malvar St. #62', 'San Vicente', 'Aliaga', 'Nueva Ecija', 'Region III', 396),
(397, 'McArthur Hwy #63', 'San Vicente', 'Aliaga', 'Nueva Ecija', 'Region III', 397),
(398, 'Brgy. Road #15', 'Poblacion', 'Aliaga', 'Nueva Ecija', 'Region III', 398),
(399, 'National Highway #11', 'San Vicente', 'Aliaga', 'Nueva Ecija', 'Region III', 399),
(400, 'National Highway #145', 'Poblacion', 'Aliaga', 'Nueva Ecija', 'Region III', 400),
(401, 'National Highway #89', 'Poblacion', 'Talavera', 'Nueva Ecija', 'Region III', 401),
(402, 'McArthur Hwy #102', 'Santo Niño', 'Talavera', 'Nueva Ecija', 'Region III', 402),
(403, 'Blk 12 Lot 4 #48', 'Halang', 'Talavera', 'Nueva Ecija', 'Region III', 403),
(404, 'A. Santos St. #40', 'Santa Cruz', 'Talavera', 'Nueva Ecija', 'Region III', 404),
(405, 'National Highway #132', 'Santa Cruz', 'Aliaga', 'Nueva Ecija', 'Region III', 405),
(406, 'Purok 3 #99', 'Poblacion', 'Aliaga', 'Nueva Ecija', 'Region III', 406),
(407, 'Malvar St. #98', 'San Roque', 'Aliaga', 'Nueva Ecija', 'Region III', 407),
(408, 'Blk 12 Lot 4 #71', 'Santa Cruz', 'Aliaga', 'Nueva Ecija', 'Region III', 408),
(409, 'Brgy. Road #86', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 409),
(410, 'Malvar St. #102', 'Santo Niño', 'San Jose', 'Nueva Ecija', 'Region III', 410),
(411, 'Purok 3 #30', 'Halang', 'San Jose', 'Nueva Ecija', 'Region III', 411),
(412, 'Blk 12 Lot 4 #97', 'San Juan', 'San Isidro', 'Nueva Ecija', 'Region III', 412),
(413, 'Blk 12 Lot 4 #140', 'Poblacion', 'San Isidro', 'Nueva Ecija', 'Region III', 413),
(414, 'Purok 3 #43', 'Halang', 'San Isidro', 'Nueva Ecija', 'Region III', 414),
(415, 'A. Santos St. #57', 'Bayanihan', 'San Isidro', 'Nueva Ecija', 'Region III', 415),
(416, 'Malvar St. #90', 'Mabini', 'Palayan', 'Nueva Ecija', 'Region III', 416),
(417, 'Brgy. Road #116', 'Santo Niño', 'Palayan', 'Nueva Ecija', 'Region III', 417),
(418, 'Malvar St. #63', 'Bayanihan', 'Palayan', 'Nueva Ecija', 'Region III', 418),
(419, 'Blk 12 Lot 4 #100', 'Poblacion', 'San Isidro', 'Nueva Ecija', 'Region III', 419),
(420, 'Malvar St. #94', 'Santo Niño', 'San Isidro', 'Nueva Ecija', 'Region III', 420),
(421, 'Purok 3 #100', 'Halang', 'San Isidro', 'Nueva Ecija', 'Region III', 421),
(422, 'A. Santos St. #22', 'San Roque', 'San Isidro', 'Nueva Ecija', 'Region III', 422),
(423, 'Malvar St. #143', 'San Roque', 'San Jose', 'Nueva Ecija', 'Region III', 423),
(424, 'Purok 3 #3', 'Bagong Bayan', 'San Jose', 'Nueva Ecija', 'Region III', 424),
(425, 'Brgy. Road #107', 'Bagong Bayan', 'San Jose', 'Nueva Ecija', 'Region III', 425),
(426, 'A. Santos St. #58', 'Bayanihan', 'San Jose', 'Nueva Ecija', 'Region III', 426),
(427, 'McArthur Hwy #30', 'Mabini', 'San Jose', 'Nueva Ecija', 'Region III', 427),
(428, 'Del Pilar St. #54', 'Halang', 'Palayan', 'Nueva Ecija', 'Region III', 428),
(429, 'Del Pilar St. #16', 'Halang', 'Palayan', 'Nueva Ecija', 'Region III', 429),
(430, 'A. Santos St. #75', 'Halang', 'Palayan', 'Nueva Ecija', 'Region III', 430),
(431, 'Blk 12 Lot 4 #97', 'Bagong Bayan', 'Palayan', 'Nueva Ecija', 'Region III', 431),
(432, 'Brgy. Road #84', 'Halang', 'Palayan', 'Nueva Ecija', 'Region III', 432),
(433, 'McArthur Hwy #125', 'Santo Niño', 'Gapan', 'Nueva Ecija', 'Region III', 433),
(434, 'Brgy. Road #117', 'Poblacion', 'Gapan', 'Nueva Ecija', 'Region III', 434),
(435, 'Purok 3 #65', 'San Juan', 'Gapan', 'Nueva Ecija', 'Region III', 435),
(436, 'National Highway #114', 'Poblacion', 'Gapan', 'Nueva Ecija', 'Region III', 436),
(437, 'Del Pilar St. #99', 'San Juan', 'Gapan', 'Nueva Ecija', 'Region III', 437),
(438, 'Malvar St. #18', 'Bayanihan', 'Gapan', 'Nueva Ecija', 'Region III', 438),
(439, 'Malvar St. #106', 'Halang', 'Gapan', 'Nueva Ecija', 'Region III', 439),
(440, 'A. Santos St. #7', 'Mabini', 'Gapan', 'Nueva Ecija', 'Region III', 440),
(441, 'Mabini St. #62', 'Bagong Bayan', 'Gapan', 'Nueva Ecija', 'Region III', 441),
(442, 'Rizal Ave. #4', 'Mabini', 'Talavera', 'Nueva Ecija', 'Region III', 442),
(443, 'National Highway #107', 'Santa Cruz', 'Talavera', 'Nueva Ecija', 'Region III', 443),
(444, 'A. Santos St. #21', 'Bayanihan', 'Talavera', 'Nueva Ecija', 'Region III', 444),
(445, 'Rizal Ave. #80', 'Santa Cruz', 'Talavera', 'Nueva Ecija', 'Region III', 445),
(446, 'McArthur Hwy #15', 'Mabini', 'Talavera', 'Nueva Ecija', 'Region III', 446),
(447, 'Purok 3 #110', 'Mabini', 'Gapan', 'Nueva Ecija', 'Region III', 447),
(448, 'Mabini St. #128', 'Halang', 'Gapan', 'Nueva Ecija', 'Region III', 448),
(449, 'Rizal Ave. #59', 'Bayanihan', 'Gapan', 'Nueva Ecija', 'Region III', 449),
(450, 'Malvar St. #46', 'Poblacion', 'Gapan', 'Nueva Ecija', 'Region III', 450),
(451, 'Rizal Ave. #147', 'Santo Niño', 'Gapan', 'Nueva Ecija', 'Region III', 451),
(452, 'Rizal Ave. #120', 'Mabini', 'Gapan', 'Nueva Ecija', 'Region III', 452),
(453, 'Del Pilar St. #39', 'Poblacion', 'San Jose', 'Nueva Ecija', 'Region III', 453),
(454, 'Mabini St. #86', 'Poblacion', 'San Jose', 'Nueva Ecija', 'Region III', 454),
(455, 'Mabini St. #37', 'Mabini', 'San Jose', 'Nueva Ecija', 'Region III', 455),
(456, 'Rizal Ave. #149', 'San Juan', 'San Jose', 'Nueva Ecija', 'Region III', 456),
(457, 'Malvar St. #61', 'Mabini', 'San Jose', 'Nueva Ecija', 'Region III', 457),
(458, 'Rizal Ave. #52', 'San Roque', 'San Jose', 'Nueva Ecija', 'Region III', 458),
(459, 'A. Santos St. #11', 'San Vicente', 'San Jose', 'Nueva Ecija', 'Region III', 459),
(460, 'A. Santos St. #67', 'San Roque', 'San Jose', 'Nueva Ecija', 'Region III', 460),
(461, 'Rizal Ave. #36', 'San Juan', 'San Jose', 'Nueva Ecija', 'Region III', 461),
(462, 'Rizal Ave. #85', 'San Juan', 'Palayan', 'Nueva Ecija', 'Region III', 462),
(463, 'Blk 12 Lot 4 #128', 'Poblacion', 'Palayan', 'Nueva Ecija', 'Region III', 463),
(464, 'Brgy. Road #39', 'Poblacion', 'Palayan', 'Nueva Ecija', 'Region III', 464),
(465, 'A. Santos St. #99', 'San Roque', 'Palayan', 'Nueva Ecija', 'Region III', 465),
(466, 'Mabini St. #72', 'Poblacion', 'San Jose', 'Nueva Ecija', 'Region III', 466),
(467, 'Del Pilar St. #69', 'Bayanihan', 'San Jose', 'Nueva Ecija', 'Region III', 467),
(468, 'McArthur Hwy #82', 'Santo Niño', 'San Jose', 'Nueva Ecija', 'Region III', 468),
(469, 'National Highway #80', 'San Roque', 'San Jose', 'Nueva Ecija', 'Region III', 469),
(470, 'National Highway #123', 'Poblacion', 'San Jose', 'Nueva Ecija', 'Region III', 470),
(471, 'Blk 12 Lot 4 #26', 'Santo Niño', 'Aliaga', 'Nueva Ecija', 'Region III', 471),
(472, 'Purok 3 #45', 'Bayanihan', 'Aliaga', 'Nueva Ecija', 'Region III', 472),
(473, 'A. Santos St. #33', 'San Roque', 'Aliaga', 'Nueva Ecija', 'Region III', 473),
(474, 'McArthur Hwy #57', 'Halang', 'Aliaga', 'Nueva Ecija', 'Region III', 474),
(475, 'Malvar St. #23', 'Santo Niño', 'Aliaga', 'Nueva Ecija', 'Region III', 475),
(476, 'A. Santos St. #28', 'Poblacion', 'Aliaga', 'Nueva Ecija', 'Region III', 476),
(477, 'A. Santos St. #6', 'Santo Niño', 'Gapan', 'Nueva Ecija', 'Region III', 477),
(478, 'Rizal Ave. #141', 'San Juan', 'Gapan', 'Nueva Ecija', 'Region III', 478),
(479, 'Malvar St. #112', 'San Roque', 'Gapan', 'Nueva Ecija', 'Region III', 479),
(480, 'National Highway #68', 'Mabini', 'Gapan', 'Nueva Ecija', 'Region III', 480),
(481, 'Malvar St. #14', 'Santo Niño', 'Gapan', 'Nueva Ecija', 'Region III', 481),
(482, 'A. Santos St. #24', 'Bayanihan', 'Aliaga', 'Nueva Ecija', 'Region III', 482),
(483, 'A. Santos St. #113', 'Bagong Bayan', 'Aliaga', 'Nueva Ecija', 'Region III', 483),
(484, 'Rizal Ave. #22', 'Santo Niño', 'Aliaga', 'Nueva Ecija', 'Region III', 484),
(485, 'Blk 12 Lot 4 #138', 'Bagong Bayan', 'Aliaga', 'Nueva Ecija', 'Region III', 485),
(486, 'Del Pilar St. #38', 'Halang', 'San Isidro', 'Nueva Ecija', 'Region III', 486),
(487, 'Purok 3 #71', 'Bayanihan', 'San Isidro', 'Nueva Ecija', 'Region III', 487),
(488, 'Blk 12 Lot 4 #125', 'Halang', 'San Jose', 'Nueva Ecija', 'Region III', 488),
(489, 'Blk 12 Lot 4 #10', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 489),
(490, 'A. Santos St. #80', 'Mabini', 'San Jose', 'Nueva Ecija', 'Region III', 490),
(491, 'A. Santos St. #107', 'Halang', 'San Jose', 'Nueva Ecija', 'Region III', 491),
(492, 'Mabini St. #64', 'Poblacion', 'San Jose', 'Nueva Ecija', 'Region III', 492),
(493, 'National Highway #102', 'San Juan', 'San Jose', 'Nueva Ecija', 'Region III', 493),
(494, 'McArthur Hwy #142', 'Santo Niño', 'San Jose', 'Nueva Ecija', 'Region III', 494),
(495, 'Mabini St. #122', 'San Roque', 'San Isidro', 'Nueva Ecija', 'Region III', 495),
(496, 'A. Santos St. #109', 'Santa Cruz', 'San Isidro', 'Nueva Ecija', 'Region III', 496),
(497, 'Brgy. Road #17', 'Santo Niño', 'Aliaga', 'Nueva Ecija', 'Region III', 497),
(498, 'Del Pilar St. #39', 'Bayanihan', 'Aliaga', 'Nueva Ecija', 'Region III', 498),
(499, 'Mabini St. #128', 'Mabini', 'Aliaga', 'Nueva Ecija', 'Region III', 499),
(500, 'Del Pilar St. #88', 'San Vicente', 'Aliaga', 'Nueva Ecija', 'Region III', 500),
(501, 'A. Santos St. #25', 'Bagong Bayan', 'Aliaga', 'Nueva Ecija', 'Region III', 501),
(502, 'Del Pilar St. #91', 'San Vicente', 'Aliaga', 'Nueva Ecija', 'Region III', 502),
(503, 'A. Santos St. #106', 'Poblacion', 'San Isidro', 'Nueva Ecija', 'Region III', 503),
(504, 'Purok 3 #47', 'San Juan', 'San Isidro', 'Nueva Ecija', 'Region III', 504),
(505, 'A. Santos St. #54', 'San Roque', 'San Isidro', 'Nueva Ecija', 'Region III', 505),
(506, 'Del Pilar St. #5', 'Poblacion', 'Gapan', 'Nueva Ecija', 'Region III', 506),
(507, 'McArthur Hwy #79', 'San Roque', 'Gapan', 'Nueva Ecija', 'Region III', 507),
(508, 'National Highway #87', 'Santa Cruz', 'Gapan', 'Nueva Ecija', 'Region III', 508),
(509, 'Mabini St. #97', 'Mabini', 'Cabanatuan', 'Nueva Ecija', 'Region III', 509),
(510, 'Rizal Ave. #107', 'Bagong Bayan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 510),
(511, 'Mabini St. #78', 'Santa Cruz', 'Cabanatuan', 'Nueva Ecija', 'Region III', 511),
(512, 'Rizal Ave. #131', 'Halang', 'Cabanatuan', 'Nueva Ecija', 'Region III', 512),
(513, 'Brgy. Road #85', 'San Vicente', 'San Isidro', 'Nueva Ecija', 'Region III', 513),
(514, 'Rizal Ave. #131', 'San Juan', 'San Isidro', 'Nueva Ecija', 'Region III', 514),
(515, 'Rizal Ave. #45', 'Poblacion', 'San Isidro', 'Nueva Ecija', 'Region III', 515),
(516, 'Purok 3 #88', 'San Roque', 'San Isidro', 'Nueva Ecija', 'Region III', 516),
(517, 'Blk 12 Lot 4 #43', 'San Juan', 'San Isidro', 'Nueva Ecija', 'Region III', 517),
(518, 'Brgy. Road #29', 'Santa Cruz', 'Palayan', 'Nueva Ecija', 'Region III', 518),
(519, 'National Highway #148', 'Halang', 'Palayan', 'Nueva Ecija', 'Region III', 519),
(520, 'Blk 12 Lot 4 #64', 'Bagong Bayan', 'Palayan', 'Nueva Ecija', 'Region III', 520),
(521, 'Malvar St. #130', 'Bagong Bayan', 'Palayan', 'Nueva Ecija', 'Region III', 521),
(522, 'Brgy. Road #23', 'Bagong Bayan', 'Aliaga', 'Nueva Ecija', 'Region III', 522),
(523, 'Blk 12 Lot 4 #10', 'Bayanihan', 'Aliaga', 'Nueva Ecija', 'Region III', 523),
(524, 'Del Pilar St. #117', 'Santo Niño', 'Aliaga', 'Nueva Ecija', 'Region III', 524),
(525, 'McArthur Hwy #122', 'Santo Niño', 'Aliaga', 'Nueva Ecija', 'Region III', 525),
(526, 'Rizal Ave. #66', 'Halang', 'San Jose', 'Nueva Ecija', 'Region III', 526),
(527, 'Purok 3 #28', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 527),
(528, 'Malvar St. #128', 'Poblacion', 'San Jose', 'Nueva Ecija', 'Region III', 528),
(529, 'McArthur Hwy #45', 'San Roque', 'San Jose', 'Nueva Ecija', 'Region III', 529),
(530, 'National Highway #81', 'Bayanihan', 'Gapan', 'Nueva Ecija', 'Region III', 530),
(531, 'Malvar St. #46', 'Bayanihan', 'Gapan', 'Nueva Ecija', 'Region III', 531),
(532, 'Blk 12 Lot 4 #137', 'Mabini', 'Gapan', 'Nueva Ecija', 'Region III', 532),
(533, 'Mabini St. #52', 'Mabini', 'Gapan', 'Nueva Ecija', 'Region III', 533),
(534, 'Blk 12 Lot 4 #61', 'Bayanihan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 534),
(535, 'Mabini St. #4', 'Mabini', 'Cabanatuan', 'Nueva Ecija', 'Region III', 535),
(536, 'Purok 3 #140', 'Halang', 'Cabanatuan', 'Nueva Ecija', 'Region III', 536),
(537, 'McArthur Hwy #66', 'Poblacion', 'Cabanatuan', 'Nueva Ecija', 'Region III', 537),
(538, 'McArthur Hwy #78', 'Bagong Bayan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 538),
(539, 'National Highway #41', 'Santa Cruz', 'Cabanatuan', 'Nueva Ecija', 'Region III', 539),
(540, 'Purok 3 #76', 'San Vicente', 'Cabanatuan', 'Nueva Ecija', 'Region III', 540),
(541, 'Mabini St. #133', 'Santo Niño', 'San Jose', 'Nueva Ecija', 'Region III', 541),
(542, 'Rizal Ave. #25', 'San Roque', 'San Jose', 'Nueva Ecija', 'Region III', 542),
(543, 'Del Pilar St. #138', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 543),
(544, 'Rizal Ave. #14', 'San Roque', 'San Jose', 'Nueva Ecija', 'Region III', 544),
(545, 'Rizal Ave. #92', 'Bayanihan', 'Gapan', 'Nueva Ecija', 'Region III', 545),
(546, 'Blk 12 Lot 4 #102', 'Poblacion', 'Gapan', 'Nueva Ecija', 'Region III', 546),
(547, 'A. Santos St. #37', 'Mabini', 'Gapan', 'Nueva Ecija', 'Region III', 547),
(548, 'Malvar St. #42', 'San Roque', 'San Jose', 'Nueva Ecija', 'Region III', 548),
(549, 'Mabini St. #141', 'Bagong Bayan', 'San Jose', 'Nueva Ecija', 'Region III', 549),
(550, 'Brgy. Road #85', 'Santo Niño', 'San Jose', 'Nueva Ecija', 'Region III', 550),
(551, 'Brgy. Road #116', 'Santo Niño', 'San Jose', 'Nueva Ecija', 'Region III', 551),
(552, 'Blk 12 Lot 4 #44', 'Poblacion', 'San Jose', 'Nueva Ecija', 'Region III', 552),
(553, 'Purok 3 #123', 'Bagong Bayan', 'San Jose', 'Nueva Ecija', 'Region III', 553),
(554, 'Mabini St. #130', 'Poblacion', 'Palayan', 'Nueva Ecija', 'Region III', 554),
(555, 'Brgy. Road #39', 'Santo Niño', 'Palayan', 'Nueva Ecija', 'Region III', 555),
(556, 'Rizal Ave. #102', 'Santo Niño', 'Palayan', 'Nueva Ecija', 'Region III', 556),
(557, 'Purok 3 #60', 'Poblacion', 'San Jose', 'Nueva Ecija', 'Region III', 557),
(558, 'Purok 3 #27', 'Bayanihan', 'San Jose', 'Nueva Ecija', 'Region III', 558),
(559, 'Blk 12 Lot 4 #94', 'Halang', 'San Jose', 'Nueva Ecija', 'Region III', 559),
(560, 'Purok 3 #125', 'Bagong Bayan', 'San Jose', 'Nueva Ecija', 'Region III', 560),
(561, 'Blk 12 Lot 4 #85', 'San Juan', 'Palayan', 'Nueva Ecija', 'Region III', 561),
(562, 'Mabini St. #63', 'Poblacion', 'Palayan', 'Nueva Ecija', 'Region III', 562),
(563, 'Brgy. Road #121', 'Bagong Bayan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 563),
(564, 'McArthur Hwy #131', 'Mabini', 'Cabanatuan', 'Nueva Ecija', 'Region III', 564),
(565, 'Blk 12 Lot 4 #34', 'San Juan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 565),
(566, 'McArthur Hwy #25', 'San Roque', 'Cabanatuan', 'Nueva Ecija', 'Region III', 566),
(567, 'Del Pilar St. #124', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 567),
(568, 'Del Pilar St. #22', 'Mabini', 'San Jose', 'Nueva Ecija', 'Region III', 568),
(569, 'McArthur Hwy #134', 'San Juan', 'San Jose', 'Nueva Ecija', 'Region III', 569),
(570, 'Blk 12 Lot 4 #150', 'Mabini', 'San Jose', 'Nueva Ecija', 'Region III', 570),
(571, 'Blk 12 Lot 4 #53', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 571),
(572, 'McArthur Hwy #89', 'Santa Cruz', 'San Jose', 'Nueva Ecija', 'Region III', 572),
(573, 'Blk 12 Lot 4 #23', 'San Juan', 'Gapan', 'Nueva Ecija', 'Region III', 573),
(574, 'Blk 12 Lot 4 #134', 'Mabini', 'Gapan', 'Nueva Ecija', 'Region III', 574),
(575, 'National Highway #74', 'San Vicente', 'Gapan', 'Nueva Ecija', 'Region III', 575),
(576, 'Mabini St. #93', 'San Vicente', 'Gapan', 'Nueva Ecija', 'Region III', 576),
(577, 'Blk 12 Lot 4 #52', 'Bayanihan', 'Gapan', 'Nueva Ecija', 'Region III', 577),
(578, 'McArthur Hwy #90', 'Santo Niño', 'Gapan', 'Nueva Ecija', 'Region III', 578),
(579, 'McArthur Hwy #65', 'Bagong Bayan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 579),
(580, 'McArthur Hwy #8', 'Bagong Bayan', 'Cabanatuan', 'Nueva Ecija', 'Region III', 580),
(581, 'Del Pilar St. #81', 'Santa Cruz', 'Cabanatuan', 'Nueva Ecija', 'Region III', 581),
(582, 'Rizal Ave. #103', 'Santo Niño', 'Cabanatuan', 'Nueva Ecija', 'Region III', 582),
(583, 'Del Pilar St. #64', 'Halang', 'Talavera', 'Nueva Ecija', 'Region III', 583),
(584, 'McArthur Hwy #2', 'Bayanihan', 'Talavera', 'Nueva Ecija', 'Region III', 584),
(585, 'Brgy. Road #47', 'Bayanihan', 'Talavera', 'Nueva Ecija', 'Region III', 585),
(586, 'Brgy. Road #139', 'Poblacion', 'Talavera', 'Nueva Ecija', 'Region III', 586),
(587, 'Purok 3 #3', 'Poblacion', 'Talavera', 'Nueva Ecija', 'Region III', 587),
(588, 'Malvar St. #141', 'Mabini', 'Talavera', 'Nueva Ecija', 'Region III', 588),
(589, 'McArthur Hwy #59', 'San Juan', 'Gapan', 'Nueva Ecija', 'Region III', 589),
(590, 'Malvar St. #122', 'Poblacion', 'Gapan', 'Nueva Ecija', 'Region III', 590),
(591, 'Purok 3 #125', 'Mabini', 'Gapan', 'Nueva Ecija', 'Region III', 591),
(592, 'Mabini St. #56', 'Mabini', 'Gapan', 'Nueva Ecija', 'Region III', 592),
(593, 'National Highway #66', 'Santo Niño', 'Gapan', 'Nueva Ecija', 'Region III', 593),
(594, 'Malvar St. #43', 'Santo Niño', 'Talavera', 'Nueva Ecija', 'Region III', 594),
(595, 'Del Pilar St. #81', 'Santo Niño', 'Talavera', 'Nueva Ecija', 'Region III', 595),
(596, 'McArthur Hwy #134', 'Bagong Bayan', 'Talavera', 'Nueva Ecija', 'Region III', 596),
(597, 'A. Santos St. #21', 'San Vicente', 'Talavera', 'Nueva Ecija', 'Region III', 597),
(598, 'Mabini St. #102', 'Bayanihan', 'Talavera', 'Nueva Ecija', 'Region III', 598),
(599, 'A. Santos St. #59', 'San Vicente', 'Talavera', 'Nueva Ecija', 'Region III', 599),
(600, '', '', '', '', '', 54),
(601, '77 San Pedro St.', 'Sumacab', 'Cabanatuan', 'Nueva Ecija', 'Region III', 600),
(602, '', '', '', '', '', 57),
(603, '', '', '', '', '', 83),
(604, 'Sampaguita', 'Poblacion Centro', 'Aliaga ', 'Nueva Ecija', 'Region III', 601),
(605, '77 San Pedro', 'Poblacion Central', 'Aliaga', 'Nueva Ecija', 'Region III', 602),
(606, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 603),
(607, 'Bukid St.', 'San Emeliano', 'Aliaga', 'Nueva Ecija', 'Ragion III', 604),
(608, 'Sampaguita', 'Poblacion Centro', 'Aliaga ', 'Nueva Ecija', 'Region III', 605),
(609, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 606),
(610, '77 San Pedro St.', 'Poblacion Centro', 'Aliaga ', 'Nueva Ecija', 'Region III', 607),
(611, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 608),
(612, 'Taga Diyan', 'Barangay Diyan', 'Aliaga ', 'Nueva Ecija', 'Region III', 609),
(613, 'Sampaguita', 'Poblacion Centro', 'Aliaga ', 'Nueva Ecija', 'Region III', 610),
(614, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 611),
(615, '77 San Pedro St.', 'Sumacab', 'Cabanatuan', 'Nueva Ecija', 'Region III', 48),
(616, 'Primavera St.', 'Poblacion Centro', 'Cabanatuan', 'Nueva Ecija', 'Region III', 612),
(617, '77 San Pedro St.', 'Poblacion Centro', 'Aliaga ', 'Nueva Ecija', 'Region III', 613),
(618, '77 San Pedro', 'Poblacion Central', 'Aliaga', 'Nueva Ecija', 'Region III', 614),
(619, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 615),
(620, 'Duon', 'San Emeliano', 'Aliaga', 'Nueva Ecija', 'Ragion III', 616),
(621, '', '', '', '', '', 100),
(622, '77 San Pedro St.', 'Poblacion Centro', 'Aliaga ', 'Nueva Ecija', 'Region III', 617),
(623, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 618),
(624, '77 San Pedro St.', 'Poblacion Centro', 'Aliaga ', 'Nueva Ecija', 'Region III', 619),
(625, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 620),
(626, '77 San Pedro St.', 'Poblacion Centro', 'Aliaga', 'Nueva Ecija', 'Region III', 621),
(627, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 622),
(628, 'Sampaguita', 'Poblacion Centro', 'Aliaga', 'Nueva Ecija', 'Region III', 623),
(629, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 624),
(630, 'Sampaguita', 'Poblacion Centro', 'Aliaga', 'Nueva Ecija', 'Region III', 625),
(631, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 626),
(632, 'Sampaguita', 'Poblacion Centro', 'Aliaga', 'Nueva Ecija', 'Region III', 627),
(633, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 628),
(634, '77 San Pedro St.', 'Poblacion Centro', 'Aliaga', 'Nueva Ecija', 'Region III', 629),
(635, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 630),
(636, 'Sampaguita', 'Poblacion Centro', 'Aliaga', 'Nueva Ecija', 'Region III', 631),
(637, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 632),
(638, '77 San Pedro St.', 'Poblacion Centro', 'Aliaga', 'Nueva Ecija', 'Region III', 633),
(639, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 634),
(640, 'Sampaguita', 'Poblacion Centro', 'Aliaga', 'Nueva Ecija', 'Region III', 635),
(641, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 636),
(642, 'Sampaguita', 'Poblacion Centro', 'Aliaga', 'Nueva Ecija', 'Region III', 637),
(643, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 638),
(644, 'Sampaguita', 'Poblacion Centro', 'Aliaga', 'Nueva Ecija', 'Region III', 639),
(645, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 640),
(646, 'Sampaguita', 'Poblacion Centro', 'Aliaga', 'Nueva Ecija', 'Region III', 641),
(647, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 642),
(648, 'Bukid St.', 'San Emeliano', 'Papaya', 'Nueva Ecija', 'Ragion III', 643),
(649, '77 San Pedro St.', 'Poblacion Centro', 'Aliaga', 'Nueva Ecija', 'Region III', 644),
(650, '44 Sa Gilid St.', 'Bibiclat', 'Primavera', 'Nueva Ecija', 'Region III', 645),
(651, 'Bukid St.', 'San Emeliano', 'Aliaga', 'Nueva Ecija', 'Ragion III', 646);

-- --------------------------------------------------------

--
-- Table structure for table `denial_comment`
--

CREATE TABLE `denial_comment` (
  `ID` int(11) NOT NULL,
  `Docket_Number` varchar(50) DEFAULT NULL,
  `Type` enum('Subpoena','Resolution') NOT NULL,
  `Comment` text NOT NULL,
  `Created_By` int(11) DEFAULT NULL,
  `Timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `denial_comment`
--

INSERT INTO `denial_comment` (`ID`, `Docket_Number`, `Type`, `Comment`, `Created_By`, `Timestamp`) VALUES
(1, 'III-09-INV-25J-0001', 'Subpoena', 'panget', 5, '2025-10-30 07:27:17'),
(2, 'III-09-INV-25J-0001', 'Resolution', 'mali', 1, '2025-10-30 08:03:47'),
(3, 'III-09-INV-25J-0002', 'Subpoena', 'panget', 1, '2025-10-30 08:11:32'),
(4, 'III-09-INV-25K-0001', 'Subpoena', 'Panget\r\n', 12, '2025-11-01 13:08:25'),
(5, 'III-09-INV-25K-0001', 'Resolution', 'Panget', 1, '2025-11-01 13:11:56'),
(6, 'III-09-INV-25K-0002', 'Subpoena', 'Not Good', 10, '2025-11-07 00:57:04'),
(7, 'III-09-INV-25K-0002', 'Resolution', 'Not good', 1, '2025-11-07 01:00:41'),
(8, 'III-09-INV-25K-0003', 'Subpoena', 'panget\r\n', 1, '2025-11-07 07:33:41'),
(9, 'III-09-INV-25K-0035-0036-0037-0038', 'Subpoena', 'Panget', 1, '2025-11-15 14:34:18'),
(10, 'III-09-INV-25K-0042-0044', 'Subpoena', 'Panget', 5, '2025-11-15 14:34:35');

-- --------------------------------------------------------

--
-- Table structure for table `involved_party`
--

CREATE TABLE `involved_party` (
  `PERSON_ID` int(11) NOT NULL,
  `Docket_Number` varchar(50) NOT NULL,
  `Role` enum('Complainant','Respondent') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `involved_party`
--

INSERT INTO `involved_party` (`PERSON_ID`, `Docket_Number`, `Role`) VALUES
(200, 'III-09-INV-25A-0001', 'Complainant'),
(201, 'III-09-INV-25A-0001', 'Respondent'),
(202, 'III-09-INV-25A-0002', 'Complainant'),
(203, 'III-09-INV-25A-0002', 'Complainant'),
(204, 'III-09-INV-25A-0002', 'Respondent'),
(205, 'III-09-INV-25A-0002', 'Respondent'),
(206, 'III-09-INV-25A-0002', 'Respondent'),
(207, 'III-09-INV-25A-0003', 'Complainant'),
(208, 'III-09-INV-25A-0003', 'Complainant'),
(209, 'III-09-INV-25A-0003', 'Respondent'),
(210, 'III-09-INV-25A-0003', 'Respondent'),
(211, 'III-09-INV-25A-0004', 'Complainant'),
(212, 'III-09-INV-25A-0004', 'Respondent'),
(213, 'III-09-INV-25A-0004', 'Respondent'),
(214, 'III-09-INV-25A-0004', 'Respondent'),
(215, 'III-09-INV-25A-0005', 'Complainant'),
(216, 'III-09-INV-25A-0005', 'Complainant'),
(217, 'III-09-INV-25A-0005', 'Respondent'),
(218, 'III-09-INV-25A-0006', 'Complainant'),
(219, 'III-09-INV-25A-0006', 'Complainant'),
(220, 'III-09-INV-25A-0006', 'Respondent'),
(221, 'III-09-INV-25A-0007', 'Complainant'),
(222, 'III-09-INV-25A-0007', 'Complainant'),
(223, 'III-09-INV-25A-0007', 'Respondent'),
(224, 'III-09-INV-25A-0007', 'Respondent'),
(225, 'III-09-INV-25A-0008', 'Complainant'),
(226, 'III-09-INV-25A-0008', 'Respondent'),
(227, 'III-09-INV-25A-0009', 'Complainant'),
(228, 'III-09-INV-25A-0009', 'Respondent'),
(229, 'III-09-INV-25A-0009', 'Respondent'),
(230, 'III-09-INV-25A-0009', 'Respondent'),
(231, 'III-09-INV-25A-0010', 'Complainant'),
(232, 'III-09-INV-25A-0010', 'Complainant'),
(233, 'III-09-INV-25A-0010', 'Respondent'),
(234, 'III-09-INV-25A-0010', 'Respondent'),
(235, 'III-09-INV-25A-0011', 'Complainant'),
(236, 'III-09-INV-25A-0011', 'Complainant'),
(237, 'III-09-INV-25A-0011', 'Complainant'),
(238, 'III-09-INV-25A-0011', 'Respondent'),
(239, 'III-09-INV-25A-0012', 'Complainant'),
(240, 'III-09-INV-25A-0012', 'Complainant'),
(241, 'III-09-INV-25A-0012', 'Complainant'),
(242, 'III-09-INV-25A-0012', 'Respondent'),
(243, 'III-09-INV-25A-0012', 'Respondent'),
(244, 'III-09-INV-25A-0013', 'Complainant'),
(245, 'III-09-INV-25A-0013', 'Respondent'),
(246, 'III-09-INV-25A-0013', 'Respondent'),
(247, 'III-09-INV-25A-0014', 'Complainant'),
(248, 'III-09-INV-25A-0014', 'Complainant'),
(249, 'III-09-INV-25A-0014', 'Respondent'),
(250, 'III-09-INV-25A-0015', 'Complainant'),
(251, 'III-09-INV-25A-0015', 'Complainant'),
(252, 'III-09-INV-25A-0015', 'Complainant'),
(253, 'III-09-INV-25A-0015', 'Respondent'),
(254, 'III-09-INV-25A-0015', 'Respondent'),
(255, 'III-09-INV-25A-0015', 'Respondent'),
(256, 'III-09-INV-25A-0016', 'Complainant'),
(257, 'III-09-INV-25A-0016', 'Respondent'),
(258, 'III-09-INV-25A-0017', 'Complainant'),
(259, 'III-09-INV-25A-0017', 'Complainant'),
(260, 'III-09-INV-25A-0017', 'Respondent'),
(261, 'III-09-INV-25A-0018', 'Complainant'),
(262, 'III-09-INV-25A-0018', 'Respondent'),
(263, 'III-09-INV-25A-0019', 'Complainant'),
(264, 'III-09-INV-25A-0019', 'Complainant'),
(265, 'III-09-INV-25A-0019', 'Complainant'),
(266, 'III-09-INV-25A-0019', 'Respondent'),
(267, 'III-09-INV-25A-0019', 'Respondent'),
(268, 'III-09-INV-25A-0020', 'Complainant'),
(269, 'III-09-INV-25A-0020', 'Complainant'),
(270, 'III-09-INV-25A-0020', 'Respondent'),
(271, 'III-09-INV-25A-0020', 'Respondent'),
(272, 'III-09-INV-25A-0020', 'Respondent'),
(273, 'III-09-INV-25A-0021', 'Complainant'),
(274, 'III-09-INV-25A-0021', 'Complainant'),
(275, 'III-09-INV-25A-0021', 'Complainant'),
(276, 'III-09-INV-25A-0021', 'Respondent'),
(277, 'III-09-INV-25A-0022', 'Complainant'),
(278, 'III-09-INV-25A-0022', 'Complainant'),
(279, 'III-09-INV-25A-0022', 'Complainant'),
(280, 'III-09-INV-25A-0022', 'Respondent'),
(281, 'III-09-INV-25A-0023', 'Complainant'),
(282, 'III-09-INV-25A-0023', 'Complainant'),
(283, 'III-09-INV-25A-0023', 'Complainant'),
(284, 'III-09-INV-25A-0023', 'Respondent'),
(285, 'III-09-INV-25A-0023', 'Respondent'),
(286, 'III-09-INV-25A-0024', 'Complainant'),
(287, 'III-09-INV-25A-0024', 'Complainant'),
(288, 'III-09-INV-25A-0024', 'Complainant'),
(289, 'III-09-INV-25A-0024', 'Respondent'),
(290, 'III-09-INV-25A-0024', 'Respondent'),
(291, 'III-09-INV-25A-0025', 'Complainant'),
(292, 'III-09-INV-25A-0025', 'Complainant'),
(293, 'III-09-INV-25A-0025', 'Respondent'),
(294, 'III-09-INV-25A-0026', 'Complainant'),
(295, 'III-09-INV-25A-0026', 'Complainant'),
(296, 'III-09-INV-25A-0026', 'Respondent'),
(297, 'III-09-INV-25A-0026', 'Respondent'),
(298, 'III-09-INV-25A-0026', 'Respondent'),
(299, 'III-09-INV-25A-0027', 'Complainant'),
(300, 'III-09-INV-25A-0027', 'Complainant'),
(301, 'III-09-INV-25A-0027', 'Complainant'),
(302, 'III-09-INV-25A-0027', 'Respondent'),
(303, 'III-09-INV-25A-0027', 'Respondent'),
(304, 'III-09-INV-25A-0027', 'Respondent'),
(305, 'III-09-INV-25A-0028', 'Complainant'),
(306, 'III-09-INV-25A-0028', 'Complainant'),
(307, 'III-09-INV-25A-0028', 'Respondent'),
(308, 'III-09-INV-25A-0028', 'Respondent'),
(309, 'III-09-INV-25A-0029', 'Complainant'),
(310, 'III-09-INV-25A-0029', 'Respondent'),
(311, 'III-09-INV-25A-0029', 'Respondent'),
(312, 'III-09-INV-25A-0030', 'Complainant'),
(313, 'III-09-INV-25A-0030', 'Complainant'),
(314, 'III-09-INV-25A-0030', 'Respondent'),
(315, 'III-09-INV-25A-0030', 'Respondent'),
(316, 'III-09-INV-25A-0031', 'Complainant'),
(317, 'III-09-INV-25A-0031', 'Complainant'),
(318, 'III-09-INV-25A-0031', 'Complainant'),
(319, 'III-09-INV-25A-0031', 'Respondent'),
(320, 'III-09-INV-25B-0032', 'Complainant'),
(321, 'III-09-INV-25B-0032', 'Respondent'),
(322, 'III-09-INV-25B-0033', 'Complainant'),
(323, 'III-09-INV-25B-0033', 'Complainant'),
(324, 'III-09-INV-25B-0033', 'Respondent'),
(325, 'III-09-INV-25B-0033', 'Respondent'),
(326, 'III-09-INV-25B-0034', 'Complainant'),
(327, 'III-09-INV-25B-0034', 'Complainant'),
(328, 'III-09-INV-25B-0034', 'Respondent'),
(329, 'III-09-INV-25B-0034', 'Respondent'),
(330, 'III-09-INV-25B-0035', 'Complainant'),
(331, 'III-09-INV-25B-0035', 'Respondent'),
(332, 'III-09-INV-25B-0035', 'Respondent'),
(333, 'III-09-INV-25B-0036', 'Complainant'),
(334, 'III-09-INV-25B-0036', 'Complainant'),
(335, 'III-09-INV-25B-0036', 'Respondent'),
(336, 'III-09-INV-25B-0036', 'Respondent'),
(337, 'III-09-INV-25B-0037', 'Complainant'),
(338, 'III-09-INV-25B-0037', 'Respondent'),
(339, 'III-09-INV-25B-0037', 'Respondent'),
(340, 'III-09-INV-25B-0037', 'Respondent'),
(341, 'III-09-INV-25B-0038', 'Complainant'),
(342, 'III-09-INV-25B-0038', 'Complainant'),
(343, 'III-09-INV-25B-0038', 'Complainant'),
(344, 'III-09-INV-25B-0038', 'Respondent'),
(345, 'III-09-INV-25B-0039', 'Complainant'),
(346, 'III-09-INV-25B-0039', 'Complainant'),
(347, 'III-09-INV-25B-0039', 'Complainant'),
(348, 'III-09-INV-25B-0039', 'Respondent'),
(349, 'III-09-INV-25B-0039', 'Respondent'),
(350, 'III-09-INV-25B-0039', 'Respondent'),
(351, 'III-09-INV-25B-0040', 'Complainant'),
(352, 'III-09-INV-25B-0040', 'Complainant'),
(353, 'III-09-INV-25B-0040', 'Respondent'),
(354, 'III-09-INV-25B-0040', 'Respondent'),
(355, 'III-09-INV-25B-0040', 'Respondent'),
(356, 'III-09-INV-25B-0041', 'Complainant'),
(357, 'III-09-INV-25B-0041', 'Respondent'),
(358, 'III-09-INV-25B-0042', 'Complainant'),
(359, 'III-09-INV-25B-0042', 'Complainant'),
(360, 'III-09-INV-25B-0042', 'Complainant'),
(361, 'III-09-INV-25B-0042', 'Respondent'),
(362, 'III-09-INV-25B-0042', 'Respondent'),
(363, 'III-09-INV-25B-0042', 'Respondent'),
(364, 'III-09-INV-25B-0043', 'Complainant'),
(365, 'III-09-INV-25B-0043', 'Respondent'),
(366, 'III-09-INV-25B-0043', 'Respondent'),
(367, 'III-09-INV-25B-0044', 'Complainant'),
(368, 'III-09-INV-25B-0044', 'Complainant'),
(369, 'III-09-INV-25B-0044', 'Complainant'),
(370, 'III-09-INV-25B-0044', 'Respondent'),
(371, 'III-09-INV-25B-0045', 'Complainant'),
(372, 'III-09-INV-25B-0045', 'Complainant'),
(373, 'III-09-INV-25B-0045', 'Respondent'),
(374, 'III-09-INV-25B-0046', 'Complainant'),
(375, 'III-09-INV-25B-0046', 'Complainant'),
(376, 'III-09-INV-25B-0046', 'Complainant'),
(377, 'III-09-INV-25B-0046', 'Respondent'),
(378, 'III-09-INV-25B-0046', 'Respondent'),
(379, 'III-09-INV-25B-0047', 'Complainant'),
(380, 'III-09-INV-25B-0047', 'Complainant'),
(381, 'III-09-INV-25B-0047', 'Complainant'),
(382, 'III-09-INV-25B-0047', 'Respondent'),
(383, 'III-09-INV-25B-0047', 'Respondent'),
(384, 'III-09-INV-25B-0047', 'Respondent'),
(385, 'III-09-INV-25B-0048', 'Complainant'),
(386, 'III-09-INV-25B-0048', 'Complainant'),
(387, 'III-09-INV-25B-0048', 'Respondent'),
(388, 'III-09-INV-25B-0048', 'Respondent'),
(389, 'III-09-INV-25B-0048', 'Respondent'),
(390, 'III-09-INV-25B-0049', 'Complainant'),
(391, 'III-09-INV-25B-0049', 'Complainant'),
(392, 'III-09-INV-25B-0049', 'Complainant'),
(393, 'III-09-INV-25B-0049', 'Respondent'),
(394, 'III-09-INV-25B-0049', 'Respondent'),
(395, 'III-09-INV-25B-0049', 'Respondent'),
(396, 'III-09-INV-25B-0050', 'Complainant'),
(397, 'III-09-INV-25B-0050', 'Complainant'),
(398, 'III-09-INV-25B-0050', 'Complainant'),
(399, 'III-09-INV-25B-0050', 'Respondent'),
(400, 'III-09-INV-25B-0050', 'Respondent'),
(401, 'III-09-INV-25B-0051', 'Complainant'),
(402, 'III-09-INV-25B-0051', 'Complainant'),
(403, 'III-09-INV-25B-0051', 'Complainant'),
(404, 'III-09-INV-25B-0051', 'Respondent'),
(405, 'III-09-INV-25B-0052', 'Complainant'),
(406, 'III-09-INV-25B-0052', 'Complainant'),
(407, 'III-09-INV-25B-0052', 'Respondent'),
(408, 'III-09-INV-25B-0052', 'Respondent'),
(409, 'III-09-INV-25B-0053', 'Complainant'),
(410, 'III-09-INV-25B-0053', 'Complainant'),
(411, 'III-09-INV-25B-0053', 'Respondent'),
(412, 'III-09-INV-25B-0054', 'Complainant'),
(413, 'III-09-INV-25B-0054', 'Complainant'),
(414, 'III-09-INV-25B-0054', 'Complainant'),
(415, 'III-09-INV-25B-0054', 'Respondent'),
(416, 'III-09-INV-25B-0055', 'Complainant'),
(417, 'III-09-INV-25B-0055', 'Respondent'),
(418, 'III-09-INV-25B-0055', 'Respondent'),
(419, 'III-09-INV-25B-0056', 'Complainant'),
(420, 'III-09-INV-25B-0056', 'Complainant'),
(421, 'III-09-INV-25B-0056', 'Complainant'),
(422, 'III-09-INV-25B-0056', 'Respondent'),
(423, 'III-09-INV-25B-0057', 'Complainant'),
(424, 'III-09-INV-25B-0057', 'Complainant'),
(425, 'III-09-INV-25B-0057', 'Respondent'),
(426, 'III-09-INV-25B-0057', 'Respondent'),
(427, 'III-09-INV-25B-0057', 'Respondent'),
(428, 'III-09-INV-25B-0058', 'Complainant'),
(429, 'III-09-INV-25B-0058', 'Respondent'),
(430, 'III-09-INV-25B-0058', 'Respondent'),
(431, 'III-09-INV-25B-0059', 'Complainant'),
(432, 'III-09-INV-25B-0059', 'Respondent'),
(433, 'III-09-INV-25C-0060', 'Complainant'),
(434, 'III-09-INV-25C-0060', 'Complainant'),
(435, 'III-09-INV-25C-0060', 'Respondent'),
(436, 'III-09-INV-25C-0061', 'Complainant'),
(437, 'III-09-INV-25C-0061', 'Respondent'),
(438, 'III-09-INV-25C-0061', 'Respondent'),
(439, 'III-09-INV-25C-0061', 'Respondent'),
(440, 'III-09-INV-25C-0062', 'Complainant'),
(441, 'III-09-INV-25C-0062', 'Respondent'),
(442, 'III-09-INV-25C-0063', 'Complainant'),
(443, 'III-09-INV-25C-0063', 'Complainant'),
(444, 'III-09-INV-25C-0063', 'Respondent'),
(445, 'III-09-INV-25C-0063', 'Respondent'),
(446, 'III-09-INV-25C-0063', 'Respondent'),
(447, 'III-09-INV-25C-0064', 'Complainant'),
(448, 'III-09-INV-25C-0064', 'Complainant'),
(449, 'III-09-INV-25C-0064', 'Complainant'),
(450, 'III-09-INV-25C-0064', 'Respondent'),
(451, 'III-09-INV-25C-0064', 'Respondent'),
(452, 'III-09-INV-25C-0064', 'Respondent'),
(453, 'III-09-INV-25C-0065', 'Complainant'),
(454, 'III-09-INV-25C-0065', 'Complainant'),
(455, 'III-09-INV-25C-0065', 'Complainant'),
(456, 'III-09-INV-25C-0065', 'Respondent'),
(457, 'III-09-INV-25C-0065', 'Respondent'),
(458, 'III-09-INV-25C-0065', 'Respondent'),
(459, 'III-09-INV-25C-0066', 'Complainant'),
(460, 'III-09-INV-25C-0066', 'Respondent'),
(461, 'III-09-INV-25C-0066', 'Respondent'),
(462, 'III-09-INV-25C-0067', 'Complainant'),
(463, 'III-09-INV-25C-0067', 'Complainant'),
(464, 'III-09-INV-25C-0067', 'Complainant'),
(465, 'III-09-INV-25C-0067', 'Respondent'),
(466, 'III-09-INV-25C-0068', 'Complainant'),
(467, 'III-09-INV-25C-0068', 'Complainant'),
(468, 'III-09-INV-25C-0068', 'Respondent'),
(469, 'III-09-INV-25C-0068', 'Respondent'),
(470, 'III-09-INV-25C-0068', 'Respondent'),
(471, 'III-09-INV-25C-0069', 'Complainant'),
(472, 'III-09-INV-25C-0069', 'Complainant'),
(473, 'III-09-INV-25C-0069', 'Complainant'),
(474, 'III-09-INV-25C-0069', 'Respondent'),
(475, 'III-09-INV-25C-0069', 'Respondent'),
(476, 'III-09-INV-25C-0069', 'Respondent'),
(477, 'III-09-INV-25C-0070', 'Complainant'),
(478, 'III-09-INV-25C-0070', 'Complainant'),
(479, 'III-09-INV-25C-0070', 'Complainant'),
(480, 'III-09-INV-25C-0070', 'Respondent'),
(481, 'III-09-INV-25C-0070', 'Respondent'),
(482, 'III-09-INV-25C-0071', 'Complainant'),
(483, 'III-09-INV-25C-0071', 'Respondent'),
(484, 'III-09-INV-25C-0071', 'Respondent'),
(485, 'III-09-INV-25C-0071', 'Respondent'),
(486, 'III-09-INV-25C-0072', 'Complainant'),
(487, 'III-09-INV-25C-0072', 'Respondent'),
(488, 'III-09-INV-25C-0073', 'Complainant'),
(489, 'III-09-INV-25C-0073', 'Complainant'),
(490, 'III-09-INV-25C-0073', 'Complainant'),
(491, 'III-09-INV-25C-0073', 'Respondent'),
(492, 'III-09-INV-25C-0074', 'Complainant'),
(493, 'III-09-INV-25C-0074', 'Respondent'),
(494, 'III-09-INV-25C-0074', 'Respondent'),
(495, 'III-09-INV-25C-0075', 'Complainant'),
(496, 'III-09-INV-25C-0075', 'Respondent'),
(497, 'III-09-INV-25C-0076', 'Complainant'),
(498, 'III-09-INV-25C-0076', 'Complainant'),
(499, 'III-09-INV-25C-0076', 'Complainant'),
(500, 'III-09-INV-25C-0076', 'Respondent'),
(501, 'III-09-INV-25C-0076', 'Respondent'),
(502, 'III-09-INV-25C-0076', 'Respondent'),
(503, 'III-09-INV-25C-0077', 'Complainant'),
(504, 'III-09-INV-25C-0077', 'Complainant'),
(505, 'III-09-INV-25C-0077', 'Respondent'),
(506, 'III-09-INV-25C-0078', 'Complainant'),
(507, 'III-09-INV-25C-0078', 'Complainant'),
(508, 'III-09-INV-25C-0078', 'Respondent'),
(509, 'III-09-INV-25C-0079', 'Complainant'),
(510, 'III-09-INV-25C-0079', 'Complainant'),
(511, 'III-09-INV-25C-0079', 'Complainant'),
(512, 'III-09-INV-25C-0079', 'Respondent'),
(513, 'III-09-INV-25C-0080', 'Complainant'),
(514, 'III-09-INV-25C-0080', 'Respondent'),
(515, 'III-09-INV-25C-0080', 'Respondent'),
(516, 'III-09-INV-25C-0081', 'Complainant'),
(517, 'III-09-INV-25C-0081', 'Respondent'),
(518, 'III-09-INV-25C-0082', 'Complainant'),
(519, 'III-09-INV-25C-0082', 'Respondent'),
(520, 'III-09-INV-25C-0082', 'Respondent'),
(521, 'III-09-INV-25C-0082', 'Respondent'),
(522, 'III-09-INV-25C-0083', 'Complainant'),
(523, 'III-09-INV-25C-0083', 'Respondent'),
(524, 'III-09-INV-25C-0083', 'Respondent'),
(525, 'III-09-INV-25C-0083', 'Respondent'),
(526, 'III-09-INV-25C-0084', 'Complainant'),
(527, 'III-09-INV-25C-0084', 'Complainant'),
(528, 'III-09-INV-25C-0084', 'Complainant'),
(529, 'III-09-INV-25C-0084', 'Respondent'),
(530, 'III-09-INV-25C-0085', 'Complainant'),
(531, 'III-09-INV-25C-0085', 'Complainant'),
(532, 'III-09-INV-25C-0085', 'Respondent'),
(533, 'III-09-INV-25C-0085', 'Respondent'),
(534, 'III-09-INV-25C-0086', 'Complainant'),
(535, 'III-09-INV-25C-0086', 'Respondent'),
(536, 'III-09-INV-25C-0086', 'Respondent'),
(537, 'III-09-INV-25C-0087', 'Complainant'),
(538, 'III-09-INV-25C-0087', 'Complainant'),
(539, 'III-09-INV-25C-0087', 'Complainant'),
(540, 'III-09-INV-25C-0087', 'Respondent'),
(541, 'III-09-INV-25C-0088', 'Complainant'),
(542, 'III-09-INV-25C-0088', 'Respondent'),
(543, 'III-09-INV-25C-0088', 'Respondent'),
(544, 'III-09-INV-25C-0088', 'Respondent'),
(545, 'III-09-INV-25C-0089', 'Complainant'),
(546, 'III-09-INV-25C-0089', 'Respondent'),
(547, 'III-09-INV-25C-0089', 'Respondent'),
(548, 'III-09-INV-25C-0090', 'Complainant'),
(549, 'III-09-INV-25C-0090', 'Complainant'),
(550, 'III-09-INV-25C-0090', 'Complainant'),
(551, 'III-09-INV-25C-0090', 'Respondent'),
(552, 'III-09-INV-25C-0090', 'Respondent'),
(553, 'III-09-INV-25C-0090', 'Respondent'),
(554, 'III-09-INV-25D-0091', 'Complainant'),
(555, 'III-09-INV-25D-0091', 'Respondent'),
(556, 'III-09-INV-25D-0091', 'Respondent'),
(557, 'III-09-INV-25D-0092', 'Complainant'),
(558, 'III-09-INV-25D-0092', 'Respondent'),
(559, 'III-09-INV-25D-0092', 'Respondent'),
(560, 'III-09-INV-25D-0092', 'Respondent'),
(561, 'III-09-INV-25D-0093', 'Complainant'),
(562, 'III-09-INV-25D-0093', 'Respondent'),
(563, 'III-09-INV-25D-0094', 'Complainant'),
(564, 'III-09-INV-25D-0094', 'Respondent'),
(565, 'III-09-INV-25D-0094', 'Respondent'),
(566, 'III-09-INV-25D-0094', 'Respondent'),
(567, 'III-09-INV-25D-0095', 'Complainant'),
(568, 'III-09-INV-25D-0095', 'Complainant'),
(569, 'III-09-INV-25D-0095', 'Complainant'),
(570, 'III-09-INV-25D-0095', 'Respondent'),
(571, 'III-09-INV-25D-0095', 'Respondent'),
(572, 'III-09-INV-25D-0095', 'Respondent'),
(573, 'III-09-INV-25D-0096', 'Complainant'),
(574, 'III-09-INV-25D-0096', 'Complainant'),
(575, 'III-09-INV-25D-0096', 'Complainant'),
(576, 'III-09-INV-25D-0096', 'Respondent'),
(577, 'III-09-INV-25D-0096', 'Respondent'),
(578, 'III-09-INV-25D-0096', 'Respondent'),
(579, 'III-09-INV-25D-0097', 'Complainant'),
(580, 'III-09-INV-25D-0097', 'Complainant'),
(581, 'III-09-INV-25D-0097', 'Complainant'),
(582, 'III-09-INV-25D-0097', 'Respondent'),
(583, 'III-09-INV-25D-0098', 'Complainant'),
(584, 'III-09-INV-25D-0098', 'Complainant'),
(585, 'III-09-INV-25D-0098', 'Complainant'),
(586, 'III-09-INV-25D-0098', 'Respondent'),
(587, 'III-09-INV-25D-0098', 'Respondent'),
(588, 'III-09-INV-25D-0098', 'Respondent'),
(589, 'III-09-INV-25D-0099', 'Complainant'),
(590, 'III-09-INV-25D-0099', 'Complainant'),
(591, 'III-09-INV-25D-0099', 'Respondent'),
(592, 'III-09-INV-25D-0099', 'Respondent'),
(593, 'III-09-INV-25D-0099', 'Respondent'),
(594, 'III-09-INV-25D-0100', 'Complainant'),
(595, 'III-09-INV-25D-0100', 'Complainant'),
(596, 'III-09-INV-25D-0100', 'Complainant'),
(597, 'III-09-INV-25D-0100', 'Respondent'),
(598, 'III-09-INV-25D-0100', 'Respondent'),
(599, 'III-09-INV-25D-0100', 'Respondent'),
(601, 'III-09-INV-25J-0001', 'Complainant'),
(602, 'III-09-INV-25J-0001', 'Complainant'),
(603, 'III-09-INV-25J-0001', 'Respondent'),
(604, 'III-09-INV-25J-0001', 'Respondent'),
(605, 'III-09-INV-25J-0002', 'Complainant'),
(606, 'III-09-INV-25J-0002', 'Respondent'),
(607, 'III-09-INV-25J-0003', 'Complainant'),
(608, 'III-09-INV-25J-0003', 'Respondent'),
(610, 'III-09-INV-25K-0001', 'Complainant'),
(611, 'III-09-INV-25K-0001', 'Respondent'),
(614, 'III-09-INV-25K-0002', 'Complainant'),
(616, 'III-09-INV-25K-0002', 'Respondent'),
(617, 'III-09-INV-25K-0002', 'Complainant'),
(618, 'III-09-INV-25K-0002', 'Respondent'),
(619, 'III-09-INV-25K-0003', 'Complainant'),
(620, 'III-09-INV-25K-0003', 'Respondent'),
(621, 'III-09-INV-25K-0004-0005-0006', 'Complainant'),
(622, 'III-09-INV-25K-0004-0005-0006', 'Respondent'),
(623, 'III-09-INV-25K-0007-0008-0009', 'Complainant'),
(624, 'III-09-INV-25K-0007-0008-0009', 'Respondent'),
(625, 'III-09-INV-25K-0010-0011-0012', 'Complainant'),
(626, 'III-09-INV-25K-0010-0011-0012', 'Respondent'),
(627, 'III-09-INV-25K-0013-0014-0015', 'Complainant'),
(628, 'III-09-INV-25K-0013-0014-0015', 'Respondent'),
(629, 'III-09-INV-25K-0016-0017-0018-0019', 'Complainant'),
(630, 'III-09-INV-25K-0016-0017-0018-0019', 'Respondent'),
(631, 'III-09-INV-25K-0020-0021-0022', 'Complainant'),
(632, 'III-09-INV-25K-0020-0021-0022', 'Respondent'),
(633, 'III-09-INV-25K-0023-0024-0025-0026', 'Complainant'),
(634, 'III-09-INV-25K-0023-0024-0025-0026', 'Respondent'),
(635, 'III-09-INV-25K-0027-0028-0029-0030', 'Complainant'),
(636, 'III-09-INV-25K-0027-0028-0029-0030', 'Respondent'),
(637, 'III-09-INV-25K-0031-0032-0033-0034', 'Complainant'),
(638, 'III-09-INV-25K-0031-0032-0033-0034', 'Respondent'),
(639, 'III-09-INV-25K-0035-0036-0037-0038', 'Complainant'),
(640, 'III-09-INV-25K-0035-0036-0037-0038', 'Respondent'),
(641, 'III-09-INV-25K-0039-0041', 'Complainant'),
(642, 'III-09-INV-25K-0039-0041', 'Respondent'),
(643, 'III-09-INV-25K-0039-0041', 'Respondent'),
(644, 'III-09-INV-25K-0042-0044', 'Complainant'),
(645, 'III-09-INV-25K-0042-0044', 'Respondent'),
(646, 'III-09-INV-25K-0042-0044', 'Respondent');

-- --------------------------------------------------------

--
-- Table structure for table `log_table`
--

CREATE TABLE `log_table` (
  `LOG_ID` int(11) NOT NULL,
  `USER_ID` int(11) DEFAULT NULL,
  `Action` text DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_table`
--

INSERT INTO `log_table` (`LOG_ID`, `USER_ID`, `Action`, `Timestamp`) VALUES
(1, 1, 'Created subpoena III-09-INV-25F-0001', '2025-06-11 15:46:29'),
(2, 1, 'Created subpoena III-09-INV-25F-0002', '2025-06-13 14:41:39'),
(3, 1, 'Created subpoena III-09-INV-25F-0003', '2025-06-13 19:52:03'),
(4, 1, 'Created subpoena III-09-INV-25F-0004', '2025-06-14 15:52:55'),
(5, 1, 'Created subpoena III-09-INV-25F-0005', '2025-06-15 15:11:00'),
(6, 1, 'Created subpoena III-09-INV-25F-0006', '2025-06-16 15:59:42'),
(7, 1, 'Created subpoena III-09-INV-25F-0007', '2025-06-24 21:25:31'),
(8, 1, 'Created subpoena III-09-INV-25G-0001', '2025-07-01 14:58:22'),
(9, 1, 'Edited user \'Christian James  Legaspi\': Username from \'Itchan\' to \'Itchanisan\'; Updated password', '2025-07-09 06:46:06'),
(10, 1, 'Edited Resolution for III-09-INV-25F-0007: Verdict from \'For Filing\' to \'Dismissed\'; Court from \'aliaga\' to \'N/A\'; Date from \'2025-07-07\' to \'2025-07-09\'', '2025-07-09 06:46:36'),
(11, 1, 'Approved Resolution for III-09-INV-25F-0007', '2025-07-09 06:46:44'),
(12, 1, 'Created subpoena III-09-INV-25G-0002', '2025-07-09 15:09:04'),
(13, 1, 'Edited Subpoena III-09-INV-25G-0002: Crime from \'Stafanot\' to \'Stafa\'; Police Station from \'Bulakan\' to \'Balakan\'; New Complainant: Juanito Manilda Bernardo; New Respondent: Marineta Gojo Legaspi', '2025-07-09 07:12:15'),
(14, 1, 'Denied subpoena III-09-INV-25G-0002 with comment: trip ko lang\r\n', '2025-07-09 15:27:49'),
(15, 1, 'Edited Subpoena III-09-INV-25G-0002: Complainant linked: Juanito Manilda Bernardo; Respondent linked: Marineta Gojo Legaspi', '2025-07-09 15:27:53'),
(16, 1, 'Approved subpoena III-09-INV-25G-0002', '2025-07-09 15:27:56'),
(17, 1, 'Edited user \'Andrei  Esluzar Bernardo\': Updated password', '2025-07-09 15:32:20'),
(18, 1, 'User logged in', '2025-07-10 16:30:11'),
(19, 1, 'User logged out', '2025-07-10 16:30:33'),
(20, 1, 'User logged in', '2025-07-10 16:30:43'),
(21, 1, 'User logged in', '2025-07-10 16:31:10'),
(22, 1, 'User logged out', '2025-07-10 16:41:22'),
(23, 1, 'User logged in', '2025-07-10 16:41:41'),
(24, 1, 'User logged out', '2025-07-10 16:55:11'),
(25, 2, 'User logged in', '2025-07-10 17:03:45'),
(26, 1, 'User logged in', '2025-07-10 17:03:55'),
(27, 1, 'User logged out', '2025-07-10 17:04:16'),
(28, 2, 'User logged in', '2025-07-10 17:07:07'),
(29, 2, 'User logged in', '2025-07-10 17:10:21'),
(30, 2, 'User logged in', '2025-07-10 17:54:07'),
(31, 2, 'User logged in', '2025-07-10 17:54:17'),
(32, 2, 'User logged in', '2025-07-10 18:01:38'),
(33, 2, 'User logged in', '2025-07-10 18:03:35'),
(34, 2, 'User logged in', '2025-07-10 18:06:29'),
(35, 2, 'User logged in', '2025-07-10 18:09:51'),
(36, 2, 'User logged in', '2025-07-10 18:12:37'),
(37, 2, 'User logged in', '2025-07-10 18:13:53'),
(38, 2, 'User logged in', '2025-07-10 18:57:49'),
(39, 2, 'Created subpoena III-09-INV-25G-0003', '2025-07-10 19:16:28'),
(40, 1, 'User logged in', '2025-07-10 19:20:00'),
(41, 2, 'User logged in', '2025-07-10 19:21:54'),
(42, 2, 'User logged in', '2025-07-10 19:48:25'),
(43, 2, 'User logged in', '2025-07-10 20:09:54'),
(44, 1, 'User logged in', '2025-07-10 20:26:22'),
(45, 1, 'Denied subpoena III-09-INV-25G-0003 with comment: panget e', '2025-07-10 20:42:36'),
(46, 1, 'Denied subpoena III-09-INV-25F-0002 with comment: panget', '2025-07-10 20:43:21'),
(47, 2, 'User logged in', '2025-07-10 20:44:17'),
(48, 2, 'Edited Subpoena III-09-INV-25G-0003: Complainant linked: Juan Nigga Bernardo; Respondent linked: Pogi James Kitagawa', '2025-07-10 20:44:38'),
(49, 2, 'Edited Subpoena III-09-INV-25G-0003: Complainant linked: Juan Nigga Bernardo; Respondent linked: Pogi James Kitagawa', '2025-07-10 20:58:28'),
(50, 2, 'Edited Subpoena III-09-INV-25G-0003: Complainant linked: Juan Nigga Bernardo; Respondent linked: Pogi James Kitagawa', '2025-07-10 21:02:38'),
(51, 2, 'Edited Subpoena III-09-INV-25G-0003: Complainant linked: Juan Nigga Bernardo; Respondent linked: Pogi James Kitagawa', '2025-07-10 21:04:41'),
(52, 2, 'Edited Subpoena III-09-INV-25G-0003: Complainant linked: Juan Nigga Bernardo; Respondent linked: Pogi James Kitagawa', '2025-07-10 21:04:48'),
(53, 2, 'Edited Subpoena III-09-INV-25G-0003: Complainant linked: Juan Nigga Bernardo; Respondent linked: Pogi James Kitagawa', '2025-07-10 21:04:58'),
(54, 2, 'Edited Subpoena III-09-INV-25G-0003: Complainant linked: Juan Nigga Bernardo; Respondent linked: Pogi James Kitagawa', '2025-07-10 21:10:16'),
(55, 2, 'Edited Subpoena III-09-INV-25G-0003: Complainant linked: Juan Nigga Bernardo; Respondent linked: Pogi James Kitagawa', '2025-07-10 21:14:48'),
(56, 2, 'Edited Subpoena III-09-INV-25G-0003: Complainant linked: Juan Nigga Bernardo; Respondent linked: Pogi James Kitagawa', '2025-07-10 21:14:52'),
(57, 2, 'Edited Subpoena III-09-INV-25G-0003: Complainant linked: Juan Nigga Bernardo; Respondent linked: Pogi James Kitagawa', '2025-07-10 21:15:54'),
(58, 2, 'Edited Subpoena III-09-INV-25F-0002: Complainant linked: dwdsaw aswda wdwdwqa; Complainant linked: fwfsddfa fwfawd dwfas; Respondent linked: ffgdvasa sdwfasd fwaea; Respondent linked: afasdaascas fawdawfdqwa fasdaw', '2025-07-10 21:15:57'),
(59, 2, 'Edited Subpoena III-09-INV-25G-0003: Complainant linked: Juan Nigga Bernardo; Respondent linked: Pogi James Kitagawa', '2025-07-10 21:16:05'),
(60, 2, 'Denied subpoena III-09-INV-25G-0003 with comment: tite', '2025-07-10 21:17:22'),
(61, 2, 'Edited Subpoena III-09-INV-25G-0003: Complainant linked: Juan Nigga Bernardo; Respondent linked: Pogi James Kitagawa', '2025-07-10 21:17:30'),
(62, 2, 'Approved subpoena III-09-INV-25G-0003', '2025-07-10 21:31:26'),
(63, 2, 'Created Resolution for III-09-INV-25G-0003 with Verdict: For Filing, Court: Sa Kanto, Date: 2025-07-10', '2025-07-10 21:39:34'),
(64, 2, 'Created Resolution for III-09-INV-25G-0003 with Verdict: Dismissed, Court: N/A, Date: 2025-07-10', '2025-07-10 21:46:07'),
(65, 2, 'Re-submitted Resolution for III-09-INV-25G-0003 with no field changes', '2025-07-10 21:46:28'),
(66, 2, 'Created Resolution for III-09-INV-25G-0003 with Verdict: Dismissed, Court: N/A, Date: 2025-07-10', '2025-07-10 21:49:00'),
(67, 1, 'User logged in', '2025-07-10 23:10:40'),
(68, 2, 'User logged in', '2025-07-10 23:10:55'),
(69, 2, 'Denied Resolution for III-09-INV-25G-0003 with comment: tanga', '2025-07-10 23:14:18'),
(70, 2, 'Edited Resolution for III-09-INV-25G-0003: Verdict from \'Dismissed\' to \'For Filing\'; Court from \'None\' to \'Sa Kanto\'', '2025-07-10 23:14:29'),
(71, 2, 'Edited Resolution for III-09-INV-25G-0003: Verdict from \'For Filing\' to \'Dismissed\'; Court from \'Sa Kanto\' to \'N/A\'', '2025-07-10 23:17:02'),
(72, 2, 'Denied Resolution for III-09-INV-25G-0003 with comment: tite', '2025-07-10 23:17:27'),
(73, 2, 'Re-submitted Resolution for III-09-INV-25G-0003 with no changes', '2025-07-10 23:23:09'),
(74, 2, 'Edited Resolution for III-09-INV-25G-0003: Verdict from \'Dismissed\' to \'For Filing\'; Court from \'None\' to \'Sa Kanto\'', '2025-07-10 23:23:25'),
(75, 2, 'Approved Resolution for III-09-INV-25G-0003', '2025-07-10 23:23:39'),
(76, 2, 'User logged out', '2025-07-10 23:24:40'),
(77, 1, 'User logged in', '2025-07-15 13:48:14'),
(78, 1, 'User logged in', '2025-07-15 14:12:07'),
(79, 1, 'User logged in', '2025-07-15 14:35:03'),
(80, 1, 'Edited user \'Nicolas Nigga Eugenio\': Updated password; Added prosecutor info', '2025-07-15 14:38:14'),
(81, 5, 'User logged in', '2025-07-15 15:02:34'),
(82, 5, 'User logged out', '2025-07-15 15:02:36'),
(83, 1, 'User logged in', '2025-07-15 15:02:48'),
(84, 1, 'User logged out', '2025-07-15 15:05:35'),
(85, 5, 'User logged in', '2025-07-15 15:08:47'),
(86, 5, 'User logged out', '2025-07-15 15:08:51'),
(87, 1, 'User logged in', '2025-07-15 15:12:59'),
(88, 1, 'User logged out', '2025-07-15 15:15:23'),
(89, 5, 'User logged in', '2025-07-15 15:26:11'),
(90, 5, 'User logged out', '2025-07-15 15:29:08'),
(91, 1, 'User logged in', '2025-07-15 15:29:14'),
(92, 1, 'User logged out', '2025-07-15 15:31:45'),
(93, 5, 'User logged in', '2025-07-15 15:31:53'),
(94, 5, 'Denied subpoena III-09-INV-25F-0002 with comment: Kapanget', '2025-07-15 15:45:00'),
(95, 5, 'User logged out', '2025-07-15 15:45:12'),
(96, 1, 'User logged in', '2025-07-15 15:45:20'),
(97, 1, 'User logged out', '2025-07-15 15:46:20'),
(98, 2, 'User logged in', '2025-07-15 16:07:16'),
(99, 2, 'Created subpoena III-09-INV-25G-0004', '2025-07-15 16:10:30'),
(100, 2, 'User logged out', '2025-07-15 16:17:51'),
(101, 5, 'User logged in', '2025-07-15 16:18:14'),
(102, 5, 'Approved subpoena III-09-INV-25G-0004', '2025-07-15 16:29:17'),
(103, 5, 'Denied subpoena III-09-INV-25G-0004 with comment: diko trip', '2025-07-15 16:33:02'),
(104, 5, 'User logged out', '2025-07-15 16:33:06'),
(105, 2, 'User logged in', '2025-07-15 16:33:18'),
(106, 2, 'Edited Subpoena III-09-INV-25G-0004: Complainant linked: Mail Nigga Bernardo; Respondent linked: Marine MIyor Legaspi; Respondent linked: Jayrold Wilder Moreed', '2025-07-15 16:33:25'),
(107, 2, 'User logged out', '2025-07-15 16:33:28'),
(108, 5, 'User logged in', '2025-07-15 16:33:41'),
(109, 5, 'Approved subpoena III-09-INV-25G-0004', '2025-07-15 16:33:45'),
(110, 5, 'Approved subpoena III-09-INV-25G-0004', '2025-07-15 16:36:00'),
(111, 5, 'Approved subpoena III-09-INV-25G-0004', '2025-07-15 16:36:23'),
(112, 5, 'Approved subpoena III-09-INV-25G-0004', '2025-07-15 16:38:26'),
(113, 5, 'Approved subpoena III-09-INV-25G-0004', '2025-07-15 16:40:15'),
(114, 5, 'User logged out', '2025-07-15 16:40:34'),
(115, 2, 'User logged in', '2025-07-15 16:40:47'),
(116, 2, 'User logged out', '2025-07-15 16:41:34'),
(117, 1, 'User logged in', '2025-07-15 16:41:46'),
(118, 1, 'User logged in', '2025-07-28 20:08:51'),
(119, 1, 'User logged out', '2025-07-28 20:10:36'),
(120, 2, 'User logged in', '2025-07-28 20:16:19'),
(121, 2, 'User logged out', '2025-07-28 20:16:37'),
(122, 1, 'User logged in', '2025-07-28 20:16:45'),
(123, 1, 'User logged in', '2025-07-28 20:50:48'),
(124, 1, 'User logged out', '2025-07-28 20:57:02'),
(125, 5, 'User logged in', '2025-07-28 20:57:13'),
(126, 5, 'User logged out', '2025-07-28 20:57:27'),
(127, 1, 'User logged in', '2025-07-29 22:18:26'),
(128, 1, 'User logged out', '2025-07-29 22:23:38'),
(129, 2, 'User logged in', '2025-07-29 22:23:45'),
(130, 2, 'User logged out', '2025-07-29 22:23:58'),
(131, 5, 'User logged in', '2025-07-29 22:24:03'),
(132, 1, 'User logged in', '2025-09-03 10:26:41'),
(133, 1, 'User logged out', '2025-09-03 10:27:45'),
(134, 2, 'User logged in', '2025-09-03 10:27:54'),
(135, 2, 'User logged out', '2025-09-03 10:28:13'),
(136, 5, 'User logged in', '2025-09-03 10:28:21'),
(137, 5, 'User logged out', '2025-09-03 10:28:32'),
(138, 1, 'User logged in', '2025-09-03 10:31:48'),
(139, 1, 'Created subpoena III-09-INV-25I-0001', '2025-09-03 10:48:59'),
(140, 1, 'Denied subpoena III-09-INV-25I-0001 with comment: Ampanget', '2025-09-03 10:49:54'),
(141, 1, 'Edited Subpoena III-09-INV-25I-0001: Complainant linked: Jayrold  Delos Santos; Respondent linked: KurtNijel  Curamen', '2025-09-03 10:50:03'),
(142, 1, 'Approved subpoena III-09-INV-25I-0001', '2025-09-03 10:50:57'),
(143, 1, 'Created Resolution for III-09-INV-25I-0001 with Verdict: Dismissed, Court: N/A, Date: 2025-09-03', '2025-09-03 10:55:31'),
(144, 1, 'Denied Resolution for III-09-INV-25F-0002 with comment: pagm', '2025-09-03 10:55:42'),
(145, 1, 'Edited Resolution for III-09-INV-25F-0002: Date from \'2025-06-29\' to \'2025-09-03\'', '2025-09-03 10:55:44'),
(146, 1, 'Approved Resolution for III-09-INV-25F-0002', '2025-09-03 10:55:47'),
(147, 1, 'User logged in', '2025-09-27 16:25:01'),
(148, 1, 'User logged in', '2025-09-27 17:08:54'),
(149, 1, 'Edited Subpoena III-09-INV-25F-0002: Complainant linked: dwdsaw aswda wdwdwqa; Complainant linked: fwfsddfa fwfawd dwfas; Respondent linked: ffgdvasa sdwfasd fwaea; Respondent linked: afasdaascas fawdawfdqwa fasdaw', '2025-09-27 17:12:35'),
(150, 1, 'User logged in', '2025-09-27 18:18:26'),
(151, 1, 'User logged in', '2025-09-27 18:43:22'),
(152, 1, 'User logged in', '2025-09-27 19:19:01'),
(153, 1, 'User logged in', '2025-09-27 21:20:53'),
(154, 1, 'User logged in', '2025-09-27 21:57:43'),
(155, 1, 'User logged in', '2025-09-27 22:19:48'),
(156, 1, 'Created subpoena III-09-INV-25I-0002', '2025-09-27 22:28:50'),
(157, 1, 'Created subpoena III-09-INV-25I-0003', '2025-09-27 22:35:44'),
(158, 1, 'Created subpoena III-09-INV-25I-0004', '2025-09-27 22:44:32'),
(159, 1, 'Created subpoena III-09-INV-25I-0005', '2025-09-27 23:01:35'),
(160, 1, 'Created subpoena III-09-INV-25I-0006', '2025-09-27 23:09:43'),
(161, 1, 'Created subpoena III-09-INV-25I-0007', '2025-09-27 23:22:37'),
(162, 1, 'User logged in', '2025-09-27 23:42:50'),
(163, 1, 'User logged in', '2025-09-28 00:10:50'),
(164, 1, 'Edited Subpoena III-09-INV-25I-0007: Crimes from [\'Theft\', \'Estafa\', \'Rape\'] to []; Complainant linked: Juan Nigga Bernardo; Respondent linked: Marine James Kitagawa', '2025-09-28 00:24:36'),
(165, 1, 'Edited Subpoena III-09-INV-25I-0006: Complainant linked: Juan Nigga Bernardo; Respondent linked: Dawr James Legaspi', '2025-09-28 00:25:20'),
(166, 1, 'Edited Subpoena III-09-INV-25I-0002: Prosecutor ID from \'7\' to \'6\'; Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 00:27:03'),
(167, 1, 'Edited Subpoena III-09-INV-25I-0007: Prosecutor ID from \'7\' to \'6\'; Complainant linked: Juan Nigga Bernardo; Respondent linked: Marine James Kitagawa', '2025-09-28 00:27:18'),
(168, 1, 'Edited Subpoena III-09-INV-25I-0002: Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 00:32:15'),
(169, 1, 'Edited Subpoena III-09-INV-25I-0007: Complainant linked: Juan Nigga Bernardo; Respondent linked: Marine James Kitagawa', '2025-09-28 00:32:25'),
(170, 1, 'Edited Subpoena III-09-INV-25I-0006: Complainant linked: Juan Nigga Bernardo; Respondent linked: Dawr James Legaspi', '2025-09-28 00:33:43'),
(171, 1, 'Edited Subpoena III-09-INV-25I-0002: Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 00:42:36'),
(172, 1, 'Edited Subpoena III-09-INV-25I-0002: Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 01:01:22'),
(173, 1, 'Edited Subpoena III-09-INV-25I-0002: Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 01:02:09'),
(174, 1, 'Edited Subpoena III-09-INV-25I-0002: Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 01:07:18'),
(175, 1, 'Edited Subpoena III-09-INV-25I-0002: Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 01:25:51'),
(176, 1, 'Edited Subpoena III-09-INV-25I-0002: Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 01:27:00'),
(177, 1, 'Edited Subpoena III-09-INV-25I-0002: Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 01:27:05'),
(178, 1, 'Edited Subpoena III-09-INV-25I-0004: Complainant linked: Main Nigga Bernardo; Respondent linked: Marine James Kitagawa', '2025-09-28 01:27:16'),
(179, 1, 'Edited Subpoena III-09-INV-25I-0002: Crimes from [] to [\'Estafa\']; Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 01:29:36'),
(180, 1, 'Edited Subpoena III-09-INV-25I-0002: Crimes from [\'Estafa\'] to [\'Estafa\', \'Illegal Drugs\']; Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 01:29:44'),
(181, 1, 'Edited Subpoena III-09-INV-25I-0002: Crimes from [\'Estafa\', \'Illegal Drugs\'] to [\'Illegal Drugs\']; Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 01:30:06'),
(182, 1, 'Edited Subpoena III-09-INV-25I-0002: Crimes from [\'Illegal Drugs\'] to [\'Estafa\', \'Illegal Drugs\']; Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 01:30:12'),
(183, 1, 'Edited Subpoena III-09-INV-25I-0003: Crimes from [] to [\'Rape\']; Complainant linked: Mail Nigga Bernardo; Respondent linked: Pogi MIyor Kitagawa', '2025-09-28 01:30:20'),
(184, 1, 'Edited Subpoena III-09-INV-25I-0004: Crimes from [] to [\'Theft\', \'Estafa\', \'Rape\', \'Illegal Drugs\']; Complainant linked: Main Nigga Bernardo; Respondent linked: Marine James Kitagawa', '2025-09-28 01:30:37'),
(185, 1, 'Edited Subpoena III-09-INV-25I-0005: Crimes from [] to [\'Estafa\']; Complainant linked: Mail Esluzar Bernardo; Respondent linked: Pogi James Legaspi', '2025-09-28 01:31:27'),
(186, 1, 'Edited Subpoena III-09-INV-25I-0006: Crimes from [] to [\'Theft\']; Complainant linked: Juan Nigga Bernardo; Respondent linked: Dawr James Legaspi', '2025-09-28 01:31:36'),
(187, 1, 'Edited Subpoena III-09-INV-25I-0007: Crimes from [] to [\'Theft\', \'Estafa\']; Complainant linked: Juan Nigga Bernardo; Respondent linked: Marine James Kitagawa', '2025-09-28 01:31:43'),
(188, 1, 'Edited Subpoena III-09-INV-25I-0007: Crimes from [\'Theft\', \'Estafa\'] to [\'Estafa\']; Complainant linked: Juan Nigga Bernardo; Respondent linked: Marine James Kitagawa', '2025-09-28 01:31:46'),
(189, 1, 'Edited Subpoena III-09-INV-25I-0004: Complainant linked: Main Nigga Bernardo; Respondent linked: Marine James Kitagawa', '2025-09-28 01:32:02'),
(190, 1, 'Edited Subpoena III-09-INV-25F-0002: Crimes from [] to [\'Estafa\', \'Illegal Drugs\']; Complainant linked: dwdsaw aswda wdwdwqa; Complainant linked: fwfsddfa fwfawd dwfas; Respondent linked: ffgdvasa sdwfasd fwaea; Respondent linked: afasdaascas fawdawfdqwa fasdaw', '2025-09-28 01:32:13'),
(191, 1, 'Edited Subpoena III-09-INV-25F-0002: Crimes from [\'Estafa\', \'Illegal Drugs\'] to [\'Illegal Drugs\']; Complainant linked: dwdsaw aswda wdwdwqa; Complainant linked: fwfsddfa fwfawd dwfas; Respondent linked: ffgdvasa sdwfasd fwaea; Respondent linked: afasdaascas fawdawfdqwa fasdaw', '2025-09-28 01:32:20'),
(192, 1, 'Edited Subpoena III-09-INV-25I-0002: Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 01:33:54'),
(193, 1, 'Edited Subpoena III-09-INV-25I-0004: Complainant linked: Main Nigga Bernardo; Respondent linked: Marine James Kitagawa', '2025-09-28 01:33:57'),
(194, 1, 'User logged in', '2025-09-28 12:01:49'),
(195, 1, 'User logged in', '2025-09-28 12:23:06'),
(196, 1, 'User logged in', '2025-09-28 12:44:32'),
(197, 1, 'User logged in', '2025-09-28 13:12:43'),
(198, 1, 'User logged in', '2025-09-28 13:33:13'),
(199, 1, 'User logged in', '2025-09-28 14:30:54'),
(200, 1, 'Denied subpoena III-09-INV-25I-0002 with comment: Weak', '2025-09-28 14:32:23'),
(201, 1, 'Edited Subpoena III-09-INV-25I-0002: Crimes from [\'Estafa\', \'Illegal Drugs\'] to [\'Theft\', \'Estafa\', \'Illegal Drugs\']; Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-09-28 14:32:33'),
(202, 1, 'Edited Subpoena III-09-INV-25F-0002: Hearing Date 2 from \'None\' to \'2025-10-08 15:00:00\'; Complainant linked: dwdsaw aswda wdwdwqa; Complainant linked: fwfsddfa fwfawd dwfas; Respondent linked: ffgdvasa sdwfasd fwaea; Respondent linked: afasdaascas fawdawfdqwa fasdaw', '2025-09-28 14:36:34'),
(203, 1, 'Edited Subpoena III-09-INV-25F-0002: Complainant linked: dwdsaw aswda wdwdwqa; Complainant linked: fwfsddfa fwfawd dwfas; Respondent linked: ffgdvasa sdwfasd fwaea; Respondent linked: afasdaascas fawdawfdqwa fasdaw', '2025-09-28 14:43:21'),
(204, 1, 'Edited Subpoena III-09-INV-25F-0002: Complainant linked: dwdsaw aswda wdwdwqa; Complainant linked: fwfsddfa fwfawd dwfas; Respondent linked: ffgdvasa sdwfasd fwaea; Respondent linked: afasdaascas fawdawfdqwa fasdaw', '2025-09-28 14:43:30'),
(205, 1, 'Approved subpoena III-09-INV-25I-0002', '2025-09-28 14:47:54'),
(206, 1, 'Approved subpoena III-09-INV-25I-0004', '2025-09-28 14:48:13'),
(207, 1, 'Created Resolution for III-09-INV-25I-0004 with Verdict: Dismissed, Court: N/A, Date: 2025-09-28', '2025-09-28 14:49:47'),
(208, 1, 'Edited Resolution for III-09-INV-25I-0001: Verdict from \'Dismissed\' to \'For Filing\'; Court from \'None\' to \'aliaga\'; Date from \'2025-09-03\' to \'2025-09-28\'', '2025-09-28 14:53:45'),
(209, 1, 'Denied Resolution for III-09-INV-25I-0004 with comment: panget', '2025-09-28 14:55:38'),
(210, 1, 'Re-submitted Resolution for III-09-INV-25I-0004 with no changes', '2025-09-28 14:55:47'),
(211, 1, 'Approved Resolution for III-09-INV-25I-0004', '2025-09-28 14:55:52'),
(212, 1, 'User logged in', '2025-10-02 15:00:46'),
(213, 1, 'Edited Subpoena III-09-INV-25I-0007: Crimes from [\'Estafa\'] to [\'Theft\', \'Estafa\', \'Rape\', \'Illegal Drugs\']; Complainant linked: Juan Nigga Bernardo; Respondent linked: Marine James Kitagawa', '2025-10-02 15:03:35'),
(214, 1, 'Approved subpoena III-09-INV-25I-0007', '2025-10-02 15:03:42'),
(215, 1, 'User logged in', '2025-10-02 15:24:51'),
(216, 1, 'Created Resolution for III-09-INV-25I-0007 with Verdict: Dismissed, Court: N/A, Date: 2025-10-02', '2025-10-02 15:28:19'),
(217, 1, 'User logged in', '2025-10-02 15:49:27'),
(218, 1, 'User logged out', '2025-10-02 15:50:59'),
(219, 1, 'User logged in', '2025-10-02 15:51:10'),
(220, 1, 'User logged out', '2025-10-02 15:52:40'),
(221, 5, 'User logged in', '2025-10-02 15:52:52'),
(222, 5, 'User logged out', '2025-10-02 15:53:06'),
(223, 2, 'User logged in', '2025-10-02 15:53:14'),
(224, 2, 'User logged in', '2025-10-02 16:39:42'),
(225, 2, 'Created subpoena III-09-INV-25J-0001', '2025-10-02 16:43:03'),
(226, 2, 'User logged out', '2025-10-02 16:46:47'),
(227, 1, 'User logged in', '2025-10-02 16:47:01'),
(228, 1, 'User logged out', '2025-10-02 16:47:09'),
(229, 2, 'User logged in', '2025-10-02 16:47:18'),
(230, 2, 'Edited Subpoena III-09-INV-25J-0001: Crimes from [\'Estafa\'] to [\'Estafa\', \'Illegal Drugs\']; Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-10-02 16:54:13'),
(231, 2, 'Edited Subpoena III-09-INV-25J-0001: Crimes from [\'Estafa\', \'Illegal Drugs\'] to [\'Estafa\']; Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-10-02 16:56:34'),
(232, 2, 'Edited Subpoena III-09-INV-25J-0001: Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-10-02 16:57:47'),
(233, 2, 'Edited Subpoena III-09-INV-25J-0001: Crimes from [\'Estafa\'] to [\'Theft\', \'Estafa\']; Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Kitagawa', '2025-10-02 16:59:08'),
(234, 2, 'User logged out', '2025-10-02 17:10:49'),
(235, 5, 'User logged in', '2025-10-02 17:11:01'),
(236, 5, 'Approved subpoena III-09-INV-25J-0001', '2025-10-02 17:17:20'),
(237, 5, 'User logged out', '2025-10-02 17:17:43'),
(238, 2, 'User logged in', '2025-10-02 17:17:54'),
(239, 2, 'Created Resolution for III-09-INV-25J-0001 with Verdict: Dismissed, Court: N/A, Date: 2025-10-02', '2025-10-02 17:22:00'),
(240, 2, 'User logged out', '2025-10-02 17:35:47'),
(241, 2, 'User logged in', '2025-10-02 18:06:48'),
(242, 2, 'User logged out', '2025-10-02 18:09:41'),
(243, 1, 'User logged in', '2025-10-02 18:09:49'),
(244, 1, 'User logged in', '2025-10-02 18:58:43'),
(245, 1, 'User logged in', '2025-10-02 19:29:52'),
(246, 1, 'User logged in', '2025-10-02 20:24:28'),
(247, 2, 'User logged in', '2025-10-02 21:05:48'),
(248, 2, 'User logged out', '2025-10-02 21:05:50'),
(249, 1, 'User logged in', '2025-10-02 21:06:08'),
(250, 1, 'User logged out', '2025-10-02 21:07:15'),
(251, 1, 'User logged in', '2025-10-02 21:20:21'),
(252, 1, 'User logged in', '2025-10-02 21:42:39'),
(253, 1, 'User logged in', '2025-10-02 22:06:14'),
(254, 1, 'User logged in', '2025-10-02 22:26:29'),
(255, 1, 'User logged in', '2025-10-02 22:46:51'),
(256, 1, 'User logged in', '2025-10-02 23:08:35'),
(257, 1, 'User logged in', '2025-10-02 23:28:52'),
(258, 1, 'User logged in', '2025-10-03 16:22:44'),
(259, 1, 'User logged in', '2025-10-03 16:43:29'),
(260, 1, 'User logged in', '2025-10-03 17:08:11'),
(261, 1, 'User logged out', '2025-10-03 17:14:16'),
(262, 2, 'User logged in', '2025-10-03 17:14:21'),
(263, 2, 'User logged out', '2025-10-03 17:17:41'),
(264, 1, 'User logged in', '2025-10-03 17:17:45'),
(265, 1, 'User logged out', '2025-10-03 17:20:38'),
(266, 5, 'User logged in', '2025-10-03 17:20:46'),
(267, 5, 'User logged out', '2025-10-03 17:28:38'),
(268, 2, 'User logged in', '2025-10-03 17:28:50'),
(269, 2, 'User logged out', '2025-10-03 17:33:26'),
(270, 5, 'User logged in', '2025-10-03 17:33:33'),
(271, 5, 'User logged out', '2025-10-03 17:44:06'),
(272, 5, 'User logged in', '2025-10-03 17:44:26'),
(273, 5, 'User logged out', '2025-10-03 17:44:55'),
(274, 1, 'User logged in', '2025-10-03 17:45:06'),
(275, 1, 'Created new user: Noel  Hula Eugenio with role \'PS\' and username \'PServer1\'', '2025-10-03 17:46:53'),
(276, 1, 'User logged out', '2025-10-03 17:46:59'),
(277, 6, 'User logged in', '2025-10-03 17:51:29'),
(278, 6, 'User logged in', '2025-10-03 17:57:38'),
(279, 6, 'User logged in', '2025-10-03 18:00:05'),
(280, 6, 'User logged out', '2025-10-03 18:01:48'),
(281, 1, 'User logged in', '2025-10-04 14:12:59'),
(282, 1, 'User logged in', '2025-10-04 14:34:09'),
(283, 1, 'User logged out', '2025-10-04 14:43:00'),
(284, 1, 'User logged in', '2025-10-04 14:52:56'),
(285, 1, 'Created Resolution for III-09-INV-25I-0002 with Verdict: For Filing, Court: Sa Kanto, Date: 2025-10-04', '2025-10-04 15:11:06'),
(286, 1, 'User logged in', '2025-10-18 19:01:16'),
(287, 1, 'User logged in', '2025-10-18 20:23:09'),
(288, 1, 'User logged in', '2025-10-25 13:51:26'),
(289, 1, 'User logged in', '2025-10-25 14:14:15'),
(290, 1, 'Created subpoena III-09-INV-25J-0002', '2025-10-25 14:25:32'),
(291, 1, 'User logged in', '2025-10-25 14:47:02'),
(292, 1, 'User logged in', '2025-10-25 15:31:03'),
(293, 1, 'User logged in', '2025-10-25 15:51:20'),
(294, 1, 'Edited Subpoena III-09-INV-25J-0002: Complainant linked: Juan Manilda Bernardo IV; New Complainant: Andrei Esluzar Manersing; New Respondent: Dawr James Legaspi; Respondent linked: Malakaaas Wilder Moreed Sr.', '2025-10-25 15:56:12'),
(295, 1, 'Edited Subpoena III-09-INV-25I-0003: New Complainant: Mail Nigga Bernardo; New Respondent: Pogi  Kitagawa', '2025-10-25 16:01:36'),
(296, 1, 'Edited Subpoena III-09-INV-25J-0002: Complainant linked: Juan Manilda Bernardo IV; New Complainant: Andrei Esluzar Manersing; New Respondent: Malakaaas  Moreed Sr.; New Respondent: Dawr James Legaspi', '2025-10-25 16:01:54'),
(297, 1, 'Approved subpoena III-09-INV-25J-0002', '2025-10-25 16:03:35'),
(298, 1, 'Created Resolution for III-09-INV-25J-0002 with Verdict: For Filing, Court: aliaga, Date: 2025-10-25', '2025-10-25 16:07:27'),
(299, 1, 'User logged out', '2025-10-25 16:14:55'),
(300, 2, 'User logged in', '2025-10-25 16:15:07'),
(301, 2, 'Created subpoena III-09-INV-25J-0003', '2025-10-25 16:26:30'),
(302, 2, 'Created subpoena III-09-INV-25J-0004', '2025-10-25 16:28:44'),
(303, 2, 'Edited Subpoena III-09-INV-25J-0004: Crimes from [] to [\'Illegal Drugs\', \'Serious Physical Injuries\']; Complainant linked: Juan  Manersingods Jr.; Respondent linked: Marine Gojo Kitagawa', '2025-10-25 16:29:12'),
(304, 2, 'Edited Subpoena III-09-INV-25J-0004: Complainant linked: Juan  Manersingods Jr.; Respondent linked: Marine Gojo Kitagawa', '2025-10-25 16:30:53'),
(305, 2, 'Edited Subpoena III-09-INV-25J-0004: Complainant linked: Juan  Manersingods Jr.; Respondent linked: Marine Gojo Kitagawa', '2025-10-25 16:31:26'),
(306, 2, 'Edited Subpoena III-09-INV-25J-0004: Complainant linked: Juan  Manersingods Jr.; Respondent linked: Marine Gojo Kitagawa', '2025-10-25 16:31:41'),
(307, 2, 'Edited Subpoena III-09-INV-25J-0004: Complainant linked: Juan  Manersingods Jr.; Respondent linked: Marine Gojo Kitagawa', '2025-10-25 16:31:50'),
(308, 2, 'User logged out', '2025-10-25 16:33:46'),
(309, 5, 'User logged in', '2025-10-25 16:33:54'),
(310, 5, 'Approved subpoena III-09-INV-25J-0003', '2025-10-25 16:34:55'),
(311, 5, 'Approved subpoena III-09-INV-25J-0004', '2025-10-25 16:34:57'),
(312, 5, 'User logged out', '2025-10-25 16:35:02'),
(313, 2, 'User logged in', '2025-10-25 16:35:14'),
(314, 2, 'Created Resolution for III-09-INV-25J-0003 with Verdict: For Filing, Court: Sa Kanto, Date: 2025-10-25', '2025-10-25 16:38:15'),
(315, 2, 'Edited Resolution for III-09-INV-25J-0003: Verdict from \'For Filing\' to \'Dismissed\'; Court from \'Sa Kanto\' to \'N/A\'', '2025-10-25 16:38:21'),
(316, 2, 'User logged out', '2025-10-25 16:38:29'),
(317, 5, 'User logged in', '2025-10-25 16:38:36'),
(318, 5, 'Denied subpoena III-09-INV-25I-0003 with comment: panget', '2025-10-25 16:38:48'),
(319, 5, 'User logged out', '2025-10-25 16:38:54'),
(320, 1, 'User logged in', '2025-10-25 16:38:58'),
(321, 1, 'Edited Subpoena III-09-INV-25I-0003: Complainant linked: Mail Nigga Bernardo; Respondent linked: Pogi  Kitagawa', '2025-10-25 16:39:06'),
(322, 1, 'Approved Resolution for III-09-INV-25J-0003', '2025-10-25 16:39:24'),
(323, 1, 'Created new user: Jayrold  Delos Santos III with role \'Prosecutor\' and username \'Jaysecutor\'', '2025-10-25 16:52:16'),
(324, 1, 'Edited user \'Andrei  Esluzar Bernardo Jr.\': Suffix from \'None\' to \'Jr.\'; Updated password', '2025-10-25 16:58:03'),
(325, 1, 'Edited user \'Andrei  Esluzar Bernardo Jr.\': Updated password', '2025-10-25 17:04:31'),
(326, 1, 'User logged out', '2025-10-25 17:04:34'),
(327, 1, 'User logged in', '2025-10-25 17:04:45'),
(328, 1, 'User logged out', '2025-10-25 17:04:53'),
(329, 7, 'User logged in', '2025-10-25 17:05:03'),
(330, 7, 'User logged out', '2025-10-25 17:05:04'),
(331, 1, 'User logged in', '2025-10-25 17:05:10'),
(332, 1, 'Created new user: KurtNijel  Curamen with role \'Prosecutor\' and username \'Kurtcutor\'', '2025-10-25 17:06:28'),
(333, 1, 'User logged out', '2025-10-25 17:07:10'),
(334, 1, 'User logged in', '2025-10-25 17:07:42'),
(335, 1, 'Edited user \'KurtNijel  Curamen\': Updated password', '2025-10-25 17:07:59'),
(336, 1, 'Edited user \'KurtNijel  Curamen\': Updated password', '2025-10-25 17:09:12'),
(337, 1, 'User logged in', '2025-10-25 17:31:26'),
(338, 1, 'Created new user: Jan Paul  Mensalvas IV with role \'Prosecutor\' and username \'Prosecutor1\'', '2025-10-25 17:43:36'),
(339, 1, 'Edited user \'Jan Paul  Mensalvas IV\': Username from \'Prosecutor1\' to \'Prosecutor2\'', '2025-10-25 17:43:55'),
(340, 1, 'Edited user \'Jayrold  Delos Santos III\': Updated password', '2025-10-25 17:44:39'),
(341, 1, 'Edited user \'Nicolas Nigga Eugenio\': Suffix from \'None\' to \'\'', '2025-10-25 17:45:48'),
(342, 1, 'Edited user \'Jan Paul  Mensalvas IV\': Role from \'Prosecutor\' to \'superuser\'', '2025-10-25 17:48:09'),
(343, 1, 'Edited user \'Andrei  Esluzar Bernardo Jr.\': Updated password', '2025-10-25 17:49:12'),
(344, 1, 'Created new user: Arjann Esluzar Bernardo with role \'Prosecutor\' and username \'Prosecutor3\'', '2025-10-25 17:59:17'),
(345, 1, 'User logged in', '2025-10-25 18:36:17'),
(346, 1, 'User logged in', '2025-10-25 20:26:55'),
(347, 1, 'User logged in', '2025-10-25 20:52:19'),
(348, 1, 'User logged in', '2025-10-26 16:39:12'),
(349, 1, 'User logged in', '2025-10-26 19:46:05'),
(350, 1, 'User logged in', '2025-10-26 20:09:20'),
(351, 1, 'User logged in', '2025-10-26 20:43:03'),
(352, 1, 'User logged in', '2025-10-26 22:05:50'),
(353, 1, 'User logged in', '2025-10-26 22:29:27'),
(354, 1, 'User logged in', '2025-10-26 22:52:25'),
(355, 1, 'User logged in', '2025-10-26 23:14:24'),
(356, 1, 'User logged in', '2025-10-30 15:12:20'),
(357, 1, 'User logged out', '2025-10-30 15:15:46'),
(358, 1, 'User logged in', '2025-10-30 15:16:10'),
(359, 1, 'Edited user \'Christian James  Legaspi\': Suffix from \'None\' to \'\'; Added new address; Updated password', '2025-10-30 15:16:40'),
(360, 1, 'Created new user: Kian Black Bernardo Sr. with role \'Secretary\' and username \'Kiancretary\'', '2025-10-30 15:17:42'),
(361, 1, 'Edited user \'Nicolas Nigga Eugenio\': Added new address; Updated password', '2025-10-30 15:18:09'),
(362, 1, 'Edited user \'Noel  Hula Eugenio\': Suffix from \'None\' to \'\'; Added new address; Updated password', '2025-10-30 15:18:28'),
(363, 1, 'User logged out', '2025-10-30 15:22:22'),
(364, 2, 'User logged in', '2025-10-30 15:22:43'),
(365, 2, 'Created subpoena III-09-INV-25J-0001', '2025-10-30 15:26:12'),
(366, 2, 'User logged out', '2025-10-30 15:26:42'),
(367, 5, 'User logged in', '2025-10-30 15:26:52'),
(368, 5, 'Denied subpoena III-09-INV-25J-0001 with comment: panget', '2025-10-30 15:27:17'),
(369, 5, 'User logged out', '2025-10-30 15:27:19'),
(370, 2, 'User logged in', '2025-10-30 15:27:28'),
(371, 2, 'Edited Subpoena III-09-INV-25J-0001: Complainant linked: Juan Manilda Bernardo; Complainant linked: Mail Esluzar Manersing Jr.; Respondent linked: Dawr James Mowr III; Respondent linked: Jayrold Wilder Moreed Sr.', '2025-10-30 15:27:38'),
(372, 2, 'User logged out', '2025-10-30 15:27:44'),
(373, 5, 'User logged in', '2025-10-30 15:27:49'),
(374, 5, 'Approved subpoena III-09-INV-25J-0001', '2025-10-30 15:27:54'),
(375, 5, 'User logged out', '2025-10-30 15:29:08'),
(376, 6, 'User logged in', '2025-10-30 15:31:20'),
(377, 6, 'User logged out', '2025-10-30 15:31:35'),
(378, 1, 'User logged in', '2025-10-30 15:35:33'),
(379, 1, 'User logged out', '2025-10-30 15:49:35'),
(380, 2, 'User logged in', '2025-10-30 15:49:49'),
(381, 2, 'User logged in', '2025-10-30 15:50:00'),
(382, 2, 'Created subpoena III-09-INV-25J-0002', '2025-10-30 16:00:13'),
(383, 2, 'Created Resolution for III-09-INV-25J-0001 with Verdict: Dismissed, Court: N/A, Date: 2025-10-30', '2025-10-30 16:02:51'),
(384, 2, 'User logged out', '2025-10-30 16:03:03'),
(385, 1, 'User logged in', '2025-10-30 16:03:13'),
(386, 1, 'Denied Resolution for III-09-INV-25J-0001 with comment: mali', '2025-10-30 16:03:47'),
(387, 1, 'User logged out', '2025-10-30 16:04:45'),
(388, 2, 'User logged in', '2025-10-30 16:04:55'),
(389, 2, 'Edited Resolution for III-09-INV-25J-0001: Verdict from \'Dismissed\' to \'For Filing\'; Court from \'None\' to \'aliaga\'', '2025-10-30 16:05:13'),
(390, 2, 'User logged out', '2025-10-30 16:05:18'),
(391, 1, 'User logged in', '2025-10-30 16:05:40'),
(392, 1, 'Approved Resolution for III-09-INV-25J-0001', '2025-10-30 16:05:48'),
(393, 1, 'User logged in', '2025-10-30 16:10:35'),
(394, 1, 'Denied subpoena III-09-INV-25J-0002 with comment: panget', '2025-10-30 16:11:32'),
(395, 1, 'Edited Subpoena III-09-INV-25J-0002: Complainant linked: Juan Manilda Bernardo; Respondent linked: Marine James Legaspi Sr.', '2025-10-30 16:11:41'),
(396, 1, 'Approved subpoena III-09-INV-25J-0002', '2025-10-30 16:11:50'),
(397, 1, 'User logged in', '2025-10-30 22:41:45'),
(398, 1, 'User logged in', '2025-10-30 23:02:08'),
(399, 1, 'User logged in', '2025-10-30 23:34:31'),
(400, 1, 'User logged in', '2025-10-30 23:54:05'),
(401, 1, 'User logged out', '2025-10-30 23:54:21'),
(402, 1, 'User logged in', '2025-10-30 23:54:42'),
(403, 1, 'User logged out', '2025-10-30 23:54:51'),
(404, 1, 'User logged in', '2025-10-31 09:34:46'),
(405, 1, 'User logged in', '2025-10-31 09:54:57'),
(406, 1, 'Created subpoena III-09-INV-25J-0003', '2025-10-31 10:12:36'),
(407, 1, 'User logged in', '2025-10-31 10:32:59'),
(408, 1, 'Created Resolution for III-09-INV-25J-0002 with Verdict: For Filing, Court: MTC - Sta. Rosa, Date: 2025-10-31', '2025-10-31 10:44:46'),
(409, 1, 'Edited Resolution for III-09-INV-25J-0002: Court from \'MTC - Sta. Rosa\' to \'RTC - Branch 24\'', '2025-10-31 10:46:25'),
(410, 1, 'User logged in', '2025-10-31 11:12:02'),
(411, 1, 'User logged out', '2025-10-31 11:27:36'),
(412, 2, 'User logged in', '2025-10-31 11:27:41'),
(413, 2, 'User logged out', '2025-10-31 11:37:35'),
(414, 1, 'User logged in', '2025-10-31 11:37:43'),
(415, 1, 'User logged out', '2025-10-31 11:39:05'),
(416, 2, 'User logged in', '2025-10-31 11:39:12'),
(417, 2, 'User logged out', '2025-10-31 11:44:26'),
(418, 1, 'User logged in', '2025-10-31 11:49:26'),
(419, 1, 'User logged out', '2025-10-31 12:05:37'),
(420, 1, 'User logged in', '2025-11-01 20:35:08'),
(421, 1, 'User logged out', '2025-11-01 20:35:14'),
(422, 1, 'User logged in', '2025-11-01 20:37:07'),
(423, 1, 'Created new user: Pao Visaya Guiraldo with role \'Prosecutor\' and username \'Paulul\'', '2025-11-01 20:50:25'),
(424, 1, 'User logged out', '2025-11-01 20:55:33'),
(425, 2, 'User logged in', '2025-11-01 20:55:39'),
(426, 2, 'Created subpoena III-09-INV-25K-0001', '2025-11-01 21:07:40'),
(427, 2, 'User logged out', '2025-11-01 21:07:54'),
(428, 12, 'User logged in', '2025-11-01 21:08:06'),
(429, 12, 'Denied subpoena III-09-INV-25K-0001 with comment: Panget\r\n', '2025-11-01 21:08:25'),
(430, 12, 'User logged out', '2025-11-01 21:08:29'),
(431, 2, 'User logged in', '2025-11-01 21:08:34'),
(432, 2, 'Edited Subpoena III-09-INV-25K-0001: Crimes from [\'Theft\', \'Less Serious Physical Injuries\', \'Robbery with Homicide\'] to [\'Theft\', \'Less Serious Physical Injuries\']; Complainant linked: Mail Manilda Bernardo III; Respondent linked: Marine Gojo Legaspi', '2025-11-01 21:08:45'),
(433, 2, 'User logged out', '2025-11-01 21:08:51'),
(434, 12, 'User logged in', '2025-11-01 21:09:05'),
(435, 12, 'Approved subpoena III-09-INV-25K-0001', '2025-11-01 21:09:20'),
(436, 12, 'User logged out', '2025-11-01 21:09:58'),
(437, 2, 'User logged in', '2025-11-01 21:10:03'),
(438, 2, 'Created Resolution for III-09-INV-25K-0001 with Verdict: For Filing, Court: RTC - Branch 25, Date: 2025-11-01', '2025-11-01 21:11:28'),
(439, 2, 'User logged out', '2025-11-01 21:11:34'),
(440, 1, 'User logged in', '2025-11-01 21:11:40'),
(441, 1, 'Denied Resolution for III-09-INV-25K-0001 with comment: Panget', '2025-11-01 21:11:56'),
(442, 1, 'Edited Resolution for III-09-INV-25K-0001: Verdict from \'For Filing\' to \'Dismissed\'; Court from \'RTC - Branch 25\' to \'N/A\'', '2025-11-01 21:12:05'),
(443, 1, 'Approved Resolution for III-09-INV-25K-0001', '2025-11-01 21:12:08'),
(444, 1, 'User logged out', '2025-11-01 21:13:49'),
(445, 1, 'User logged in', '2025-11-01 21:27:15'),
(446, 1, 'User logged in', '2025-11-02 14:56:04'),
(447, 1, 'User logged in', '2025-11-02 15:17:34'),
(448, 1, 'User logged in', '2025-11-02 15:43:09'),
(449, 1, 'User logged in', '2025-11-02 16:10:12'),
(450, 1, 'Approved subpoena III-09-INV-25J-0003', '2025-11-02 16:25:56'),
(451, 1, 'User logged in', '2025-11-02 18:05:52'),
(452, 1, 'User logged in', '2025-11-02 18:26:38'),
(453, 1, 'User logged in', '2025-11-02 18:47:29'),
(454, 1, 'User logged in', '2025-11-02 19:08:45'),
(455, 1, 'User logged in', '2025-11-02 19:56:30'),
(456, 1, 'User logged in', '2025-11-02 21:01:29'),
(457, 1, 'User logged in', '2025-11-02 21:22:28'),
(458, 1, 'User logged in', '2025-11-02 21:42:41'),
(459, 1, 'User logged in', '2025-11-03 20:37:32'),
(460, 1, 'User logged in', '2025-11-03 21:20:25'),
(461, 1, 'User logged in', '2025-11-03 21:42:23'),
(462, 1, 'User logged in', '2025-11-03 22:04:38'),
(463, 1, 'User logged in', '2025-11-03 22:26:50'),
(464, 1, 'User logged in', '2025-11-03 22:47:29'),
(465, 1, 'User logged in', '2025-11-03 23:08:32'),
(466, 1, 'User logged in', '2025-11-03 23:34:29'),
(467, 1, 'User logged in', '2025-11-03 23:54:56'),
(468, 1, 'User logged in', '2025-11-07 01:48:49'),
(469, 1, 'User logged out', '2025-11-07 01:51:54'),
(470, 1, 'User logged in', '2025-11-07 01:52:14'),
(471, 1, 'User logged in', '2025-11-07 02:16:05'),
(472, 1, 'User logged out', '2025-11-07 02:16:07'),
(473, 1, 'User logged in', '2025-11-07 02:18:31'),
(474, 1, 'User logged out', '2025-11-07 02:18:33'),
(475, 1, 'User logged in', '2025-11-07 02:24:26'),
(476, 1, 'User logged out', '2025-11-07 02:39:19'),
(477, 2, 'User logged in', '2025-11-07 02:39:27'),
(478, 2, 'User logged out', '2025-11-07 02:45:24'),
(479, 5, 'User logged in', '2025-11-07 02:45:32'),
(480, 5, 'User logged out', '2025-11-07 02:45:40'),
(481, 1, 'User logged in', '2025-11-07 02:52:41'),
(482, 1, 'User logged out', '2025-11-07 02:55:44'),
(483, 6, 'User logged in', '2025-11-07 02:55:57'),
(484, 6, 'User logged out', '2025-11-07 02:56:01'),
(485, 1, 'User logged in', '2025-11-07 04:39:02'),
(486, 1, 'User logged in', '2025-11-07 04:59:37'),
(487, 1, 'User logged in', '2025-11-07 05:28:45'),
(488, 1, 'Archived user Jayrold Delos Santos', '2025-11-07 06:07:00'),
(489, 1, '<function log_action at 0x000002BACF4268E0>', '2025-11-07 06:07:12'),
(490, 1, 'Archived user KurtNijel Curamen', '2025-11-07 06:08:14'),
(493, 1, 'Archived user Jayrold Delos Santos', '2025-11-07 06:09:19'),
(495, 1, 'Archived user Jayrold Delos Santos', '2025-11-07 06:12:33'),
(497, 1, 'Archived user Jayrold Delos Santos', '2025-11-07 06:13:55'),
(498, 1, 'Restored user Jayrold Delos Santos', '2025-11-07 06:13:58'),
(499, 1, 'Edited user \'Andrei  Esluzar Bernardo Jr.\': Added new address', '2025-11-07 06:32:07'),
(500, 1, 'User logged out', '2025-11-07 06:39:50'),
(501, 1, 'User \'chiefadmin\' logged in', '2025-11-07 07:30:19'),
(502, 1, 'Archived user Jayrold Delos Santos', '2025-11-07 07:30:44'),
(503, 1, 'User logged out', '2025-11-07 07:30:46'),
(504, 1, 'User \'chiefadmin\' logged in', '2025-11-07 07:38:45'),
(505, 1, 'User logged out', '2025-11-07 07:38:59'),
(506, 1, 'User logged in', '2025-11-07 08:04:39'),
(507, 1, 'User logged out', '2025-11-07 08:04:41'),
(508, 1, 'User logged in', '2025-11-07 08:13:07'),
(509, 1, 'User logged out', '2025-11-07 08:18:37'),
(510, 1, 'User logged in', '2025-11-07 08:19:30'),
(511, 1, 'User logged out', '2025-11-07 08:21:30'),
(512, 1, 'User logged in', '2025-11-07 08:23:45'),
(513, 1, 'Created new user: Gelo Esluzar Sandi with role \'Secretary\' and username \'Secretary1\'', '2025-11-07 08:29:41'),
(514, 1, 'Edited user \'Gelo Esluzar Sandi\': Updated password', '2025-11-07 08:30:06'),
(515, 1, 'Archived user KurtNijel Curamen', '2025-11-07 08:30:27'),
(516, 1, 'Restored user KurtNijel Curamen', '2025-11-07 08:30:38'),
(517, 1, 'User logged out', '2025-11-07 08:43:03'),
(518, 13, 'User logged in', '2025-11-07 08:49:20'),
(519, 13, 'Created subpoena III-09-INV-25K-0002', '2025-11-07 08:54:07'),
(520, 13, 'User logged out', '2025-11-07 08:54:54'),
(521, 1, 'User logged in', '2025-11-07 08:55:02'),
(522, 1, 'User logged out', '2025-11-07 08:55:11'),
(523, 1, 'User logged in', '2025-11-07 08:55:38'),
(524, 1, 'Edited user \'Arjann Esluzar Bernardo\': Added new address; Updated password', '2025-11-07 08:56:01'),
(525, 1, 'User logged out', '2025-11-07 08:56:05'),
(526, 10, 'User logged in', '2025-11-07 08:56:16'),
(527, 10, 'Denied subpoena III-09-INV-25K-0002 with comment: Not Good', '2025-11-07 08:57:04'),
(528, 10, 'User logged out', '2025-11-07 08:57:08'),
(529, 13, 'User logged in', '2025-11-07 08:57:33'),
(530, 13, 'Edited Subpoena III-09-INV-25K-0002: Crimes from [\'Theft\', \'Illegal Drugs\', \'Slight Physical Injuries\'] to [\'Theft\', \'Illegal Drugs\']; New Complainant: Juans Manilda Bernardo Sr.; Complainant linked: Andrei Esluzar Manersing; New Respondent: Darwin James Legaspi II; Respondent linked: Jayrold Wilder Moreed', '2025-11-07 08:58:00'),
(531, 13, 'User logged out', '2025-11-07 08:58:08'),
(532, 10, 'User logged in', '2025-11-07 08:58:17'),
(533, 10, 'Approved subpoena III-09-INV-25K-0002', '2025-11-07 08:58:39'),
(534, 10, 'User logged out', '2025-11-07 08:58:50'),
(535, 13, 'User logged in', '2025-11-07 08:59:02'),
(536, 13, 'Created Resolution for III-09-INV-25K-0002 with Verdict: For Filing, Court: RTC - Branch 24, Date: 2025-11-07', '2025-11-07 08:59:57'),
(537, 13, 'Edited Resolution for III-09-INV-25K-0002: Verdict from \'For Filing\' to \'Dismissed\'; Court from \'RTC - Branch 24\' to \'N/A\'', '2025-11-07 09:00:04'),
(538, 13, 'User logged out', '2025-11-07 09:00:12'),
(539, 1, 'User logged in', '2025-11-07 09:00:18'),
(540, 1, 'Denied Resolution for III-09-INV-25K-0002 with comment: Not good', '2025-11-07 09:00:41'),
(541, 1, 'Edited Resolution for III-09-INV-25K-0002: Verdict from \'Dismissed\' to \'For Filing\'; Court from \'None\' to \'MTC - Aliaga\'', '2025-11-07 09:00:59'),
(542, 1, 'Approved Resolution for III-09-INV-25K-0002', '2025-11-07 09:01:06'),
(543, 1, 'User logged out', '2025-11-07 09:01:26'),
(544, 13, 'User logged in', '2025-11-07 09:01:36'),
(545, 13, 'User logged out', '2025-11-07 09:01:43'),
(546, 6, 'User logged in', '2025-11-07 09:01:56'),
(547, 6, 'User logged out', '2025-11-07 09:02:13'),
(548, 1, 'User logged in', '2025-11-07 09:05:03'),
(549, 1, 'User logged in', '2025-11-07 15:14:05'),
(550, 1, 'User logged out', '2025-11-07 15:17:33'),
(551, 1, 'User logged in', '2025-11-07 15:19:59'),
(552, 1, 'Created subpoena III-09-INV-25K-0003', '2025-11-07 15:33:15'),
(553, 1, 'Denied subpoena III-09-INV-25K-0003 with comment: panget\r\n', '2025-11-07 15:33:41'),
(554, 1, 'Edited Subpoena III-09-INV-25K-0003: Complainant linked: Juan  Bernardo Jr.; Respondent linked: Marine Gojo Kitagawa', '2025-11-07 15:33:47'),
(555, 1, 'Edited Subpoena III-09-INV-25K-0003: Complainant linked: Juan  Bernardo Jr.; Respondent linked: Marine Gojo Kitagawa', '2025-11-07 15:34:11'),
(556, 1, 'Approved subpoena III-09-INV-25K-0003', '2025-11-07 15:34:23'),
(557, 1, 'Created Resolution for III-09-INV-25K-0003 with Verdict: For Filing, Court: MTC - Aliaga, Date: 2025-11-07', '2025-11-07 15:46:33'),
(558, 1, 'Edited Resolution for III-09-INV-25K-0003: Verdict from \'For Filing\' to \'Dismissed\'; Court from \'MTC - Aliaga\' to \'N/A\'', '2025-11-07 15:46:57'),
(559, 1, 'Approved Resolution for III-09-INV-25K-0003', '2025-11-07 15:48:40'),
(560, 1, 'User logged out', '2025-11-07 15:57:58'),
(561, 2, 'User logged in', '2025-11-07 15:58:11'),
(562, 2, 'User logged out', '2025-11-07 15:58:24'),
(563, 1, 'User logged in', '2025-11-07 15:59:28'),
(564, 1, 'User logged out', '2025-11-07 16:15:48'),
(565, 2, 'User logged in', '2025-11-07 16:15:58'),
(566, 1, 'User \'chiefadmin\' logged in', '2025-11-13 15:16:09'),
(567, 1, 'User logged out', '2025-11-13 15:16:19'),
(568, 7, 'Archived user \'Jaysecutor\' attempted to log in', '2025-11-13 15:16:32'),
(569, 7, 'Archived user \'Jaysecutor\' attempted to log in', '2025-11-13 15:16:41'),
(570, 1, 'User \'chiefadmin\' logged in', '2025-11-13 15:16:57'),
(573, 1, 'Added new crime \'Null\' (Null)', '2025-11-13 15:23:13'),
(574, 1, 'Edited crime ID 108: Name \'Null\' → \'panget\', Law Reference \'Null\' → \'Null\'', '2025-11-13 15:23:31'),
(575, 1, 'User \'chiefadmin\' logged in', '2025-11-13 15:48:45'),
(576, 1, 'User \'chiefadmin\' logged in', '2025-11-13 17:15:05'),
(577, 1, 'User \'chiefadmin\' logged in', '2025-11-13 17:38:08'),
(578, 1, 'User \'chiefadmin\' logged in', '2025-11-14 15:00:57'),
(579, 1, 'User \'chiefadmin\' logged in', '2025-11-14 15:21:41'),
(580, 1, 'User \'chiefadmin\' logged in', '2025-11-14 15:48:55'),
(581, 1, 'User \'chiefadmin\' logged in', '2025-11-14 16:11:40'),
(582, 1, 'User \'chiefadmin\' logged in', '2025-11-14 16:41:46'),
(583, 1, 'User \'chiefadmin\' logged in', '2025-11-14 17:07:22'),
(584, 1, 'User \'chiefadmin\' logged in', '2025-11-14 17:27:48'),
(585, 1, 'Created subpoena III-09-INV-25K-0004-0005-0006', '2025-11-14 17:29:40'),
(586, 1, 'User \'chiefadmin\' logged in', '2025-11-14 17:51:14'),
(587, 1, 'Created subpoena III-09-INV-25K-0007-0008-0009', '2025-11-14 18:01:52'),
(588, 1, 'Created subpoena III-09-INV-25K-0010-0011-0012', '2025-11-14 18:04:44'),
(589, 1, 'Created subpoena III-09-INV-25K-0013-0014-0015', '2025-11-14 18:11:13'),
(590, 1, 'User \'chiefadmin\' logged in', '2025-11-14 18:59:30'),
(591, 1, 'Created subpoena III-09-INV-25K-0016-0017-0018-0019', '2025-11-14 19:01:04'),
(592, 1, 'Created subpoena III-09-INV-25K-0020-0021-0022', '2025-11-14 19:07:02'),
(593, 1, 'Created subpoena III-09-INV-25K-0023-0024-0025-0026', '2025-11-14 19:12:28'),
(594, 1, 'Created subpoena III-09-INV-25K-0027-0028-0029-0030', '2025-11-14 19:17:30'),
(595, 1, 'Created subpoena III-09-INV-25K-0031-0032-0033-0034', '2025-11-14 19:25:10'),
(596, 1, 'User \'chiefadmin\' logged in', '2025-11-14 20:18:17'),
(597, 1, 'Created subpoena III-09-INV-25K-0035-0036-0037-0038', '2025-11-14 20:30:57'),
(598, 1, 'User \'chiefadmin\' logged in', '2025-11-14 20:52:00'),
(599, 1, 'User \'chiefadmin\' logged in', '2025-11-14 21:12:14'),
(600, 1, 'User \'chiefadmin\' logged in', '2025-11-14 21:33:27'),
(601, 1, 'User \'chiefadmin\' logged in', '2025-11-14 21:55:25'),
(602, 1, 'Edited Subpoena III-09-INV-25K-0004-0005-0006: Crimes from [\'Illegal Drugs\', \'Parricide\', \'Less Serious Physical Injuries\'] to [\'Illegal Drugs\', \'Parricide\']; Complainant linked: Juan Manilda Bernardo; Respondent linked: Pogi James Legaspi', '2025-11-14 21:56:15'),
(603, 1, 'User \'chiefadmin\' logged in', '2025-11-14 22:24:44'),
(604, 1, 'Failed login attempt for \'chiefadmin\'', '2025-11-14 22:45:45'),
(605, 1, 'User \'chiefadmin\' logged in', '2025-11-14 22:45:49'),
(606, 1, 'Failed login attempt for \'chiefadmin\'', '2025-11-14 23:10:49'),
(607, 1, 'Failed login attempt for \'chiefadmin\'', '2025-11-14 23:10:53'),
(608, 1, 'User \'chiefadmin\' logged in', '2025-11-14 23:11:01'),
(609, 1, 'User \'chiefadmin\' logged in', '2025-11-14 23:41:14'),
(610, 1, 'User \'chiefadmin\' logged in', '2025-11-14 23:41:16'),
(611, 1, 'Created subpoena III-09-INV-25K-0039-0041', '2025-11-14 23:55:41'),
(612, 1, 'Approved subpoena III-09-INV-25K-0039-0041', '2025-11-15 00:09:20'),
(613, 1, 'User \'chiefadmin\' logged in', '2025-11-15 00:29:48'),
(614, 1, 'User \'chiefadmin\' logged in', '2025-11-15 17:20:50'),
(615, 1, 'User \'chiefadmin\' logged in', '2025-11-15 17:42:26'),
(616, 1, 'User \'chiefadmin\' logged in', '2025-11-15 18:03:31'),
(617, 1, 'User \'chiefadmin\' logged in', '2025-11-15 18:29:32'),
(618, 1, 'User \'chiefadmin\' logged in', '2025-11-15 19:45:12'),
(619, 1, 'User \'chiefadmin\' logged in', '2025-11-15 20:07:16'),
(620, 1, 'User \'chiefadmin\' logged in', '2025-11-15 20:39:49'),
(621, 1, 'Edited Resolution for III-09-INV-25J-0002: Court from \'RTC - Branch 24\' to \'MCTC Cabiao-San Isidro\'; Date from \'2025-10-31\' to \'2025-11-15\'', '2025-11-15 20:40:26'),
(622, 1, 'Approved Resolution for III-09-INV-25J-0002', '2025-11-15 20:55:43'),
(623, 1, 'User \'chiefadmin\' logged in', '2025-11-15 21:18:29'),
(624, 1, 'User logged out', '2025-11-15 21:34:22'),
(625, 2, 'User \'Itchanisan\' logged in', '2025-11-15 21:41:03'),
(626, 2, 'Created subpoena III-09-INV-25K-0042-0044', '2025-11-15 21:50:10'),
(627, 2, 'User logged out', '2025-11-15 21:53:57'),
(628, 1, 'User \'chiefadmin\' logged in', '2025-11-15 21:54:01'),
(629, 1, 'User logged out', '2025-11-15 21:57:42'),
(630, 2, 'User \'Itchanisan\' logged in', '2025-11-15 21:57:47'),
(631, 2, 'User logged out', '2025-11-15 22:16:56'),
(632, 1, 'User \'chiefadmin\' logged in', '2025-11-15 22:17:10'),
(633, 1, 'User logged out', '2025-11-15 22:17:23'),
(634, 2, 'User \'Itchanisan\' logged in', '2025-11-15 22:17:40'),
(635, 2, 'User logged out', '2025-11-15 22:18:32'),
(636, 5, 'Failed login attempt for \'Prosecutor1\'', '2025-11-15 22:18:38'),
(637, 5, 'User \'Prosecutor1\' logged in', '2025-11-15 22:18:42'),
(638, 5, 'User logged out', '2025-11-15 22:31:36');
INSERT INTO `log_table` (`LOG_ID`, `USER_ID`, `Action`, `Timestamp`) VALUES
(639, 1, 'User \'chiefadmin\' logged in', '2025-11-15 22:31:43'),
(640, 1, 'User logged out', '2025-11-15 22:31:58'),
(641, 5, 'User \'Prosecutor1\' logged in', '2025-11-15 22:32:04'),
(642, 5, 'User logged out', '2025-11-15 22:34:01'),
(643, 1, 'User \'chiefadmin\' logged in', '2025-11-15 22:34:06'),
(644, 1, 'Denied subpoena III-09-INV-25K-0035-0036-0037-0038 with comment: Panget', '2025-11-15 22:34:18'),
(645, 1, 'Denied subpoena III-09-INV-25K-0042-0044 with comment: Panget', '2025-11-15 22:34:35'),
(646, 1, 'Edited Subpoena III-09-INV-25K-0042-0044: Complainant linked: Juan Manilda Bernardo III; Respondent linked: Pogi James Kitagawa; Respondent linked: Jayrold Wilder Mowr', '2025-11-15 22:34:38'),
(647, 1, 'User logged out', '2025-11-15 22:34:41'),
(648, 5, 'User \'Prosecutor1\' logged in', '2025-11-15 22:34:50'),
(649, 5, 'Approved subpoena III-09-INV-25K-0023-0024-0025-0026', '2025-11-15 22:40:59'),
(650, 5, 'Denied subpoena III-09-INV-25K-0042-0044 with comment: Panget', '2025-11-15 22:45:59'),
(651, 5, 'User logged out', '2025-11-15 22:46:19'),
(652, 2, 'User \'Itchanisan\' logged in', '2025-11-15 22:46:33'),
(653, 2, 'Edited Subpoena III-09-INV-25K-0042-0044: Complainant linked: Juan Manilda Bernardo III; Respondent linked: Pogi James Kitagawa; Respondent linked: Jayrold Wilder Mowr', '2025-11-15 22:46:40'),
(654, 2, 'User logged out', '2025-11-15 22:46:44'),
(655, 5, 'User \'Prosecutor1\' logged in', '2025-11-15 22:47:00'),
(656, 5, 'Approved subpoena III-09-INV-25K-0042-0044', '2025-11-15 22:47:07'),
(657, 5, 'User logged out', '2025-11-15 22:47:12'),
(658, 2, 'User \'Itchanisan\' logged in', '2025-11-15 22:47:26'),
(659, 2, 'Created Resolution for III-09-INV-25K-0042-0044 with Verdict: For Filing, Court: MTC Aliaga, Date: 2025-11-15', '2025-11-15 22:47:46'),
(660, 2, 'User logged out', '2025-11-15 22:49:17'),
(661, 1, 'User \'chiefadmin\' logged in', '2025-11-15 22:49:22'),
(662, 1, 'User logged out', '2025-11-15 22:49:29'),
(663, 5, 'User \'Prosecutor1\' logged in', '2025-11-15 22:49:38'),
(664, 5, 'User logged out', '2025-11-15 22:53:04'),
(665, 2, 'User \'Itchanisan\' logged in', '2025-11-15 22:53:09'),
(666, 2, 'Edited Resolution for III-09-INV-25K-0042-0044: Verdict from \'For Filing\' to \'Dismissed\'; Court from \'MTC Aliaga\' to \'N/A\'', '2025-11-15 22:56:27'),
(667, 2, 'Edited Resolution for III-09-INV-25K-0042-0044: Verdict from \'Dismissed\' to \'For Filing\'', '2025-11-15 22:56:34'),
(668, 2, 'Edited Resolution for III-09-INV-25K-0042-0044: Court from \'None\' to \'MTC Carranglan\'', '2025-11-15 22:56:39'),
(669, 2, 'Edited Resolution for III-09-INV-25K-0042-0044: Court from \'MTC Carranglan\' to \'MTC San Antonio\'', '2025-11-15 22:56:58'),
(670, 2, 'User logged out', '2025-11-15 22:57:11'),
(671, 1, 'User \'chiefadmin\' logged in', '2025-11-15 22:57:16'),
(672, 1, 'Edited Resolution for III-09-INV-25K-0042-0044: Court from \'MTC San Antonio\' to \'N/A\'', '2025-11-15 22:57:33'),
(673, 1, 'Edited Resolution for III-09-INV-25K-0042-0044: Court from \'None\' to \'MTC Cuyapo\'', '2025-11-15 22:57:38'),
(674, 1, 'Approved Resolution for III-09-INV-25K-0042-0044', '2025-11-15 22:58:12'),
(675, 1, 'User logged out', '2025-11-15 22:58:26'),
(676, 6, 'User \'PServer1\' logged in', '2025-11-15 22:58:32');

-- --------------------------------------------------------

--
-- Table structure for table `offense`
--

CREATE TABLE `offense` (
  `offense_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `law_reference` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offense`
--

INSERT INTO `offense` (`offense_id`, `name`, `law_reference`) VALUES
(1, 'Theft', 'Art. 308, RPC'),
(2, 'Estafa', 'Art. 315, RPC'),
(3, 'Rape', 'R.A. 8353'),
(4, 'Illegal Drugs', 'R.A. 9165'),
(5, 'Murder', 'Art. 248, RPC'),
(6, 'Homicide', 'Art. 249, RPC'),
(7, 'Parricide', 'Art. 246, RPC'),
(8, 'Serious Physical Injuries', 'Art. 263, RPC'),
(9, 'Less Serious Physical Injuries', 'Art. 265, RPC'),
(10, 'Slight Physical Injuries', 'Art. 266, RPC'),
(11, 'Robbery with Violence Against or Intimidation of Persons', 'Art. 294, RPC'),
(12, 'Robbery with Homicide', 'Art. 294(1), RPC'),
(13, 'Robbery with Rape', 'Art. 294(2), RPC'),
(14, 'Qualified Theft', 'Art. 310, RPC'),
(15, 'Arson', 'Art. 320, RPC'),
(16, 'Malicious Mischief', 'Art. 327, RPC'),
(17, 'Grave Threats', 'Art. 282, RPC'),
(18, 'Light Threats', 'Art. 283, RPC'),
(19, 'Grave Coercion', 'Art. 286, RPC'),
(20, 'Unjust Vexation', 'Art. 287, RPC'),
(21, 'Acts of Lasciviousness', 'Art. 336, RPC'),
(22, 'Adultery', 'Art. 333, RPC'),
(23, 'Concubinage', 'Art. 334, RPC'),
(24, 'Bigamy', 'Art. 349, RPC'),
(25, 'Illegal Recruitment', 'Art. 38, Labor Code / R.A. 8042'),
(26, 'Child Abuse', 'R.A. 7610'),
(27, 'Violence Against Women and Children (VAWC)', 'R.A. 9262'),
(28, 'Anti-Sexual Harassment', 'R.A. 7877'),
(29, 'Trafficking in Persons', 'R.A. 9208 as amended by R.A. 10364'),
(30, 'Plunder', 'R.A. 7080'),
(31, 'Graft and Corrupt Practices', 'R.A. 3019'),
(32, 'Bribery (Direct)', 'Art. 210, RPC'),
(33, 'Bribery (Indirect)', 'Art. 211, RPC'),
(34, 'Qualified Bribery', 'Art. 211-A, RPC'),
(35, 'Malversation of Public Funds', 'Art. 217, RPC'),
(36, 'Technical Malversation', 'Art. 220, RPC'),
(37, 'Illegal Possession of Firearms', 'R.A. 10591'),
(38, 'Illegal Possession of Dangerous Drugs', 'R.A. 9165'),
(39, 'Illegal Trafficking of Dangerous Drugs', 'R.A. 9165'),
(40, 'Carnapping', 'R.A. 6539'),
(41, 'Highway Robbery / Brigandage', 'P.D. 532'),
(42, 'Illegal Gambling', 'P.D. 1602'),
(43, 'Cybercrime (Computer-Related Offenses)', 'R.A. 10175'),
(44, 'Libel', 'Art. 353, RPC'),
(45, 'Slander (Oral Defamation)', 'Art. 358, RPC'),
(46, 'Intriguing Against Honor', 'Art. 364, RPC'),
(47, 'Forgery of Public Document', 'Art. 171, RPC'),
(48, 'Falsification of Private Document', 'Art. 172, RPC'),
(49, 'Use of Falsified Documents', 'Art. 172(2), RPC'),
(50, 'Perjury', 'Art. 183, RPC'),
(51, 'Alarm and Scandal', 'Art. 155, RPC'),
(52, 'Illegal Assembly', 'Art. 146, RPC'),
(53, 'Illegal Possession of Explosives', 'R.A. 9516'),
(54, 'Kidnapping and Serious Illegal Detention', 'Art. 267, RPC'),
(55, 'Slight Illegal Detention', 'Art. 268, RPC'),
(56, 'Kidnapping for Ransom', 'Art. 267, RPC'),
(57, 'Infanticide', 'Art. 255, RPC'),
(58, 'Abortion (Intentional)', 'Art. 256, RPC'),
(59, 'Abortion (Unintentional)', 'Art. 257, RPC'),
(60, 'Abortion (By Woman or Parents)', 'Art. 258, RPC'),
(61, 'Illegal Marriage', 'Art. 350, RPC'),
(62, 'Premature Marriages', 'Art. 351, RPC'),
(63, 'Usurpation of Authority', 'Art. 177, RPC'),
(64, 'False Testimony', 'Art. 180, RPC'),
(65, 'Rebellion', 'Art. 134, RPC'),
(66, 'Sedition', 'Art. 139, RPC'),
(67, 'Direct Assault', 'Art. 148, RPC'),
(68, 'Indirect Assault', 'Art. 149, RPC'),
(69, 'Resistance and Disobedience to Authority', 'Art. 151, RPC'),
(70, 'Evasion of Service of Sentence', 'Art. 157, RPC'),
(71, 'Escape of Prisoner', 'Art. 158, RPC'),
(72, 'Delivering Prisoners from Jail', 'Art. 156, RPC'),
(73, 'Infidelity in the Custody of Prisoners', 'Art. 223, RPC'),
(74, 'Infidelity in the Custody of Documents', 'Art. 226, RPC'),
(75, 'Anti-Hazing Act Violation', 'R.A. 8049 as amended by R.A. 11053'),
(76, 'Anti-Drunk and Drugged Driving', 'R.A. 10586'),
(77, 'Illegal Logging', 'P.D. 705'),
(78, 'Illegal Fishing', 'P.D. 704'),
(79, 'Smuggling', 'Tariff and Customs Code / R.A. 1937'),
(80, 'Money Laundering', 'R.A. 9160 as amended'),
(81, 'Torture', 'R.A. 9745'),
(82, 'Enforced Disappearance', 'R.A. 10353'),
(83, 'Anti-Terrorism', 'R.A. 11479'),
(84, 'Unlawful Arrest', 'Art. 269, RPC'),
(85, 'Abandonment of Person in Danger', 'Art. 275, RPC'),
(86, 'Abandonment of Minor', 'Art. 276, RPC'),
(87, 'Exploitation of Minors', 'Art. 278, RPC'),
(88, 'Qualified Seduction', 'Art. 337, RPC'),
(89, 'Simple Seduction', 'Art. 338, RPC'),
(90, 'Acts of Child Prostitution and Sexual Abuse', 'R.A. 7610'),
(91, 'Anti-Child Pornography', 'R.A. 9775'),
(92, 'Anti-Photo and Video Voyeurism', 'R.A. 9995'),
(93, 'Stalking / Unjust Vexation Extension', 'Art. 287, RPC'),
(94, 'Reckless Imprudence Resulting in Homicide', 'Art. 365, RPC'),
(95, 'Reckless Imprudence Resulting in Physical Injuries', 'Art. 365, RPC'),
(96, 'Reckless Imprudence Resulting in Damage to Property', 'Art. 365, RPC'),
(97, 'Fencing', 'P.D. 1612'),
(98, 'Vagrancy', 'Art. 202, RPC (decriminalized by R.A. 10158)'),
(99, 'Prostitution', 'Art. 202, RPC / R.A. 10158'),
(100, 'Obstruction of Justice', 'P.D. 1829'),
(101, 'null', 'null'),
(102, 'Null', 'Null'),
(103, 'Null', 'Null'),
(104, 'Null', 'Null'),
(105, 'Nulls', 'Nulls'),
(106, 'Null', 'Null'),
(107, 'Null', 'Null'),
(108, 'panget', 'Null');

-- --------------------------------------------------------

--
-- Table structure for table `password`
--

CREATE TABLE `password` (
  `PASSWORD_ID` int(11) NOT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `USER_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password`
--

INSERT INTO `password` (`PASSWORD_ID`, `Password`, `USER_ID`) VALUES
(1, 'scrypt:32768:8:1$dHYypTsQ0y2fnoU1$76b5965f6368d30d5d5a236545e8f1438ec40a551e857a0d80713c14ccfa003f8a379c85907e90d2000aea49a600a9754db022010e67ccef32bdd8eede248a25', 1),
(2, 'scrypt:32768:8:1$5xm5ecGqlqh2tx4i$73f8a7f1f665c62f66afbc52bb2bf9c825b1915319ff28063e5c29450782ddb65940afd2a25162a07fb56d54605799e3e87a0f00168f49dddf8fa19208162690', 2),
(5, 'scrypt:32768:8:1$f46otL4ThIX3wPAl$f1584b903eeb4ca3fcba18cd99607bdedcddf9b8172e223478c0b3ccd6534c1cc1ef8aa5d96a1ad7bf7adb608f9dfe3368c7bbddd4d40fe3a01b8d831492ff51', 5),
(6, 'scrypt:32768:8:1$C1u5379TqBtQLRb0$c338ca5b2f20a2e6ab248a3acf3acf6221847d5feddcbd478bd384c5260c452c0b144e5130cffe9f3eac22cb924fee6b9285066aeae8c297670982df9b31a729', 6),
(7, 'scrypt:32768:8:1$ZqFPmWutGUnj4RDZ$4232b8e47d9d0e54d62ee260174b806285d0db5a69372a4791d75cf4ae33754a4d56ce004133cc1e8b0542c41391d2848fe7bd4e2bfb4222faa5d9828b09cd64', 7),
(8, 'scrypt:32768:8:1$HdJLrJYpSG9kO6Fn$d5f7a41660874f5124695dbf3f21557f787ec44f7153ba97fbaa426a92c93198068745d5ff31ef5441a269a2fcc0caad40f3f9c9611b1b5946098883d413d5cd', 8),
(9, 'scrypt:32768:8:1$WdCfEToeWqkPbhJX$d7ca86d2baf682583043e69a0422806e14475e0b559fc4375e4fe5fb1d010fcc15237747f844bab6f7d7848a014d585f4ee6bc04655c18ead0e6611f9005b0a6', 9),
(10, 'scrypt:32768:8:1$TiBzDQF3kUxnNoy1$2bd161fcba447d90e2ee9edce6901f9321021f884dee5ae732964af40af8be08cedc8c468f3a5574727b7062f463d0be7298df8cfb793307d98031f253bff195', 10),
(11, 'scrypt:32768:8:1$mJihffPpSbaVy8hM$3581ec26f31e8f9edeccc0ea8946dda97b70d86fd368713717cde5ea2b91bd91ea41f0043866cc40d98f7421831e4d7a78c76d41eb13e3c369905e03bc91475c', 11),
(12, 'scrypt:32768:8:1$TeT8Q4dE7Nt1Bz6Q$b02d53721c6969318cb3dd73abc02c0c0f12a5caef43c95cb4df00ec51ca9b5962e97f660f5f2fba2fbb640a6f0c95fe0bf74333ff68af9bfbb075ec814279fb', 12),
(13, 'scrypt:32768:8:1$ufBu2F6t5tftfOiX$e822b2e251a615e9bc1dbd8fb8399e160131dd349dc7f16f664d84a07e53ec23575304d3a138b05569609d339eb46b326ac878c890510484d991e97f8164728e', 13);

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `PERSON_ID` int(11) NOT NULL,
  `Last_name` varchar(100) NOT NULL,
  `First_name` varchar(100) NOT NULL,
  `Middle_name` varchar(100) DEFAULT NULL,
  `suffix` enum('Jr.','Sr.','II','III','IV') DEFAULT NULL,
  `Date_of_Birth` date DEFAULT NULL,
  `Sex` enum('Male','Female') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`PERSON_ID`, `Last_name`, `First_name`, `Middle_name`, `suffix`, `Date_of_Birth`, `Sex`) VALUES
(1, 'Cruz', 'Juan', 'Dela', NULL, '1980-05-20', 'Male'),
(48, 'Bernardo', 'Andrei ', 'Esluzar', 'Jr.', '2003-03-22', 'Male'),
(54, 'Legaspi', 'Christian James', '', '', '2003-06-12', 'Male'),
(57, 'Eugenio', 'Nicolas', 'Nigga', '', '2003-01-22', 'Male'),
(83, 'Eugenio', 'Noel ', 'Hula', '', '1967-12-03', 'Male'),
(97, 'Delos Santos', 'Jayrold', '', 'III', '1982-10-27', 'Male'),
(98, 'Curamen', 'KurtNijel', '', '', '1881-06-25', 'Female'),
(99, 'Mensalvas', 'Jan Paul', '', 'IV', '1990-10-30', 'Male'),
(100, 'Bernardo', 'Arjann', 'Esluzar', '', '1998-08-14', 'Male'),
(200, 'Ramos', 'Andrei', 'C.', 'Jr.', '1997-07-02', 'Male'),
(201, 'Legaspi', 'Emilio', 'R.', 'IV', '1986-04-15', 'Male'),
(202, 'Torres', 'Ana', 'R.', 'IV', '1967-07-03', 'Female'),
(203, 'Reyes', 'Mark', 'H.', 'Sr.', '1978-02-28', 'Male'),
(204, 'Bernardo', 'Liza', 'L.', 'II', '1982-04-22', 'Female'),
(205, 'Torres', 'Nicolas', 'M.', 'IV', '1977-11-23', 'Male'),
(206, 'Mensalvas', 'Jose', 'M.', 'IV', '1977-02-07', 'Male'),
(207, 'Morales', 'Christian', 'P.', 'Jr.', '1965-01-28', 'Male'),
(208, 'Gonzales', 'Ramon', 'T.', 'IV', '1989-09-09', 'Male'),
(209, 'Cruz', 'Rita', 'J.', 'Jr.', '1987-03-15', 'Female'),
(210, 'Morales', 'Jan', 'T.', 'Sr.', '1972-03-12', 'Male'),
(211, 'Ramos', 'Grace', 'E.', 'IV', '1968-11-16', 'Female'),
(212, 'Ramos', 'Catherine', 'G.', NULL, '2005-05-13', 'Female'),
(213, 'Eugenio', 'Liza', 'H.', 'IV', '1964-06-01', 'Female'),
(214, 'Garcia', 'Juan', 'B.', 'II', '1974-02-02', 'Male'),
(215, 'Ramirez', 'Andrei', 'L.', NULL, '1987-07-15', 'Male'),
(216, 'Cruz', 'Rita', 'H.', 'III', '1972-04-18', 'Female'),
(217, 'Eugenio', 'Elaine', 'C.', 'Jr.', '1988-09-04', 'Female'),
(218, 'Torres', 'Kristine', 'J.', 'IV', '1987-12-24', 'Female'),
(219, 'Reyes', 'Catherine', 'S.', 'II', '1994-01-24', 'Female'),
(220, 'Morales', 'Sofia', 'F.', 'Sr.', '1963-09-03', 'Female'),
(221, 'Eugenio', 'Michael', 'I.', NULL, '1985-03-22', 'Male'),
(222, 'Torres', 'Juan', 'T.', 'IV', '1996-02-03', 'Male'),
(223, 'Garcia', 'Daniel', 'H.', 'III', '1983-05-06', 'Male'),
(224, 'Curamen', 'Emilio', 'D.', 'Jr.', '1968-05-04', 'Male'),
(225, 'Reyes', 'Kristine', 'A.', 'II', '1981-03-21', 'Female'),
(226, 'Santos', 'Nina', 'D.', 'IV', '1964-12-05', 'Female'),
(227, 'Ramos', 'Daniel', 'N.', 'Sr.', '1999-12-05', 'Male'),
(228, 'Mensalvas', 'Nicolas', 'N.', 'Sr.', '2002-12-26', 'Male'),
(229, 'Flores', 'Ana', 'H.', 'II', '1972-08-12', 'Female'),
(230, 'Mensalvas', 'Ramon', 'I.', NULL, '1964-05-12', 'Male'),
(231, 'Navarro', 'Mara', 'Q.', 'Sr.', '1967-07-19', 'Female'),
(232, 'Ramos', 'Manuel', 'G.', NULL, '1983-07-03', 'Male'),
(233, 'Curamen', 'Sofia', 'N.', 'II', '1980-07-23', 'Female'),
(234, 'Bernardo', 'Andrea', 'T.', 'IV', '1996-05-13', 'Female'),
(235, 'Morales', 'Jan', 'T.', 'Sr.', '1981-02-27', 'Male'),
(236, 'Reyes', 'Juan', 'H.', 'Jr.', '1990-10-28', 'Male'),
(237, 'Flores', 'Ramon', 'M.', NULL, '1975-03-21', 'Male'),
(238, 'Morales', 'Nicolas', 'O.', 'Jr.', '1963-09-08', 'Male'),
(239, 'Eugenio', 'Kristine', 'I.', 'Sr.', '1993-08-21', 'Female'),
(240, 'Delos Santos', 'Angela', 'K.', 'Sr.', '1980-09-03', 'Female'),
(241, 'Garcia', 'Arjann', 'N.', 'III', '1986-06-18', 'Male'),
(242, 'Vargas', 'Andrea', 'A.', 'Jr.', '1996-07-16', 'Female'),
(243, 'Ramos', 'Nina', 'T.', 'II', '1974-08-08', 'Female'),
(244, 'Ramirez', 'Mark', 'E.', 'II', '1989-03-02', 'Male'),
(245, 'Mensalvas', 'Rita', 'M.', 'Jr.', '1977-07-09', 'Female'),
(246, 'Eugenio', 'Daniel', 'C.', 'Jr.', '2001-01-25', 'Male'),
(247, 'Curamen', 'Nicolas', 'D.', 'IV', '1997-01-10', 'Male'),
(248, 'Eugenio', 'Roberto', 'D.', NULL, '2004-05-28', 'Male'),
(249, 'Ramos', 'Daniel', 'N.', 'IV', '2002-06-03', 'Male'),
(250, 'Ramos', 'Isabel', 'P.', NULL, '1989-07-27', 'Female'),
(251, 'Delos Santos', 'Mark', 'O.', 'IV', '1975-08-19', 'Male'),
(252, 'Bernardo', 'Rita', 'P.', 'II', '1973-06-26', 'Female'),
(253, 'Santos', 'Nina', 'Q.', NULL, '1972-02-08', 'Female'),
(254, 'Flores', 'Luis', 'O.', 'Sr.', '1961-02-10', 'Male'),
(255, 'Ramos', 'Gina', 'Q.', 'IV', '1982-07-24', 'Female'),
(256, 'Delos Santos', 'Luis', 'S.', 'Jr.', '1993-10-10', 'Male'),
(257, 'Curamen', 'Jillian', 'A.', 'II', '2005-09-05', 'Female'),
(258, 'Flores', 'Kurt', 'D.', 'Jr.', '1964-07-16', 'Male'),
(259, 'Curamen', 'Roberto', 'C.', 'III', '1975-02-18', 'Male'),
(260, 'Torres', 'Elaine', 'J.', 'IV', '1997-07-10', 'Female'),
(261, 'Navarro', 'Elaine', 'P.', 'II', '1978-01-08', 'Female'),
(262, 'Vargas', 'Kurt', 'G.', 'Sr.', '1987-02-18', 'Male'),
(263, 'Morales', 'Kristine', 'R.', 'IV', '1991-08-03', 'Female'),
(264, 'Garcia', 'Maria', 'H.', 'Jr.', '2003-10-19', 'Female'),
(265, 'Morales', 'Luis', 'O.', 'III', '1977-03-19', 'Male'),
(266, 'Mensalvas', 'Mara', 'K.', 'Sr.', '2002-02-28', 'Female'),
(267, 'Ramos', 'Andrea', 'B.', 'II', '1989-02-11', 'Female'),
(268, 'Legaspi', 'Ana', 'I.', 'III', '1995-03-10', 'Female'),
(269, 'Curamen', 'Nicolas', 'R.', 'Jr.', '1960-09-14', 'Male'),
(270, 'Flores', 'Christian', 'J.', 'III', '1992-12-09', 'Male'),
(271, 'Dela Cruz', 'Nina', 'M.', NULL, '1972-10-17', 'Female'),
(272, 'Morales', 'Rita', 'I.', 'II', '1960-05-24', 'Female'),
(273, 'Ramirez', 'Angela', 'B.', NULL, '1980-12-16', 'Female'),
(274, 'Dela Cruz', 'Ana', 'Q.', 'Jr.', '1997-06-28', 'Female'),
(275, 'Dela Cruz', 'Maria', 'N.', 'III', '2001-03-03', 'Female'),
(276, 'Mensalvas', 'Grace', 'R.', NULL, '1984-06-21', 'Female'),
(277, 'Curamen', 'Jillian', 'A.', 'Jr.', '1962-06-26', 'Female'),
(278, 'Eugenio', 'Katrina', 'Q.', 'Sr.', '1986-10-22', 'Female'),
(279, 'Eugenio', 'Isabel', 'P.', 'III', '1997-03-08', 'Female'),
(280, 'Curamen', 'Pedro', 'R.', 'II', '1970-02-15', 'Male'),
(281, 'Gonzales', 'Maria', 'I.', NULL, '1960-10-28', 'Female'),
(282, 'Lopez', 'Rogelio', 'H.', 'II', '2000-04-20', 'Male'),
(283, 'Reyes', 'Elaine', 'S.', 'Jr.', '1983-12-05', 'Female'),
(284, 'Dela Cruz', 'Arjann', 'R.', 'II', '1983-09-17', 'Male'),
(285, 'Cruz', 'Rita', 'O.', 'Sr.', '1964-03-25', 'Female'),
(286, 'Cruz', 'Liza', 'H.', 'IV', '1990-01-20', 'Female'),
(287, 'Ramirez', 'Joy', 'D.', 'II', '1968-01-02', 'Female'),
(288, 'Dela Cruz', 'Emilio', 'M.', NULL, '1989-06-22', 'Male'),
(289, 'Cruz', 'Carlos', 'P.', 'Jr.', '1999-07-09', 'Male'),
(290, 'Lopez', 'Angela', 'D.', NULL, '2003-06-18', 'Female'),
(291, 'Legaspi', 'Roberto', 'C.', 'Sr.', '1995-04-19', 'Male'),
(292, 'Dela Cruz', 'Kurt', 'E.', 'Sr.', '1994-05-26', 'Male'),
(293, 'Eugenio', 'Daniel', 'S.', 'II', '1980-01-06', 'Male'),
(294, 'Reyes', 'Rogelio', 'Q.', 'Jr.', '1979-08-21', 'Male'),
(295, 'Flores', 'Liza', 'O.', 'IV', '1964-02-11', 'Female'),
(296, 'Vargas', 'Isabel', 'R.', 'IV', '2005-06-13', 'Female'),
(297, 'Cruz', 'Liza', 'R.', 'Sr.', '1973-07-15', 'Female'),
(298, 'Cruz', 'Mara', 'K.', 'II', '1987-06-22', 'Female'),
(299, 'Ramirez', 'Liza', 'L.', NULL, '2002-07-28', 'Female'),
(300, 'Cruz', 'Liza', 'S.', NULL, '1992-04-05', 'Female'),
(301, 'Lopez', 'Nina', 'D.', 'III', '1977-10-08', 'Female'),
(302, 'Bernardo', 'Maria', 'I.', 'II', '2004-05-11', 'Female'),
(303, 'Dela Cruz', 'Grace', 'A.', 'Sr.', '1965-12-17', 'Female'),
(304, 'Lopez', 'Jillian', 'J.', 'Jr.', '1980-10-20', 'Female'),
(305, 'Cruz', 'Manuel', 'L.', NULL, '1987-02-10', 'Male'),
(306, 'Eugenio', 'Ana', 'M.', 'Sr.', '1998-01-01', 'Female'),
(307, 'Mensalvas', 'Joy', 'D.', 'III', '1960-08-24', 'Female'),
(308, 'Ramos', 'Manuel', 'L.', NULL, '1964-07-28', 'Male'),
(309, 'Torres', 'Rogelio', 'L.', 'Jr.', '1965-07-28', 'Male'),
(310, 'Garcia', 'Sofia', 'M.', 'Sr.', '1979-12-11', 'Female'),
(311, 'Morales', 'Manuel', 'G.', NULL, '1982-06-24', 'Male'),
(312, 'Navarro', 'Carmela', 'K.', 'III', '2000-06-05', 'Female'),
(313, 'Vargas', 'Kristine', 'B.', 'II', '1982-09-03', 'Female'),
(314, 'Curamen', 'Daniel', 'C.', 'IV', '2001-02-20', 'Male'),
(315, 'Vargas', 'Pedro', 'G.', 'IV', '1980-10-16', 'Male'),
(316, 'Curamen', 'Liza', 'M.', 'IV', '1986-06-22', 'Female'),
(317, 'Ramos', 'Liza', 'M.', NULL, '1978-05-24', 'Female'),
(318, 'Dela Cruz', 'Roberto', 'L.', NULL, '1979-11-23', 'Male'),
(319, 'Ramos', 'Jan', 'M.', 'Sr.', '2001-06-27', 'Male'),
(320, 'Morales', 'Liza', 'R.', 'II', '1993-01-22', 'Female'),
(321, 'Bernardo', 'Katrina', 'F.', 'Sr.', '2004-10-26', 'Female'),
(322, 'Vargas', 'Daniel', 'O.', 'III', '1989-05-25', 'Male'),
(323, 'Navarro', 'Arjann', 'E.', 'III', '1976-01-21', 'Male'),
(324, 'Garcia', 'Jan', 'F.', 'Sr.', '1977-08-17', 'Male'),
(325, 'Santos', 'Liza', 'N.', 'II', '1963-07-17', 'Female'),
(326, 'Torres', 'Luis', 'T.', 'II', '1960-02-01', 'Male'),
(327, 'Curamen', 'Liza', 'H.', 'Sr.', '1979-02-02', 'Female'),
(328, 'Navarro', 'Luis', 'R.', 'IV', '1961-11-17', 'Male'),
(329, 'Navarro', 'Maria', 'L.', 'Sr.', '1975-10-14', 'Female'),
(330, 'Eugenio', 'Daniel', 'D.', 'II', '1997-12-25', 'Male'),
(331, 'Torres', 'Jillian', 'P.', 'Sr.', '2000-03-26', 'Female'),
(332, 'Reyes', 'Catherine', 'G.', 'IV', '1962-06-10', 'Female'),
(333, 'Gonzales', 'Elaine', 'K.', 'III', '1971-08-23', 'Female'),
(334, 'Garcia', 'Carlos', 'N.', 'II', '1998-03-18', 'Male'),
(335, 'Curamen', 'Joy', 'O.', 'Sr.', '1998-12-14', 'Female'),
(336, 'Navarro', 'Daniel', 'N.', 'Jr.', '1977-11-26', 'Male'),
(337, 'Gonzales', 'Liza', 'S.', NULL, '1962-10-05', 'Female'),
(338, 'Vargas', 'Grace', 'E.', 'II', '1993-06-13', 'Female'),
(339, 'Flores', 'Nicolas', 'Q.', 'II', '1984-09-04', 'Male'),
(340, 'Legaspi', 'Gina', 'D.', 'Sr.', '1968-02-15', 'Female'),
(341, 'Dela Cruz', 'Arjann', 'H.', 'IV', '1991-01-12', 'Male'),
(342, 'Garcia', 'Rogelio', 'C.', NULL, '1979-07-23', 'Male'),
(343, 'Garcia', 'Carmela', 'E.', 'III', '1980-11-03', 'Female'),
(344, 'Vargas', 'Emilio', 'F.', 'Jr.', '1968-07-17', 'Male'),
(345, 'Curamen', 'Katrina', 'T.', NULL, '1994-02-17', 'Female'),
(346, 'Navarro', 'Rogelio', 'K.', 'Jr.', '1996-01-27', 'Male'),
(347, 'Vargas', 'Catherine', 'N.', 'III', '1999-11-01', 'Female'),
(348, 'Gonzales', 'Angela', 'J.', 'Jr.', '1989-02-23', 'Female'),
(349, 'Legaspi', 'Elaine', 'K.', NULL, '1998-03-11', 'Female'),
(350, 'Morales', 'Daniel', 'R.', 'III', '1966-06-08', 'Male'),
(351, 'Bernardo', 'Catherine', 'P.', 'II', '1992-08-16', 'Female'),
(352, 'Torres', 'Sofia', 'H.', 'Jr.', '1973-10-12', 'Female'),
(353, 'Ramos', 'Joy', 'A.', 'II', '1966-07-05', 'Female'),
(354, 'Reyes', 'Ramon', 'S.', 'IV', '1995-04-12', 'Male'),
(355, 'Delos Santos', 'Nina', 'T.', 'Sr.', '2003-10-04', 'Female'),
(356, 'Morales', 'Gina', 'O.', 'Sr.', '1969-10-17', 'Female'),
(357, 'Curamen', 'Isabel', 'S.', 'IV', '1981-09-27', 'Female'),
(358, 'Flores', 'Rogelio', 'I.', 'Sr.', '2001-10-19', 'Male'),
(359, 'Navarro', 'Manuel', 'M.', 'Jr.', '1969-11-08', 'Male'),
(360, 'Mensalvas', 'Pedro', 'N.', 'Sr.', '1969-07-23', 'Male'),
(361, 'Dela Cruz', 'Ana', 'Q.', NULL, '1973-09-11', 'Female'),
(362, 'Torres', 'Jillian', 'R.', NULL, '1981-09-12', 'Female'),
(363, 'Ramos', 'Kurt', 'J.', 'II', '1974-05-25', 'Male'),
(364, 'Garcia', 'Jan', 'L.', NULL, '1988-11-09', 'Male'),
(365, 'Delos Santos', 'Nina', 'E.', 'IV', '1966-10-24', 'Female'),
(366, 'Reyes', 'Jayrold', 'D.', 'III', '1986-06-23', 'Male'),
(367, 'Eugenio', 'Roberto', 'R.', 'Sr.', '1962-03-14', 'Male'),
(368, 'Reyes', 'Jan', 'A.', 'Jr.', '1979-10-20', 'Male'),
(369, 'Morales', 'Katrina', 'O.', 'Jr.', '1977-04-26', 'Female'),
(370, 'Santos', 'Jillian', 'K.', 'Sr.', '1978-10-22', 'Female'),
(371, 'Mensalvas', 'Kristine', 'J.', 'Jr.', '1997-12-19', 'Female'),
(372, 'Torres', 'Andrei', 'J.', 'IV', '1970-07-22', 'Male'),
(373, 'Eugenio', 'Isabel', 'H.', 'III', '1968-08-05', 'Female'),
(374, 'Cruz', 'Roberto', 'B.', 'IV', '1995-09-07', 'Male'),
(375, 'Torres', 'Sofia', 'D.', 'IV', '2003-04-23', 'Female'),
(376, 'Torres', 'Ana', 'E.', 'IV', '1992-07-15', 'Female'),
(377, 'Gonzales', 'Maria', 'I.', 'IV', '1960-12-07', 'Female'),
(378, 'Ramos', 'Grace', 'B.', 'II', '1964-08-02', 'Female'),
(379, 'Cruz', 'Daniel', 'F.', 'Sr.', '1994-07-17', 'Male'),
(380, 'Ramos', 'Elaine', 'N.', 'Sr.', '1994-07-27', 'Female'),
(381, 'Legaspi', 'Kurt', 'D.', 'IV', '1962-11-14', 'Male'),
(382, 'Navarro', 'Andrei', 'B.', NULL, '1988-10-22', 'Male'),
(383, 'Eugenio', 'Elaine', 'R.', 'IV', '1973-01-05', 'Female'),
(384, 'Navarro', 'Carmela', 'K.', NULL, '1975-05-05', 'Female'),
(385, 'Ramirez', 'Mara', 'E.', 'IV', '1979-07-06', 'Female'),
(386, 'Torres', 'Katrina', 'B.', 'IV', '1995-07-14', 'Female'),
(387, 'Legaspi', 'Kurt', 'K.', 'II', '2001-02-15', 'Male'),
(388, 'Gonzales', 'Kurt', 'T.', 'Jr.', '1998-01-28', 'Male'),
(389, 'Mensalvas', 'Catherine', 'J.', NULL, '1960-04-07', 'Female'),
(390, 'Delos Santos', 'Joy', 'L.', 'Jr.', '1992-08-15', 'Female'),
(391, 'Ramirez', 'Rita', 'B.', 'Sr.', '1996-04-24', 'Female'),
(392, 'Dela Cruz', 'Joy', 'G.', 'IV', '1981-04-13', 'Female'),
(393, 'Flores', 'Kristine', 'P.', 'II', '1989-03-24', 'Female'),
(394, 'Ramos', 'Jillian', 'B.', 'Jr.', '1993-01-27', 'Female'),
(395, 'Garcia', 'Jayrold', 'E.', 'III', '1960-04-17', 'Male'),
(396, 'Morales', 'Maria', 'N.', 'IV', '1971-02-04', 'Female'),
(397, 'Delos Santos', 'Liza', 'M.', 'III', '1965-06-13', 'Female'),
(398, 'Reyes', 'Grace', 'C.', 'IV', '1985-07-13', 'Female'),
(399, 'Flores', 'Mark', 'N.', 'Jr.', '2001-06-19', 'Male'),
(400, 'Flores', 'Roberto', 'I.', 'II', '1962-02-22', 'Male'),
(401, 'Mensalvas', 'Nina', 'M.', 'Jr.', '1968-12-24', 'Female'),
(402, 'Eugenio', 'Carlos', 'C.', 'IV', '1981-10-25', 'Male'),
(403, 'Torres', 'Kurt', 'P.', 'III', '1974-06-18', 'Male'),
(404, 'Navarro', 'Grace', 'J.', 'Jr.', '1975-12-03', 'Female'),
(405, 'Dela Cruz', 'Liza', 'C.', 'IV', '1971-07-15', 'Female'),
(406, 'Garcia', 'Juan', 'L.', 'IV', '1995-02-20', 'Male'),
(407, 'Gonzales', 'Mara', 'C.', 'IV', '1995-04-19', 'Female'),
(408, 'Curamen', 'Kurt', 'I.', 'Sr.', '1991-03-03', 'Male'),
(409, 'Santos', 'Jan', 'M.', 'II', '1981-10-13', 'Male'),
(410, 'Mensalvas', 'Jan', 'T.', 'II', '2004-04-16', 'Male'),
(411, 'Vargas', 'Gina', 'H.', 'III', '1980-07-09', 'Female'),
(412, 'Dela Cruz', 'Gina', 'J.', 'Sr.', '1975-05-22', 'Female'),
(413, 'Flores', 'Isabel', 'S.', NULL, '1985-09-17', 'Female'),
(414, 'Navarro', 'Nina', 'C.', NULL, '1966-04-22', 'Female'),
(415, 'Gonzales', 'Roberto', 'K.', 'Jr.', '1987-02-01', 'Male'),
(416, 'Cruz', 'Luis', 'J.', NULL, '1986-02-04', 'Male'),
(417, 'Legaspi', 'Elaine', 'Q.', 'Jr.', '1990-06-16', 'Female'),
(418, 'Reyes', 'Jan', 'D.', 'Jr.', '1961-06-21', 'Male'),
(419, 'Gonzales', 'Carlos', 'A.', 'IV', '1999-04-15', 'Male'),
(420, 'Delos Santos', 'Arjann', 'C.', 'IV', '1996-02-26', 'Male'),
(421, 'Cruz', 'Pedro', 'I.', NULL, '2002-08-17', 'Male'),
(422, 'Cruz', 'Carmela', 'L.', 'Sr.', '1982-08-20', 'Female'),
(423, 'Gonzales', 'Roberto', 'N.', 'IV', '1971-08-21', 'Male'),
(424, 'Dela Cruz', 'Joy', 'F.', 'Jr.', '1980-08-20', 'Female'),
(425, 'Gonzales', 'Arjann', 'R.', 'III', '1992-11-16', 'Male'),
(426, 'Garcia', 'Jillian', 'S.', 'Jr.', '1961-04-10', 'Female'),
(427, 'Torres', 'Jillian', 'S.', 'Jr.', '1991-09-17', 'Female'),
(428, 'Delos Santos', 'Pedro', 'L.', 'Jr.', '1965-08-28', 'Male'),
(429, 'Ramirez', 'Isabel', 'F.', 'Sr.', '1999-03-26', 'Female'),
(430, 'Delos Santos', 'Nina', 'T.', NULL, '1994-03-11', 'Female'),
(431, 'Gonzales', 'Angela', 'P.', 'II', '1969-10-21', 'Female'),
(432, 'Gonzales', 'Mark', 'Q.', 'III', '1977-12-12', 'Male'),
(433, 'Mensalvas', 'Kristine', 'J.', 'Sr.', '1981-09-19', 'Female'),
(434, 'Cruz', 'Jose', 'O.', 'Sr.', '1961-02-28', 'Male'),
(435, 'Dela Cruz', 'Catherine', 'J.', NULL, '1970-05-03', 'Female'),
(436, 'Legaspi', 'Juan', 'P.', 'Sr.', '1964-03-19', 'Male'),
(437, 'Cruz', 'Michael', 'N.', 'Jr.', '2004-03-16', 'Male'),
(438, 'Mensalvas', 'Andrei', 'L.', 'Sr.', '1979-03-13', 'Male'),
(439, 'Bernardo', 'Rogelio', 'O.', NULL, '1982-12-07', 'Male'),
(440, 'Eugenio', 'Grace', 'R.', 'IV', '1998-10-24', 'Female'),
(441, 'Navarro', 'Manuel', 'Q.', 'II', '1972-12-13', 'Male'),
(442, 'Ramos', 'Liza', 'F.', 'IV', '1990-02-01', 'Female'),
(443, 'Reyes', 'Jose', 'M.', NULL, '1992-05-21', 'Male'),
(444, 'Ramos', 'Grace', 'R.', 'Jr.', '1999-03-09', 'Female'),
(445, 'Ramos', 'Christian', 'K.', NULL, '1985-10-21', 'Male'),
(446, 'Eugenio', 'Jose', 'C.', 'IV', '1987-02-15', 'Male'),
(447, 'Lopez', 'Jillian', 'E.', 'Jr.', '1977-12-04', 'Female'),
(448, 'Vargas', 'Kurt', 'C.', 'II', '1991-08-17', 'Male'),
(449, 'Bernardo', 'Daniel', 'I.', NULL, '1966-10-22', 'Male'),
(450, 'Santos', 'Jose', 'H.', 'III', '1962-08-12', 'Male'),
(451, 'Mensalvas', 'Angela', 'H.', 'II', '1986-12-11', 'Female'),
(452, 'Reyes', 'Manuel', 'F.', 'III', '1974-09-02', 'Male'),
(453, 'Lopez', 'Pedro', 'S.', 'IV', '1991-04-24', 'Male'),
(454, 'Eugenio', 'Maria', 'R.', NULL, '1982-11-27', 'Female'),
(455, 'Cruz', 'Joy', 'G.', 'III', '1993-04-14', 'Female'),
(456, 'Eugenio', 'Jose', 'Q.', 'III', '1986-12-12', 'Male'),
(457, 'Garcia', 'Ramon', 'S.', NULL, '1996-01-14', 'Male'),
(458, 'Gonzales', 'Rita', 'K.', 'Sr.', '1980-08-09', 'Female'),
(459, 'Delos Santos', 'Elaine', 'D.', NULL, '1965-03-26', 'Female'),
(460, 'Garcia', 'Katrina', 'H.', 'Jr.', '1982-07-17', 'Female'),
(461, 'Torres', 'Ramon', 'R.', 'III', '1995-04-04', 'Male'),
(462, 'Santos', 'Grace', 'C.', 'Sr.', '1972-11-15', 'Female'),
(463, 'Reyes', 'Pedro', 'F.', NULL, '1996-07-27', 'Male'),
(464, 'Bernardo', 'Mara', 'L.', 'II', '1973-03-09', 'Female'),
(465, 'Flores', 'Jan', 'N.', 'Jr.', '1995-08-02', 'Male'),
(466, 'Delos Santos', 'Andrea', 'F.', 'Sr.', '1961-06-20', 'Female'),
(467, 'Lopez', 'Sofia', 'S.', 'Sr.', '1974-03-04', 'Female'),
(468, 'Vargas', 'Jayrold', 'M.', 'Sr.', '1982-03-06', 'Male'),
(469, 'Vargas', 'Daniel', 'S.', 'III', '1969-10-07', 'Male'),
(470, 'Garcia', 'Ana', 'B.', 'Jr.', '1974-10-08', 'Female'),
(471, 'Morales', 'Andrei', 'L.', NULL, '1964-06-23', 'Male'),
(472, 'Dela Cruz', 'Rita', 'F.', NULL, '1987-11-16', 'Female'),
(473, 'Vargas', 'Angela', 'F.', NULL, '1984-05-24', 'Female'),
(474, 'Gonzales', 'Roberto', 'S.', 'II', '1962-03-20', 'Male'),
(475, 'Dela Cruz', 'Luis', 'K.', 'II', '1964-04-12', 'Male'),
(476, 'Delos Santos', 'Maria', 'G.', 'II', '1975-12-03', 'Female'),
(477, 'Vargas', 'Luis', 'H.', 'Jr.', '1970-08-03', 'Male'),
(478, 'Garcia', 'Liza', 'K.', NULL, '1970-07-06', 'Female'),
(479, 'Navarro', 'Isabel', 'P.', NULL, '2005-01-14', 'Female'),
(480, 'Mensalvas', 'Andrei', 'G.', 'IV', '1972-07-23', 'Male'),
(481, 'Cruz', 'Angela', 'B.', 'III', '1985-10-18', 'Female'),
(482, 'Flores', 'Grace', 'D.', 'III', '1979-07-16', 'Female'),
(483, 'Lopez', 'Jillian', 'M.', 'Jr.', '1983-03-15', 'Female'),
(484, 'Delos Santos', 'Angela', 'S.', NULL, '1963-03-25', 'Female'),
(485, 'Eugenio', 'Carmela', 'R.', 'IV', '1963-07-27', 'Female'),
(486, 'Dela Cruz', 'Arjann', 'B.', 'III', '1987-02-22', 'Male'),
(487, 'Garcia', 'Rita', 'C.', 'IV', '1984-09-13', 'Female'),
(488, 'Cruz', 'Roberto', 'J.', 'II', '1994-06-14', 'Male'),
(489, 'Bernardo', 'Ana', 'I.', 'IV', '1985-03-20', 'Female'),
(490, 'Reyes', 'Angela', 'P.', 'II', '1977-06-01', 'Female'),
(491, 'Eugenio', 'Liza', 'E.', 'II', '1979-12-15', 'Female'),
(492, 'Morales', 'Katrina', 'S.', 'Sr.', '1961-03-07', 'Female'),
(493, 'Lopez', 'Ana', 'G.', 'III', '1977-06-27', 'Female'),
(494, 'Lopez', 'Jayrold', 'P.', 'III', '1998-08-06', 'Male'),
(495, 'Delos Santos', 'Arjann', 'N.', NULL, '1992-01-28', 'Male'),
(496, 'Santos', 'Rogelio', 'H.', 'II', '1976-10-26', 'Male'),
(497, 'Navarro', 'Nina', 'T.', 'Jr.', '1978-05-22', 'Female'),
(498, 'Delos Santos', 'Rita', 'I.', 'II', '2001-12-21', 'Female'),
(499, 'Navarro', 'Jose', 'M.', 'Sr.', '2002-06-22', 'Male'),
(500, 'Gonzales', 'Mara', 'M.', 'IV', '1962-10-23', 'Female'),
(501, 'Morales', 'Liza', 'J.', 'Sr.', '1970-11-18', 'Female'),
(502, 'Ramos', 'Kurt', 'F.', 'Jr.', '2003-06-21', 'Male'),
(503, 'Legaspi', 'Luis', 'Q.', 'IV', '1967-11-13', 'Male'),
(504, 'Legaspi', 'Christian', 'K.', 'Sr.', '1986-10-15', 'Male'),
(505, 'Bernardo', 'Rita', 'K.', 'III', '2000-01-01', 'Female'),
(506, 'Legaspi', 'Emilio', 'L.', 'IV', '1960-06-25', 'Male'),
(507, 'Lopez', 'Jayrold', 'J.', 'IV', '1968-02-13', 'Male'),
(508, 'Curamen', 'Jose', 'J.', 'IV', '1989-12-17', 'Male'),
(509, 'Vargas', 'Juan', 'Q.', NULL, '1970-02-12', 'Male'),
(510, 'Reyes', 'Rogelio', 'D.', NULL, '2001-01-02', 'Male'),
(511, 'Ramos', 'Liza', 'I.', 'Sr.', '1990-12-05', 'Female'),
(512, 'Delos Santos', 'Manuel', 'T.', 'III', '1998-12-05', 'Male'),
(513, 'Bernardo', 'Joy', 'B.', NULL, '1995-08-07', 'Female'),
(514, 'Garcia', 'Juan', 'D.', 'Sr.', '1996-11-16', 'Male'),
(515, 'Eugenio', 'Kurt', 'O.', 'Jr.', '1978-05-15', 'Male'),
(516, 'Lopez', 'Michael', 'O.', 'Jr.', '1999-05-24', 'Male'),
(517, 'Gonzales', 'Ramon', 'O.', 'III', '1977-07-23', 'Male'),
(518, 'Navarro', 'Liza', 'A.', 'III', '2003-12-05', 'Female'),
(519, 'Garcia', 'Ana', 'I.', NULL, '2001-06-01', 'Female'),
(520, 'Morales', 'Michael', 'Q.', 'Jr.', '2004-12-20', 'Male'),
(521, 'Dela Cruz', 'Andrea', 'R.', NULL, '1999-01-01', 'Female'),
(522, 'Eugenio', 'Andrea', 'C.', 'IV', '1989-08-26', 'Female'),
(523, 'Cruz', 'Rita', 'P.', 'III', '2001-01-04', 'Female'),
(524, 'Navarro', 'Mark', 'T.', 'IV', '2000-05-17', 'Male'),
(525, 'Eugenio', 'Ana', 'O.', 'IV', '1981-09-25', 'Female'),
(526, 'Flores', 'Nicolas', 'E.', 'III', '2005-12-24', 'Male'),
(527, 'Cruz', 'Arjann', 'M.', 'Sr.', '1973-08-27', 'Male'),
(528, 'Cruz', 'Roberto', 'O.', 'IV', '1989-11-19', 'Male'),
(529, 'Ramirez', 'Emilio', 'S.', 'Sr.', '1990-09-25', 'Male'),
(530, 'Ramirez', 'Christian', 'T.', 'II', '2004-12-17', 'Male'),
(531, 'Legaspi', 'Arjann', 'T.', 'II', '2005-05-22', 'Male'),
(532, 'Lopez', 'Liza', 'R.', NULL, '1990-10-19', 'Female'),
(533, 'Morales', 'Maria', 'D.', 'Jr.', '1961-07-05', 'Female'),
(534, 'Navarro', 'Liza', 'R.', 'IV', '1974-12-21', 'Female'),
(535, 'Gonzales', 'Ana', 'M.', 'IV', '1986-11-11', 'Female'),
(536, 'Torres', 'Rogelio', 'H.', NULL, '2000-12-23', 'Male'),
(537, 'Ramirez', 'Ana', 'I.', 'Sr.', '1995-05-05', 'Female'),
(538, 'Dela Cruz', 'Elaine', 'B.', 'Jr.', '1969-06-20', 'Female'),
(539, 'Mensalvas', 'Grace', 'Q.', 'Jr.', '1974-03-17', 'Female'),
(540, 'Lopez', 'Grace', 'H.', 'II', '1973-11-11', 'Female'),
(541, 'Cruz', 'Andrea', 'M.', 'II', '1976-09-24', 'Female'),
(542, 'Reyes', 'Gina', 'J.', 'IV', '2001-04-11', 'Female'),
(543, 'Legaspi', 'Mark', 'G.', 'Jr.', '2003-07-27', 'Male'),
(544, 'Santos', 'Christian', 'O.', 'Jr.', '2005-06-02', 'Male'),
(545, 'Santos', 'Emilio', 'T.', 'Jr.', '1964-12-19', 'Male'),
(546, 'Curamen', 'Jan', 'T.', 'III', '1965-05-25', 'Male'),
(547, 'Ramos', 'Jillian', 'H.', 'IV', '1968-12-13', 'Female'),
(548, 'Legaspi', 'Jan', 'L.', 'IV', '1973-07-21', 'Male'),
(549, 'Delos Santos', 'Rogelio', 'G.', 'IV', '1967-03-22', 'Male'),
(550, 'Garcia', 'Jan', 'I.', 'IV', '1966-04-24', 'Male'),
(551, 'Cruz', 'Jayrold', 'J.', 'II', '1999-02-07', 'Male'),
(552, 'Dela Cruz', 'Carmela', 'S.', 'II', '1996-06-26', 'Female'),
(553, 'Eugenio', 'Angela', 'N.', NULL, '1977-06-05', 'Female'),
(554, 'Legaspi', 'Emilio', 'I.', 'Jr.', '2000-02-24', 'Male'),
(555, 'Legaspi', 'Carmela', 'B.', 'IV', '1995-05-18', 'Female'),
(556, 'Vargas', 'Angela', 'J.', 'IV', '1968-08-17', 'Female'),
(557, 'Reyes', 'Liza', 'H.', 'II', '1991-04-03', 'Female'),
(558, 'Lopez', 'Manuel', 'M.', 'Jr.', '1990-08-02', 'Male'),
(559, 'Vargas', 'Kristine', 'R.', NULL, '1996-03-13', 'Female'),
(560, 'Delos Santos', 'Manuel', 'M.', 'II', '1974-09-13', 'Male'),
(561, 'Lopez', 'Nicolas', 'T.', 'Sr.', '2005-02-22', 'Male'),
(562, 'Flores', 'Gina', 'G.', 'III', '1997-03-21', 'Female'),
(563, 'Vargas', 'Isabel', 'A.', 'Sr.', '2002-05-03', 'Female'),
(564, 'Ramirez', 'Jayrold', 'T.', 'Sr.', '1969-10-27', 'Male'),
(565, 'Torres', 'Michael', 'T.', 'III', '1997-02-08', 'Male'),
(566, 'Morales', 'Arjann', 'Q.', 'Sr.', '2003-07-27', 'Male'),
(567, 'Ramirez', 'Sofia', 'L.', 'III', '1962-12-17', 'Female'),
(568, 'Vargas', 'Carmela', 'D.', 'III', '1987-03-09', 'Female'),
(569, 'Legaspi', 'Kristine', 'A.', 'Jr.', '2005-12-26', 'Female'),
(570, 'Legaspi', 'Ramon', 'K.', 'Sr.', '1986-06-04', 'Male'),
(571, 'Ramirez', 'Nina', 'S.', NULL, '1983-10-09', 'Female'),
(572, 'Lopez', 'Jillian', 'R.', 'II', '1995-08-09', 'Female'),
(573, 'Gonzales', 'Nicolas', 'A.', 'IV', '1965-03-16', 'Male'),
(574, 'Lopez', 'Angela', 'C.', 'III', '1998-01-24', 'Female'),
(575, 'Flores', 'Nicolas', 'O.', NULL, '1960-04-28', 'Male'),
(576, 'Morales', 'Rogelio', 'Q.', 'Sr.', '2004-04-20', 'Male'),
(577, 'Garcia', 'Nicolas', 'I.', 'III', '1985-06-22', 'Male'),
(578, 'Garcia', 'Mark', 'R.', 'IV', '1978-12-27', 'Male'),
(579, 'Curamen', 'Manuel', 'K.', 'IV', '1967-09-09', 'Male'),
(580, 'Flores', 'Carmela', 'H.', 'III', '1981-08-22', 'Female'),
(581, 'Garcia', 'Kurt', 'M.', NULL, '2000-04-22', 'Male'),
(582, 'Ramos', 'Sofia', 'A.', 'II', '2004-05-08', 'Female'),
(583, 'Legaspi', 'Luis', 'H.', 'Sr.', '1975-05-07', 'Male'),
(584, 'Cruz', 'Katrina', 'D.', 'III', '1965-11-22', 'Female'),
(585, 'Lopez', 'Luis', 'T.', 'II', '1980-08-19', 'Male'),
(586, 'Eugenio', 'Andrea', 'S.', 'III', '1968-01-17', 'Female'),
(587, 'Bernardo', 'Andrea', 'O.', 'III', '1967-12-17', 'Female'),
(588, 'Vargas', 'Ramon', 'D.', 'II', '1980-06-20', 'Male'),
(589, 'Gonzales', 'Liza', 'I.', 'Sr.', '1988-03-19', 'Female'),
(590, 'Ramos', 'Angela', 'N.', NULL, '1984-04-05', 'Female'),
(591, 'Flores', 'Carlos', 'E.', NULL, '2000-09-18', 'Male'),
(592, 'Vargas', 'Nina', 'B.', 'Sr.', '1985-02-23', 'Female'),
(593, 'Torres', 'Liza', 'K.', 'IV', '1976-06-12', 'Female'),
(594, 'Garcia', 'Elaine', 'M.', NULL, '1999-05-15', 'Female'),
(595, 'Vargas', 'Isabel', 'M.', 'II', '1964-02-06', 'Female'),
(596, 'Navarro', 'Kristine', 'M.', 'II', '1977-08-25', 'Female'),
(597, 'Bernardo', 'Jillian', 'A.', NULL, '1968-12-08', 'Female'),
(598, 'Cruz', 'Ramon', 'D.', 'Jr.', '1964-08-18', 'Male'),
(599, 'Delos Santos', 'Andrei', 'T.', 'III', '1969-02-21', 'Male'),
(600, 'Bernardo', 'Kian', 'Black', 'Sr.', '1995-08-03', 'Male'),
(601, 'Bernardo', 'Juan', 'Manilda', '', '2001-07-20', 'Male'),
(602, 'Manersing', 'Mail', 'Esluzar', 'Jr.', '1994-11-02', 'Female'),
(603, 'Mowr', 'Dawr', 'James', 'III', '1993-07-28', 'Female'),
(604, 'Moreed', 'Jayrold', 'Wilder', 'Sr.', '1995-07-13', 'Male'),
(605, 'Bernardo', 'Juan', 'Manilda', '', '2003-07-01', 'Female'),
(606, 'Legaspi', 'Marine', 'James', 'Sr.', '1999-07-15', 'Male'),
(607, 'Bernardo', 'Andrei ', 'Esluzar', '', '2004-02-26', 'Male'),
(608, 'Legaspi', 'Pogi', 'Gojo', 'IV', '2003-06-12', 'Female'),
(609, 'Guiraldo', 'Pao', 'Visaya', '', '1999-11-07', 'Female'),
(610, 'Bernardo', 'Mail', 'Manilda', 'III', '1997-06-06', 'Male'),
(611, 'Legaspi', 'Marine', 'Gojo', '', '2007-10-30', 'Female'),
(612, 'Sandi', 'Gelo', 'Esluzar', '', '1993-07-14', 'Male'),
(613, 'Bernardo', 'Juan', 'Manilda', 'Sr.', '1994-07-21', 'Female'),
(614, 'Manersing', 'Andrei', 'Esluzar', '', '2007-11-01', 'Male'),
(615, 'Legaspi', 'Dawr', 'James', 'II', '2004-02-17', 'Male'),
(616, 'Moreed', 'Jayrold', 'Wilder', '', '2001-10-10', 'Male'),
(617, 'Bernardo', 'Juans', 'Manilda', 'Sr.', '1994-07-21', 'Female'),
(618, 'Legaspi', 'Darwin', 'James', 'II', '2004-02-17', 'Male'),
(619, 'Bernardo', 'Juan', '', 'Jr.', '2003-06-03', 'Male'),
(620, 'Kitagawa', 'Marine', 'Gojo', '', '2007-08-01', 'Female'),
(621, 'Bernardo', 'Juan', 'Manilda', '', NULL, 'Male'),
(622, 'Legaspi', 'Pogi', 'James', '', '2005-06-19', 'Female'),
(623, 'Bernardo', 'Juan', 'Manilda', 'Sr.', '2007-11-01', 'Male'),
(624, 'Kitagawa', 'Pogi', 'James', '', '2003-06-26', 'Male'),
(625, 'Bernardo', 'Juan', 'Nigga', '', '2000-02-10', 'Male'),
(626, 'Kitagawa', 'Marine', 'James', 'Sr.', '2001-10-12', 'Male'),
(627, 'Bernardo', 'Juan', 'Manilda', '', '2003-02-04', 'Male'),
(628, 'Legaspi', 'Pogi', 'Gojo', 'III', '1999-02-19', 'Female'),
(629, 'Bernardo', 'Juan', 'Manilda', '', '2007-11-05', 'Male'),
(630, 'Kitagawa', 'Pogi', 'James', 'Sr.', '2007-11-04', 'Male'),
(631, 'Bernardo', 'Juan', 'Manilda', 'IV', '2007-11-08', 'Male'),
(632, 'Legaspi', 'Pogi', 'James', 'IV', '2007-11-06', 'Female'),
(633, 'Bernardo', 'Juan', 'Manilda', '', '2001-06-05', 'Male'),
(634, 'Kitagawa', 'Pogi', 'James', 'Sr.', '2007-11-08', 'Male'),
(635, 'Bernardo', 'Juan', 'Manilda', '', '2007-11-01', 'Female'),
(636, 'Kitagawa', 'Marine', 'Gojo', '', '2003-06-19', 'Female'),
(637, 'Bernardo', 'Juan', 'Manilda', 'Jr.', '2003-01-30', 'Female'),
(638, 'Kitagawa', 'Dawr', 'James', '', '2007-11-06', 'Male'),
(639, 'Bernardo', 'Juan', 'Manilda', '', '2001-02-09', 'Female'),
(640, 'Kitagawa', 'Pogi', 'James', 'Jr.', '1997-02-05', 'Female'),
(641, 'Bernardo', 'Juan', 'Manilda', '', '1994-06-09', 'Male'),
(642, 'Kitagawa', 'Pogi', 'James', '', '2004-02-19', 'Male'),
(643, 'Moreed', 'Jayrold', 'Wilder', 'III', '2007-11-08', 'Male'),
(644, 'Bernardo', 'Juan', 'Manilda', 'III', NULL, 'Female'),
(645, 'Kitagawa', 'Pogi', 'James', '', '2001-06-20', 'Male'),
(646, 'Mowr', 'Jayrold', 'Wilder', '', NULL, 'Male');

-- --------------------------------------------------------

--
-- Table structure for table `pin_code`
--

CREATE TABLE `pin_code` (
  `PIN_CODE` varchar(10) NOT NULL,
  `Docket_Number` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pin_code`
--

INSERT INTO `pin_code` (`PIN_CODE`, `Docket_Number`) VALUES
('207175', 'III-09-INV-25A-0001'),
('358607', 'III-09-INV-25A-0002'),
('351083', 'III-09-INV-25A-0003'),
('704201', 'III-09-INV-25A-0004'),
('604740', 'III-09-INV-25A-0005'),
('185965', 'III-09-INV-25A-0006'),
('820892', 'III-09-INV-25A-0007'),
('934794', 'III-09-INV-25A-0008'),
('708792', 'III-09-INV-25A-0009'),
('563246', 'III-09-INV-25A-0010'),
('742412', 'III-09-INV-25A-0011'),
('981334', 'III-09-INV-25A-0012'),
('691364', 'III-09-INV-25A-0013'),
('841666', 'III-09-INV-25A-0014'),
('430876', 'III-09-INV-25A-0015'),
('112861', 'III-09-INV-25A-0016'),
('264686', 'III-09-INV-25A-0017'),
('885339', 'III-09-INV-25A-0018'),
('156837', 'III-09-INV-25A-0019'),
('448588', 'III-09-INV-25A-0020'),
('883041', 'III-09-INV-25A-0021'),
('211834', 'III-09-INV-25A-0022'),
('229592', 'III-09-INV-25A-0023'),
('794963', 'III-09-INV-25A-0024'),
('915809', 'III-09-INV-25A-0025'),
('201255', 'III-09-INV-25A-0026'),
('794093', 'III-09-INV-25A-0027'),
('843963', 'III-09-INV-25A-0028'),
('260295', 'III-09-INV-25A-0029'),
('359778', 'III-09-INV-25A-0030'),
('903373', 'III-09-INV-25A-0031'),
('398768', 'III-09-INV-25B-0032'),
('979940', 'III-09-INV-25B-0033'),
('145649', 'III-09-INV-25B-0034'),
('918771', 'III-09-INV-25B-0035'),
('811027', 'III-09-INV-25B-0036'),
('992717', 'III-09-INV-25B-0037'),
('462831', 'III-09-INV-25B-0038'),
('502810', 'III-09-INV-25B-0039'),
('633853', 'III-09-INV-25B-0040'),
('806537', 'III-09-INV-25B-0041'),
('227794', 'III-09-INV-25B-0042'),
('782139', 'III-09-INV-25B-0043'),
('600646', 'III-09-INV-25B-0044'),
('925618', 'III-09-INV-25B-0045'),
('570325', 'III-09-INV-25B-0046'),
('619696', 'III-09-INV-25B-0047'),
('678897', 'III-09-INV-25B-0048'),
('106933', 'III-09-INV-25B-0049'),
('251195', 'III-09-INV-25B-0050'),
('478221', 'III-09-INV-25B-0051'),
('358568', 'III-09-INV-25B-0052'),
('842776', 'III-09-INV-25B-0053'),
('510133', 'III-09-INV-25B-0054'),
('547080', 'III-09-INV-25B-0055'),
('291936', 'III-09-INV-25B-0056'),
('329157', 'III-09-INV-25B-0057'),
('162165', 'III-09-INV-25B-0058'),
('991401', 'III-09-INV-25B-0059'),
('755993', 'III-09-INV-25C-0060'),
('718213', 'III-09-INV-25C-0061'),
('653948', 'III-09-INV-25C-0062'),
('835575', 'III-09-INV-25C-0063'),
('486839', 'III-09-INV-25C-0064'),
('429287', 'III-09-INV-25C-0065'),
('963684', 'III-09-INV-25C-0066'),
('919898', 'III-09-INV-25C-0067'),
('941403', 'III-09-INV-25C-0068'),
('274418', 'III-09-INV-25C-0069'),
('603660', 'III-09-INV-25C-0070'),
('626491', 'III-09-INV-25C-0071'),
('534574', 'III-09-INV-25C-0072'),
('896386', 'III-09-INV-25C-0073'),
('505343', 'III-09-INV-25C-0074'),
('810091', 'III-09-INV-25C-0075'),
('714015', 'III-09-INV-25C-0076'),
('554779', 'III-09-INV-25C-0077'),
('272892', 'III-09-INV-25C-0078'),
('308296', 'III-09-INV-25C-0079'),
('874415', 'III-09-INV-25C-0080'),
('536236', 'III-09-INV-25C-0081'),
('352593', 'III-09-INV-25C-0082'),
('472390', 'III-09-INV-25C-0083'),
('539001', 'III-09-INV-25C-0084'),
('980155', 'III-09-INV-25C-0085'),
('286044', 'III-09-INV-25C-0086'),
('567315', 'III-09-INV-25C-0087'),
('506881', 'III-09-INV-25C-0088'),
('143802', 'III-09-INV-25C-0089'),
('678469', 'III-09-INV-25C-0090'),
('266956', 'III-09-INV-25D-0091'),
('341162', 'III-09-INV-25D-0092'),
('141094', 'III-09-INV-25D-0093'),
('605666', 'III-09-INV-25D-0094'),
('205149', 'III-09-INV-25D-0095'),
('702833', 'III-09-INV-25D-0096'),
('470711', 'III-09-INV-25D-0097'),
('483699', 'III-09-INV-25D-0098'),
('308622', 'III-09-INV-25D-0099'),
('979249', 'III-09-INV-25D-0100'),
('630191', 'III-09-INV-25J-0001'),
('023042', 'III-09-INV-25J-0002'),
('110512', 'III-09-INV-25J-0003'),
('142772', 'III-09-INV-25K-0001'),
('097535', 'III-09-INV-25K-0002'),
('975700', 'III-09-INV-25K-0003'),
('975093', 'III-09-INV-25K-0004-0005-0006'),
('477011', 'III-09-INV-25K-0007-0008-0009'),
('736613', 'III-09-INV-25K-0010-0011-0012'),
('896840', 'III-09-INV-25K-0013-0014-0015'),
('006756', 'III-09-INV-25K-0016-0017-0018-0019'),
('240627', 'III-09-INV-25K-0020-0021-0022'),
('155983', 'III-09-INV-25K-0023-0024-0025-0026'),
('879591', 'III-09-INV-25K-0027-0028-0029-0030'),
('818370', 'III-09-INV-25K-0031-0032-0033-0034'),
('298084', 'III-09-INV-25K-0035-0036-0037-0038'),
('650825', 'III-09-INV-25K-0039-0041'),
('753882', 'III-09-INV-25K-0042-0044');

-- --------------------------------------------------------

--
-- Table structure for table `prosecutor`
--

CREATE TABLE `prosecutor` (
  `PROSECUTOR_ID` int(11) NOT NULL,
  `PERSON_ID` int(11) DEFAULT NULL,
  `Licens_No` varchar(100) DEFAULT NULL,
  `Office_No` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prosecutor`
--

INSERT INTO `prosecutor` (`PROSECUTOR_ID`, `PERSON_ID`, `Licens_No`, `Office_No`) VALUES
(6, 1, 'LX123456', '09'),
(7, 57, 'PRNHB42069', '03'),
(8, 97, 'PRNHB42047', '05'),
(9, 98, 'PRNHB42069', ''),
(10, 99, 'PRNHB3030', '01'),
(11, 100, 'PRNHB42034', '02'),
(12, 609, 'PRNHB3033', '06');

-- --------------------------------------------------------

--
-- Table structure for table `resolution`
--

CREATE TABLE `resolution` (
  `RESOLUTION_ID` int(11) NOT NULL,
  `Docket_Number` varchar(50) DEFAULT NULL,
  `Verdict` enum('For Filing','Dismissed','Pending') DEFAULT NULL,
  `Status` enum('Pending','Approved','Denied') DEFAULT 'Pending',
  `Court` varchar(255) DEFAULT NULL,
  `Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `resolution`
--

INSERT INTO `resolution` (`RESOLUTION_ID`, `Docket_Number`, `Verdict`, `Status`, `Court`, `Date`) VALUES
(1, 'III-09-INV-25A-0001', 'For Filing', 'Approved', 'RTC Branch 11, Palayan', '2025-01-20'),
(2, 'III-09-INV-25A-0002', 'For Filing', 'Approved', 'RTC Branch 5, Aliaga', '2025-01-26'),
(3, 'III-09-INV-25A-0003', 'For Filing', 'Approved', 'RTC Branch 10, Gapan', '2025-01-31'),
(4, 'III-09-INV-25A-0004', 'For Filing', 'Approved', 'RTC Branch 19, San Jose', '2025-01-22'),
(5, 'III-09-INV-25A-0005', 'Dismissed', 'Approved', NULL, '2025-02-03'),
(6, 'III-09-INV-25A-0006', 'For Filing', 'Approved', 'RTC Branch 20, Aliaga', '2025-01-23'),
(7, 'III-09-INV-25A-0007', 'Dismissed', 'Approved', NULL, '2025-01-30'),
(8, 'III-09-INV-25A-0008', 'For Filing', 'Approved', 'RTC Branch 12, Gapan', '2025-02-03'),
(9, 'III-09-INV-25A-0009', 'Dismissed', 'Approved', NULL, '2025-01-29'),
(10, 'III-09-INV-25A-0010', 'Dismissed', 'Approved', NULL, '2025-02-06'),
(11, 'III-09-INV-25A-0011', 'Dismissed', 'Approved', NULL, '2025-02-08'),
(12, 'III-09-INV-25A-0012', 'Dismissed', 'Approved', NULL, '2025-02-03'),
(13, 'III-09-INV-25A-0013', 'Dismissed', 'Approved', NULL, '2025-01-30'),
(14, 'III-09-INV-25A-0014', 'Dismissed', 'Approved', NULL, '2025-02-13'),
(15, 'III-09-INV-25A-0015', 'For Filing', 'Approved', 'RTC Branch 7, Cabanatuan', '2025-02-03'),
(16, 'III-09-INV-25A-0016', 'Dismissed', 'Approved', NULL, '2025-02-05'),
(17, 'III-09-INV-25A-0017', 'For Filing', 'Approved', 'RTC Branch 3, Gapan', '2025-02-10'),
(18, 'III-09-INV-25A-0018', 'For Filing', 'Approved', 'RTC Branch 20, San Jose', '2025-02-10'),
(19, 'III-09-INV-25A-0019', 'Dismissed', 'Approved', NULL, '2025-02-17'),
(20, 'III-09-INV-25A-0020', 'Dismissed', 'Approved', NULL, '2025-02-17'),
(21, 'III-09-INV-25A-0021', 'Dismissed', 'Approved', NULL, '2025-02-13'),
(22, 'III-09-INV-25A-0022', 'For Filing', 'Approved', 'RTC Branch 16, Aliaga', '2025-02-19'),
(23, 'III-09-INV-25A-0023', 'For Filing', 'Approved', 'RTC Branch 18, San Jose', '2025-02-16'),
(24, 'III-09-INV-25A-0024', 'Dismissed', 'Approved', NULL, '2025-02-10'),
(25, 'III-09-INV-25A-0025', 'Dismissed', 'Approved', NULL, '2025-02-25'),
(26, 'III-09-INV-25A-0026', 'For Filing', 'Approved', 'RTC Branch 14, San Jose', '2025-02-14'),
(27, 'III-09-INV-25A-0027', 'Dismissed', 'Approved', NULL, '2025-02-24'),
(28, 'III-09-INV-25A-0028', 'Dismissed', 'Approved', NULL, '2025-02-25'),
(29, 'III-09-INV-25A-0029', 'For Filing', 'Approved', 'RTC Branch 20, Aliaga', '2025-02-18'),
(30, 'III-09-INV-25A-0030', 'For Filing', 'Approved', 'RTC Branch 2, San Isidro', '2025-02-18'),
(31, 'III-09-INV-25A-0031', 'For Filing', 'Approved', 'RTC Branch 11, San Jose', '2025-02-22'),
(32, 'III-09-INV-25B-0032', 'For Filing', 'Approved', 'RTC Branch 20, Cabanatuan', '2025-03-01'),
(33, 'III-09-INV-25B-0033', 'Dismissed', 'Approved', NULL, '2025-02-19'),
(34, 'III-09-INV-25B-0034', 'For Filing', 'Approved', 'RTC Branch 16, Cabanatuan', '2025-03-01'),
(35, 'III-09-INV-25B-0035', 'For Filing', 'Approved', 'RTC Branch 12, Talavera', '2025-02-28'),
(36, 'III-09-INV-25B-0036', 'For Filing', 'Approved', 'RTC Branch 20, Talavera', '2025-02-24'),
(37, 'III-09-INV-25B-0037', 'Dismissed', 'Approved', NULL, '2025-02-28'),
(38, 'III-09-INV-25B-0038', 'Dismissed', 'Approved', NULL, '2025-02-28'),
(39, 'III-09-INV-25B-0039', 'For Filing', 'Approved', 'RTC Branch 10, Talavera', '2025-02-22'),
(40, 'III-09-INV-25B-0040', 'For Filing', 'Approved', 'RTC Branch 20, San Isidro', '2025-03-01'),
(41, 'III-09-INV-25B-0041', 'Dismissed', 'Approved', NULL, '2025-03-09'),
(42, 'III-09-INV-25B-0042', 'Dismissed', 'Approved', NULL, '2025-03-08'),
(43, 'III-09-INV-25B-0043', 'Dismissed', 'Approved', NULL, '2025-03-15'),
(44, 'III-09-INV-25B-0044', 'For Filing', 'Approved', 'RTC Branch 5, Talavera', '2025-03-05'),
(45, 'III-09-INV-25B-0045', 'For Filing', 'Approved', 'RTC Branch 20, Aliaga', '2025-03-07'),
(46, 'III-09-INV-25B-0046', 'Dismissed', 'Approved', NULL, '2025-03-16'),
(47, 'III-09-INV-25B-0047', 'For Filing', 'Approved', 'RTC Branch 18, Aliaga', '2025-03-17'),
(48, 'III-09-INV-25B-0048', 'Dismissed', 'Approved', NULL, '2025-03-11'),
(49, 'III-09-INV-25B-0049', 'Dismissed', 'Approved', NULL, '2025-03-05'),
(50, 'III-09-INV-25B-0050', 'For Filing', 'Approved', 'RTC Branch 19, Aliaga', '2025-03-10'),
(51, 'III-09-INV-25B-0051', 'Dismissed', 'Approved', NULL, '2025-03-15'),
(52, 'III-09-INV-25B-0052', 'Dismissed', 'Approved', NULL, '2025-03-14'),
(53, 'III-09-INV-25B-0053', 'For Filing', 'Approved', 'RTC Branch 15, San Jose', '2025-03-11'),
(54, 'III-09-INV-25B-0054', 'For Filing', 'Approved', 'RTC Branch 12, San Isidro', '2025-03-25'),
(55, 'III-09-INV-25B-0055', 'For Filing', 'Approved', 'RTC Branch 18, Palayan', '2025-03-23'),
(56, 'III-09-INV-25B-0056', 'Dismissed', 'Approved', NULL, '2025-03-14'),
(57, 'III-09-INV-25B-0057', 'For Filing', 'Approved', 'RTC Branch 18, San Jose', '2025-03-26'),
(58, 'III-09-INV-25B-0058', 'For Filing', 'Approved', 'RTC Branch 14, Palayan', '2025-03-16'),
(59, 'III-09-INV-25B-0059', 'For Filing', 'Approved', 'RTC Branch 12, Palayan', '2025-03-28'),
(60, 'III-09-INV-25C-0060', 'For Filing', 'Approved', 'RTC Branch 13, Gapan', '2025-03-19'),
(61, 'III-09-INV-25C-0061', 'For Filing', 'Approved', 'RTC Branch 4, Gapan', '2025-03-20'),
(62, 'III-09-INV-25C-0062', 'Dismissed', 'Approved', NULL, '2025-03-20'),
(63, 'III-09-INV-25C-0063', 'For Filing', 'Approved', 'RTC Branch 5, Talavera', '2025-03-19'),
(64, 'III-09-INV-25C-0064', 'Dismissed', 'Approved', NULL, '2025-03-19'),
(65, 'III-09-INV-25C-0065', 'Dismissed', 'Approved', NULL, '2025-04-04'),
(66, 'III-09-INV-25C-0066', 'For Filing', 'Approved', 'RTC Branch 7, San Jose', '2025-03-24'),
(67, 'III-09-INV-25C-0067', 'For Filing', 'Approved', 'RTC Branch 13, Palayan', '2025-03-23'),
(68, 'III-09-INV-25C-0068', 'For Filing', 'Approved', 'RTC Branch 6, San Jose', '2025-04-04'),
(69, 'III-09-INV-25C-0069', 'Dismissed', 'Approved', NULL, '2025-04-05'),
(70, 'III-09-INV-25C-0070', 'For Filing', 'Approved', 'RTC Branch 20, Gapan', '2025-04-05'),
(71, 'III-09-INV-25C-0071', 'For Filing', 'Approved', 'RTC Branch 2, Aliaga', '2025-04-06'),
(72, 'III-09-INV-25C-0072', 'Dismissed', 'Approved', NULL, '2025-03-29'),
(73, 'III-09-INV-25C-0073', 'For Filing', 'Approved', 'RTC Branch 16, San Jose', '2025-04-10'),
(74, 'III-09-INV-25C-0074', 'For Filing', 'Approved', 'RTC Branch 1, San Jose', '2025-04-06'),
(75, 'III-09-INV-25C-0075', 'For Filing', 'Approved', 'RTC Branch 10, San Isidro', '2025-04-13'),
(76, 'III-09-INV-25C-0076', 'Dismissed', 'Approved', NULL, '2025-04-11'),
(77, 'III-09-INV-25C-0077', 'For Filing', 'Approved', 'RTC Branch 20, San Isidro', '2025-04-07'),
(78, 'III-09-INV-25C-0078', 'Dismissed', 'Approved', NULL, '2025-04-10'),
(79, 'III-09-INV-25C-0079', 'For Filing', 'Approved', 'RTC Branch 16, Cabanatuan', '2025-04-05'),
(80, 'III-09-INV-25C-0080', 'Dismissed', 'Approved', NULL, '2025-04-18'),
(81, 'III-09-INV-25C-0081', 'For Filing', 'Approved', 'RTC Branch 4, San Isidro', '2025-04-09'),
(82, 'III-09-INV-25C-0082', 'Dismissed', 'Approved', NULL, '2025-04-19'),
(83, 'III-09-INV-25C-0083', 'For Filing', 'Approved', 'RTC Branch 11, Aliaga', '2025-04-08'),
(84, 'III-09-INV-25C-0084', 'Dismissed', 'Approved', NULL, '2025-04-23'),
(85, 'III-09-INV-25C-0085', 'Dismissed', 'Approved', NULL, '2025-04-14'),
(86, 'III-09-INV-25C-0086', 'For Filing', 'Approved', 'RTC Branch 15, Cabanatuan', '2025-04-20'),
(87, 'III-09-INV-25C-0087', 'For Filing', 'Approved', 'RTC Branch 12, Cabanatuan', '2025-04-14'),
(88, 'III-09-INV-25C-0088', 'For Filing', 'Approved', 'RTC Branch 14, San Jose', '2025-04-23'),
(89, 'III-09-INV-25C-0089', 'For Filing', 'Approved', 'RTC Branch 4, Gapan', '2025-04-19'),
(90, 'III-09-INV-25C-0090', 'Dismissed', 'Approved', NULL, '2025-05-02'),
(91, 'III-09-INV-25D-0091', 'For Filing', 'Approved', 'RTC Branch 15, Palayan', '2025-04-19'),
(92, 'III-09-INV-25D-0092', 'Dismissed', 'Approved', NULL, '2025-04-24'),
(93, 'III-09-INV-25D-0093', 'For Filing', 'Approved', 'RTC Branch 17, Palayan', '2025-04-24'),
(94, 'III-09-INV-25D-0094', 'For Filing', 'Approved', 'RTC Branch 3, Cabanatuan', '2025-04-20'),
(95, 'III-09-INV-25D-0095', 'For Filing', 'Approved', 'RTC Branch 6, San Jose', '2025-05-06'),
(96, 'III-09-INV-25D-0096', 'For Filing', 'Approved', 'RTC Branch 13, Gapan', '2025-05-07'),
(97, 'III-09-INV-25D-0097', 'For Filing', 'Approved', 'RTC Branch 11, Cabanatuan', '2025-05-07'),
(98, 'III-09-INV-25D-0098', 'Dismissed', 'Approved', NULL, '2025-05-05'),
(99, 'III-09-INV-25D-0099', 'For Filing', 'Approved', 'RTC Branch 20, Gapan', '2025-05-06'),
(100, 'III-09-INV-25D-0100', 'For Filing', 'Approved', 'RTC Branch 17, Talavera', '2025-04-29'),
(101, 'III-09-INV-25J-0001', 'For Filing', 'Approved', 'aliaga', '2025-10-30'),
(102, 'III-09-INV-25J-0002', 'For Filing', 'Approved', 'MCTC Cabiao-San Isidro', '2025-11-15'),
(103, 'III-09-INV-25K-0001', 'Dismissed', 'Approved', NULL, '2025-11-01'),
(104, 'III-09-INV-25K-0002', 'For Filing', 'Approved', 'MTC - Aliaga', '2025-11-07'),
(105, 'III-09-INV-25K-0003', 'Dismissed', 'Approved', NULL, '2025-11-07'),
(106, 'III-09-INV-25K-0042-0044', 'For Filing', 'Approved', 'MTC Cuyapo', '2025-11-15');

-- --------------------------------------------------------

--
-- Table structure for table `subpoena`
--

CREATE TABLE `subpoena` (
  `Docket_Number` varchar(50) NOT NULL,
  `Date` date DEFAULT NULL,
  `Hearing_Date_1` datetime DEFAULT NULL,
  `Police_Station` varchar(255) DEFAULT NULL,
  `PROSECUTOR_ID` int(11) DEFAULT NULL,
  `Status` enum('Pending','Approved','Denied') DEFAULT 'Pending',
  `Hearing_Date_2` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subpoena`
--

INSERT INTO `subpoena` (`Docket_Number`, `Date`, `Hearing_Date_1`, `Police_Station`, `PROSECUTOR_ID`, `Status`, `Hearing_Date_2`) VALUES
('III-09-INV-25A-0001', '2025-01-01', '2025-01-03 10:00:00', 'PNP, Palayan, Nueva Ecija', 8, 'Approved', '2025-01-09 10:00:00'),
('III-09-INV-25A-0002', '2025-01-02', '2025-01-04 10:00:00', 'PNP, Aliaga, Nueva Ecija', 8, 'Approved', '2025-01-13 10:00:00'),
('III-09-INV-25A-0003', '2025-01-03', '2025-01-07 10:00:00', 'PNP, Gapan, Nueva Ecija', 10, 'Approved', '2025-01-15 10:00:00'),
('III-09-INV-25A-0004', '2025-01-04', '2025-01-06 10:00:00', 'PNP, San Jose, Nueva Ecija', 6, 'Approved', '2025-01-13 10:00:00'),
('III-09-INV-25A-0005', '2025-01-05', '2025-01-10 10:00:00', 'PNP, San Isidro, Nueva Ecija', 9, 'Approved', '2025-01-14 10:00:00'),
('III-09-INV-25A-0006', '2025-01-06', '2025-01-09 10:00:00', 'PNP, Aliaga, Nueva Ecija', 7, 'Approved', '2025-01-17 10:00:00'),
('III-09-INV-25A-0007', '2025-01-07', '2025-01-12 10:00:00', 'PNP, San Jose, Nueva Ecija', 10, 'Approved', '2025-01-19 10:00:00'),
('III-09-INV-25A-0008', '2025-01-08', '2025-01-12 10:00:00', 'PNP, Gapan, Nueva Ecija', 8, 'Approved', '2025-01-20 10:00:00'),
('III-09-INV-25A-0009', '2025-01-09', '2025-01-11 10:00:00', 'PNP, Cabanatuan, Nueva Ecija', 11, 'Approved', '2025-01-19 10:00:00'),
('III-09-INV-25A-0010', '2025-01-10', '2025-01-14 10:00:00', 'PNP, Aliaga, Nueva Ecija', 10, 'Approved', '2025-01-18 10:00:00'),
('III-09-INV-25A-0011', '2025-01-11', '2025-01-16 10:00:00', 'PNP, San Jose, Nueva Ecija', 9, 'Approved', '2025-01-20 10:00:00'),
('III-09-INV-25A-0012', '2025-01-12', '2025-01-17 10:00:00', 'PNP, Gapan, Nueva Ecija', 7, 'Approved', '2025-01-24 10:00:00'),
('III-09-INV-25A-0013', '2025-01-13', '2025-01-18 10:00:00', 'PNP, San Jose, Nueva Ecija', 10, 'Approved', '2025-01-22 10:00:00'),
('III-09-INV-25A-0014', '2025-01-14', '2025-01-17 10:00:00', 'PNP, Palayan, Nueva Ecija', 8, 'Approved', '2025-01-25 10:00:00'),
('III-09-INV-25A-0015', '2025-01-15', '2025-01-18 10:00:00', 'PNP, Cabanatuan, Nueva Ecija', 11, 'Approved', '2025-01-26 10:00:00'),
('III-09-INV-25A-0016', '2025-01-16', '2025-01-18 10:00:00', 'PNP, San Isidro, Nueva Ecija', 11, 'Approved', '2025-01-28 10:00:00'),
('III-09-INV-25A-0017', '2025-01-17', '2025-01-21 10:00:00', 'PNP, Gapan, Nueva Ecija', 9, 'Approved', '2025-01-28 10:00:00'),
('III-09-INV-25A-0018', '2025-01-18', '2025-01-21 10:00:00', 'PNP, San Jose, Nueva Ecija', 6, 'Approved', '2025-01-27 10:00:00'),
('III-09-INV-25A-0019', '2025-01-19', '2025-01-23 10:00:00', 'PNP, Aliaga, Nueva Ecija', 9, 'Approved', '2025-01-30 10:00:00'),
('III-09-INV-25A-0020', '2025-01-20', '2025-01-23 10:00:00', 'PNP, Talavera, Nueva Ecija', 10, 'Approved', '2025-02-01 10:00:00'),
('III-09-INV-25A-0021', '2025-01-21', '2025-01-26 10:00:00', 'PNP, Talavera, Nueva Ecija', 7, 'Approved', '2025-02-01 10:00:00'),
('III-09-INV-25A-0022', '2025-01-22', '2025-01-24 10:00:00', 'PNP, Aliaga, Nueva Ecija', 11, 'Approved', '2025-02-02 10:00:00'),
('III-09-INV-25A-0023', '2025-01-23', '2025-01-26 10:00:00', 'PNP, San Jose, Nueva Ecija', 8, 'Approved', '2025-02-03 10:00:00'),
('III-09-INV-25A-0024', '2025-01-24', '2025-01-29 10:00:00', 'PNP, Palayan, Nueva Ecija', 11, 'Approved', '2025-02-03 10:00:00'),
('III-09-INV-25A-0025', '2025-01-25', '2025-01-28 10:00:00', 'PNP, Aliaga, Nueva Ecija', 6, 'Approved', '2025-02-06 10:00:00'),
('III-09-INV-25A-0026', '2025-01-26', '2025-01-30 10:00:00', 'PNP, San Jose, Nueva Ecija', 6, 'Approved', '2025-02-07 10:00:00'),
('III-09-INV-25A-0027', '2025-01-27', '2025-01-31 10:00:00', 'PNP, San Jose, Nueva Ecija', 6, 'Approved', '2025-02-05 10:00:00'),
('III-09-INV-25A-0028', '2025-01-28', '2025-02-02 10:00:00', 'PNP, San Jose, Nueva Ecija', 9, 'Approved', '2025-02-08 10:00:00'),
('III-09-INV-25A-0029', '2025-01-29', '2025-02-03 10:00:00', 'PNP, Aliaga, Nueva Ecija', 9, 'Approved', '2025-02-08 10:00:00'),
('III-09-INV-25A-0030', '2025-01-30', '2025-02-01 10:00:00', 'PNP, San Isidro, Nueva Ecija', 11, 'Approved', '2025-02-08 10:00:00'),
('III-09-INV-25A-0031', '2025-01-31', '2025-02-05 10:00:00', 'PNP, San Jose, Nueva Ecija', 10, 'Approved', '2025-02-11 10:00:00'),
('III-09-INV-25B-0032', '2025-02-01', '2025-02-06 10:00:00', 'PNP, Cabanatuan, Nueva Ecija', 7, 'Approved', '2025-02-10 10:00:00'),
('III-09-INV-25B-0033', '2025-02-02', '2025-02-07 10:00:00', 'PNP, San Jose, Nueva Ecija', 7, 'Approved', '2025-02-11 10:00:00'),
('III-09-INV-25B-0034', '2025-02-03', '2025-02-07 10:00:00', 'PNP, Cabanatuan, Nueva Ecija', 6, 'Approved', '2025-02-12 10:00:00'),
('III-09-INV-25B-0035', '2025-02-04', '2025-02-09 10:00:00', 'PNP, Talavera, Nueva Ecija', 11, 'Approved', '2025-02-14 10:00:00'),
('III-09-INV-25B-0036', '2025-02-05', '2025-02-07 10:00:00', 'PNP, Talavera, Nueva Ecija', 6, 'Approved', '2025-02-15 10:00:00'),
('III-09-INV-25B-0037', '2025-02-06', '2025-02-11 10:00:00', 'PNP, Cabanatuan, Nueva Ecija', 6, 'Approved', '2025-02-14 10:00:00'),
('III-09-INV-25B-0038', '2025-02-07', '2025-02-10 10:00:00', 'PNP, San Isidro, Nueva Ecija', 8, 'Approved', '2025-02-16 10:00:00'),
('III-09-INV-25B-0039', '2025-02-08', '2025-02-12 10:00:00', 'PNP, Talavera, Nueva Ecija', 7, 'Approved', '2025-02-16 10:00:00'),
('III-09-INV-25B-0040', '2025-02-09', '2025-02-14 10:00:00', 'PNP, San Isidro, Nueva Ecija', 7, 'Approved', '2025-02-18 10:00:00'),
('III-09-INV-25B-0041', '2025-02-10', '2025-02-15 10:00:00', 'PNP, Aliaga, Nueva Ecija', 6, 'Approved', '2025-02-22 10:00:00'),
('III-09-INV-25B-0042', '2025-02-11', '2025-02-13 10:00:00', 'PNP, San Jose, Nueva Ecija', 8, 'Approved', '2025-02-22 10:00:00'),
('III-09-INV-25B-0043', '2025-02-12', '2025-02-17 10:00:00', 'PNP, San Isidro, Nueva Ecija', 8, 'Approved', '2025-02-23 10:00:00'),
('III-09-INV-25B-0044', '2025-02-13', '2025-02-16 10:00:00', 'PNP, Talavera, Nueva Ecija', 8, 'Approved', '2025-02-23 10:00:00'),
('III-09-INV-25B-0045', '2025-02-14', '2025-02-18 10:00:00', 'PNP, Aliaga, Nueva Ecija', 8, 'Approved', '2025-02-23 10:00:00'),
('III-09-INV-25B-0046', '2025-02-15', '2025-02-17 10:00:00', 'PNP, Gapan, Nueva Ecija', 10, 'Approved', '2025-02-27 10:00:00'),
('III-09-INV-25B-0047', '2025-02-16', '2025-02-21 10:00:00', 'PNP, Aliaga, Nueva Ecija', 11, 'Approved', '2025-02-27 10:00:00'),
('III-09-INV-25B-0048', '2025-02-17', '2025-02-19 10:00:00', 'PNP, Palayan, Nueva Ecija', 11, 'Approved', '2025-02-27 10:00:00'),
('III-09-INV-25B-0049', '2025-02-18', '2025-02-22 10:00:00', 'PNP, Gapan, Nueva Ecija', 9, 'Approved', '2025-02-28 10:00:00'),
('III-09-INV-25B-0050', '2025-02-19', '2025-02-24 10:00:00', 'PNP, Aliaga, Nueva Ecija', 10, 'Approved', '2025-02-27 10:00:00'),
('III-09-INV-25B-0051', '2025-02-20', '2025-02-25 10:00:00', 'PNP, Talavera, Nueva Ecija', 7, 'Approved', '2025-02-28 10:00:00'),
('III-09-INV-25B-0052', '2025-02-21', '2025-02-23 10:00:00', 'PNP, Aliaga, Nueva Ecija', 8, 'Approved', '2025-03-01 10:00:00'),
('III-09-INV-25B-0053', '2025-02-22', '2025-02-27 10:00:00', 'PNP, San Jose, Nueva Ecija', 7, 'Approved', '2025-03-06 10:00:00'),
('III-09-INV-25B-0054', '2025-02-23', '2025-02-26 10:00:00', 'PNP, San Isidro, Nueva Ecija', 8, 'Approved', '2025-03-06 10:00:00'),
('III-09-INV-25B-0055', '2025-02-24', '2025-03-01 10:00:00', 'PNP, Palayan, Nueva Ecija', 10, 'Approved', '2025-03-08 10:00:00'),
('III-09-INV-25B-0056', '2025-02-25', '2025-03-02 10:00:00', 'PNP, San Isidro, Nueva Ecija', 9, 'Approved', '2025-03-06 10:00:00'),
('III-09-INV-25B-0057', '2025-02-26', '2025-03-02 10:00:00', 'PNP, San Jose, Nueva Ecija', 9, 'Approved', '2025-03-07 10:00:00'),
('III-09-INV-25B-0058', '2025-02-27', '2025-03-04 10:00:00', 'PNP, Palayan, Nueva Ecija', 11, 'Approved', '2025-03-07 10:00:00'),
('III-09-INV-25B-0059', '2025-02-28', '2025-03-04 10:00:00', 'PNP, Palayan, Nueva Ecija', 7, 'Approved', '2025-03-09 10:00:00'),
('III-09-INV-25C-0060', '2025-03-01', '2025-03-03 10:00:00', 'PNP, Gapan, Nueva Ecija', 7, 'Approved', '2025-03-13 10:00:00'),
('III-09-INV-25C-0061', '2025-03-02', '2025-03-06 10:00:00', 'PNP, Gapan, Nueva Ecija', 11, 'Approved', '2025-03-11 10:00:00'),
('III-09-INV-25C-0062', '2025-03-03', '2025-03-08 10:00:00', 'PNP, Gapan, Nueva Ecija', 8, 'Approved', '2025-03-13 10:00:00'),
('III-09-INV-25C-0063', '2025-03-04', '2025-03-06 10:00:00', 'PNP, Talavera, Nueva Ecija', 7, 'Approved', '2025-03-14 10:00:00'),
('III-09-INV-25C-0064', '2025-03-05', '2025-03-07 10:00:00', 'PNP, Gapan, Nueva Ecija', 8, 'Approved', '2025-03-14 10:00:00'),
('III-09-INV-25C-0065', '2025-03-06', '2025-03-09 10:00:00', 'PNP, San Jose, Nueva Ecija', 8, 'Approved', '2025-03-16 10:00:00'),
('III-09-INV-25C-0066', '2025-03-07', '2025-03-12 10:00:00', 'PNP, San Jose, Nueva Ecija', 8, 'Approved', '2025-03-15 10:00:00'),
('III-09-INV-25C-0067', '2025-03-08', '2025-03-13 10:00:00', 'PNP, Palayan, Nueva Ecija', 11, 'Approved', '2025-03-18 10:00:00'),
('III-09-INV-25C-0068', '2025-03-09', '2025-03-13 10:00:00', 'PNP, San Jose, Nueva Ecija', 9, 'Approved', '2025-03-20 10:00:00'),
('III-09-INV-25C-0069', '2025-03-10', '2025-03-14 10:00:00', 'PNP, Aliaga, Nueva Ecija', 7, 'Approved', '2025-03-18 10:00:00'),
('III-09-INV-25C-0070', '2025-03-11', '2025-03-16 10:00:00', 'PNP, Gapan, Nueva Ecija', 8, 'Approved', '2025-03-22 10:00:00'),
('III-09-INV-25C-0071', '2025-03-12', '2025-03-15 10:00:00', 'PNP, Aliaga, Nueva Ecija', 7, 'Approved', '2025-03-20 10:00:00'),
('III-09-INV-25C-0072', '2025-03-13', '2025-03-16 10:00:00', 'PNP, San Isidro, Nueva Ecija', 9, 'Approved', '2025-03-21 10:00:00'),
('III-09-INV-25C-0073', '2025-03-14', '2025-03-17 10:00:00', 'PNP, San Jose, Nueva Ecija', 10, 'Approved', '2025-03-23 10:00:00'),
('III-09-INV-25C-0074', '2025-03-15', '2025-03-19 10:00:00', 'PNP, San Jose, Nueva Ecija', 7, 'Approved', '2025-03-23 10:00:00'),
('III-09-INV-25C-0075', '2025-03-16', '2025-03-18 10:00:00', 'PNP, San Isidro, Nueva Ecija', 10, 'Approved', '2025-03-25 10:00:00'),
('III-09-INV-25C-0076', '2025-03-17', '2025-03-22 10:00:00', 'PNP, Aliaga, Nueva Ecija', 6, 'Approved', '2025-03-29 10:00:00'),
('III-09-INV-25C-0077', '2025-03-18', '2025-03-22 10:00:00', 'PNP, San Isidro, Nueva Ecija', 6, 'Approved', '2025-03-29 10:00:00'),
('III-09-INV-25C-0078', '2025-03-19', '2025-03-24 10:00:00', 'PNP, Gapan, Nueva Ecija', 9, 'Approved', '2025-03-30 10:00:00'),
('III-09-INV-25C-0079', '2025-03-20', '2025-03-25 10:00:00', 'PNP, Cabanatuan, Nueva Ecija', 7, 'Approved', '2025-03-28 10:00:00'),
('III-09-INV-25C-0080', '2025-03-21', '2025-03-24 10:00:00', 'PNP, San Isidro, Nueva Ecija', 10, 'Approved', '2025-03-31 10:00:00'),
('III-09-INV-25C-0081', '2025-03-22', '2025-03-24 10:00:00', 'PNP, San Isidro, Nueva Ecija', 6, 'Approved', '2025-03-30 10:00:00'),
('III-09-INV-25C-0082', '2025-03-23', '2025-03-28 10:00:00', 'PNP, Palayan, Nueva Ecija', 9, 'Approved', '2025-04-04 10:00:00'),
('III-09-INV-25C-0083', '2025-03-24', '2025-03-28 10:00:00', 'PNP, Aliaga, Nueva Ecija', 10, 'Approved', '2025-04-03 10:00:00'),
('III-09-INV-25C-0084', '2025-03-25', '2025-03-29 10:00:00', 'PNP, San Jose, Nueva Ecija', 8, 'Approved', '2025-04-06 10:00:00'),
('III-09-INV-25C-0085', '2025-03-26', '2025-03-29 10:00:00', 'PNP, Gapan, Nueva Ecija', 8, 'Approved', '2025-04-05 10:00:00'),
('III-09-INV-25C-0086', '2025-03-27', '2025-03-29 10:00:00', 'PNP, Cabanatuan, Nueva Ecija', 10, 'Approved', '2025-04-06 10:00:00'),
('III-09-INV-25C-0087', '2025-03-28', '2025-03-30 10:00:00', 'PNP, Cabanatuan, Nueva Ecija', 11, 'Approved', '2025-04-06 10:00:00'),
('III-09-INV-25C-0088', '2025-03-29', '2025-04-01 10:00:00', 'PNP, San Jose, Nueva Ecija', 7, 'Approved', '2025-04-10 10:00:00'),
('III-09-INV-25C-0089', '2025-03-30', '2025-04-04 10:00:00', 'PNP, Gapan, Nueva Ecija', 8, 'Approved', '2025-04-10 10:00:00'),
('III-09-INV-25C-0090', '2025-03-31', '2025-04-02 10:00:00', 'PNP, San Jose, Nueva Ecija', 9, 'Approved', '2025-04-12 10:00:00'),
('III-09-INV-25D-0091', '2025-04-01', '2025-04-03 10:00:00', 'PNP, Palayan, Nueva Ecija', 10, 'Approved', '2025-04-10 10:00:00'),
('III-09-INV-25D-0092', '2025-04-02', '2025-04-05 10:00:00', 'PNP, San Jose, Nueva Ecija', 11, 'Approved', '2025-04-14 10:00:00'),
('III-09-INV-25D-0093', '2025-04-03', '2025-04-05 10:00:00', 'PNP, Palayan, Nueva Ecija', 8, 'Approved', '2025-04-15 10:00:00'),
('III-09-INV-25D-0094', '2025-04-04', '2025-04-07 10:00:00', 'PNP, Cabanatuan, Nueva Ecija', 8, 'Approved', '2025-04-12 10:00:00'),
('III-09-INV-25D-0095', '2025-04-05', '2025-04-08 10:00:00', 'PNP, San Jose, Nueva Ecija', 6, 'Approved', '2025-04-17 10:00:00'),
('III-09-INV-25D-0096', '2025-04-06', '2025-04-09 10:00:00', 'PNP, Gapan, Nueva Ecija', 8, 'Approved', '2025-04-18 10:00:00'),
('III-09-INV-25D-0097', '2025-04-07', '2025-04-09 10:00:00', 'PNP, Cabanatuan, Nueva Ecija', 9, 'Approved', '2025-04-17 10:00:00'),
('III-09-INV-25D-0098', '2025-04-08', '2025-04-11 10:00:00', 'PNP, Talavera, Nueva Ecija', 7, 'Approved', '2025-04-20 10:00:00'),
('III-09-INV-25D-0099', '2025-04-09', '2025-04-12 10:00:00', 'PNP, Gapan, Nueva Ecija', 7, 'Approved', '2025-04-20 10:00:00'),
('III-09-INV-25D-0100', '2025-04-10', '2025-04-13 10:00:00', 'PNP, Talavera, Nueva Ecija', 8, 'Approved', '2025-04-20 10:00:00'),
('III-09-INV-25J-0001', '2025-10-30', '2025-11-05 13:30:00', 'PNP, Aliaga, Nueva Ecija', 7, 'Approved', '2025-11-12 13:30:00'),
('III-09-INV-25J-0002', '2025-10-30', '2025-11-06 08:00:00', 'Papaya Police Station', 8, 'Approved', '2025-07-17 08:53:00'),
('III-09-INV-25J-0003', '2025-10-31', '2025-11-07 13:00:00', 'PNP, General Mamerto Natividad, Nueva Ecija', 7, 'Approved', '2025-11-01 13:00:00'),
('III-09-INV-25K-0001', '2025-11-01', '2025-11-05 21:29:00', 'PNP, Paranyake, Nueva Ecija', 12, 'Approved', '2025-11-12 21:04:00'),
('III-09-INV-25K-0002', '2025-11-07', '2025-11-12 10:00:00', 'PNP, Quezon, Nueva Ecija', 11, 'Approved', '2025-11-19 10:00:00'),
('III-09-INV-25K-0003', '2025-11-07', '2025-11-21 09:30:00', 'PNP, Llanera, Nueva Ecija', 12, 'Approved', '2025-11-28 09:30:00'),
('III-09-INV-25K-0004-0005-0006', '2025-11-14', '2025-11-19 23:30:00', 'PNP, Aliaga, Nueva Ecija', 7, 'Pending', '2025-11-26 23:30:00'),
('III-09-INV-25K-0007-0008-0009', '2025-11-14', '2025-11-19 17:00:00', 'PNP, Aliaga, Nueva Ecija', 7, 'Pending', '2025-11-26 17:00:00'),
('III-09-INV-25K-0010-0011-0012', '2025-11-14', '2025-11-19 21:00:00', 'PNP, Bongabon, Nueva Ecija', 7, 'Pending', '2025-11-26 21:00:00'),
('III-09-INV-25K-0013-0014-0015', '2025-11-14', '2025-11-19 20:00:00', 'PNP, Cabiao, Nueva Ecija', 9, 'Pending', '2025-11-26 20:00:00'),
('III-09-INV-25K-0016-0017-0018-0019', '2025-11-14', '2025-11-19 07:00:00', 'PNP, Guimba, Nueva Ecija', 7, 'Pending', '2025-11-26 07:00:00'),
('III-09-INV-25K-0020-0021-0022', '2025-11-14', '2025-11-19 07:00:00', 'PNP, Cuyapo, Nueva Ecija', 7, 'Pending', '2025-11-26 07:00:00'),
('III-09-INV-25K-0023-0024-0025-0026', '2025-11-14', '2025-11-19 07:00:00', 'PNP, General Tinio, Nueva Ecija', 7, 'Approved', '2025-11-26 19:00:00'),
('III-09-INV-25K-0027-0028-0029-0030', '2025-11-14', '2025-11-19 07:00:00', 'PNP, Lupao, Nueva Ecija', 9, 'Pending', '2025-11-26 07:00:00'),
('III-09-INV-25K-0031-0032-0033-0034', '2025-11-14', '2025-11-19 10:30:00', 'PNP, Carranglan, Nueva Ecija', 9, 'Pending', '2025-11-26 10:30:00'),
('III-09-INV-25K-0035-0036-0037-0038', '2025-11-14', '2025-11-19 09:30:00', 'PNP, Carranglan, Nueva Ecija', 10, 'Denied', '2025-11-26 09:30:00'),
('III-09-INV-25K-0039-0041', '2025-11-14', '2025-11-19 12:00:00', 'PNP, Carranglan, Nueva Ecija', 7, 'Approved', '2025-11-26 12:00:00'),
('III-09-INV-25K-0042-0044', '2025-11-15', '2025-11-19 11:00:00', 'PNP, Cuyapo, Nueva Ecija', 7, 'Approved', '2025-11-26 11:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `subpoena_offense`
--

CREATE TABLE `subpoena_offense` (
  `Docket_Number` varchar(50) NOT NULL,
  `offense_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subpoena_offense`
--

INSERT INTO `subpoena_offense` (`Docket_Number`, `offense_id`) VALUES
('III-09-INV-25A-0001', 36),
('III-09-INV-25A-0001', 44),
('III-09-INV-25A-0001', 55),
('III-09-INV-25A-0002', 59),
('III-09-INV-25A-0002', 83),
('III-09-INV-25A-0003', 3),
('III-09-INV-25A-0003', 42),
('III-09-INV-25A-0003', 63),
('III-09-INV-25A-0004', 63),
('III-09-INV-25A-0004', 86),
('III-09-INV-25A-0005', 22),
('III-09-INV-25A-0006', 16),
('III-09-INV-25A-0006', 73),
('III-09-INV-25A-0007', 27),
('III-09-INV-25A-0007', 78),
('III-09-INV-25A-0008', 17),
('III-09-INV-25A-0008', 19),
('III-09-INV-25A-0008', 56),
('III-09-INV-25A-0009', 4),
('III-09-INV-25A-0009', 15),
('III-09-INV-25A-0010', 56),
('III-09-INV-25A-0011', 68),
('III-09-INV-25A-0011', 72),
('III-09-INV-25A-0011', 77),
('III-09-INV-25A-0012', 44),
('III-09-INV-25A-0012', 86),
('III-09-INV-25A-0013', 17),
('III-09-INV-25A-0013', 20),
('III-09-INV-25A-0013', 31),
('III-09-INV-25A-0014', 14),
('III-09-INV-25A-0014', 56),
('III-09-INV-25A-0015', 33),
('III-09-INV-25A-0015', 40),
('III-09-INV-25A-0016', 17),
('III-09-INV-25A-0016', 90),
('III-09-INV-25A-0017', 13),
('III-09-INV-25A-0017', 27),
('III-09-INV-25A-0017', 98),
('III-09-INV-25A-0018', 8),
('III-09-INV-25A-0019', 1),
('III-09-INV-25A-0019', 70),
('III-09-INV-25A-0019', 85),
('III-09-INV-25A-0020', 58),
('III-09-INV-25A-0021', 9),
('III-09-INV-25A-0021', 31),
('III-09-INV-25A-0021', 81),
('III-09-INV-25A-0022', 33),
('III-09-INV-25A-0022', 39),
('III-09-INV-25A-0022', 59),
('III-09-INV-25A-0023', 51),
('III-09-INV-25A-0024', 16),
('III-09-INV-25A-0024', 25),
('III-09-INV-25A-0025', 9),
('III-09-INV-25A-0025', 15),
('III-09-INV-25A-0025', 96),
('III-09-INV-25A-0026', 12),
('III-09-INV-25A-0027', 7),
('III-09-INV-25A-0027', 11),
('III-09-INV-25A-0027', 87),
('III-09-INV-25A-0028', 10),
('III-09-INV-25A-0028', 41),
('III-09-INV-25A-0029', 33),
('III-09-INV-25A-0030', 44),
('III-09-INV-25A-0031', 3),
('III-09-INV-25A-0031', 40),
('III-09-INV-25A-0031', 47),
('III-09-INV-25B-0032', 87),
('III-09-INV-25B-0032', 93),
('III-09-INV-25B-0033', 4),
('III-09-INV-25B-0033', 29),
('III-09-INV-25B-0034', 68),
('III-09-INV-25B-0035', 5),
('III-09-INV-25B-0035', 97),
('III-09-INV-25B-0036', 21),
('III-09-INV-25B-0036', 87),
('III-09-INV-25B-0036', 96),
('III-09-INV-25B-0037', 9),
('III-09-INV-25B-0037', 45),
('III-09-INV-25B-0037', 91),
('III-09-INV-25B-0038', 21),
('III-09-INV-25B-0038', 22),
('III-09-INV-25B-0039', 19),
('III-09-INV-25B-0040', 47),
('III-09-INV-25B-0040', 72),
('III-09-INV-25B-0041', 3),
('III-09-INV-25B-0041', 61),
('III-09-INV-25B-0042', 45),
('III-09-INV-25B-0042', 72),
('III-09-INV-25B-0043', 21),
('III-09-INV-25B-0043', 53),
('III-09-INV-25B-0043', 84),
('III-09-INV-25B-0044', 12),
('III-09-INV-25B-0044', 42),
('III-09-INV-25B-0044', 52),
('III-09-INV-25B-0045', 61),
('III-09-INV-25B-0045', 71),
('III-09-INV-25B-0045', 97),
('III-09-INV-25B-0046', 54),
('III-09-INV-25B-0046', 83),
('III-09-INV-25B-0046', 94),
('III-09-INV-25B-0047', 8),
('III-09-INV-25B-0047', 36),
('III-09-INV-25B-0048', 27),
('III-09-INV-25B-0048', 78),
('III-09-INV-25B-0048', 91),
('III-09-INV-25B-0049', 62),
('III-09-INV-25B-0049', 79),
('III-09-INV-25B-0049', 86),
('III-09-INV-25B-0050', 41),
('III-09-INV-25B-0051', 20),
('III-09-INV-25B-0051', 82),
('III-09-INV-25B-0051', 95),
('III-09-INV-25B-0052', 10),
('III-09-INV-25B-0052', 62),
('III-09-INV-25B-0053', 76),
('III-09-INV-25B-0054', 67),
('III-09-INV-25B-0054', 72),
('III-09-INV-25B-0054', 75),
('III-09-INV-25B-0055', 71),
('III-09-INV-25B-0056', 16),
('III-09-INV-25B-0056', 31),
('III-09-INV-25B-0057', 47),
('III-09-INV-25B-0057', 70),
('III-09-INV-25B-0057', 97),
('III-09-INV-25B-0058', 66),
('III-09-INV-25B-0058', 87),
('III-09-INV-25B-0059', 100),
('III-09-INV-25C-0060', 84),
('III-09-INV-25C-0060', 86),
('III-09-INV-25C-0061', 12),
('III-09-INV-25C-0061', 28),
('III-09-INV-25C-0061', 57),
('III-09-INV-25C-0062', 15),
('III-09-INV-25C-0062', 31),
('III-09-INV-25C-0063', 23),
('III-09-INV-25C-0063', 85),
('III-09-INV-25C-0063', 95),
('III-09-INV-25C-0064', 12),
('III-09-INV-25C-0064', 42),
('III-09-INV-25C-0065', 14),
('III-09-INV-25C-0065', 20),
('III-09-INV-25C-0065', 22),
('III-09-INV-25C-0066', 8),
('III-09-INV-25C-0067', 26),
('III-09-INV-25C-0067', 83),
('III-09-INV-25C-0068', 26),
('III-09-INV-25C-0068', 79),
('III-09-INV-25C-0069', 50),
('III-09-INV-25C-0070', 55),
('III-09-INV-25C-0071', 31),
('III-09-INV-25C-0071', 39),
('III-09-INV-25C-0071', 61),
('III-09-INV-25C-0072', 2),
('III-09-INV-25C-0072', 90),
('III-09-INV-25C-0073', 12),
('III-09-INV-25C-0073', 25),
('III-09-INV-25C-0073', 57),
('III-09-INV-25C-0074', 21),
('III-09-INV-25C-0074', 34),
('III-09-INV-25C-0075', 33),
('III-09-INV-25C-0075', 59),
('III-09-INV-25C-0076', 40),
('III-09-INV-25C-0076', 43),
('III-09-INV-25C-0076', 54),
('III-09-INV-25C-0077', 21),
('III-09-INV-25C-0077', 63),
('III-09-INV-25C-0077', 98),
('III-09-INV-25C-0078', 18),
('III-09-INV-25C-0078', 44),
('III-09-INV-25C-0078', 63),
('III-09-INV-25C-0079', 37),
('III-09-INV-25C-0080', 47),
('III-09-INV-25C-0080', 87),
('III-09-INV-25C-0081', 90),
('III-09-INV-25C-0082', 10),
('III-09-INV-25C-0082', 22),
('III-09-INV-25C-0083', 13),
('III-09-INV-25C-0083', 15),
('III-09-INV-25C-0083', 58),
('III-09-INV-25C-0084', 50),
('III-09-INV-25C-0085', 37),
('III-09-INV-25C-0086', 100),
('III-09-INV-25C-0087', 61),
('III-09-INV-25C-0087', 68),
('III-09-INV-25C-0087', 72),
('III-09-INV-25C-0088', 10),
('III-09-INV-25C-0088', 72),
('III-09-INV-25C-0089', 48),
('III-09-INV-25C-0089', 83),
('III-09-INV-25C-0089', 94),
('III-09-INV-25C-0090', 46),
('III-09-INV-25C-0090', 100),
('III-09-INV-25D-0091', 2),
('III-09-INV-25D-0091', 31),
('III-09-INV-25D-0091', 85),
('III-09-INV-25D-0092', 1),
('III-09-INV-25D-0092', 18),
('III-09-INV-25D-0092', 65),
('III-09-INV-25D-0093', 74),
('III-09-INV-25D-0094', 77),
('III-09-INV-25D-0094', 79),
('III-09-INV-25D-0095', 16),
('III-09-INV-25D-0095', 18),
('III-09-INV-25D-0095', 85),
('III-09-INV-25D-0096', 29),
('III-09-INV-25D-0096', 78),
('III-09-INV-25D-0097', 71),
('III-09-INV-25D-0098', 35),
('III-09-INV-25D-0099', 53),
('III-09-INV-25D-0100', 37),
('III-09-INV-25D-0100', 57),
('III-09-INV-25D-0100', 81),
('III-09-INV-25J-0001', 6),
('III-09-INV-25J-0001', 8),
('III-09-INV-25J-0002', 2),
('III-09-INV-25J-0003', 8),
('III-09-INV-25J-0003', 10),
('III-09-INV-25K-0001', 1),
('III-09-INV-25K-0001', 9),
('III-09-INV-25K-0002', 1),
('III-09-INV-25K-0002', 4),
('III-09-INV-25K-0003', 1),
('III-09-INV-25K-0003', 9),
('III-09-INV-25K-0003', 20),
('III-09-INV-25K-0004-0005-0006', 4),
('III-09-INV-25K-0004-0005-0006', 7),
('III-09-INV-25K-0007-0008-0009', 4),
('III-09-INV-25K-0007-0008-0009', 7),
('III-09-INV-25K-0007-0008-0009', 8),
('III-09-INV-25K-0010-0011-0012', 4),
('III-09-INV-25K-0010-0011-0012', 10),
('III-09-INV-25K-0010-0011-0012', 20),
('III-09-INV-25K-0013-0014-0015', 2),
('III-09-INV-25K-0013-0014-0015', 5),
('III-09-INV-25K-0013-0014-0015', 6),
('III-09-INV-25K-0016-0017-0018-0019', 1),
('III-09-INV-25K-0016-0017-0018-0019', 2),
('III-09-INV-25K-0016-0017-0018-0019', 6),
('III-09-INV-25K-0016-0017-0018-0019', 9),
('III-09-INV-25K-0020-0021-0022', 4),
('III-09-INV-25K-0020-0021-0022', 5),
('III-09-INV-25K-0020-0021-0022', 6),
('III-09-INV-25K-0023-0024-0025-0026', 2),
('III-09-INV-25K-0023-0024-0025-0026', 6),
('III-09-INV-25K-0023-0024-0025-0026', 7),
('III-09-INV-25K-0023-0024-0025-0026', 8),
('III-09-INV-25K-0027-0028-0029-0030', 2),
('III-09-INV-25K-0027-0028-0029-0030', 4),
('III-09-INV-25K-0027-0028-0029-0030', 6),
('III-09-INV-25K-0027-0028-0029-0030', 7),
('III-09-INV-25K-0031-0032-0033-0034', 4),
('III-09-INV-25K-0031-0032-0033-0034', 5),
('III-09-INV-25K-0031-0032-0033-0034', 6),
('III-09-INV-25K-0031-0032-0033-0034', 9),
('III-09-INV-25K-0035-0036-0037-0038', 4),
('III-09-INV-25K-0035-0036-0037-0038', 5),
('III-09-INV-25K-0035-0036-0037-0038', 9),
('III-09-INV-25K-0035-0036-0037-0038', 10),
('III-09-INV-25K-0039-0041', 1),
('III-09-INV-25K-0039-0041', 4),
('III-09-INV-25K-0039-0041', 5),
('III-09-INV-25K-0042-0044', 4),
('III-09-INV-25K-0042-0044', 5),
('III-09-INV-25K-0042-0044', 10);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `USER_ID` int(11) NOT NULL,
  `PERSON_ID` int(11) DEFAULT NULL,
  `Role` enum('PS','Prosecutor','Secretary','superuser') DEFAULT NULL,
  `Archived` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`USER_ID`, `PERSON_ID`, `Role`, `Archived`) VALUES
(1, 48, 'superuser', 0),
(2, 54, 'Secretary', 0),
(5, 57, 'Prosecutor', 0),
(6, 83, 'PS', 0),
(7, 97, 'Prosecutor', 1),
(8, 98, 'Prosecutor', 0),
(9, 99, 'superuser', 0),
(10, 100, 'Prosecutor', 0),
(11, 600, 'Secretary', 0),
(12, 609, 'Prosecutor', 0),
(13, 612, 'Secretary', 0);

-- --------------------------------------------------------

--
-- Table structure for table `username`
--

CREATE TABLE `username` (
  `USERNAME_ID` int(11) NOT NULL,
  `Username` varchar(100) DEFAULT NULL,
  `USER_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `username`
--

INSERT INTO `username` (`USERNAME_ID`, `Username`, `USER_ID`) VALUES
(1, 'chiefadmin', 1),
(2, 'Itchanisan', 2),
(5, 'Prosecutor1', 5),
(6, 'PServer1', 6),
(7, 'Jaysecutor', 7),
(8, 'Kurtcutor', 8),
(9, 'Prosecutor2', 9),
(10, 'Prosecutor3', 10),
(11, 'Kiancretary', 11),
(12, 'Paulul', 12),
(13, 'Secretary1', 13);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_case_lookup`
-- (See below for the actual view)
--
CREATE TABLE `view_case_lookup` (
`Docket_Number` varchar(50)
,`Case_Type` longtext
,`complainants` mediumtext
,`respondents` mediumtext
,`Prosecutor` varchar(205)
,`Verdict` varchar(19)
,`Resolution_Date` date
,`Court` varchar(255)
,`Resolution_Status` enum('Pending','Approved','Denied')
,`PIN_CODE` varchar(10)
,`Hearing_Date_1` datetime
,`Hearing_Date_2` datetime
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_manage_users`
-- (See below for the actual view)
--
CREATE TABLE `view_manage_users` (
`USER_ID` int(11)
,`Full_Name` varchar(205)
,`Role` enum('PS','Prosecutor','Secretary','superuser')
,`Username` varchar(100)
,`Password` varchar(255)
,`Status` varchar(8)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_prosecutor_list`
-- (See below for the actual view)
--
CREATE TABLE `view_prosecutor_list` (
`PROSECUTOR_ID` int(11)
,`PERSON_ID` int(11)
,`full_name` varchar(205)
,`Licens_No` varchar(100)
,`Office_No` varchar(100)
,`Archived` tinyint(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_reports`
-- (See below for the actual view)
--
CREATE TABLE `view_reports` (
`Docket_Number` varchar(50)
,`Crime` mediumtext
,`Police_Station` varchar(255)
,`Date_` date
,`Hearing_Date_1` datetime
,`Hearing_Date_2` datetime
,`Verdict` enum('For Filing','Dismissed','Pending')
,`Verdict_Date` date
,`Court` varchar(255)
,`Resolution_Status` enum('Pending','Approved','Denied')
,`Prosecutor` varchar(306)
,`Complainants` mediumtext
,`Respondents` mediumtext
,`Sex` varchar(6)
,`Age_Group` varchar(7)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_subpoena_list`
-- (See below for the actual view)
--
CREATE TABLE `view_subpoena_list` (
`Docket_Number` varchar(50)
,`Crime` mediumtext
,`Date_` date
,`Hearing_Date_1` datetime
,`Hearing_Date_2` datetime
,`Police_Station` varchar(255)
,`Complainant` varchar(205)
,`Respondent` varchar(205)
,`Prosecutor` varchar(205)
,`Prosecutor_Person_ID` int(11)
,`Pin` varchar(10)
,`Status` enum('Pending','Approved','Denied')
,`Verdict` enum('For Filing','Dismissed','Pending')
,`Court` varchar(255)
,`Verdict_Date` date
,`Creator_ID` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_user_logs`
-- (See below for the actual view)
--
CREATE TABLE `view_user_logs` (
`LOG_ID` int(11)
,`USER_ID` int(11)
,`Full_Name` varchar(306)
,`Role` enum('PS','Prosecutor','Secretary','superuser')
,`Action` text
,`Timestamp` datetime
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_verify_resolutions`
-- (See below for the actual view)
--
CREATE TABLE `view_verify_resolutions` (
`Docket_Number` varchar(50)
,`Complainants` mediumtext
,`Respondents` mediumtext
,`Prosecutor` varchar(205)
,`Crime` mediumtext
,`Verdict` enum('For Filing','Dismissed','Pending')
,`Status` enum('Pending','Approved','Denied')
,`Court` varchar(255)
,`Verdict_Date` date
,`Created_By` varchar(205)
,`Creator_ID` int(11)
,`Denial_Comment` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_verify_subpoenas`
-- (See below for the actual view)
--
CREATE TABLE `view_verify_subpoenas` (
`Docket_Number` varchar(50)
,`Status` enum('Pending','Approved','Denied')
,`Crimes` mediumtext
,`Complainants` mediumtext
,`Respondents` mediumtext
,`Police_Station` varchar(255)
,`Date_` varchar(73)
,`Hearing_Date_1` datetime
,`Hearing_Date_2` datetime
,`Prosecutor` varchar(205)
,`Prosecutor_Person_ID` int(11)
,`Created_By` varchar(205)
,`Creator_ID` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `view_case_lookup`
--
DROP TABLE IF EXISTS `view_case_lookup`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_case_lookup`  AS SELECT `s`.`Docket_Number` AS `Docket_Number`, CASE WHEN `oc`.`offense_count` = 0 THEN 'No Offense Listed' WHEN `oc`.`offense_count` = 1 THEN `oc`.`offense_list` WHEN `oc`.`offense_count` = 2 THEN replace(`oc`.`offense_list`,',',' and ') WHEN `oc`.`offense_count` = 3 THEN concat(substring_index(`oc`.`offense_list`,',',2),', and ',substring_index(`oc`.`offense_list`,',',-1)) ELSE concat(substring_index(`oc`.`offense_list`,',',3),', etc') END AS `Case_Type`, `cc`.`complainants` AS `complainants`, `rc`.`respondents` AS `respondents`, concat_ws(' ',`prs_p`.`First_name`,`prs_p`.`Last_name`,`prs_p`.`suffix`) AS `Prosecutor`, CASE WHEN `r`.`Status` = 'Approved' THEN `r`.`Verdict` WHEN `r`.`Status` = 'Denied' THEN concat('Denied (',`r`.`Verdict`,')') WHEN `r`.`Status` = 'Pending' THEN 'Under Review' ELSE NULL END AS `Verdict`, CASE WHEN `r`.`Status` = 'Approved' THEN `r`.`Date` ELSE NULL END AS `Resolution_Date`, CASE WHEN `r`.`Status` = 'Approved' THEN `r`.`Court` ELSE NULL END AS `Court`, `r`.`Status` AS `Resolution_Status`, `pc`.`PIN_CODE` AS `PIN_CODE`, `s`.`Hearing_Date_1` AS `Hearing_Date_1`, `s`.`Hearing_Date_2` AS `Hearing_Date_2` FROM (((((((`subpoena` `s` left join (select `so`.`Docket_Number` AS `Docket_Number`,count(`o`.`name`) AS `offense_count`,group_concat(distinct `o`.`name` order by `o`.`name` ASC separator ',') AS `offense_list` from (`subpoena_offense` `so` left join `offense` `o` on(`so`.`offense_id` = `o`.`offense_id`)) group by `so`.`Docket_Number`) `oc` on(`s`.`Docket_Number` = `oc`.`Docket_Number`)) left join (select `ic`.`Docket_Number` AS `Docket_Number`,group_concat(distinct concat_ws(' ',`p`.`First_name`,`p`.`Last_name`,`p`.`suffix`) order by `p`.`First_name` ASC,`p`.`Last_name` ASC separator ', ') AS `complainants` from (`involved_party` `ic` left join `person` `p` on(`ic`.`PERSON_ID` = `p`.`PERSON_ID`)) where `ic`.`Role` = 'Complainant' group by `ic`.`Docket_Number`) `cc` on(`s`.`Docket_Number` = `cc`.`Docket_Number`)) left join (select `ir`.`Docket_Number` AS `Docket_Number`,group_concat(distinct concat_ws(' ',`p`.`First_name`,`p`.`Last_name`,`p`.`suffix`) order by `p`.`First_name` ASC,`p`.`Last_name` ASC separator ', ') AS `respondents` from (`involved_party` `ir` left join `person` `p` on(`ir`.`PERSON_ID` = `p`.`PERSON_ID`)) where `ir`.`Role` = 'Respondent' group by `ir`.`Docket_Number`) `rc` on(`s`.`Docket_Number` = `rc`.`Docket_Number`)) left join `prosecutor` `prs` on(`s`.`PROSECUTOR_ID` = `prs`.`PROSECUTOR_ID`)) left join `person` `prs_p` on(`prs`.`PERSON_ID` = `prs_p`.`PERSON_ID`)) left join `resolution` `r` on(`s`.`Docket_Number` = `r`.`Docket_Number`)) left join `pin_code` `pc` on(`s`.`Docket_Number` = `pc`.`Docket_Number`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_manage_users`
--
DROP TABLE IF EXISTS `view_manage_users`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_manage_users`  AS SELECT `u`.`USER_ID` AS `USER_ID`, concat_ws(' ',`p`.`First_name`,`p`.`Last_name`,`p`.`suffix`) AS `Full_Name`, `u`.`Role` AS `Role`, `un`.`Username` AS `Username`, `pw`.`Password` AS `Password`, CASE WHEN `u`.`Archived` = 1 THEN 'Archived' ELSE 'Active' END AS `Status` FROM (((`user` `u` left join `person` `p` on(`u`.`PERSON_ID` = `p`.`PERSON_ID`)) left join `username` `un` on(`u`.`USER_ID` = `un`.`USER_ID`)) left join `password` `pw` on(`u`.`USER_ID` = `pw`.`USER_ID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_prosecutor_list`
--
DROP TABLE IF EXISTS `view_prosecutor_list`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_prosecutor_list`  AS SELECT `p`.`PROSECUTOR_ID` AS `PROSECUTOR_ID`, `p`.`PERSON_ID` AS `PERSON_ID`, trim(concat(`per`.`First_name`,' ',`per`.`Last_name`,' ',coalesce(`per`.`suffix`,''))) AS `full_name`, `p`.`Licens_No` AS `Licens_No`, `p`.`Office_No` AS `Office_No`, `u`.`Archived` AS `Archived` FROM ((`prosecutor` `p` join `person` `per` on(`p`.`PERSON_ID` = `per`.`PERSON_ID`)) left join `user` `u` on(`u`.`PERSON_ID` = `per`.`PERSON_ID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_reports`
--
DROP TABLE IF EXISTS `view_reports`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_reports`  AS SELECT `s`.`Docket_Number` AS `Docket_Number`, (select group_concat(`o`.`name` order by `o`.`name` ASC separator ', ') from (`subpoena_offense` `so` join `offense` `o` on(`so`.`offense_id` = `o`.`offense_id`)) where `so`.`Docket_Number` = `s`.`Docket_Number`) AS `Crime`, `s`.`Police_Station` AS `Police_Station`, `s`.`Date` AS `Date_`, `s`.`Hearing_Date_1` AS `Hearing_Date_1`, `s`.`Hearing_Date_2` AS `Hearing_Date_2`, `res`.`Verdict` AS `Verdict`, `res`.`Date` AS `Verdict_Date`, `res`.`Court` AS `Court`, `res`.`Status` AS `Resolution_Status`, concat_ws(' ',`p_pros`.`First_name`,`p_pros`.`Middle_name`,`p_pros`.`Last_name`,`p_pros`.`suffix`) AS `Prosecutor`, (select group_concat(concat_ws(' ',`p`.`First_name`,`p`.`Last_name`,`p`.`suffix`) order by `p`.`First_name` ASC,`p`.`Last_name` ASC separator ', ') from (`involved_party` `ip` join `person` `p` on(`ip`.`PERSON_ID` = `p`.`PERSON_ID`)) where `ip`.`Docket_Number` = `s`.`Docket_Number` and `ip`.`Role` = 'Complainant') AS `Complainants`, (select group_concat(concat_ws(' ',`p`.`First_name`,`p`.`Last_name`,`p`.`suffix`) order by `p`.`First_name` ASC,`p`.`Last_name` ASC separator ', ') from (`involved_party` `ip` join `person` `p` on(`ip`.`PERSON_ID` = `p`.`PERSON_ID`)) where `ip`.`Docket_Number` = `s`.`Docket_Number` and `ip`.`Role` = 'Respondent') AS `Respondents`, (select `p`.`Sex` from (`involved_party` `ip` join `person` `p` on(`ip`.`PERSON_ID` = `p`.`PERSON_ID`)) where `ip`.`Docket_Number` = `s`.`Docket_Number` and `ip`.`Role` = 'Complainant' limit 1) AS `Sex`, (select case when timestampdiff(YEAR,`p`.`Date_of_Birth`,curdate()) between 0 and 17 then '0-17' when timestampdiff(YEAR,`p`.`Date_of_Birth`,curdate()) between 18 and 30 then '18-30' when timestampdiff(YEAR,`p`.`Date_of_Birth`,curdate()) between 31 and 45 then '31-45' when timestampdiff(YEAR,`p`.`Date_of_Birth`,curdate()) between 46 and 60 then '46-60' when timestampdiff(YEAR,`p`.`Date_of_Birth`,curdate()) > 60 then '61+' else 'Unknown' end from (`involved_party` `ip` join `person` `p` on(`ip`.`PERSON_ID` = `p`.`PERSON_ID`)) where `ip`.`Docket_Number` = `s`.`Docket_Number` and `ip`.`Role` = 'Complainant' limit 1) AS `Age_Group` FROM (((`subpoena` `s` left join `resolution` `res` on(`s`.`Docket_Number` = `res`.`Docket_Number` and `res`.`Verdict` in ('For Filing','Dismissed'))) left join `prosecutor` `pros` on(`s`.`PROSECUTOR_ID` = `pros`.`PROSECUTOR_ID`)) left join `person` `p_pros` on(`pros`.`PERSON_ID` = `p_pros`.`PERSON_ID`)) WHERE `s`.`Status` = 'Approved' AND `res`.`Verdict` is not null ;

-- --------------------------------------------------------

--
-- Structure for view `view_subpoena_list`
--
DROP TABLE IF EXISTS `view_subpoena_list`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_subpoena_list`  AS SELECT `s`.`Docket_Number` AS `Docket_Number`, `c`.`Crimes` AS `Crime`, `s`.`Date` AS `Date_`, `s`.`Hearing_Date_1` AS `Hearing_Date_1`, `s`.`Hearing_Date_2` AS `Hearing_Date_2`, `s`.`Police_Station` AS `Police_Station`, (select trim(concat(coalesce(`p`.`First_name`,''),' ',coalesce(`p`.`Last_name`,''),' ',coalesce(`p`.`suffix`,''))) from (`involved_party` `ip` join `person` `p` on(`ip`.`PERSON_ID` = `p`.`PERSON_ID`)) where `ip`.`Docket_Number` = `s`.`Docket_Number` and `ip`.`Role` = 'Complainant' order by `p`.`PERSON_ID` limit 1) AS `Complainant`, (select trim(concat(coalesce(`p`.`First_name`,''),' ',coalesce(`p`.`Last_name`,''),' ',coalesce(`p`.`suffix`,''))) from (`involved_party` `ip` join `person` `p` on(`ip`.`PERSON_ID` = `p`.`PERSON_ID`)) where `ip`.`Docket_Number` = `s`.`Docket_Number` and `ip`.`Role` = 'Respondent' order by `p`.`PERSON_ID` limit 1) AS `Respondent`, trim(concat(coalesce(`pros_p`.`First_name`,''),' ',coalesce(`pros_p`.`Last_name`,''),' ',coalesce(`pros_p`.`suffix`,''))) AS `Prosecutor`, `pros`.`PERSON_ID` AS `Prosecutor_Person_ID`, `pc`.`PIN_CODE` AS `Pin`, `res`.`Status` AS `Status`, `res`.`Verdict` AS `Verdict`, `res`.`Court` AS `Court`, `res`.`Date` AS `Verdict_Date`, `logs`.`USER_ID` AS `Creator_ID` FROM ((((((`subpoena` `s` left join (select `so`.`Docket_Number` AS `Docket_Number`,group_concat(`o`.`name` order by `o`.`name` ASC separator ', ') AS `Crimes` from (`subpoena_offense` `so` join `offense` `o` on(`so`.`offense_id` = `o`.`offense_id`)) group by `so`.`Docket_Number`) `c` on(`s`.`Docket_Number` = `c`.`Docket_Number`)) left join `pin_code` `pc` on(`s`.`Docket_Number` = `pc`.`Docket_Number`)) left join `resolution` `res` on(`s`.`Docket_Number` = `res`.`Docket_Number`)) left join `prosecutor` `pros` on(`s`.`PROSECUTOR_ID` = `pros`.`PROSECUTOR_ID`)) left join `person` `pros_p` on(`pros`.`PERSON_ID` = `pros_p`.`PERSON_ID`)) left join (select `log_table`.`USER_ID` AS `USER_ID`,substring_index(`log_table`.`Action`,'Created subpoena ',-1) AS `Docket_Num` from `log_table` where `log_table`.`Action` like 'Created subpoena %' group by substring_index(`log_table`.`Action`,'Created subpoena ',-1)) `logs` on(`logs`.`Docket_Num` = `s`.`Docket_Number`)) WHERE `s`.`Status` = 'Approved' ;

-- --------------------------------------------------------

--
-- Structure for view `view_user_logs`
--
DROP TABLE IF EXISTS `view_user_logs`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_user_logs`  AS SELECT `l`.`LOG_ID` AS `LOG_ID`, `l`.`USER_ID` AS `USER_ID`, concat_ws(' ',`p`.`First_name`,`p`.`Middle_name`,`p`.`Last_name`,`p`.`suffix`) AS `Full_Name`, `u`.`Role` AS `Role`, `l`.`Action` AS `Action`, `l`.`Timestamp` AS `Timestamp` FROM ((`log_table` `l` join `user` `u` on(`l`.`USER_ID` = `u`.`USER_ID`)) join `person` `p` on(`u`.`PERSON_ID` = `p`.`PERSON_ID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_verify_resolutions`
--
DROP TABLE IF EXISTS `view_verify_resolutions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_verify_resolutions`  AS SELECT `r`.`Docket_Number` AS `Docket_Number`, group_concat(distinct concat_ws(' ',`c`.`First_name`,`c`.`Last_name`,`c`.`suffix`) order by `c`.`First_name` ASC,`c`.`Last_name` ASC separator ', ') AS `Complainants`, group_concat(distinct concat_ws(' ',`rps`.`First_name`,`rps`.`Last_name`,`rps`.`suffix`) order by `rps`.`First_name` ASC,`rps`.`Last_name` ASC separator ', ') AS `Respondents`, concat_ws(' ',`p`.`First_name`,`p`.`Last_name`,`p`.`suffix`) AS `Prosecutor`, `c2`.`Crimes` AS `Crime`, `r`.`Verdict` AS `Verdict`, `r`.`Status` AS `Status`, `r`.`Court` AS `Court`, `r`.`Date` AS `Verdict_Date`, concat_ws(' ',`cp`.`First_name`,`cp`.`Last_name`,`cp`.`suffix`) AS `Created_By`, `logs`.`USER_ID` AS `Creator_ID`, `dc`.`Comment` AS `Denial_Comment` FROM ((((((((((((`resolution` `r` left join `involved_party` `ic` on(`r`.`Docket_Number` = `ic`.`Docket_Number` and `ic`.`Role` = 'Complainant')) left join `person` `c` on(`ic`.`PERSON_ID` = `c`.`PERSON_ID`)) left join `involved_party` `ir` on(`r`.`Docket_Number` = `ir`.`Docket_Number` and `ir`.`Role` = 'Respondent')) left join `person` `rps` on(`ir`.`PERSON_ID` = `rps`.`PERSON_ID`)) left join `subpoena` `s` on(`r`.`Docket_Number` = `s`.`Docket_Number`)) left join `prosecutor` `pr` on(`s`.`PROSECUTOR_ID` = `pr`.`PROSECUTOR_ID`)) left join `person` `p` on(`pr`.`PERSON_ID` = `p`.`PERSON_ID`)) left join (select `so`.`Docket_Number` AS `Docket_Number`,group_concat(`o`.`name` order by `o`.`name` ASC separator ', ') AS `Crimes` from (`subpoena_offense` `so` join `offense` `o` on(`so`.`offense_id` = `o`.`offense_id`)) group by `so`.`Docket_Number`) `c2` on(`s`.`Docket_Number` = `c2`.`Docket_Number`)) left join (select `l`.`USER_ID` AS `USER_ID`,trim(substring_index(substring_index(`l`.`Action`,'with',1),'Created Resolution for ',-1)) AS `Docket_Num` from `log_table` `l` where `l`.`Action` like 'Created Resolution for %' and `l`.`Timestamp` = (select max(`l2`.`Timestamp`) from `log_table` `l2` where `l2`.`Action` like 'Created Resolution for %' and trim(substring_index(substring_index(`l2`.`Action`,'with',1),'Created Resolution for ',-1)) = trim(substring_index(substring_index(`l`.`Action`,'with',1),'Created Resolution for ',-1)))) `logs` on(`logs`.`Docket_Num` = `r`.`Docket_Number`)) left join `user` `u` on(`logs`.`USER_ID` = `u`.`USER_ID`)) left join `person` `cp` on(`u`.`PERSON_ID` = `cp`.`PERSON_ID`)) left join (select `dc1`.`Docket_Number` AS `Docket_Number`,`dc1`.`Comment` AS `Comment` from `denial_comment` `dc1` where `dc1`.`Type` = 'Resolution' and `dc1`.`Timestamp` = (select max(`dc2`.`Timestamp`) from `denial_comment` `dc2` where `dc2`.`Docket_Number` = `dc1`.`Docket_Number` and `dc2`.`Type` = 'Resolution')) `dc` on(`dc`.`Docket_Number` = `r`.`Docket_Number`)) WHERE `r`.`Status` <> 'Approved' GROUP BY `r`.`Docket_Number` ;

-- --------------------------------------------------------

--
-- Structure for view `view_verify_subpoenas`
--
DROP TABLE IF EXISTS `view_verify_subpoenas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_verify_subpoenas`  AS SELECT `s`.`Docket_Number` AS `Docket_Number`, `s`.`Status` AS `Status`, `c`.`Crimes` AS `Crimes`, group_concat(distinct concat_ws(' ',`cp`.`First_name`,`cp`.`Last_name`,`cp`.`suffix`) order by `cp`.`First_name` ASC,`cp`.`Last_name` ASC separator ',') AS `Complainants`, group_concat(distinct concat_ws(' ',`rp`.`First_name`,`rp`.`Last_name`,`rp`.`suffix`) order by `rp`.`First_name` ASC,`rp`.`Last_name` ASC separator ',') AS `Respondents`, `s`.`Police_Station` AS `Police_Station`, date_format(`s`.`Date`,'%M %e, %Y') AS `Date_`, `s`.`Hearing_Date_1` AS `Hearing_Date_1`, `s`.`Hearing_Date_2` AS `Hearing_Date_2`, concat_ws(' ',`prs`.`First_name`,`prs`.`Last_name`,`prs`.`suffix`) AS `Prosecutor`, `pr`.`PERSON_ID` AS `Prosecutor_Person_ID`, concat_ws(' ',`cr`.`First_name`,`cr`.`Last_name`,`cr`.`suffix`) AS `Created_By`, `logs`.`USER_ID` AS `Creator_ID` FROM ((((((((((`subpoena` `s` left join (select `so`.`Docket_Number` AS `Docket_Number`,group_concat(`o`.`name` order by `o`.`name` ASC separator ', ') AS `Crimes` from (`subpoena_offense` `so` join `offense` `o` on(`so`.`offense_id` = `o`.`offense_id`)) group by `so`.`Docket_Number`) `c` on(`s`.`Docket_Number` = `c`.`Docket_Number`)) left join `involved_party` `ic` on(`s`.`Docket_Number` = `ic`.`Docket_Number` and `ic`.`Role` = 'Complainant')) left join `person` `cp` on(`ic`.`PERSON_ID` = `cp`.`PERSON_ID`)) left join `involved_party` `ir` on(`s`.`Docket_Number` = `ir`.`Docket_Number` and `ir`.`Role` = 'Respondent')) left join `person` `rp` on(`ir`.`PERSON_ID` = `rp`.`PERSON_ID`)) left join `prosecutor` `pr` on(`s`.`PROSECUTOR_ID` = `pr`.`PROSECUTOR_ID`)) left join `person` `prs` on(`pr`.`PERSON_ID` = `prs`.`PERSON_ID`)) left join (select `l1`.`USER_ID` AS `USER_ID`,substring_index(`l1`.`Action`,'Created subpoena ',-1) AS `Docket_Num` from `log_table` `l1` where `l1`.`Action` like 'Created subpoena %') `logs` on(`logs`.`Docket_Num` = `s`.`Docket_Number`)) left join `user` `u` on(`logs`.`USER_ID` = `u`.`USER_ID`)) left join `person` `cr` on(`u`.`PERSON_ID` = `cr`.`PERSON_ID`)) WHERE `s`.`Status` <> 'Approved' GROUP BY `s`.`Docket_Number` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`Address_ID`),
  ADD KEY `PERSON_ID` (`PERSON_ID`);

--
-- Indexes for table `denial_comment`
--
ALTER TABLE `denial_comment`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Docket_Number` (`Docket_Number`),
  ADD KEY `Created_By` (`Created_By`);

--
-- Indexes for table `involved_party`
--
ALTER TABLE `involved_party`
  ADD PRIMARY KEY (`PERSON_ID`,`Docket_Number`),
  ADD KEY `Docket_Number` (`Docket_Number`);

--
-- Indexes for table `log_table`
--
ALTER TABLE `log_table`
  ADD PRIMARY KEY (`LOG_ID`),
  ADD KEY `USER_ID` (`USER_ID`);

--
-- Indexes for table `offense`
--
ALTER TABLE `offense`
  ADD PRIMARY KEY (`offense_id`);

--
-- Indexes for table `password`
--
ALTER TABLE `password`
  ADD PRIMARY KEY (`PASSWORD_ID`),
  ADD KEY `USER_ID` (`USER_ID`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`PERSON_ID`);

--
-- Indexes for table `pin_code`
--
ALTER TABLE `pin_code`
  ADD PRIMARY KEY (`PIN_CODE`),
  ADD KEY `Docket_Number` (`Docket_Number`);

--
-- Indexes for table `prosecutor`
--
ALTER TABLE `prosecutor`
  ADD PRIMARY KEY (`PROSECUTOR_ID`),
  ADD KEY `PERSON_ID` (`PERSON_ID`);

--
-- Indexes for table `resolution`
--
ALTER TABLE `resolution`
  ADD PRIMARY KEY (`RESOLUTION_ID`),
  ADD KEY `Docket_Number` (`Docket_Number`);

--
-- Indexes for table `subpoena`
--
ALTER TABLE `subpoena`
  ADD PRIMARY KEY (`Docket_Number`),
  ADD KEY `PROSECUTOR_ID` (`PROSECUTOR_ID`);

--
-- Indexes for table `subpoena_offense`
--
ALTER TABLE `subpoena_offense`
  ADD PRIMARY KEY (`Docket_Number`,`offense_id`),
  ADD KEY `offense_id` (`offense_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`USER_ID`),
  ADD KEY `PERSON_ID` (`PERSON_ID`);

--
-- Indexes for table `username`
--
ALTER TABLE `username`
  ADD PRIMARY KEY (`USERNAME_ID`),
  ADD KEY `USER_ID` (`USER_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `Address_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=652;

--
-- AUTO_INCREMENT for table `denial_comment`
--
ALTER TABLE `denial_comment`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `log_table`
--
ALTER TABLE `log_table`
  MODIFY `LOG_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=677;

--
-- AUTO_INCREMENT for table `offense`
--
ALTER TABLE `offense`
  MODIFY `offense_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `password`
--
ALTER TABLE `password`
  MODIFY `PASSWORD_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `person`
--
ALTER TABLE `person`
  MODIFY `PERSON_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=647;

--
-- AUTO_INCREMENT for table `prosecutor`
--
ALTER TABLE `prosecutor`
  MODIFY `PROSECUTOR_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `resolution`
--
ALTER TABLE `resolution`
  MODIFY `RESOLUTION_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `USER_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `username`
--
ALTER TABLE `username`
  MODIFY `USERNAME_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`PERSON_ID`) REFERENCES `person` (`PERSON_ID`);

--
-- Constraints for table `denial_comment`
--
ALTER TABLE `denial_comment`
  ADD CONSTRAINT `denial_comment_ibfk_1` FOREIGN KEY (`Docket_Number`) REFERENCES `subpoena` (`Docket_Number`),
  ADD CONSTRAINT `denial_comment_ibfk_2` FOREIGN KEY (`Created_By`) REFERENCES `user` (`USER_ID`);

--
-- Constraints for table `involved_party`
--
ALTER TABLE `involved_party`
  ADD CONSTRAINT `involved_party_ibfk_1` FOREIGN KEY (`PERSON_ID`) REFERENCES `person` (`PERSON_ID`),
  ADD CONSTRAINT `involved_party_ibfk_2` FOREIGN KEY (`Docket_Number`) REFERENCES `subpoena` (`Docket_Number`);

--
-- Constraints for table `log_table`
--
ALTER TABLE `log_table`
  ADD CONSTRAINT `log_table_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`);

--
-- Constraints for table `password`
--
ALTER TABLE `password`
  ADD CONSTRAINT `password_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pin_code`
--
ALTER TABLE `pin_code`
  ADD CONSTRAINT `pin_code_ibfk_1` FOREIGN KEY (`Docket_Number`) REFERENCES `subpoena` (`Docket_Number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prosecutor`
--
ALTER TABLE `prosecutor`
  ADD CONSTRAINT `prosecutor_ibfk_1` FOREIGN KEY (`PERSON_ID`) REFERENCES `person` (`PERSON_ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `resolution`
--
ALTER TABLE `resolution`
  ADD CONSTRAINT `resolution_ibfk_1` FOREIGN KEY (`Docket_Number`) REFERENCES `subpoena` (`Docket_Number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `subpoena`
--
ALTER TABLE `subpoena`
  ADD CONSTRAINT `subpoena_ibfk_1` FOREIGN KEY (`PROSECUTOR_ID`) REFERENCES `prosecutor` (`PROSECUTOR_ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `subpoena_offense`
--
ALTER TABLE `subpoena_offense`
  ADD CONSTRAINT `subpoena_offense_ibfk_1` FOREIGN KEY (`Docket_Number`) REFERENCES `subpoena` (`Docket_Number`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `subpoena_offense_ibfk_2` FOREIGN KEY (`offense_id`) REFERENCES `offense` (`offense_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`PERSON_ID`) REFERENCES `person` (`PERSON_ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `username`
--
ALTER TABLE `username`
  ADD CONSTRAINT `username_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
