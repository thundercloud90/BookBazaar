-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 06, 2014 at 10:20 AM
-- Server version: 5.5.31
-- PHP Version: 5.4.4-14+deb7u7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `bookBazaar`
--

-- --------------------------------------------------------

--
-- Table structure for table `Abuse`
--

CREATE TABLE IF NOT EXISTS `Abuse` (
  `AbusersNumber` int(11) NOT NULL AUTO_INCREMENT,
  `Report` varchar(8000) DEFAULT NULL,
  `User_PhoneNum` varchar(10) NOT NULL,
  `Solved` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`AbusersNumber`,`User_PhoneNum`),
  UNIQUE KEY `Abuse_UNIQUE` (`AbusersNumber`),
  KEY `fk_Abuse_Users1_idx` (`User_PhoneNum`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `Abuse`
--

INSERT INTO `Abuse` (`AbusersNumber`, `Report`, `User_PhoneNum`, `Solved`) VALUES
(1, 'Fraud', '1234567890', 0),
(2, 'I want to be like mike', '7894560123', 0),
(3, 'He deserves a high five', '7894560123', 0),
(4, 'Go aggies', '8761518469', 1),
(5, 'Your welcome', '8218721898', 0);

-- --------------------------------------------------------

--
-- Table structure for table `Books`
--

CREATE TABLE IF NOT EXISTS `Books` (
  `ISBN` varchar(13) NOT NULL,
  `BookName` varchar(45) DEFAULT NULL,
  `Author` varchar(45) DEFAULT NULL,
  `FileName` varchar(45) DEFAULT NULL,
  `Condition` varchar(45) DEFAULT NULL,
  `Edition` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ISBN`),
  UNIQUE KEY `idBooks_UNIQUE` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Books`
--

INSERT INTO `Books` (`ISBN`, `BookName`, `Author`, `FileName`, `Condition`, `Edition`) VALUES
('1234567890122', 'We Are Water', '', 'default.jpg', '', '87'),
('1234567890123', 'Ender''s Game (The Ender Quintet, #1) ', 'Orson Scott Card ', 'default.jpg', 'new', '1'),
('1234567890124', 'The Journey to the Polar Sea', 'Franklin, Sir. John', 'default.jpg', 'old', NULL),
('1234567890126', 'Dune (Dune Chronicles, #1) ', '', 'default.jpg', '', NULL),
('1234567890127', '1984 ', '', 'default.jpg', '', '4'),
('1234567890129', 'Backpacking with the Saints', 'Lane, Belden C.', 'default.jpg', '', NULL),
('1234578987', 'Banana', 'Author', NULL, NULL, ''),
('7845816548421', 'Melt in Your Mouth', 'Chappell, Melissa', 'default.jpg', 'new', '5'),
('8465213652464', 'The Lives of Others', 'Michael Crichton ', 'default.jpg', '', NULL),
('8974621852469', 'Introduction to Quasi-Monte Carlo Integration', 'Leobacher, Gunther', 'default.jpg', '', NULL),
('9865432151588', 'Naked Addiction', '', 'default.jpg', '', '8th');

-- --------------------------------------------------------

--
-- Table structure for table `Login`
--

CREATE TABLE IF NOT EXISTS `Login` (
  `UsersName` varchar(50) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `User_PhoneNum` varchar(10) NOT NULL,
  `Baned` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`User_PhoneNum`),
  UNIQUE KEY `UsersName_UNIQUE` (`UsersName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Login`
--

INSERT INTO `Login` (`UsersName`, `Password`, `User_PhoneNum`, `Baned`) VALUES
('JoShamo@gmail.com', '123456', '1122334455', 0),
('StanTheMan@yahoo.com', '123456', '1234567890', 0),
('MassYra@re.c', '123456', '7892584562', 1),
('theonering@m', '123456', '7894560123', 0),
('biggunGuy@in', '123456', '8218721898', 0),
('Ithinkican@g', '123456', '8761518469', 1),
('saturdaynigh', '123456', '9632587410', 0),
('Imakemyown@h', '123456', '9887517851', 0);

-- --------------------------------------------------------

--
-- Table structure for table `Postings`
--

CREATE TABLE IF NOT EXISTS `Postings` (
  `Books_ISBN` varchar(13) NOT NULL,
  `User_PhoneNum` varchar(10) NOT NULL,
  `Timeposted` datetime NOT NULL,
  `Price` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`Books_ISBN`,`User_PhoneNum`),
  KEY `fk_Postings_Books_idx` (`Books_ISBN`),
  KEY `fk_Postings_Users1_idx` (`User_PhoneNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Postings`
--

INSERT INTO `Postings` (`Books_ISBN`, `User_PhoneNum`, `Timeposted`, `Price`) VALUES
('1234567890122', '1122334455', '0000-00-00 00:00:00', '50.00'),
('1234567890123', '1122334455', '2014-12-17 11:36:20', '520.00'),
('1234567890123', '8761518469', '0000-00-00 00:00:00', NULL),
('1234567890127', '8218721898', '0000-00-00 00:00:00', NULL),
('1234567890127', '8761518469', '0000-00-00 00:00:00', NULL),
('1234567890127', '9887517851', '0000-00-00 00:00:00', NULL),
('1234567890129', '7892584562', '0000-00-00 00:00:00', NULL),
('1234578987', '1234567890', '0000-00-00 00:00:00', '123'),
('8465213652464', '1122334455', '0000-00-00 00:00:00', NULL),
('8465213652464', '7892584562', '0000-00-00 00:00:00', NULL),
('9865432151588', '1122334455', '0000-00-00 00:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE IF NOT EXISTS `Users` (
  `PhoneNum` varchar(10) NOT NULL,
  `FirstName` varchar(45) NOT NULL,
  `LastName` varchar(45) NOT NULL,
  `Street` varchar(45) NOT NULL,
  `City` varchar(45) NOT NULL,
  `State` varchar(45) NOT NULL,
  `ZipCode` varchar(45) NOT NULL,
  `IsAdmin` tinyint(1) NOT NULL DEFAULT '0',
  `AvatarFileName` varchar(45) DEFAULT NULL,
  `Email` varchar(45) NOT NULL,
  PRIMARY KEY (`PhoneNum`),
  UNIQUE KEY `PhoneNum_UNIQUE` (`PhoneNum`),
  UNIQUE KEY `Email_UNIQUE` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`PhoneNum`, `FirstName`, `LastName`, `Street`, `City`, `State`, `ZipCode`, `IsAdmin`, `AvatarFileName`, `Email`) VALUES
('1122334455', 'Jo', 'Shamo', '9818 street dr', 'Logan', 'utah', '84321', 0, 'myfile.png', 'JoShamo@gmail.com'),
('1234567890', 'Stan', 'The Man', '45 Yo House way', 'ThatOne', 'utah', '84084', 1, 'myfile.png', 'StanTheMan@yahoo.com'),
('7892584562', 'Barney', 'Thedinosoure', '123 abc', '98 sesmee st', 'kiddies', '74568', 0, 'Default.jpg', 'MassYra@re.com'),
('7894560123', 'Bilbo', 'Baggins', '1 holeintheground st', 'Shire', 'MiddleEarth', '85274', 1, 'Default.jpg', 'theonering@morador.gov'),
('8218721898', 'Clit', 'Eastwood', '123 Dirty Harry ln', 'Feelingluck', 'Areya', '45784', 0, 'Default.jpg', 'biggunGuy@inyoface.com'),
('8761518469', 'Happy', 'Feet', '485 asdf dr', 'lkjhpoiu', 'zawsx', '98487', 0, 'Default.jpg', 'Ithinkican@gmail.com'),
('9632587410', 'Josh', 'Massy', '45 Yo House way', 'lkjhpoiu', 'Texus', '52140', 0, 'Default.jpg', 'saturdaynightride@now.net'),
('9887517851', 'Darth', 'Vader', '9875 DeathStar rd.', 'A Galaxy', 'Far Far Away', '99999', 0, 'Default.jpg', 'Imakemyown@happyhome.net');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Abuse`
--
ALTER TABLE `Abuse`
  ADD CONSTRAINT `fk_Abuse_Users1` FOREIGN KEY (`User_PhoneNum`) REFERENCES `Users` (`PhoneNum`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Login`
--
ALTER TABLE `Login`
  ADD CONSTRAINT `fk_Login_Users1` FOREIGN KEY (`User_PhoneNum`) REFERENCES `Users` (`PhoneNum`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Postings`
--
ALTER TABLE `Postings`
  ADD CONSTRAINT `fk_Postings_Books` FOREIGN KEY (`Books_ISBN`) REFERENCES `Books` (`ISBN`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Postings_Users1` FOREIGN KEY (`User_PhoneNum`) REFERENCES `Users` (`PhoneNum`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
