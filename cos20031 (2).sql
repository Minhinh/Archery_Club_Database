-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 18, 2024 at 07:13 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12
create DATABASE archery_club_DB;
use archery_club_DB;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cos20031`
--

-- --------------------------------------------------------

DROP TABLE IF EXISTS class;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS archer;
DROP TABLE IF EXISTS roundshoot;
DROP TABLE IF EXISTS competition;
DROP TABLE IF EXISTS rounddefinition;
DROP TABLE IF EXISTS rangenumber;
DROP TABLE IF EXISTS roundrange;
DROP TABLE IF EXISTS endscore;
DROP TABLE IF EXISTS targetfacesize;


-- --------------------------------------------------------
--
-- Table structure for table `archer`
--

CREATE TABLE archer (
  Archer_ID INT NOT NULL,
  Archer_FirstName varchar(50) DEFAULT NULL,
  Archer_LastName varchar(50) DEFAULT NULL,
  Age INT NOT NULL,
  Gender varchar(10) DEFAULT NULL
);

CREATE TABLE category (
  CategoryID INT NOT NULL,
  ClassID INT NOT NULL,
  EquipmentID INT NOT NULL
);

CREATE TABLE class (
  ClassID INT NOT NULL,
  Age_group varchar(50) NOT NULL,
  Gender varchar(10) DEFAULT NULL
);

CREATE TABLE competition (
  CompetitionID INT NOT NULL,
  CategoryID INT,
  Description varchar(255) DEFAULT NULL,
  IsYearlyChampionship boolean NOT NULL,
  RoundDefinitionID VARCHAR(50) NOT NULL
);

CREATE TABLE endscoretable (
  EndID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Arrow1 INT DEFAULT NULL,
  Arrow2 INT DEFAULT NULL,
  Arrow3 INT DEFAULT NULL,
  Arrow4 INT DEFAULT NULL,
  Arrow5 INT DEFAULT NULL,
  Arrow6 INT DEFAULT NULL,
  TotalEndScore INT DEFAULT NULL,
  RoundRangeID INT NOT NULL
);

CREATE TABLE equipment (
  EquipmentID INT NOT NULL,
  EquipmentName varchar(30) NOT NULL
);

CREATE TABLE rounddefinition (
  RoundDefinitionID VARCHAR(50) NOT NULL,
  PossibleScore INT NOT NULL,
  TotalArrows INT NOT NULL
);

CREATE TABLE roundrange (
  RoundRangeID INT NOT NULL,
  RoundDefinitionID VARCHAR(50) NOT NULL,
  RangeNumberID INT NOT NULL,
  Number_of_Ends INT NOT NULL,
  Number_of_Arrows INT NOT NULL,
  TargetFaceID INT NOT NULL
);

CREATE TABLE roundshoot (
  RoundShootID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  EquipmentID INT NOT NULL,
  CompetitionID INT NOT NULL,
  Shoot_Date date DEFAULT NULL,
  Shoot_Time time DEFAULT NULL,
  EndID INT NOT NULL,
  Archer_ID INT NOT NULL
);

CREATE TABLE targetfacesize (
  TargetFaceID INT NOT NULL,
  Target_Face_Size enum('80cm','122cm') NOT NULL
);

CREATE TABLE rangenumber (
  RangeNumberID INT NOT NULL,
  RangeDesciption varchar(50) NOT NULL,
  Distance_in_metre int(10) NOT NULL
);

ALTER TABLE archer
  ADD PRIMARY KEY (Archer_ID);

ALTER TABLE category
  ADD PRIMARY KEY (CategoryID);

ALTER TABLE class
  ADD PRIMARY KEY (ClassID);

ALTER TABLE competition
  ADD PRIMARY KEY (CompetitionID);

ALTER TABLE equipment
  ADD PRIMARY KEY (EquipmentID);

ALTER TABLE rounddefinition
  ADD PRIMARY KEY (RoundDefinitionID);

ALTER TABLE roundrange
  ADD PRIMARY KEY (RoundRangeID);

ALTER TABLE targetfacesize
  ADD PRIMARY KEY (TargetFaceID);

ALTER TABLE rangenumber
  ADD PRIMARY KEY (RangeNumberID);

ALTER TABLE category
  ADD CONSTRAINT category_ibfk_1 FOREIGN KEY (ClassID) REFERENCES class (ClassID),
  ADD CONSTRAINT category_ibfk_2 FOREIGN KEY (EquipmentID) REFERENCES equipment (EquipmentID);

ALTER TABLE competition
  ADD CONSTRAINT competition_ibfk_1 FOREIGN KEY (CategoryID) REFERENCES category (CategoryID),
  ADD CONSTRAINT competition_ibfk_2 FOREIGN KEY (RoundDefinitionID) REFERENCES rounddefinition (RoundDefinitionID);

ALTER TABLE endscoretable
  ADD CONSTRAINT endscore_ibfk_1 FOREIGN KEY (RoundRangeID) REFERENCES RoundRange (RoundRangeID);

ALTER TABLE roundrange
  ADD CONSTRAINT roundrange_ibfk_1 FOREIGN KEY (RoundDefinitionID) REFERENCES rounddefinition (RoundDefinitionID),
  ADD CONSTRAINT roundrange_ibfk_2 FOREIGN KEY (RangeNumberID) REFERENCES rangenumber (RangeNumberID),
  ADD CONSTRAINT roundrange_ibfk_3 FOREIGN KEY (TargetFaceID) REFERENCES targetfacesize (TargetFaceID);

ALTER TABLE roundshoot
  ADD CONSTRAINT roundshoot_ibfk_1 FOREIGN KEY (EquipmentID) REFERENCES equipment (EquipmentID),
  ADD CONSTRAINT roundshoot_ibfk_2 FOREIGN KEY (CompetitionID) REFERENCES competition (CompetitionID),
  ADD CONSTRAINT roundshoot_ibfk_3 FOREIGN KEY (Archer_ID) REFERENCES archer (Archer_ID),
  ADD CONSTRAINT roundshoot_ibfk_4 FOREIGN KEY (EndID) REFERENCES endscoretable (EndID);

COMMIT;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;




-- Insert into table class --

INSERT INTO class VALUES (1, 'Open', 'Female');
INSERT INTO class VALUES (2, 'Open', 'Male');
INSERT INTO class VALUES (3, '50+', 'Female');
INSERT INTO class VALUES (4, '50+', 'Male');
INSERT INTO class VALUES (5, '60+', 'Female');
INSERT INTO class VALUES (6, '60+', 'Male');
INSERT INTO class VALUES (7, '70+', 'Female');
INSERT INTO class VALUES (8, '70+', 'Male');
INSERT INTO class VALUES (9, 'Under 21', 'Female');
INSERT INTO class VALUES (10, 'Under 21', 'Male');
INSERT INTO class VALUES (11, 'Under 18', 'Female');
INSERT INTO class VALUES (12, 'Under 18', 'Male');
INSERT INTO class VALUES (13, 'Under 16', 'Female');
INSERT INTO class VALUES (14, 'Under 16', 'Male');
INSERT INTO class VALUES (15, 'Under 14', 'Female');
INSERT INTO class VALUES (16, 'Under 14', 'Male');


-- Insert into table equipment --
INSERT INTO equipment VALUES (1, 'Recurve');
INSERT INTO equipment VALUES (2, 'Compound');
INSERT INTO equipment VALUES (3, 'Recurve Barebow');
INSERT INTO equipment VALUES (4, 'Compound Barebow');
INSERT INTO equipment VALUES (5, 'Longbow');


-- Insert into table rounddefinition -- 
INSERT INTO rounddefinition VALUES ('WA90/1440',1440, 144);
INSERT INTO rounddefinition VALUES ('WA70/1440',1440, 144);
INSERT INTO rounddefinition VALUES ('WA60/1440',1440, 144);
INSERT INTO rounddefinition VALUES ('AA50/1440',1440, 144);
INSERT INTO rounddefinition VALUES ('AA40/1440',1440, 144);
INSERT INTO rounddefinition VALUES ('Long Sydney',1200, 120);
INSERT INTO rounddefinition VALUES ('Sydney',1200, 120);
INSERT INTO rounddefinition VALUES ('Long Brisbane',1200, 120);
INSERT INTO rounddefinition VALUES ('Brisbane',1200, 120);
INSERT INTO rounddefinition VALUES ('Adelaide',1200, 120);
INSERT INTO rounddefinition VALUES ('Short Adelaide',1200, 120);
INSERT INTO rounddefinition VALUES ('Hobart',900, 90);
INSERT INTO rounddefinition VALUES ('Perth',900, 90);


-- Insert into category table --
-- Male Open --
INSERT INTO category VALUES (1, 2, 1);
INSERT INTO category VALUES (2, 2, 2);
INSERT INTO category VALUES (3, 2, 3);
INSERT INTO category VALUES (4, 2, 4);
INSERT INTO category VALUES (5, 2, 5);
-- Female Open --
INSERT INTO category VALUES (6, 1, 1);
INSERT INTO category VALUES (7, 1, 2);
INSERT INTO category VALUES (8, 1, 3);
INSERT INTO category VALUES (9, 1, 4);
INSERT INTO category VALUES (10, 1, 5);
-- 50+ Male  --
INSERT INTO category VALUES (11, 4, 1);
INSERT INTO category VALUES (12, 4, 2);
INSERT INTO category VALUES (13, 4, 3);
INSERT INTO category VALUES (14, 4, 4);
INSERT INTO category VALUES (15, 4, 5);
-- 50+ Female  --
INSERT INTO category VALUES (16, 3, 1);
INSERT INTO category VALUES (17, 3, 2);
INSERT INTO category VALUES (18, 3, 3);
INSERT INTO category VALUES (19, 3, 4);
INSERT INTO category VALUES (20, 3, 5);
-- 60+ Male  --
INSERT INTO category VALUES (21, 6, 1);
INSERT INTO category VALUES (22, 6, 2);
INSERT INTO category VALUES (23, 6, 3);
INSERT INTO category VALUES (24, 6, 4);
INSERT INTO category VALUES (25, 6, 5);
-- 60+ Female  --
INSERT INTO category VALUES (26, 5, 1);
INSERT INTO category VALUES (27, 5, 2);
INSERT INTO category VALUES (28, 5, 3);
INSERT INTO category VALUES (29, 5, 4);
INSERT INTO category VALUES (30, 5, 5);
-- 70+ Male  --
INSERT INTO category VALUES (31, 8, 1);
INSERT INTO category VALUES (32, 8, 2);
INSERT INTO category VALUES (33, 8, 3);
INSERT INTO category VALUES (34, 8, 4);
INSERT INTO category VALUES (35, 8, 5);
-- 70+ Female  --
INSERT INTO category VALUES (36, 7, 1);
INSERT INTO category VALUES (37, 7, 2);
INSERT INTO category VALUES (38, 7, 3);
INSERT INTO category VALUES (39, 7, 4);
INSERT INTO category VALUES (40, 7, 5);
-- Under 21 Male  --
INSERT INTO category VALUES (41, 10, 1);
INSERT INTO category VALUES (42, 10, 2);
INSERT INTO category VALUES (43, 10, 3);
INSERT INTO category VALUES (44, 10, 4);
INSERT INTO category VALUES (45, 10, 5);
-- Under 21 Female  --
INSERT INTO category VALUES (46, 9, 1);
INSERT INTO category VALUES (47, 9, 2);
INSERT INTO category VALUES (48, 9, 3);
INSERT INTO category VALUES (49, 9, 4);
INSERT INTO category VALUES (50, 9, 5);
-- Under 18 Male  --
INSERT INTO category VALUES (51, 12, 1);
INSERT INTO category VALUES (52, 12, 2);
INSERT INTO category VALUES (53, 12, 1);
INSERT INTO category VALUES (54, 12, 2);
INSERT INTO category VALUES (55, 12, 3);
INSERT INTO category VALUES (56, 12, 4);
INSERT INTO category VALUES (57, 12, 5);
-- Under 18 Female  --
INSERT INTO category VALUES (58, 11, 1);
INSERT INTO category VALUES (59, 11, 2);
INSERT INTO category VALUES (60, 11, 3);
INSERT INTO category VALUES (61, 11, 4);
INSERT INTO category VALUES (62, 11, 5);
-- Under 16 Male  --
INSERT INTO category VALUES (63, 14, 1);
INSERT INTO category VALUES (64, 14, 2);
INSERT INTO category VALUES (65, 14, 3);
INSERT INTO category VALUES (66, 14, 4);
INSERT INTO category VALUES (67, 14, 5);
-- Under 16 Female  --
INSERT INTO category VALUES (68, 13, 1);
INSERT INTO category VALUES (69, 13, 2);
INSERT INTO category VALUES (70, 13, 3);
INSERT INTO category VALUES (71, 13, 4);
INSERT INTO category VALUES (72, 13, 5);
-- Under 14 Male  --
INSERT INTO category VALUES (73, 16, 1);
INSERT INTO category VALUES (74, 16, 2);
INSERT INTO category VALUES (75, 16, 3);
INSERT INTO category VALUES (76, 16, 4);
INSERT INTO category VALUES (77, 16, 5);
-- Under 14 Female  --
INSERT INTO category VALUES (78, 15, 1);
INSERT INTO category VALUES (79, 15, 2);
INSERT INTO category VALUES (80, 15, 3);
INSERT INTO category VALUES (81, 15, 4);
INSERT INTO category VALUES (82, 15, 5);



-- Insert into competition table --
INSERT INTO competition VALUES(1, NULL, "Practise WA90/1440", FALSE, 'WA90/1440');
INSERT INTO competition VALUES(2, NULL, "Practise WA70/1440", FALSE, 'WA70/1440');
INSERT INTO competition VALUES(3, NULL, "Practise WA60/1440", FALSE, 'WA60/1440');
INSERT INTO competition VALUES(4, NULL, "Practise AA50/1440", FALSE, 'AA50/1440');
INSERT INTO competition VALUES(5, NULL, "Practise AA40/1440", FALSE, 'AA40/1440');
INSERT INTO competition VALUES(6, NULL, "Practise Long Sydney", FALSE, 'Long Sydney');
INSERT INTO competition VALUES(7, NULL, "Practise Sydney", FALSE, 'Sydney');
INSERT INTO competition VALUES(8, NULL, "Practise Long Brisbane", FALSE, 'Long Brisbane');
INSERT INTO competition VALUES(9, NULL, "Practise Brisbane", FALSE, 'Brisbane');
INSERT INTO competition VALUES(10, NULL, "Practise Adelaide", FALSE, 'Adelaide');
INSERT INTO competition VALUES(11, NULL, "Practise Short Adelaide", FALSE, 'Short Adelaide');
INSERT INTO competition VALUES(12, NULL, "Practise Hobart", FALSE, 'Hobart');
INSERT INTO competition VALUES(13, NULL, "Practise Perth", FALSE, 'Perth');
INSERT INTO competition VALUES(14, 1, "Male Open Recurve", TRUE, "WA90/1440");
INSERT INTO competition VALUES(15, 2, "Male Open Compound", TRUE, "WA90/1440");
INSERT INTO competition VALUES(16, 3, "Male Open Recurve Barebow", FALSE, "WA70/1440");
INSERT INTO competition VALUES(17, 4, "Male Open Compound Barebow", FALSE, "WA70/1440");
INSERT INTO competition VALUES(18, 5, "Male Open Longbow", TRUE, "WA60/1440");
INSERT INTO competition VALUES(19, 6, "Female Open Recurve", TRUE, "WA70/1440");
INSERT INTO competition VALUES(20, 7, "Female Open Compound", TRUE, "WA70/1440");
INSERT INTO competition VALUES(21, 8, "Female Open Recurve Barebow", FALSE, "WA60/1440");
INSERT INTO competition VALUES(22, 9, "Female Open Compound Barebow", FALSE, "WA60/1440");
INSERT INTO competition VALUES(23, 10, "Female Open Longbow", TRUE, "AA50/1440");

INSERT INTO competition VALUES(24, 11, "Male 50+ Recurve", TRUE, "WA70/1440");
INSERT INTO competition VALUES(25, 12, "Male 50+ Compound", TRUE, "WA70/1440");
INSERT INTO competition VALUES(26, 13, "Male 50+ Recurve Barebow", FALSE, "WA60/1440");
INSERT INTO competition VALUES(27, 14, "Male 50+ Compound Barebow", FALSE, "WA60/1440");
INSERT INTO competition VALUES(28, 15, "Male 50+ Longbow", TRUE, "AA50/1440");
INSERT INTO competition VALUES(29, 16, "Female 50+ Recurve", TRUE, "WA60/1440");
INSERT INTO competition VALUES(30, 17, "Female 50+ Compound", TRUE, "WA60/1440");
INSERT INTO competition VALUES(31, 18, "Female 50+ Recurve Barebow", TRUE, "WA60/1440");
INSERT INTO competition VALUES(32, 19, "Female 50+ Compound Barebow", TRUE, "WA60/1440");
INSERT INTO competition VALUES(33, 20, "Female 50+ Longbow", FALSE, "AA50/1440");

INSERT INTO competition VALUES(34, 21, "Male 60+ Recurve", TRUE, "WA60/1440");
INSERT INTO competition VALUES(35, 22, "Male 60+ Compound", TRUE, "WA60/1440");
INSERT INTO competition VALUES(36, 23, "Male 60+ Recurve Barebow", TRUE, "WA60/1440");
INSERT INTO competition VALUES(37, 24, "Male 60+ Compound Barebow", TRUE, "WA60/1440");
INSERT INTO competition VALUES(38, 25, "Male 60+ Longbow", TRUE, "AA50/1440");
INSERT INTO competition VALUES(39, 26, "Female 60+ Recurve", TRUE, "AA50/1440");
INSERT INTO competition VALUES(40, 27, "Female 60+ Compound", TRUE, "AA50/1440");
INSERT INTO competition VALUES(41, 28, "Female 60+ Recurve Barebow", FALSE, "AA50/1440");
INSERT INTO competition VALUES(42, 29, "Female 60+ Compound Barebow", FALSE, "AA50/1440");
INSERT INTO competition VALUES(43, 30, "Female 60+ Longbow", TRUE, "AA50/1440");

INSERT INTO competition VALUES(44, 31, "Male 70+ Recurve", TRUE, "WA60/1440");
INSERT INTO competition VALUES(45, 32, "Male 70+ Compound", TRUE, "WA60/1440");
INSERT INTO competition VALUES(46, 33, "Male 70+ Recurve Barebow", FALSE, "WA60/1440");
INSERT INTO competition VALUES(47, 34, "Male 70+ Compound Barebow", FALSE, "WA60/1440");
INSERT INTO competition VALUES(48, 35, "Male 70+ Longbow", TRUE, "AA50/1440");
INSERT INTO competition VALUES(49, 36, "Female 70+ Recurve", TRUE, "AA50/1440");
INSERT INTO competition VALUES(50, 37, "Female 70+ Compound", TRUE, "AA50/1440");
INSERT INTO competition VALUES(51, 38, "Female 70+ Recurve Barebow", FALSE, "AA50/1440");
INSERT INTO competition VALUES(52, 39, "Female 70+ Compound Barebow", FALSE, "AA50/1440");
INSERT INTO competition VALUES(53, 40, "Female 70+ Longbow", TRUE, "AA50/1440");

INSERT INTO competition VALUES(54, 41, "Male Under 21 Recurve", TRUE, "WA90/1440");
INSERT INTO competition VALUES(55, 42, "Male Under 21 Compound", TRUE, "WA90/1440");
INSERT INTO competition VALUES(56, 43, "Male Under 21 Recurve Barebow", TRUE, "WA70/1440");
INSERT INTO competition VALUES(57, 44, "Male Under 21 Compound Barebow", TRUE, "WA70/1440");
INSERT INTO competition VALUES(58, 45, "Male Under 21 Longbow", TRUE, "WA60/1440");
INSERT INTO competition VALUES(59, 46, "Female Under 21 Recurve", TRUE, "WA70/1440");
INSERT INTO competition VALUES(60, 47, "Female Under 21 Compound", TRUE, "WA70/1440");
INSERT INTO competition VALUES(61, 48, "Female Under 21 Recurve Barebow", TRUE, "WA60/1440");
INSERT INTO competition VALUES(62, 49, "Female Under 21 Compound Barebow", TRUE, "WA60/1440");
INSERT INTO competition VALUES(63, 50, "Female Under 21 Longbow", TRUE, "AA50/1440");

INSERT INTO competition VALUES(64, 51, "Male Under 18 Recurve", TRUE, "WA70/1440");
INSERT INTO competition VALUES(65, 52, "Male Under 18 Compound", TRUE, "WA70/1440");
INSERT INTO competition VALUES(66, 53, "Male Under 18 Recurve Barebow", TRUE, "WA60/1440");
INSERT INTO competition VALUES(67, 54, "Male Under 18 Compound Barebow", TRUE, "WA60/1440");
INSERT INTO competition VALUES(68, 55, "Male Under 18 Recurve", TRUE, "WA60/1440");
INSERT INTO competition VALUES(69, 56, "Male Under 18 Compound", TRUE, "WA60/1440");
INSERT INTO competition VALUES(70, 57, "Male Under 18 Longbow", TRUE, "AA50/1440");
INSERT INTO competition VALUES(71, 58, "Female Under 18 Recurve", TRUE, "WA60/1440");
INSERT INTO competition VALUES(72, 59, "Female Under 18 Compound", TRUE, "WA60/1440");
INSERT INTO competition VALUES(73, 60, "Female Under 18 Recurve Barebow", TRUE, "AA50/1440");
INSERT INTO competition VALUES(74, 61, "Female Under 18 Compound Barebow", TRUE, "AA50/1440");
INSERT INTO competition VALUES(75, 62, "Female Under 18 Longbow", TRUE, "AA50/1440");

INSERT INTO competition VALUES(76, 63, "Male Under 16 Recurve", TRUE, "AA50/1440");
INSERT INTO competition VALUES(77, 64, "Male Under 16 Compound", TRUE, "AA50/1440");
INSERT INTO competition VALUES(78, 65, "Male Under 16 Recurve Barebow", TRUE, "AA40/1440");
INSERT INTO competition VALUES(79, 66, "Male Under 16 Compound Barebow", TRUE, "AA40/1440");
INSERT INTO competition VALUES(80, 67, "Male Under 16 Longbow", TRUE, "AA40/1440");
INSERT INTO competition VALUES(81, 68, "Female Under 16 Recurve", TRUE, "AA50/1440");
INSERT INTO competition VALUES(82, 69, "Female Under 16 Compound", TRUE, "AA50/1440");
INSERT INTO competition VALUES(83, 70, "Female Under 16 Recurve Barebow", TRUE, "AA40/1440");
INSERT INTO competition VALUES(84, 71, "Female Under 16 Compound Barebow", TRUE, "AA40/1440");
INSERT INTO competition VALUES(85, 72, "Female Under 16 Longbow", TRUE, "AA40/1440");


INSERT INTO competition VALUES(86, 73, "Male Under 14 Recurve", TRUE, "AA40/1440");
INSERT INTO competition VALUES(87, 74, "Male Under 14 Compound", TRUE, "AA40/1440");
INSERT INTO competition VALUES(88, 75, "Male Under 14 Recurve Barebow", TRUE, "AA40/1440");
INSERT INTO competition VALUES(89, 76, "Male Under 14 Compound Barebow", TRUE, "AA40/1440");
INSERT INTO competition VALUES(90, 77, "Male Under 14 Longbow", TRUE, "AA40/1440");
INSERT INTO competition VALUES(91, 78, "Female Under 14 Recurve", TRUE, "AA40/1440");
INSERT INTO competition VALUES(92, 79, "Female Under 14 Compound", TRUE, "AA40/1440");
INSERT INTO competition VALUES(93, 80, "Female Under 14 Recurve Barebow", TRUE, "AA40/1440");
INSERT INTO competition VALUES(94, 81, "Female Under 14 Compound Barebow", TRUE, "AA40/1440");
INSERT INTO competition VALUES(95, 82, "Female Under 14 Longbow", TRUE, "AA40/1440");


-- Insert into RangNumber --
INSERT INTO rangenumber VALUES(1, "Range 1", 90);
INSERT INTO rangenumber VALUES(2, "Range 2", 70);
INSERT INTO rangenumber VALUES(3, "Range 3", 60);
INSERT INTO rangenumber VALUES(4, "Range 4", 50);
INSERT INTO rangenumber VALUES(5, "Range 5", 40);
INSERT INTO rangenumber VALUES(6, "Range 6", 30);
INSERT INTO rangenumber VALUES(7, "Range 7", 20);
INSERT INTO rangenumber VALUES(8, "Range 8", 10);


-- Insert into Target Face Size table --
INSERT INTO targetfacesize VALUES (1, '80');
INSERT INTO targetfacesize VALUES (2, '122');


-- Create roundrange table --

-- WA90/1440--
INSERT INTO roundrange VALUES(1, "WA90/1440", 1, 6, 36, 2);
INSERT INTO roundrange VALUES(2, "WA90/1440", 2, 6, 36, 2);
INSERT INTO roundrange VALUES(3, "WA90/1440", 4, 6, 36, 1);
INSERT INTO roundrange VALUES(4, "WA90/1440", 6, 6, 36, 1);
-- WA70/1440--
INSERT INTO roundrange VALUES(5, "WA70/1440", 2, 6, 36, 2);
INSERT INTO roundrange VALUES(6, "WA70/1440", 3, 6, 36, 2);
INSERT INTO roundrange VALUES(7, "WA70/1440", 4, 6, 36, 1);
INSERT INTO roundrange VALUES(8, "WA70/1440", 6, 6, 36, 1);
-- WA60/1440--
INSERT INTO roundrange VALUES(9, "WA60/1440", 3, 6, 36, 2);
INSERT INTO roundrange VALUES(10, "WA60/1440", 4, 6, 36, 2);
INSERT INTO roundrange VALUES(11, "WA60/1440", 5, 6, 36, 1);
INSERT INTO roundrange VALUES(12, "WA60/1440", 6, 6, 36, 1);
-- AA50/1440--
INSERT INTO roundrange VALUES(13, "AA50/1440", 4, 6, 36, 2);
INSERT INTO roundrange VALUES(14, "AA50/1440", 5, 6, 36, 2);
INSERT INTO roundrange VALUES(15, "AA50/1440", 6, 6, 36, 1);
INSERT INTO roundrange VALUES(16, "AA50/1440", 7, 6, 36, 1);
-- AA40/1440--
INSERT INTO roundrange VALUES(17, "AA40/1440", 5, 6, 36, 2);
INSERT INTO roundrange VALUES(18, "AA40/1440", 6, 6, 36, 2);
INSERT INTO roundrange VALUES(19, "AA40/1440", 6, 6, 36, 1);
INSERT INTO roundrange VALUES(20, "AA40/1440", 7, 6, 36, 1);
-- Long Sydney--
INSERT INTO roundrange VALUES(21, "Long Sydney", 1, 5, 30, 2);
INSERT INTO roundrange VALUES(22, "Long Sydney", 2, 5, 30, 2);
INSERT INTO roundrange VALUES(23, "Long Sydney", 3, 5, 30, 2);
INSERT INTO roundrange VALUES(24, "Long Sydney", 4, 5, 30, 2);
-- Sydney--
INSERT INTO roundrange VALUES(25, "Sydney", 2, 5, 30, 2);
INSERT INTO roundrange VALUES(26, "Sydney", 3, 5, 30, 2);
INSERT INTO roundrange VALUES(27, "Sydney", 4, 5, 30, 2);
INSERT INTO roundrange VALUES(28, "Sydney", 5, 5, 30, 2);
-- Long Brisbane--
INSERT INTO roundrange VALUES(29, "Long Brisbane", 1, 5, 30, 2);
INSERT INTO roundrange VALUES(30, "Long Brisbane", 2, 5, 30, 2);
INSERT INTO roundrange VALUES(31, "Long Brisbane", 3, 5, 30, 1);
INSERT INTO roundrange VALUES(32, "Long Brisbane", 4, 5, 30, 1);
-- Brisbane--
INSERT INTO roundrange VALUES(33, "Brisbane", 2, 5, 30, 2);
INSERT INTO roundrange VALUES(34, "Brisbane", 3, 5, 30, 2);
INSERT INTO roundrange VALUES(35, "Brisbane", 4, 5, 30, 1);
INSERT INTO roundrange VALUES(36, "Brisbane", 5, 5, 30, 1);
-- Adelaide--
INSERT INTO roundrange VALUES(37, "Adelaide", 3, 5, 30, 2);
INSERT INTO roundrange VALUES(38, "Adelaide", 4, 5, 30, 2);
INSERT INTO roundrange VALUES(39, "Adelaide", 5, 5, 30, 1);
INSERT INTO roundrange VALUES(40, "Adelaide", 6, 5, 30, 1);
-- Short Adelaide--
INSERT INTO roundrange VALUES(41, "Short Adelaide", 4, 5, 30, 2);
INSERT INTO roundrange VALUES(42, "Short Adelaide", 5, 5, 30, 2);
INSERT INTO roundrange VALUES(43, "Short Adelaide", 6, 5, 30, 1);
INSERT INTO roundrange VALUES(44, "Short Adelaide", 7, 5, 30, 1);
-- Hobart--
INSERT INTO roundrange VALUES(45, "Hobart", 1, 5, 30, 2);
INSERT INTO roundrange VALUES(46, "Hobart", 2, 5, 30, 2);
INSERT INTO roundrange VALUES(47, "Hobart", 4, 5, 30, 2);
-- Perth--
INSERT INTO roundrange VALUES(48, "Perth", 2, 5, 30, 2);
INSERT INTO roundrange VALUES(49, "Perth", 3, 5, 30, 2);
INSERT INTO roundrange VALUES(50, "Perth", 4, 5, 30, 2);



-- insert into Archer Table --
INSERT INTO archer VALUES ('100', 'Aubrey', 'Anderson', 19, 'Female');
INSERT INTO archer VALUES ('101', 'Christopher', 'Hernandez', 18, 'Male');
INSERT INTO archer VALUES ('102', 'Matthew', 'King', 60, 'Female');
INSERT INTO archer VALUES ('103', 'Daniel', 'Baker', 64, 'Female');
INSERT INTO archer VALUES ('104', 'Elizabeth', 'Nelson', 58, 'Female');
INSERT INTO archer VALUES ('105', 'Daniel', 'Adams', 54, 'Female');
INSERT INTO archer VALUES ('106', 'Olivia', 'Wilson', 49, 'Male');
INSERT INTO archer VALUES ('107', 'Alexander', 'Edwards', 62, 'Male');
INSERT INTO archer VALUES ('108', 'Lila', 'Young', 33, 'Male');
INSERT INTO archer VALUES ('109', 'Joshua', 'Wright', 50, 'Male');
INSERT INTO archer VALUES ('110', 'Amelia', 'Hernandez', 39, 'Male');
INSERT INTO archer VALUES ('111', 'Ethan', 'Garcia', 36, 'Female');
INSERT INTO archer VALUES ('112', 'William', 'Lopez', 20, 'Male');
INSERT INTO archer VALUES ('113', 'Jacob', 'Mitchell', 40, 'Female');
INSERT INTO archer VALUES ('114', 'Aubrey', 'Mitchell', 60, 'Male');
INSERT INTO archer VALUES ('115', 'Christopher', 'Baker', 38, 'Male');
INSERT INTO archer VALUES ('116', 'Emma', 'Martinez', 63, 'Female');
INSERT INTO archer VALUES ('117', 'Amelia', 'Lopez', 61, 'Female');
INSERT INTO archer VALUES ('118', 'Sophia', 'Gonzalez', 18, 'Female');
INSERT INTO archer VALUES ('119', 'Mia', 'Robinson', 57, 'Male');
INSERT INTO archer VALUES ('120', 'Brandon', 'Young', 40, 'Male');
INSERT INTO archer VALUES ('121', 'Avery', 'Hall', 45, 'Male');
INSERT INTO archer VALUES ('122', 'Addison', 'Hernandez', 51, 'Male');
INSERT INTO archer VALUES ('123', 'Grace', 'Robinson', 57, 'Female');
INSERT INTO archer VALUES ('124', 'Lila', 'Moore', 22, 'Male');
INSERT INTO archer VALUES ('125', 'Benjamin', 'Collins', 41, 'Female');
INSERT INTO archer VALUES ('126', 'Olivia', 'Taylor', 41, 'Female');
INSERT INTO archer VALUES ('127', 'Lila', 'Hernandez', 64, 'Female');
INSERT INTO archer VALUES ('128', 'Isabella', 'Phillips', 20, 'Female');
INSERT INTO archer VALUES ('129', 'Samuel', 'Nelson', 39, 'Female');
INSERT INTO archer VALUES ('130', 'Nathan', 'Nelson', 20, 'Male');
INSERT INTO archer VALUES ('131', 'Brandon', 'Walker', 26, 'Male');
INSERT INTO archer VALUES ('132', 'John', 'Harris', 56, 'Female');
INSERT INTO archer VALUES ('133', 'Amelia', 'Lee', 19, 'Male');
INSERT INTO archer VALUES ('134', 'Isabella', 'Young', 59, 'Female');
INSERT INTO archer VALUES ('135', 'Adam', 'Hill', 57, 'Male');
INSERT INTO archer VALUES ('136', 'William', 'Thomas', 32, 'Female');
INSERT INTO archer VALUES ('137', 'Ava', 'Rodriguez', 45, 'Female');
INSERT INTO archer VALUES ('138', 'Chloe', 'Lee', 63, 'Male');
INSERT INTO archer VALUES ('139', 'Joseph', 'Gonzalez', 30, 'Female');
INSERT INTO archer VALUES ('140', 'Joseph', 'Rodriguez', 59, 'Male');
INSERT INTO archer VALUES ('141', 'Natalie', 'Anderson', 30, 'Female');
INSERT INTO archer VALUES ('142', 'Isabella', 'Baker', 40, 'Male');
INSERT INTO archer VALUES ('143', 'Sarah', 'Brown', 30, 'Female');
INSERT INTO archer VALUES ('144', 'Avery', 'Moore', 31, 'Male');
INSERT INTO archer VALUES ('145', 'Joseph', 'King', 59, 'Female');
INSERT INTO archer VALUES ('146', 'Adam', 'Roberts', 36, 'Male');
INSERT INTO archer VALUES ('147', 'Andrew', 'Moore', 49, 'Female');
INSERT INTO archer VALUES ('148', 'Christopher', 'Gonzalez', 37, 'Male');
INSERT INTO archer VALUES ('149', 'Elizabeth', 'Collins', 40, 'Male');
INSERT INTO archer VALUES ('150', 'Emily', 'Baker', 18, 'Female');
INSERT INTO archer VALUES ('151', 'Christopher', 'Roberts', 60, 'Female');
INSERT INTO archer VALUES ('152', 'James', 'Baker', 29, 'Female');
INSERT INTO archer VALUES ('153', 'Anthony', 'Allen', 65, 'Male');
INSERT INTO archer VALUES ('154', 'Adam', 'Jones', 26, 'Male');
INSERT INTO archer VALUES ('155', 'Alexander', 'Wright', 31, 'Female');
INSERT INTO archer VALUES ('156', 'Harper', 'Williams', 55, 'Female');
INSERT INTO archer VALUES ('157', 'Sarah', 'Carter', 22, 'Female');
INSERT INTO archer VALUES ('158', 'Alexander', 'Mitchell', 59, 'Female');
INSERT INTO archer VALUES ('159', 'Abigail', 'Lewis', 60, 'Male');
INSERT INTO archer VALUES ('160', 'Ella', 'Hernandez', 21, 'Female');
INSERT INTO archer VALUES ('161', 'Sarah', 'White', 38, 'Female');
INSERT INTO archer VALUES ('162', 'Ava', 'Martinez', 43, 'Male');
INSERT INTO archer VALUES ('163', 'Dylan', 'Williams', 20, 'Female');
INSERT INTO archer VALUES ('164', 'Harper', 'Young', 59, 'Female');
INSERT INTO archer VALUES ('165', 'Hannah', 'Wright', 53, 'Female');
INSERT INTO archer VALUES ('166', 'Joseph', 'Wilson', 65, 'Female');
INSERT INTO archer VALUES ('167', 'Benjamin', 'Harris', 48, 'Male');
INSERT INTO archer VALUES ('168', 'Emma', 'Garcia', 27, 'Female');
INSERT INTO archer VALUES ('169', 'Jacob', 'Young', 38, 'Male');
INSERT INTO archer VALUES ('170', 'Elizabeth', 'Johnson', 18, 'Female');
INSERT INTO archer VALUES ('171', 'Emma', 'White', 55, 'Male');
INSERT INTO archer VALUES ('172', 'Emily', 'Wilson', 31, 'Male');
INSERT INTO archer VALUES ('173', 'Hannah', 'Turner', 55, 'Male');
INSERT INTO archer VALUES ('174', 'Olivia', 'Edwards', 47, 'Female');
INSERT INTO archer VALUES ('175', 'Samuel', 'Scott', 23, 'Male');
INSERT INTO archer VALUES ('176', 'Benjamin', 'Parker', 41, 'Male');
INSERT INTO archer VALUES ('177', 'Abigail', 'Davis', 48, 'Male');
INSERT INTO archer VALUES ('178', 'Aubrey', 'Edwards', 20, 'Female');
INSERT INTO archer VALUES ('179', 'Adam', 'Rodriguez', 50, 'Female');
INSERT INTO archer VALUES ('180', 'Addison', 'Jones', 35, 'Male');
INSERT INTO archer VALUES ('181', 'Hannah', 'Evans', 38, 'Female');
INSERT INTO archer VALUES ('182', 'Dylan', 'Taylor', 41, 'Male');
INSERT INTO archer VALUES ('183', 'David', 'Allen', 47, 'Female');
INSERT INTO archer VALUES ('184', 'Zoey', 'Hill', 58, 'Male');
INSERT INTO archer VALUES ('185', 'Chloe', 'Gonzalez', 34, 'Male');
INSERT INTO archer VALUES ('186', 'John', 'Scott', 54, 'Female');
INSERT INTO archer VALUES ('187', 'Chloe', 'Lee', 50, 'Female');
INSERT INTO archer VALUES ('188', 'Ryan', 'Walker', 30, 'Female');
INSERT INTO archer VALUES ('189', 'Joshua', 'Garcia', 59, 'Male');
INSERT INTO archer VALUES ('190', 'Sarah', 'Green', 29, 'Male');
INSERT INTO archer VALUES ('191', 'Aria', 'Collins', 34, 'Male');
INSERT INTO archer VALUES ('192', 'Matthew', 'Clark', 35, 'Female');
INSERT INTO archer VALUES ('193', 'Ryan', 'Allen', 31, 'Female');
INSERT INTO archer VALUES ('194', 'Aria', 'Green', 31, 'Female');
INSERT INTO archer VALUES ('195', 'Isabella', 'King', 64, 'Male');
INSERT INTO archer VALUES ('196', 'Nathan', 'Green', 64, 'Male');
INSERT INTO archer VALUES ('197', 'Joshua', 'Walker', 24, 'Male');
INSERT INTO archer VALUES ('198', 'Andrew', 'Jones', 60, 'Female');
INSERT INTO archer VALUES ('199', 'Isaac', 'Jones', 31, 'Male');
INSERT INTO archer VALUES ('200', 'Andrew', 'Hill', 65, 'Female');
INSERT INTO archer VALUES ('201', 'Avery', 'Evans', 57, 'Female');
INSERT INTO archer VALUES ('202', 'William', 'King', 32, 'Male');
INSERT INTO archer VALUES ('203', 'Addison', 'Hernandez', 60, 'Male');
INSERT INTO archer VALUES ('204', 'Grace', 'Walker', 35, 'Female');
INSERT INTO archer VALUES ('205', 'Abigail', 'Jones', 58, 'Male');
INSERT INTO archer VALUES ('206', 'Christopher', 'Scott', 35, 'Female');
INSERT INTO archer VALUES ('207', 'David', 'Clark', 61, 'Male');
INSERT INTO archer VALUES ('208', 'Brandon', 'Martinez', 28, 'Female');
INSERT INTO archer VALUES ('209', 'John', 'Clark', 24, 'Female');
INSERT INTO archer VALUES ('210', 'Ava', 'Collins', 52, 'Male');
INSERT INTO archer VALUES ('211', 'Sophia', 'Williams', 20, 'Male');
INSERT INTO archer VALUES ('212', 'Alexander', 'Lee', 26, 'Female');
INSERT INTO archer VALUES ('213', 'Evelyn', 'White', 43, 'Male');
INSERT INTO archer VALUES ('214', 'Andrew', 'Young', 40, 'Male');
INSERT INTO archer VALUES ('215', 'Joseph', 'Turner', 26, 'Female');
INSERT INTO archer VALUES ('216', 'Addison', 'Lee', 60, 'Female');
INSERT INTO archer VALUES ('217', 'Nicholas', 'Nelson', 42, 'Female');
INSERT INTO archer VALUES ('218', 'Sarah', 'Young', 36, 'Male');
INSERT INTO archer VALUES ('219', 'Jacob', 'Williams', 21, 'Female');
INSERT INTO archer VALUES ('220', 'Alexander', 'Evans', 50, 'Female');
INSERT INTO archer VALUES ('221', 'James', 'Rodriguez', 47, 'Female');
INSERT INTO archer VALUES ('222', 'Nicholas', 'Evans', 53, 'Male');
INSERT INTO archer VALUES ('223', 'Samuel', 'Williams', 51, 'Female');
INSERT INTO archer VALUES ('224', 'Lila', 'Davis', 30, 'Male');
INSERT INTO archer VALUES ('225', 'John', 'Wilson', 65, 'Female');
INSERT INTO archer VALUES ('226', 'Ella', 'Perez', 49, 'Female');
INSERT INTO archer VALUES ('227', 'Sophia', 'Wilson', 58, 'Male');
INSERT INTO archer VALUES ('228', 'Aria', 'Green', 34, 'Female');
INSERT INTO archer VALUES ('229', 'Evelyn', 'Mitchell', 49, 'Female');
INSERT INTO archer VALUES ('230', 'Nathan', 'Gonzalez', 56, 'Male');
INSERT INTO archer VALUES ('231', 'Michael', 'Perez', 18, 'Male');
INSERT INTO archer VALUES ('232', 'Samuel', 'Anderson', 29, 'Female');
INSERT INTO archer VALUES ('233', 'Nathan', 'Mitchell', 60, 'Male');
INSERT INTO archer VALUES ('234', 'Nathan', 'Taylor', 57, 'Female');
INSERT INTO archer VALUES ('235', 'Sarah', 'Hernandez', 53, 'Male');
INSERT INTO archer VALUES ('236', 'Ryan', 'Turner', 62, 'Female');
INSERT INTO archer VALUES ('237', 'Sarah', 'Campbell', 37, 'Male');
INSERT INTO archer VALUES ('238', 'Avery', 'Garcia', 45, 'Male');
INSERT INTO archer VALUES ('239', 'Isaac', 'Carter', 21, 'Female');
INSERT INTO archer VALUES ('240', 'Aria', 'Roberts', 39, 'Male');
INSERT INTO archer VALUES ('241', 'John', 'Jones', 47, 'Male');
INSERT INTO archer VALUES ('242', 'Abigail', 'Taylor', 39, 'Male');
INSERT INTO archer VALUES ('243', 'Matthew', 'Green', 55, 'Female');
INSERT INTO archer VALUES ('244', 'Christopher', 'Young', 43, 'Female');
INSERT INTO archer VALUES ('245', 'Ethan', 'Jones', 25, 'Male');
INSERT INTO archer VALUES ('246', 'Isaac', 'Martin', 30, 'Female');
INSERT INTO archer VALUES ('247', 'Sarah', 'Green', 38, 'Female');
INSERT INTO archer VALUES ('248', 'Evelyn', 'Miller', 21, 'Female');
INSERT INTO archer VALUES ('249', 'Daniel', 'Martin', 52, 'Male');
INSERT INTO archer VALUES ('250', 'Chloe', 'Martin', 52, 'Male');
INSERT INTO archer VALUES ('251', 'Samuel', 'Hill', 28, 'Female');
INSERT INTO archer VALUES ('252', 'Nathan', 'Smith', 45, 'Male');
INSERT INTO archer VALUES ('253', 'Ryan', 'Hernandez', 42, 'Female');
INSERT INTO archer VALUES ('254', 'Christopher', 'Roberts', 32, 'Male');
INSERT INTO archer VALUES ('255', 'Samuel', 'Jones', 58, 'Female');
INSERT INTO archer VALUES ('256', 'Hannah', 'Wilson', 39, 'Female');
INSERT INTO archer VALUES ('257', 'Dylan', 'Anderson', 40, 'Female');
INSERT INTO archer VALUES ('258', 'Aria', 'Hill', 54, 'Female');
INSERT INTO archer VALUES ('259', 'Chloe', 'Scott', 54, 'Female');
INSERT INTO archer VALUES ('260', 'Ella', 'Lee', 41, 'Female');
INSERT INTO archer VALUES ('261', 'Daniel', 'Smith', 49, 'Female');
INSERT INTO archer VALUES ('262', 'Nicholas', 'Wright', 45, 'Female');
INSERT INTO archer VALUES ('263', 'Tyler', 'Hill', 34, 'Male');
INSERT INTO archer VALUES ('264', 'Emily', 'Gonzalez', 56, 'Male');
INSERT INTO archer VALUES ('265', 'Zoey', 'Martin', 44, 'Female');
INSERT INTO archer VALUES ('266', 'Avery', 'Thompson', 22, 'Female');
INSERT INTO archer VALUES ('267', 'Sarah', 'Thompson', 55, 'Female');
INSERT INTO archer VALUES ('268', 'Addison', 'Mitchell', 39, 'Female');
INSERT INTO archer VALUES ('269', 'Ava', 'Harris', 55, 'Male');
INSERT INTO archer VALUES ('270', 'Dylan', 'Collins', 59, 'Female');
INSERT INTO archer VALUES ('271', 'Avery', 'Clark', 33, 'Female');
INSERT INTO archer VALUES ('272', 'Adam', 'Jackson', 19, 'Female');
INSERT INTO archer VALUES ('273', 'Benjamin', 'Anderson', 20, 'Male');
INSERT INTO archer VALUES ('274', 'Ella', 'Davis', 46, 'Female');
INSERT INTO archer VALUES ('275', 'Joseph', 'Evans', 50, 'Male');
INSERT INTO archer VALUES ('276', 'Aria', 'Phillips', 19, 'Female');
INSERT INTO archer VALUES ('277', 'Andrew', 'Anderson', 24, 'Female');
INSERT INTO archer VALUES ('278', 'Michael', 'Lewis', 58, 'Male');
INSERT INTO archer VALUES ('279', 'Hannah', 'Thompson', 19, 'Female');
INSERT INTO archer VALUES ('280', 'Evelyn', 'Martin', 26, 'Female');
INSERT INTO archer VALUES ('281', 'Sophia', 'Parker', 20, 'Female');
INSERT INTO archer VALUES ('282', 'John', 'Martin', 55, 'Female');
INSERT INTO archer VALUES ('283', 'Harper', 'Young', 33, 'Male');
INSERT INTO archer VALUES ('284', 'Natalie', 'Young', 58, 'Male');
INSERT INTO archer VALUES ('285', 'Isabella', 'Robinson', 65, 'Male');
INSERT INTO archer VALUES ('286', 'Daniel', 'Lopez', 32, 'Female');
INSERT INTO archer VALUES ('287', 'Anthony', 'Campbell', 36, 'Male');
INSERT INTO archer VALUES ('288', 'Mia', 'Lewis', 22, 'Female');
INSERT INTO archer VALUES ('289', 'Aria', 'Brown', 37, 'Female');
INSERT INTO archer VALUES ('290', 'Lillian', 'Hall', 45, 'Female');
INSERT INTO archer VALUES ('291', 'Matthew', 'Edwards', 26, 'Female');
INSERT INTO archer VALUES ('292', 'Benjamin', 'Parker', 18, 'Female');
INSERT INTO archer VALUES ('293', 'John', 'Parker', 37, 'Male');
INSERT INTO archer VALUES ('294', 'Mia', 'Turner', 34, 'Male');
INSERT INTO archer VALUES ('295', 'Nathan', 'Davis', 33, 'Female');
INSERT INTO archer VALUES ('296', 'Avery', 'Hall', 55, 'Female');
INSERT INTO archer VALUES ('297', 'Andrew', 'Lewis', 43, 'Male');
INSERT INTO archer VALUES ('298', 'David', 'Perez', 19, 'Female');
INSERT INTO archer VALUES ('299', 'Jacob', 'Johnson', 48, 'Female');
INSERT INTO archer VALUES ('300', 'Lila', 'Adams', 46, 'Female');
INSERT INTO archer VALUES ('301', 'Benjamin', 'Lewis', 62, 'Female');
INSERT INTO archer VALUES ('302', 'Elizabeth', 'Parker', 61, 'Male');
INSERT INTO archer VALUES ('303', 'Christopher', 'Collins', 48, 'Male');
INSERT INTO archer VALUES ('304', 'Benjamin', 'Gonzalez', 62, 'Male');
INSERT INTO archer VALUES ('305', 'Dylan', 'Moore', 28, 'Male');
INSERT INTO archer VALUES ('306', 'Mia', 'Brown', 51, 'Female');
INSERT INTO archer VALUES ('307', 'Olivia', 'Perez', 60, 'Male');
INSERT INTO archer VALUES ('308', 'Benjamin', 'Lopez', 46, 'Female');
INSERT INTO archer VALUES ('309', 'Nicholas', 'Taylor', 56, 'Male');
INSERT INTO archer VALUES ('310', 'Elizabeth', 'Rodriguez', 63, 'Female');
INSERT INTO archer VALUES ('311', 'Aria', 'Mitchell', 20, 'Female');
INSERT INTO archer VALUES ('312', 'Ethan', 'Gonzalez', 23, 'Male');
INSERT INTO archer VALUES ('313', 'Benjamin', 'Smith', 26, 'Female');
INSERT INTO archer VALUES ('314', 'Samuel', 'King', 31, 'Female');
INSERT INTO archer VALUES ('315', 'Sarah', 'Martin', 18, 'Male');
INSERT INTO archer VALUES ('316', 'Zoey', 'Johnson', 50, 'Male');
INSERT INTO archer VALUES ('317', 'Lila', 'Lee', 32, 'Male');
INSERT INTO archer VALUES ('318', 'Aria', 'White', 29, 'Male');
INSERT INTO archer VALUES ('319', 'Emily', 'Phillips', 50, 'Female');
INSERT INTO archer VALUES ('320', 'Adam', 'Garcia', 33, 'Female');
INSERT INTO archer VALUES ('321', 'Aubrey', 'Davis', 45, 'Female');
INSERT INTO archer VALUES ('322', 'Christopher', 'Taylor', 21, 'Male');
INSERT INTO archer VALUES ('323', 'Brandon', 'Moore', 55, 'Male');
INSERT INTO archer VALUES ('324', 'Alexander', 'Clark', 20, 'Male');
INSERT INTO archer VALUES ('325', 'Zoey', 'Lopez', 59, 'Female');
INSERT INTO archer VALUES ('326', 'Anthony', 'Smith', 49, 'Male');
INSERT INTO archer VALUES ('327', 'Anthony', 'Davis', 51, 'Female');
INSERT INTO archer VALUES ('328', 'Chloe', 'Williams', 55, 'Male');
INSERT INTO archer VALUES ('329', 'Isabella', 'Harris', 58, 'Female');
INSERT INTO archer VALUES ('330', 'Emily', 'Jones', 59, 'Male');
INSERT INTO archer VALUES ('331', 'Benjamin', 'Davis', 28, 'Male');
INSERT INTO archer VALUES ('332', 'Olivia', 'Lee', 50, 'Male');
INSERT INTO archer VALUES ('333', 'Emily', 'Allen', 32, 'Female');
INSERT INTO archer VALUES ('334', 'Elizabeth', 'Collins', 56, 'Male');
INSERT INTO archer VALUES ('335', 'Natalie', 'Lopez', 19, 'Female');
INSERT INTO archer VALUES ('336', 'Grace', 'Lopez', 58, 'Male');
INSERT INTO archer VALUES ('337', 'Addison', 'Green', 22, 'Male');
INSERT INTO archer VALUES ('338', 'John', 'Young', 49, 'Female');
INSERT INTO archer VALUES ('339', 'Nicholas', 'Miller', 63, 'Female');
INSERT INTO archer VALUES ('340', 'Anthony', 'Thomas', 54, 'Female');
INSERT INTO archer VALUES ('341', 'Natalie', 'Moore', 42, 'Male');
INSERT INTO archer VALUES ('342', 'Lillian', 'Harris', 40, 'Female');
INSERT INTO archer VALUES ('343', 'Abigail', 'Young', 48, 'Male');
INSERT INTO archer VALUES ('344', 'Matthew', 'Davis', 24, 'Male');
INSERT INTO archer VALUES ('345', 'Harper', 'Green', 65, 'Female');
INSERT INTO archer VALUES ('346', 'Grace', 'Allen', 51, 'Female');
INSERT INTO archer VALUES ('347', 'Daniel', 'Davis', 43, 'Female');
INSERT INTO archer VALUES ('348', 'Evelyn', 'Martin', 46, 'Male');
INSERT INTO archer VALUES ('349', 'Joseph', 'Garcia', 29, 'Female');
INSERT INTO archer VALUES ('350', 'Matthew', 'Lee', 47, 'Male');
INSERT INTO archer VALUES ('351', 'Alexander', 'Green', 25, 'Female');
INSERT INTO archer VALUES ('352', 'John', 'Green', 23, 'Male');
INSERT INTO archer VALUES ('353', 'Zoey', 'Scott', 31, 'Male');
INSERT INTO archer VALUES ('354', 'Olivia', 'Collins', 58, 'Female');
INSERT INTO archer VALUES ('355', 'Aubrey', 'Smith', 41, 'Female');
INSERT INTO archer VALUES ('356', 'Isabella', 'Gonzalez', 31, 'Male');
INSERT INTO archer VALUES ('357', 'Avery', 'Martin', 30, 'Male');
INSERT INTO archer VALUES ('358', 'Benjamin', 'Gonzalez', 20, 'Female');
INSERT INTO archer VALUES ('359', 'Alexander', 'Adams', 65, 'Female');
INSERT INTO archer VALUES ('360', 'Aria', 'Hernandez', 21, 'Male');
INSERT INTO archer VALUES ('361', 'Tyler', 'Moore', 58, 'Male');
INSERT INTO archer VALUES ('362', 'Avery', 'Jones', 20, 'Male');
INSERT INTO archer VALUES ('363', 'James', 'Carter', 32, 'Female');
INSERT INTO archer VALUES ('364', 'Jacob', 'Green', 41, 'Female');
INSERT INTO archer VALUES ('365', 'David', 'Thomas', 60, 'Male');
INSERT INTO archer VALUES ('366', 'Jacob', 'Rodriguez', 48, 'Female');
INSERT INTO archer VALUES ('367', 'Samuel', 'Jones', 43, 'Male');
INSERT INTO archer VALUES ('368', 'Nicholas', 'Hill', 27, 'Female');
INSERT INTO archer VALUES ('369', 'Ryan', 'Harris', 37, 'Female');
INSERT INTO archer VALUES ('370', 'William', 'Rodriguez', 63, 'Female');
INSERT INTO archer VALUES ('371', 'Dylan', 'Allen', 37, 'Male');
INSERT INTO archer VALUES ('372', 'Anthony', 'Thomas', 38, 'Male');
INSERT INTO archer VALUES ('373', 'Evelyn', 'Brown', 30, 'Female');
INSERT INTO archer VALUES ('374', 'Joshua', 'Hill', 46, 'Female');
INSERT INTO archer VALUES ('375', 'Joshua', 'Martinez', 41, 'Female');
INSERT INTO archer VALUES ('376', 'Christopher', 'Jackson', 24, 'Female');
INSERT INTO archer VALUES ('377', 'Sarah', 'Martinez', 61, 'Female');
INSERT INTO archer VALUES ('378', 'Lillian', 'Harris', 60, 'Male');
INSERT INTO archer VALUES ('379', 'William', 'Harris', 29, 'Male');
INSERT INTO archer VALUES ('380', 'Benjamin', 'Thomas', 54, 'Female');
INSERT INTO archer VALUES ('381', 'Christopher', 'Scott', 35, 'Male');
INSERT INTO archer VALUES ('382', 'Sarah', 'Turner', 36, 'Female');
INSERT INTO archer VALUES ('383', 'Emma', 'Mitchell', 61, 'Female');
INSERT INTO archer VALUES ('384', 'Andrew', 'Clark', 22, 'Female');
INSERT INTO archer VALUES ('385', 'Chloe', 'Wilson', 31, 'Male');
INSERT INTO archer VALUES ('386', 'Aria', 'Jackson', 31, 'Female');
INSERT INTO archer VALUES ('387', 'Emma', 'Campbell', 37, 'Female');
INSERT INTO archer VALUES ('388', 'Joseph', 'Phillips', 26, 'Male');
INSERT INTO archer VALUES ('389', 'Tyler', 'Miller', 48, 'Male');
INSERT INTO archer VALUES ('390', 'Evelyn', 'Scott', 18, 'Female');
INSERT INTO archer VALUES ('391', 'Sophia', 'Jones', 65, 'Female');
INSERT INTO archer VALUES ('392', 'Aubrey', 'Martin', 62, 'Male');
INSERT INTO archer VALUES ('393', 'Lillian', 'Baker', 19, 'Male');
INSERT INTO archer VALUES ('394', 'Evelyn', 'Green', 44, 'Male');
INSERT INTO archer VALUES ('395', 'Sophia', 'Edwards', 53, 'Female');
INSERT INTO archer VALUES ('396', 'Ryan', 'Lewis', 46, 'Male');
INSERT INTO archer VALUES ('397', 'Joshua', 'Perez', 33, 'Male');
INSERT INTO archer VALUES ('398', 'Emily', 'Robinson', 40, 'Female');
INSERT INTO archer VALUES ('399', 'John', 'Evans', 64, 'Male');
INSERT INTO archer VALUES ('400', 'Aubrey', 'Lee', 28, 'Male');
INSERT INTO archer VALUES ('401', 'Christopher', 'Martinez', 43, 'Female');
INSERT INTO archer VALUES ('402', 'Emma', 'Wilson', 47, 'Female');
INSERT INTO archer VALUES ('403', 'Mia', 'Adams', 57, 'Male');
INSERT INTO archer VALUES ('404', 'John', 'Lopez', 21, 'Female');
INSERT INTO archer VALUES ('405', 'James', 'Carter', 44, 'Male');
INSERT INTO archer VALUES ('406', 'Brandon', 'Clark', 40, 'Female');
INSERT INTO archer VALUES ('407', 'Lila', 'Campbell', 30, 'Male');
INSERT INTO archer VALUES ('408', 'Anthony', 'Walker', 24, 'Male');
INSERT INTO archer VALUES ('409', 'Michael', 'Hall', 27, 'Male');
INSERT INTO archer VALUES ('410', 'Michael', 'Young', 51, 'Male');
INSERT INTO archer VALUES ('411', 'Anthony', 'Garcia', 55, 'Female');
INSERT INTO archer VALUES ('412', 'Andrew', 'King', 51, 'Female');
INSERT INTO archer VALUES ('413', 'Evelyn', 'Scott', 63, 'Male');
INSERT INTO archer VALUES ('414', 'Sarah', 'Parker', 35, 'Female');
INSERT INTO archer VALUES ('415', 'Ella', 'Moore', 57, 'Female');
INSERT INTO archer VALUES ('416', 'Mia', 'Campbell', 38, 'Female');
INSERT INTO archer VALUES ('417', 'Tyler', 'Hernandez', 60, 'Female');
INSERT INTO archer VALUES ('418', 'Amelia', 'Johnson', 21, 'Male');
INSERT INTO archer VALUES ('419', 'Lila', 'Robinson', 36, 'Male');
INSERT INTO archer VALUES ('420', 'Isaac', 'Davis', 54, 'Male');
INSERT INTO archer VALUES ('421', 'David', 'Davis', 51, 'Male');
INSERT INTO archer VALUES ('422', 'Ava', 'Evans', 34, 'Female');
INSERT INTO archer VALUES ('423', 'Grace', 'Nelson', 27, 'Female');
INSERT INTO archer VALUES ('424', 'Tyler', 'Jackson', 40, 'Female');
INSERT INTO archer VALUES ('425', 'Benjamin', 'Harris', 61, 'Male');
INSERT INTO archer VALUES ('426', 'Isabella', 'Walker', 31, 'Female');
INSERT INTO archer VALUES ('427', 'Samuel', 'Jones', 41, 'Male');
INSERT INTO archer VALUES ('428', 'Adam', 'Baker', 36, 'Male');
INSERT INTO archer VALUES ('429', 'Jacob', 'Edwards', 41, 'Female');
INSERT INTO archer VALUES ('430', 'Samuel', 'Gonzalez', 27, 'Female');
INSERT INTO archer VALUES ('431', 'Avery', 'Rodriguez', 19, 'Male');
INSERT INTO archer VALUES ('432', 'Dylan', 'Wright', 46, 'Female');
INSERT INTO archer VALUES ('433', 'Grace', 'Moore', 60, 'Female');
INSERT INTO archer VALUES ('434', 'Grace', 'Phillips', 22, 'Female');
INSERT INTO archer VALUES ('435', 'Daniel', 'Carter', 22, 'Female');
INSERT INTO archer VALUES ('436', 'Christopher', 'Allen', 18, 'Female');
INSERT INTO archer VALUES ('437', 'Michael', 'Nelson', 51, 'Male');
INSERT INTO archer VALUES ('438', 'Avery', 'Adams', 39, 'Female');
INSERT INTO archer VALUES ('439', 'Hannah', 'Edwards', 58, 'Female');
INSERT INTO archer VALUES ('440', 'Evelyn', 'Phillips', 40, 'Female');
INSERT INTO archer VALUES ('441', 'Evelyn', 'Lopez', 42, 'Male');
INSERT INTO archer VALUES ('442', 'Lillian', 'Miller', 22, 'Male');
INSERT INTO archer VALUES ('443', 'Christopher', 'Thomas', 57, 'Female');
INSERT INTO archer VALUES ('444', 'Matthew', 'Moore', 57, 'Male');
INSERT INTO archer VALUES ('445', 'Aria', 'Smith', 63, 'Female');
INSERT INTO archer VALUES ('446', 'Natalie', 'Robinson', 28, 'Female');
INSERT INTO archer VALUES ('447', 'Daniel', 'White', 61, 'Male');
INSERT INTO archer VALUES ('448', 'Harper', 'Phillips', 43, 'Male');
INSERT INTO archer VALUES ('449', 'Isabella', 'Gonzalez', 24, 'Male');
INSERT INTO archer VALUES ('450', 'Brandon', 'Lewis', 59, 'Female');
INSERT INTO archer VALUES ('451', 'Tyler', 'Mitchell', 51, 'Female');
INSERT INTO archer VALUES ('452', 'Sophia', 'Walker', 35, 'Female');
INSERT INTO archer VALUES ('453', 'Ella', 'Hill', 38, 'Female');
INSERT INTO archer VALUES ('454', 'Daniel', 'Thompson', 43, 'Male');
INSERT INTO archer VALUES ('455', 'Isabella', 'Williams', 19, 'Female');
INSERT INTO archer VALUES ('456', 'Elizabeth', 'Martinez', 42, 'Female');
INSERT INTO archer VALUES ('457', 'Dylan', 'Adams', 64, 'Male');
INSERT INTO archer VALUES ('458', 'Daniel', 'Martinez', 37, 'Male');
INSERT INTO archer VALUES ('459', 'Nathan', 'Lewis', 22, 'Male');
INSERT INTO archer VALUES ('460', 'Harper', 'Anderson', 52, 'Male');
INSERT INTO archer VALUES ('461', 'Daniel', 'Davis', 25, 'Male');
INSERT INTO archer VALUES ('462', 'Ava', 'Adams', 59, 'Female');
INSERT INTO archer VALUES ('463', 'Grace', 'Gonzalez', 44, 'Female');
INSERT INTO archer VALUES ('464', 'Joshua', 'Carter', 53, 'Male');
INSERT INTO archer VALUES ('465', 'Lillian', 'Thompson', 21, 'Male');
INSERT INTO archer VALUES ('466', 'Daniel', 'Harris', 55, 'Female');
INSERT INTO archer VALUES ('467', 'Matthew', 'Hill', 51, 'Female');
INSERT INTO archer VALUES ('468', 'Olivia', 'Green', 32, 'Female');
INSERT INTO archer VALUES ('469', 'Anthony', 'Lee', 32, 'Male');
INSERT INTO archer VALUES ('470', 'Adam', 'Davis', 36, 'Male');
INSERT INTO archer VALUES ('471', 'Emily', 'Thompson', 18, 'Male');
INSERT INTO archer VALUES ('472', 'Evelyn', 'Rodriguez', 36, 'Male');
INSERT INTO archer VALUES ('473', 'Brandon', 'Parker', 55, 'Male');
INSERT INTO archer VALUES ('474', 'Anthony', 'Turner', 40, 'Male');
INSERT INTO archer VALUES ('475', 'Joshua', 'Baker', 47, 'Female');
INSERT INTO archer VALUES ('476', 'Emily', 'Baker', 22, 'Female');
INSERT INTO archer VALUES ('477', 'Amelia', 'Lopez', 36, 'Male');
INSERT INTO archer VALUES ('478', 'Isaac', 'Davis', 64, 'Male');
INSERT INTO archer VALUES ('479', 'Lila', 'Brown', 28, 'Female');
INSERT INTO archer VALUES ('480', 'Aubrey', 'Gonzalez', 52, 'Male');
INSERT INTO archer VALUES ('481', 'Mia', 'Jones', 28, 'Female');
INSERT INTO archer VALUES ('482', 'Grace', 'Clark', 52, 'Male');
INSERT INTO archer VALUES ('483', 'Adam', 'Smith', 48, 'Female');
INSERT INTO archer VALUES ('484', 'Andrew', 'Brown', 20, 'Male');
INSERT INTO archer VALUES ('485', 'Aubrey', 'Smith', 24, 'Female');
INSERT INTO archer VALUES ('486', 'Addison', 'Wilson', 30, 'Female');
INSERT INTO archer VALUES ('487', 'James', 'Clark', 23, 'Male');
INSERT INTO archer VALUES ('488', 'Chloe', 'Carter', 32, 'Female');
INSERT INTO archer VALUES ('489', 'Sophia', 'Hernandez', 33, 'Female');
INSERT INTO archer VALUES ('490', 'Michael', 'Hernandez', 35, 'Male');
INSERT INTO archer VALUES ('491', 'Natalie', 'Adams', 18, 'Male');
INSERT INTO archer VALUES ('492', 'Dylan', 'Young', 59, 'Female');
INSERT INTO archer VALUES ('493', 'Benjamin', 'Thomas', 31, 'Male');
INSERT INTO archer VALUES ('494', 'Natalie', 'Johnson', 54, 'Female');
INSERT INTO archer VALUES ('495', 'Isaac', 'Wright', 51, 'Female');
INSERT INTO archer VALUES ('496', 'Emily', 'Taylor', 61, 'Female');
INSERT INTO archer VALUES ('497', 'Chloe', 'Scott', 47, 'Male');
INSERT INTO archer VALUES ('498', 'Michael', 'Anderson', 47, 'Female');
INSERT INTO archer VALUES ('499', 'Natalie', 'Brown', 42, 'Male');
INSERT INTO archer VALUES ('500', 'Emma', 'Jackson', 32, 'Female');
INSERT INTO archer VALUES ('501', 'James', 'Lee', 23, 'Female');
INSERT INTO archer VALUES ('502', 'Lillian', 'Scott', 59, 'Male');
INSERT INTO archer VALUES ('503', 'Isabella', 'Roberts', 28, 'Male');
INSERT INTO archer VALUES ('504', 'Lila', 'Parker', 20, 'Male');
INSERT INTO archer VALUES ('505', 'Sophia', 'Gonzalez', 34, 'Male');
INSERT INTO archer VALUES ('506', 'Christopher', 'Williams', 45, 'Male');
INSERT INTO archer VALUES ('507', 'Isabella', 'Hill', 18, 'Female');
INSERT INTO archer VALUES ('508', 'Ryan', 'Harris', 54, 'Male');
INSERT INTO archer VALUES ('509', 'Sarah', 'Taylor', 48, 'Female');
INSERT INTO archer VALUES ('510', 'Lila', 'Roberts', 36, 'Male');
INSERT INTO archer VALUES ('511', 'Mia', 'Green', 33, 'Female');
INSERT INTO archer VALUES ('512', 'Andrew', 'Mitchell', 19, 'Male');
INSERT INTO archer VALUES ('513', 'Lila', 'Hill', 20, 'Female');
INSERT INTO archer VALUES ('514', 'Grace', 'Hall', 40, 'Female');
INSERT INTO archer VALUES ('515', 'Ryan', 'Brown', 35, 'Female');
INSERT INTO archer VALUES ('516', 'Samuel', 'Robinson', 25, 'Male');
INSERT INTO archer VALUES ('517', 'Ryan', 'Campbell', 59, 'Male');
INSERT INTO archer VALUES ('518', 'Brandon', 'Harris', 34, 'Male');
INSERT INTO archer VALUES ('519', 'Addison', 'Lee', 28, 'Female');
INSERT INTO archer VALUES ('520', 'Evelyn', 'Moore', 64, 'Male');
INSERT INTO archer VALUES ('521', 'Daniel', 'Baker', 33, 'Female');
INSERT INTO archer VALUES ('522', 'Hannah', 'Taylor', 32, 'Male');
INSERT INTO archer VALUES ('523', 'Olivia', 'Robinson', 20, 'Male');
INSERT INTO archer VALUES ('524', 'Jacob', 'Nelson', 47, 'Male');
INSERT INTO archer VALUES ('525', 'Lillian', 'Lopez', 43, 'Female');
INSERT INTO archer VALUES ('526', 'William', 'Williams', 41, 'Male');
INSERT INTO archer VALUES ('527', 'James', 'Martin', 51, 'Female');
INSERT INTO archer VALUES ('528', 'Sophia', 'Roberts', 27, 'Female');
INSERT INTO archer VALUES ('529', 'Elizabeth', 'Williams', 38, 'Male');
INSERT INTO archer VALUES ('530', 'Mia', 'Miller', 38, 'Male');
INSERT INTO archer VALUES ('531', 'Abigail', 'Williams', 46, 'Male');
INSERT INTO archer VALUES ('532', 'Alexander', 'Edwards', 63, 'Female');
INSERT INTO archer VALUES ('533', 'Nicholas', 'Moore', 60, 'Male');
INSERT INTO archer VALUES ('534', 'Harper', 'Lee', 35, 'Male');
INSERT INTO archer VALUES ('535', 'Alexander', 'Jackson', 51, 'Male');
INSERT INTO archer VALUES ('536', 'Grace', 'Baker', 58, 'Female');
INSERT INTO archer VALUES ('537', 'Joseph', 'Clark', 65, 'Female');
INSERT INTO archer VALUES ('538', 'Anthony', 'Allen', 57, 'Male');
INSERT INTO archer VALUES ('539', 'Christopher', 'Nelson', 20, 'Male');
INSERT INTO archer VALUES ('540', 'Emily', 'Scott', 37, 'Female');
INSERT INTO archer VALUES ('541', 'Isabella', 'Garcia', 58, 'Male');
INSERT INTO archer VALUES ('542', 'Aria', 'Martin', 53, 'Female');
INSERT INTO archer VALUES ('543', 'Daniel', 'Robinson', 24, 'Female');
INSERT INTO archer VALUES ('544', 'Joshua', 'Turner', 39, 'Female');
INSERT INTO archer VALUES ('545', 'Harper', 'Campbell', 23, 'Female');
INSERT INTO archer VALUES ('546', 'Harper', 'Thompson', 43, 'Male');
INSERT INTO archer VALUES ('547', 'Samuel', 'Lopez', 43, 'Female');
INSERT INTO archer VALUES ('548', 'Christopher', 'Hernandez', 47, 'Male');
INSERT INTO archer VALUES ('549', 'Brandon', 'Nelson', 44, 'Male');
INSERT INTO archer VALUES ('550', 'Adam', 'Hill', 62, 'Female');
INSERT INTO archer VALUES ('551', 'Amelia', 'Hill', 22, 'Female');
INSERT INTO archer VALUES ('552', 'Ryan', 'Gonzalez', 65, 'Male');
INSERT INTO archer VALUES ('553', 'Elizabeth', 'Turner', 35, 'Male');
INSERT INTO archer VALUES ('554', 'Emma', 'Young', 62, 'Male');
INSERT INTO archer VALUES ('555', 'Joseph', 'Phillips', 61, 'Male');
INSERT INTO archer VALUES ('556', 'Ethan', 'Parker', 58, 'Female');
INSERT INTO archer VALUES ('557', 'Michael', 'Harris', 43, 'Male');
INSERT INTO archer VALUES ('558', 'Michael', 'Johnson', 23, 'Male');
INSERT INTO archer VALUES ('559', 'Ryan', 'Rodriguez', 58, 'Male');
INSERT INTO archer VALUES ('560', 'James', 'Green', 40, 'Male');
INSERT INTO archer VALUES ('561', 'John', 'Nelson', 38, 'Male');
INSERT INTO archer VALUES ('562', 'Aubrey', 'Campbell', 63, 'Male');
INSERT INTO archer VALUES ('563', 'Ryan', 'Baker', 36, 'Male');
INSERT INTO archer VALUES ('564', 'Emma', 'Lopez', 60, 'Male');
INSERT INTO archer VALUES ('565', 'Mia', 'Anderson', 44, 'Female');
INSERT INTO archer VALUES ('566', 'James', 'White', 53, 'Male');
INSERT INTO archer VALUES ('567', 'Dylan', 'Wright', 61, 'Male');
INSERT INTO archer VALUES ('568', 'Alexander', 'Lopez', 20, 'Male');
INSERT INTO archer VALUES ('569', 'Emily', 'Hernandez', 51, 'Male');
INSERT INTO archer VALUES ('570', 'Matthew', 'Campbell', 62, 'Male');
INSERT INTO archer VALUES ('571', 'Natalie', 'Adams', 38, 'Female');
INSERT INTO archer VALUES ('572', 'Jacob', 'Young', 25, 'Male');
INSERT INTO archer VALUES ('573', 'Nicholas', 'Wilson', 39, 'Female');
INSERT INTO archer VALUES ('574', 'Evelyn', 'Garcia', 65, 'Male');
INSERT INTO archer VALUES ('575', 'Andrew', 'Rodriguez', 37, 'Male');
INSERT INTO archer VALUES ('576', 'Sarah', 'Moore', 57, 'Male');
INSERT INTO archer VALUES ('577', 'Abigail', 'Scott', 24, 'Female');
INSERT INTO archer VALUES ('578', 'Alexander', 'Williams', 59, 'Female');
INSERT INTO archer VALUES ('579', 'Nicholas', 'Hernandez', 44, 'Female');
INSERT INTO archer VALUES ('580', 'Samuel', 'Johnson', 23, 'Male');
INSERT INTO archer VALUES ('581', 'Michael', 'Mitchell', 18, 'Male');
INSERT INTO archer VALUES ('582', 'Benjamin', 'Miller', 40, 'Female');
INSERT INTO archer VALUES ('583', 'Hannah', 'Rodriguez', 43, 'Male');
INSERT INTO archer VALUES ('584', 'Emily', 'Adams', 23, 'Male');
INSERT INTO archer VALUES ('585', 'Natalie', 'Scott', 40, 'Male');
INSERT INTO archer VALUES ('586', 'Natalie', 'Turner', 56, 'Female');
INSERT INTO archer VALUES ('587', 'Joshua', 'Hill', 49, 'Female');
INSERT INTO archer VALUES ('588', 'Adam', 'Jones', 36, 'Male');
INSERT INTO archer VALUES ('589', 'Emma', 'Roberts', 42, 'Male');
INSERT INTO archer VALUES ('590', 'Michael', 'Campbell', 45, 'Female');
INSERT INTO archer VALUES ('591', 'Natalie', 'Hernandez', 27, 'Male');
INSERT INTO archer VALUES ('592', 'Harper', 'Nelson', 20, 'Female');
INSERT INTO archer VALUES ('593', 'Isabella', 'Moore', 26, 'Female');
INSERT INTO archer VALUES ('594', 'Ella', 'Roberts', 48, 'Female');
INSERT INTO archer VALUES ('595', 'Adam', 'Perez', 29, 'Male');
INSERT INTO archer VALUES ('596', 'Tyler', 'Rodriguez', 64, 'Male');
INSERT INTO archer VALUES ('597', 'Sophia', 'Miller', 19, 'Female');
INSERT INTO archer VALUES ('598', 'Ella', 'Davis', 19, 'Female');
INSERT INTO archer VALUES ('599', 'Sarah', 'Brown', 32, 'Female');


---------------------------------------------------------------------------------------------------
-------------------------------------- insert into EndScore ---------------------------------------
-- INSERT INTO endscore VALUES (1, 9, 7, 8, 6, 4, 4, 38, 1);
-- INSERT INTO endscore VALUES (2, 9, 4, 6, 3, 8, 8, 38, 1);
-- INSERT INTO endscore VALUES (3, 6, 7, 8, 9, 5, 4, 39, 1);
-- INSERT INTO endscore VALUES (4, 5, 7, 8, 6, 4, 4, 34, 1);
-- INSERT INTO endscore VALUES (5, 5, 7, 5, 6, 7, 4, 34, 1);
-- INSERT INTO endscore VALUES (6, 8, 7, 8, 6, 9, 9, 47, 1);



-- For RoundRangeID: 1
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 3, 2, 2, 2, 5, 18, 1);
        

-- For RoundRangeID: 1
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 8, 1, 4, 10, 3, 36, 1);
        

-- For RoundRangeID: 1
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 8, 6, 5, 2, 2, 30, 1);
        

-- For RoundRangeID: 1
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 7, 7, 7, 9, 5, 36, 1);
        

-- For RoundRangeID: 1
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 9, 2, 10, 3, 9, 34, 1);
        

-- For RoundRangeID: 1
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 8, 10, 5, 6, 6, 41, 1);
        

-- For RoundRangeID: 2
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 1, 10, 3, 9, 4, 35, 2);
        

-- For RoundRangeID: 2
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 9, 10, 5, 9, 7, 48, 2);
        

-- For RoundRangeID: 2
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 4, 9, 9, 1, 4, 33, 2);
        

-- For RoundRangeID: 2
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 1, 6, 7, 6, 3, 28, 2);
        

-- For RoundRangeID: 2
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 2, 7, 7, 4, 6, 36, 2);
        

-- For RoundRangeID: 2
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 7, 5, 5, 9, 1, 32, 2);
        

-- For RoundRangeID: 3
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 4, 2, 8, 9, 6, 39, 3);
        

-- For RoundRangeID: 3
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 9, 10, 1, 1, 8, 35, 3);
        

-- For RoundRangeID: 3
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 10, 6, 10, 8, 3, 46, 3);
        

-- For RoundRangeID: 3
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 3, 7, 8, 1, 5, 27, 3);
        

-- For RoundRangeID: 3
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 2, 7, 9, 4, 4, 27, 3);
        

-- For RoundRangeID: 3
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 2, 10, 1, 6, 9, 31, 3);
        

-- For RoundRangeID: 4
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 4, 8, 1, 2, 9, 29, 4);
        

-- For RoundRangeID: 4
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 9, 2, 8, 2, 6, 29, 4);
        

-- For RoundRangeID: 4
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 10, 9, 3, 8, 7, 39, 4);
        

-- For RoundRangeID: 4
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 3, 2, 1, 6, 8, 22, 4);
        

-- For RoundRangeID: 4
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 4, 3, 10, 6, 2, 32, 4);
        

-- For RoundRangeID: 4
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 10, 1, 7, 8, 10, 43, 4);
        

-- For RoundRangeID: 5
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 9, 5, 9, 4, 2, 38, 5);
        

-- For RoundRangeID: 5
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 6, 3, 1, 7, 3, 30, 5);
        

-- For RoundRangeID: 5
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 2, 9, 10, 3, 3, 29, 5);
        

-- For RoundRangeID: 5
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 3, 2, 7, 2, 4, 23, 5);
        

-- For RoundRangeID: 5
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 7, 9, 2, 5, 3, 28, 5);
        

-- For RoundRangeID: 5
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 6, 6, 1, 10, 8, 35, 5);
        

-- For RoundRangeID: 6
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 1, 6, 2, 3, 7, 24, 6);
        

-- For RoundRangeID: 6
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 2, 8, 2, 1, 5, 24, 6);
        

-- For RoundRangeID: 6
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 1, 6, 8, 10, 7, 41, 6);
        

-- For RoundRangeID: 6
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 6, 3, 5, 10, 8, 33, 6);
        

-- For RoundRangeID: 6
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 7, 1, 9, 6, 7, 31, 6);
        

-- For RoundRangeID: 6
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 1, 8, 1, 2, 10, 32, 6);
        

-- For RoundRangeID: 7
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 1, 1, 8, 2, 7, 20, 7);
        

-- For RoundRangeID: 7
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 8, 4, 1, 2, 2, 27, 7);
        

-- For RoundRangeID: 7
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 7, 4, 10, 4, 10, 41, 7);
        

-- For RoundRangeID: 7
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 4, 9, 8, 10, 10, 43, 7);
        

-- For RoundRangeID: 7
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 3, 2, 7, 4, 5, 27, 7);
        

-- For RoundRangeID: 7
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 8, 10, 7, 6, 1, 41, 7);
        

-- For RoundRangeID: 8
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 8, 2, 9, 10, 3, 34, 8);
        

-- For RoundRangeID: 8
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 10, 3, 3, 10, 2, 30, 8);
        

-- For RoundRangeID: 8
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 6, 2, 1, 2, 10, 28, 8);
        

-- For RoundRangeID: 8
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 7, 6, 10, 7, 5, 45, 8);
        

-- For RoundRangeID: 8
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 10, 8, 2, 9, 8, 44, 8);
        

-- For RoundRangeID: 8
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 7, 1, 5, 7, 2, 30, 8);
        

-- For RoundRangeID: 9
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 7, 8, 3, 6, 3, 36, 9);
        

-- For RoundRangeID: 9
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 7, 5, 3, 3, 7, 28, 9);
        

-- For RoundRangeID: 9
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 9, 8, 2, 5, 10, 42, 9);
        

-- For RoundRangeID: 9
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 1, 6, 2, 2, 8, 23, 9);
        

-- For RoundRangeID: 9
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 5, 4, 2, 8, 1, 23, 9);
        

-- For RoundRangeID: 9
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 7, 5, 2, 4, 4, 28, 9);
        

-- For RoundRangeID: 10
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 6, 7, 5, 1, 3, 30, 10);
        

-- For RoundRangeID: 10
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 9, 1, 4, 2, 4, 24, 10);
        

-- For RoundRangeID: 10
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 8, 9, 5, 5, 7, 40, 10);
        

-- For RoundRangeID: 10
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 7, 5, 6, 1, 9, 34, 10);
        

-- For RoundRangeID: 10
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 5, 9, 2, 4, 8, 35, 10);
        

-- For RoundRangeID: 10
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 6, 9, 4, 9, 1, 35, 10);
        

-- For RoundRangeID: 11
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 2, 4, 9, 10, 8, 40, 11);
        

-- For RoundRangeID: 11
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 4, 5, 5, 3, 4, 29, 11);
        

-- For RoundRangeID: 11
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 7, 3, 8, 3, 9, 31, 11);
        

-- For RoundRangeID: 11
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 7, 4, 5, 1, 9, 33, 11);
        

-- For RoundRangeID: 11
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 5, 7, 7, 6, 9, 39, 11);
        

-- For RoundRangeID: 11
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 4, 3, 10, 1, 4, 31, 11);
        

-- For RoundRangeID: 12
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 1, 8, 5, 7, 1, 28, 12);
        

-- For RoundRangeID: 12
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 8, 2, 4, 4, 1, 24, 12);
        

-- For RoundRangeID: 12
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 3, 6, 4, 7, 8, 36, 12);
        

-- For RoundRangeID: 12
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 10, 5, 3, 7, 7, 37, 12);
        

-- For RoundRangeID: 12
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 7, 6, 4, 5, 5, 33, 12);
        

-- For RoundRangeID: 12
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 6, 7, 2, 9, 10, 44, 12);
        

-- For RoundRangeID: 13
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 10, 1, 10, 6, 2, 30, 13);
        

-- For RoundRangeID: 13
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 7, 8, 5, 6, 5, 40, 13);
        

-- For RoundRangeID: 13
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 2, 6, 7, 1, 6, 27, 13);
        

-- For RoundRangeID: 13
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 1, 5, 4, 2, 1, 21, 13);
        

-- For RoundRangeID: 13
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 1, 6, 4, 4, 4, 26, 13);
        

-- For RoundRangeID: 13
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 2, 8, 10, 10, 1, 34, 13);
        

-- For RoundRangeID: 14
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 1, 9, 1, 7, 3, 24, 14);
        

-- For RoundRangeID: 14
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 4, 1, 7, 1, 10, 26, 14);
        

-- For RoundRangeID: 14
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 8, 5, 10, 3, 5, 38, 14);
        

-- For RoundRangeID: 14
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 5, 6, 9, 10, 6, 39, 14);
        

-- For RoundRangeID: 14
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 8, 6, 2, 1, 6, 24, 14);
        

-- For RoundRangeID: 14
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 2, 3, 4, 5, 1, 18, 14);
        

-- For RoundRangeID: 15
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 8, 5, 8, 5, 10, 37, 15);
        

-- For RoundRangeID: 15
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 7, 4, 4, 8, 6, 33, 15);
        

-- For RoundRangeID: 15
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 5, 1, 2, 3, 4, 20, 15);
        

-- For RoundRangeID: 15
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 4, 4, 8, 2, 7, 28, 15);
        

-- For RoundRangeID: 15
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 7, 6, 5, 4, 1, 29, 15);
        

-- For RoundRangeID: 15
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 10, 5, 3, 5, 2, 29, 15);
        

-- For RoundRangeID: 16
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 5, 2, 6, 1, 7, 22, 16);
        

-- For RoundRangeID: 16
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 2, 10, 4, 2, 2, 28, 16);
        

-- For RoundRangeID: 16
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 4, 1, 7, 1, 6, 20, 16);
        

-- For RoundRangeID: 16
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 3, 6, 4, 3, 2, 27, 16);
        

-- For RoundRangeID: 16
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 5, 2, 3, 9, 5, 25, 16);
        

-- For RoundRangeID: 16
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 1, 1, 3, 7, 8, 30, 16);
        

-- For RoundRangeID: 17
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 5, 3, 6, 10, 8, 40, 17);
        

-- For RoundRangeID: 17
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 6, 1, 6, 7, 1, 22, 17);
        

-- For RoundRangeID: 17
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 6, 10, 10, 7, 4, 39, 17);
        

-- For RoundRangeID: 17
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 2, 8, 5, 2, 5, 26, 17);
        

-- For RoundRangeID: 17
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 7, 2, 10, 4, 8, 33, 17);
        

-- For RoundRangeID: 17
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 5, 4, 10, 6, 1, 32, 17);
        

-- For RoundRangeID: 18
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 9, 3, 4, 6, 5, 29, 18);
        

-- For RoundRangeID: 18
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 1, 3, 10, 5, 4, 30, 18);
        

-- For RoundRangeID: 18
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 10, 2, 10, 2, 1, 35, 18);
        

-- For RoundRangeID: 18
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 2, 1, 1, 8, 5, 22, 18);
        

-- For RoundRangeID: 18
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 9, 5, 9, 4, 7, 38, 18);
        

-- For RoundRangeID: 18
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 9, 5, 7, 5, 7, 41, 18);
        

-- For RoundRangeID: 19
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 2, 5, 7, 7, 6, 28, 19);
        

-- For RoundRangeID: 19
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 6, 5, 2, 8, 3, 33, 19);
        

-- For RoundRangeID: 19
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 5, 10, 10, 10, 8, 51, 19);
        

-- For RoundRangeID: 19
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 8, 3, 3, 6, 4, 34, 19);
        

-- For RoundRangeID: 19
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 3, 5, 9, 5, 9, 35, 19);
        

-- For RoundRangeID: 19
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 9, 2, 5, 4, 2, 26, 19);
        

-- For RoundRangeID: 20
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 4, 9, 1, 1, 7, 28, 20);
        

-- For RoundRangeID: 20
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 3, 2, 4, 3, 9, 29, 20);
        

-- For RoundRangeID: 20
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 4, 6, 2, 6, 9, 37, 20);
        

-- For RoundRangeID: 20
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 2, 8, 2, 2, 3, 18, 20);
        

-- For RoundRangeID: 20
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 9, 6, 3, 5, 2, 29, 20);
        

-- For RoundRangeID: 20
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 8, 7, 1, 8, 10, 38, 20);


-- For RoundRangeID: 21
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 6, 3, 6, 9, 1, 33, 21);
        

-- For RoundRangeID: 21
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 9, 6, 1, 4, 10, 34, 21);
        

-- For RoundRangeID: 21
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 5, 8, 10, 9, 7, 47, 21);
        

-- For RoundRangeID: 21
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 8, 8, 9, 10, 8, 44, 21);
        

-- For RoundRangeID: 21
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 5, 1, 4, 4, 7, 23, 21);
        

-- For RoundRangeID: 22
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 1, 6, 2, 3, 5, 19, 22);
        

-- For RoundRangeID: 22
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 8, 3, 8, 2, 7, 37, 22);
        

-- For RoundRangeID: 22
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 1, 2, 7, 5, 4, 24, 22);
        

-- For RoundRangeID: 22
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 3, 6, 8, 7, 8, 38, 22);
        

-- For RoundRangeID: 22
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 4, 3, 8, 3, 2, 24, 22);
        

-- For RoundRangeID: 23
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 2, 7, 8, 9, 5, 40, 23);
        

-- For RoundRangeID: 23
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 10, 5, 7, 6, 5, 41, 23);
        

-- For RoundRangeID: 23
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 9, 4, 4, 2, 1, 22, 23);
        

-- For RoundRangeID: 23
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 6, 5, 2, 6, 7, 30, 23);
        

-- For RoundRangeID: 23
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 10, 7, 9, 4, 1, 34, 23);
        

-- For RoundRangeID: 24
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 8, 2, 2, 9, 1, 24, 24);
        

-- For RoundRangeID: 24
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 1, 9, 10, 1, 3, 25, 24);
        

-- For RoundRangeID: 24
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 10, 1, 6, 3, 9, 38, 24);
        

-- For RoundRangeID: 24
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 10, 7, 1, 10, 3, 36, 24);
        

-- For RoundRangeID: 24
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 7, 5, 4, 1, 7, 29, 24);
        

-- For RoundRangeID: 25
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 6, 3, 10, 10, 8, 47, 25);
        

-- For RoundRangeID: 25
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 1, 3, 4, 4, 10, 31, 25);
        

-- For RoundRangeID: 25
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 8, 3, 8, 10, 4, 38, 25);
        

-- For RoundRangeID: 25
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 6, 10, 4, 4, 2, 27, 25);
        

-- For RoundRangeID: 25
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 8, 8, 6, 2, 10, 38, 25);
        

-- For RoundRangeID: 26
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 10, 3, 5, 2, 1, 30, 26);
        

-- For RoundRangeID: 26
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 4, 3, 9, 7, 10, 41, 26);
        

-- For RoundRangeID: 26
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 9, 10, 10, 7, 1, 45, 26);
        

-- For RoundRangeID: 26
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 7, 9, 6, 10, 2, 42, 26);
        

-- For RoundRangeID: 26
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 6, 1, 4, 10, 2, 25, 26);
        

-- For RoundRangeID: 27
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 6, 8, 6, 9, 6, 42, 27);
        

-- For RoundRangeID: 27
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 1, 10, 6, 8, 1, 33, 27);
        

-- For RoundRangeID: 27
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 2, 2, 1, 3, 7, 19, 27);
        

-- For RoundRangeID: 27
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 3, 10, 5, 1, 6, 33, 27);
        

-- For RoundRangeID: 27
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 3, 9, 4, 3, 9, 30, 27);
        

-- For RoundRangeID: 28
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 5, 8, 3, 10, 7, 37, 28);
        

-- For RoundRangeID: 28
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 9, 5, 1, 10, 9, 43, 28);
        

-- For RoundRangeID: 28
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 3, 5, 10, 3, 5, 36, 28);
        

-- For RoundRangeID: 28
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 2, 1, 2, 8, 5, 28, 28);
        

-- For RoundRangeID: 28
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 3, 5, 7, 2, 7, 32, 28);
        

-- For RoundRangeID: 29
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 2, 7, 7, 8, 4, 36, 29);
        

-- For RoundRangeID: 29
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 10, 2, 6, 5, 1, 28, 29);
        

-- For RoundRangeID: 29
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 9, 3, 3, 1, 7, 25, 29);
        

-- For RoundRangeID: 29
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 7, 10, 7, 5, 10, 46, 29);
        

-- For RoundRangeID: 29
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 2, 1, 2, 5, 10, 27, 29);
        

-- For RoundRangeID: 30
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 3, 9, 2, 5, 6, 35, 30);
        

-- For RoundRangeID: 30
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 1, 1, 5, 9, 9, 32, 30);
        

-- For RoundRangeID: 30
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 2, 4, 2, 9, 3, 29, 30);
        

-- For RoundRangeID: 30
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 9, 1, 1, 9, 9, 37, 30);
        

-- For RoundRangeID: 30
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 7, 3, 8, 10, 1, 30, 30);
        

-- For RoundRangeID: 31
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 4, 5, 1, 5, 10, 28, 31);
        

-- For RoundRangeID: 31
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 7, 5, 2, 3, 3, 27, 31);
        

-- For RoundRangeID: 31
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 3, 6, 6, 9, 1, 30, 31);
        

-- For RoundRangeID: 31
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 2, 7, 4, 4, 1, 23, 31);
        

-- For RoundRangeID: 31
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 2, 1, 9, 4, 10, 29, 31);
        

-- For RoundRangeID: 32
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 7, 7, 6, 4, 10, 40, 32);
        

-- For RoundRangeID: 32
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 9, 5, 8, 2, 6, 39, 32);
        

-- For RoundRangeID: 32
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 3, 4, 8, 9, 5, 30, 32);
        

-- For RoundRangeID: 32
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 7, 3, 2, 7, 4, 25, 32);
        

-- For RoundRangeID: 32
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 6, 3, 8, 5, 6, 29, 32);
        

-- For RoundRangeID: 33
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 9, 3, 5, 3, 5, 29, 33);
        

-- For RoundRangeID: 33
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 2, 9, 10, 6, 8, 41, 33);
        

-- For RoundRangeID: 33
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 5, 9, 10, 9, 1, 36, 33);
        

-- For RoundRangeID: 33
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 9, 10, 2, 5, 3, 31, 33);
        

-- For RoundRangeID: 33
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 8, 2, 7, 7, 9, 40, 33);
        

-- For RoundRangeID: 34
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 7, 8, 6, 3, 1, 27, 34);
        

-- For RoundRangeID: 34
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 8, 8, 2, 5, 8, 37, 34);
        

-- For RoundRangeID: 34
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 9, 10, 5, 9, 5, 41, 34);
        

-- For RoundRangeID: 34
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 10, 7, 5, 2, 4, 32, 34);
        

-- For RoundRangeID: 34
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 5, 1, 7, 7, 6, 28, 34);
        

-- For RoundRangeID: 35
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 4, 5, 7, 6, 6, 30, 35);
        

-- For RoundRangeID: 35
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 7, 2, 9, 4, 4, 35, 35);
        

-- For RoundRangeID: 35
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 1, 8, 3, 8, 9, 32, 35);
        

-- For RoundRangeID: 35
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 4, 4, 4, 9, 6, 28, 35);
        

-- For RoundRangeID: 35
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 8, 8, 4, 6, 9, 39, 35);
        

-- For RoundRangeID: 36
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 10, 7, 8, 5, 7, 42, 36);
        

-- For RoundRangeID: 36
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 3, 2, 1, 8, 3, 23, 36);
        

-- For RoundRangeID: 36
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 7, 6, 5, 10, 5, 38, 36);
        

-- For RoundRangeID: 36
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 8, 1, 2, 9, 4, 30, 36);
        

-- For RoundRangeID: 36
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 10, 2, 2, 6, 1, 22, 36);
        

-- For RoundRangeID: 37
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 2, 3, 8, 9, 7, 37, 37);
        

-- For RoundRangeID: 37
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 8, 3, 5, 5, 3, 30, 37);
        

-- For RoundRangeID: 37
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 8, 6, 1, 6, 3, 29, 37);
        

-- For RoundRangeID: 37
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 10, 8, 5, 4, 10, 39, 37);
        

-- For RoundRangeID: 37
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 3, 10, 10, 5, 2, 40, 37);
        

-- For RoundRangeID: 38
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 6, 2, 10, 7, 6, 32, 38);
        

-- For RoundRangeID: 38
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 2, 1, 2, 5, 4, 19, 38);
        

-- For RoundRangeID: 38
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 4, 1, 7, 3, 8, 30, 38);
        

-- For RoundRangeID: 38
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 3, 7, 10, 8, 9, 46, 38);
        

-- For RoundRangeID: 38
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 3, 10, 8, 2, 6, 37, 38);
        

-- For RoundRangeID: 39
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 8, 8, 1, 4, 2, 28, 39);
        

-- For RoundRangeID: 39
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 9, 6, 4, 2, 5, 30, 39);
        

-- For RoundRangeID: 39
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 1, 2, 5, 3, 10, 27, 39);
        

-- For RoundRangeID: 39
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 1, 7, 5, 2, 6, 28, 39);
        

-- For RoundRangeID: 39
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 1, 6, 2, 4, 2, 21, 39);
        

-- For RoundRangeID: 40
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 6, 7, 7, 9, 6, 45, 40);
        

-- For RoundRangeID: 40
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 7, 10, 9, 3, 3, 36, 40);
        

-- For RoundRangeID: 40
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 6, 9, 2, 2, 10, 36, 40);
        

-- For RoundRangeID: 40
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 9, 6, 2, 8, 10, 36, 40);
        

-- For RoundRangeID: 40
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 10, 3, 2, 9, 5, 34, 40);
        

-- For RoundRangeID: 41
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 8, 10, 4, 8, 5, 38, 41);
        

-- For RoundRangeID: 41
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 2, 1, 6, 2, 4, 20, 41);
        

-- For RoundRangeID: 41
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 9, 7, 3, 9, 10, 46, 41);
        

-- For RoundRangeID: 41
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 10, 7, 8, 10, 5, 43, 41);
        

-- For RoundRangeID: 41
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 3, 7, 9, 7, 9, 41, 41);
        

-- For RoundRangeID: 42
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 3, 8, 1, 1, 6, 24, 42);
        

-- For RoundRangeID: 42
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 2, 3, 7, 2, 5, 24, 42);
        

-- For RoundRangeID: 42
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 10, 5, 2, 3, 6, 35, 42);
        

-- For RoundRangeID: 42
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 2, 8, 6, 3, 4, 33, 42);
        

-- For RoundRangeID: 42
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 2, 2, 9, 10, 4, 34, 42);
        

-- For RoundRangeID: 43
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 1, 9, 9, 2, 10, 32, 43);
        

-- For RoundRangeID: 43
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 5, 1, 2, 4, 8, 21, 43);
        

-- For RoundRangeID: 43
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 8, 7, 2, 6, 8, 34, 43);
        

-- For RoundRangeID: 43
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 8, 6, 8, 7, 7, 41, 43);
        

-- For RoundRangeID: 43
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 1, 1, 10, 9, 5, 31, 43);
        

-- For RoundRangeID: 44
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 5, 1, 2, 5, 9, 30, 44);
        

-- For RoundRangeID: 44
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 2, 4, 10, 4, 5, 27, 44);
        

-- For RoundRangeID: 44
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 2, 2, 10, 4, 6, 31, 44);
        

-- For RoundRangeID: 44
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 1, 9, 6, 5, 6, 30, 44);
        

-- For RoundRangeID: 44
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 5, 10, 4, 3, 8, 35, 44);
        

-- For RoundRangeID: 45
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 8, 1, 5, 7, 7, 33, 45);
        

-- For RoundRangeID: 45
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (8, 8, 4, 10, 6, 9, 45, 45);
        

-- For RoundRangeID: 45
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 6, 4, 5, 2, 4, 28, 45);
        

-- For RoundRangeID: 45
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 7, 5, 1, 8, 6, 34, 45);
        

-- For RoundRangeID: 45
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 6, 3, 2, 7, 2, 29, 45);
        

-- For RoundRangeID: 46
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 9, 3, 1, 9, 9, 38, 46);
        

-- For RoundRangeID: 46
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 3, 7, 8, 9, 10, 43, 46);
        

-- For RoundRangeID: 46
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 8, 8, 4, 3, 2, 28, 46);
        

-- For RoundRangeID: 46
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 4, 4, 7, 2, 4, 25, 46);
        

-- For RoundRangeID: 46
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 9, 1, 4, 2, 7, 25, 46);
        

-- For RoundRangeID: 47
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (9, 2, 2, 7, 4, 8, 32, 47);
        

-- For RoundRangeID: 47
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 6, 8, 10, 5, 6, 38, 47);
        

-- For RoundRangeID: 47
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 6, 9, 5, 10, 9, 42, 47);
        

-- For RoundRangeID: 47
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 5, 9, 6, 3, 9, 38, 47);
        

-- For RoundRangeID: 47
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 5, 3, 7, 3, 9, 33, 47);
        

-- For RoundRangeID: 48
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 3, 2, 7, 7, 8, 28, 48);
        

-- For RoundRangeID: 48
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 4, 1, 9, 10, 1, 27, 48);
        

-- For RoundRangeID: 48
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 2, 3, 7, 7, 5, 26, 48);
        

-- For RoundRangeID: 48
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 4, 4, 4, 2, 10, 29, 48);
        

-- For RoundRangeID: 48
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 4, 2, 10, 6, 6, 38, 48);
        

-- For RoundRangeID: 49
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (6, 8, 7, 5, 7, 4, 37, 49);
        

-- For RoundRangeID: 49
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 10, 8, 4, 6, 3, 35, 49);
        

-- For RoundRangeID: 49
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 5, 7, 6, 1, 9, 38, 49);
        

-- For RoundRangeID: 49
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (10, 5, 4, 7, 10, 6, 42, 49);
        

-- For RoundRangeID: 49
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (4, 3, 3, 1, 9, 2, 22, 49);
        

-- For RoundRangeID: 50
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (1, 2, 4, 6, 4, 10, 27, 50);
        

-- For RoundRangeID: 50
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (5, 1, 10, 7, 1, 2, 26, 50);
        

-- For RoundRangeID: 50
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (2, 3, 1, 1, 6, 1, 14, 50);
        

-- For RoundRangeID: 50
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (3, 5, 1, 9, 10, 10, 38, 50);
        

-- For RoundRangeID: 50
INSERT INTO EndScoreTable (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6, TotalEndScore, RoundRangeID)
VALUES (7, 8, 5, 7, 6, 6, 39, 50);
        

---------------------------------------------------------------------------------------
-- Insert into roundshoot table --


-- archer 100 shoot practise --         
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '14:30:00', 1, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '14:40:00', 2, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '14:49:00', 3, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '14:58:00', 4, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '15:07:00', 5, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '15:16:00', 6, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '15:25:00', 7, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '15:34:00', 8, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '15:43:00', 9, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '15:52:00', 10, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '16:01:00', 11, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '16:10:00', 12, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '16:19:00', 13, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '16:28:00', 14, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '16:37:00', 15, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '16:46:00', 16, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '16:55:00', 17, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '17:04:00', 18, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '17:13:00', 19, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '17:22:00', 20, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '17:31:00', 21, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '17:40:00', 22, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '17:49:00', 23, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(1, 1, '2022-03-15', '17:58:00', 24, 100);

-- archer 100 shoot Female Open Recurve WA70/1440 -- 
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '11:00:00', 73, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '11:07:00', 74, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '11:15:00', 75, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '11:22:00', 76, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '11:30:00', 77, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '11:35:00', 78, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '11:40:00', 79, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '11:47:00', 80, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '11:55:00', 81, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '12:00:00', 82, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '12:08:00', 83, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '12:15:00', 84, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '12:20:00', 85, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '12:28:00', 86, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '12:35:00', 87, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '12:40:00', 88, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '12:50:00', 89, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '12:57:00', 90, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '13:05:00', 91, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '13:10:00', 92, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '13:18:00', 93, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '13:25:00', 94, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '13:33:00', 95, 100);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(5, 23, '2022-03-19', '13:40:00', 96, 100);

-- archer 110 shoot Pearth practise --
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '10:40:00', 256, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '10:45:00', 257, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '10:50:00', 258, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '10:57:00', 259, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '11:05:00', 260, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '11:12:00', 261, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '11:18:00', 262, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '11:25:00', 263, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '11:30:00', 264, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '11:38:00', 265, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '11:43:00', 266, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '11:49:00', 267, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '11:55:00', 268, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '12:02:00', 269, 110);
INSERT INTO roundshoot(EquipmentID, CompetitionID, Shoot_Date, Shoot_Time, EndID, Archer_ID) VALUES(3, 13, '2022-03-27', '12:10:00', 270, 110);
