-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 06, 2014 at 11:03 AM
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
CREATE DATABASE `bookBazaar` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bookBazaar`;

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
  `Timeposted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Price` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`Books_ISBN`,`User_PhoneNum`),
  KEY `fk_Postings_Books_idx` (`Books_ISBN`),
  KEY `fk_Postings_Users1_idx` (`User_PhoneNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Postings`
--

INSERT INTO `Postings` (`Books_ISBN`, `User_PhoneNum`, `Timeposted`, `Price`) VALUES
('1234567890122', '1122334455', '2014-12-04 02:20:41', '50.00'),
('1234567890122', '8761518469', '2014-12-06 17:53:10', '54'),
('1234567890123', '1122334455', '2014-12-17 18:36:20', '520.00'),
('1234567890123', '8761518469', '2014-12-01 19:34:48', '94.32'),
('1234567890127', '8218721898', '2014-12-01 18:00:00', '615.21'),
('1234567890127', '8761518469', '2014-12-03 19:34:00', '62'),
('1234567890127', '9887517851', '2014-12-11 01:48:00', '9.00'),
('1234567890129', '7892584562', '2014-12-05 17:36:30', '93.00'),
('1234578987', '1234567890', '2014-12-03 07:37:46', '123'),
('8465213652464', '1122334455', '2014-12-04 20:00:00', '5.02'),
('8465213652464', '7892584562', '2014-12-25 20:26:37', '6.23'),
('9865432151588', '1122334455', '2014-11-05 00:51:00', '65.42'),
('9865432151588', '7892584562', '2014-11-05 18:39:00', '42.00');

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

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE IF NOT EXISTS `post` (
  `postID` int(10) NOT NULL AUTO_INCREMENT,
  `userID` int(10) NOT NULL,
  `ISBN_num` varchar(50) NOT NULL,
  `bookName` varchar(100) NOT NULL,
  `bookAuthor` varchar(100) NOT NULL,
  `bookCondition` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bookPrice` float NOT NULL,
  `imagePath` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`postID`),
  KEY `FOREIGN` (`userID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`postID`, `userID`, `ISBN_num`, `bookName`, `bookAuthor`, `bookCondition`, `timestamp`, `bookPrice`, `imagePath`) VALUES
(1, 1, '12345', 'The Facts of Life', 'Wade Wilkey', 'Wonderful', '2014-12-04 08:27:49', 1000000, 'book1.jpg'),
(12, 22, '87987098', 'So Many Touchdowns', 'Joe Montana', 'Great\n', '2014-12-04 18:42:43', 49, 'book2.jpg'),
(13, 22, '89089080', 'Me and Joe', '', 'Okay', '2014-12-04 16:30:07', 345, 'book3.jpg'),
(15, 22, '12-389-2398-0', 'I Love Math', '', 'Good', '2014-12-04 16:30:48', 67.5, 'book5.jpg'),
(16, 22, '1-2-3377', 'Textbook', '', 'Poor', '2014-12-04 16:31:00', 56, 'book6.jpg'),
(18, 22, '28797-748', 'New One', '', 'A''ight', '2014-12-04 16:31:27', 60, 'book8.jpg'),
(19, 24, '2985098', 'Hey There', '', 'Seen Better Days', '2014-12-04 16:31:13', 302, 'book9.jpg'),
(21, 25, '1280-38973-2', 'Grease', '', '45.00', '2014-12-04 18:46:08', 45, 'book4.jpg'),
(22, 24, '2389798', 'Science', '', '56', '2014-12-04 18:46:08', 56, 'book7.jpg'),
(24, 24, '1-34-5879', 'Geology Book', 'Rocks', 'Pretty Good', '2014-12-04 18:46:08', 34, 'book2.jpg'),
(25, 26, '3945720938', 'Science', 'Science Man', 'Great', '2014-12-04 19:31:33', 100, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `timestamps`
--

CREATE TABLE IF NOT EXISTS `timestamps` (
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `emailAddr` varchar(50) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT '0',
  `city` varchar(50) NOT NULL DEFAULT 'Unknown',
  `state` varchar(2) NOT NULL DEFAULT 'NA',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=27 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `firstName`, `lastName`, `emailAddr`, `phoneNumber`, `isAdmin`, `city`, `state`) VALUES
(1, 'cs3450', 'cs3450', 'Test', 'User', '', '', 1, 'Unknown', 'NA'),
(4, 'johntest', 'test', 'john', 'doe', 'john.doe@gmail.com', '1234567890', 0, 'Logan', 'UT'),
(5, 'test', 'test', 'test', 'test', 'test', 'test', 0, 'test', 'te'),
(6, 'servTest', 'servTest', 'Service', 'Test', 'serv.test@gmail.com', '4353838383', 0, 'Logan', 'UT'),
(11, 'servTesr', 'servTest', 'Service', 'Test', 'serv.test@gmail.com', '4353838383', 0, 'Logan', 'UT'),
(21, 'john', 'john', 'John', 'Doe', 'john.doe@gmail.com', '4444444444', 0, 'Smithfield', 'UT'),
(22, 'papajoe', 'joejoe', 'Joe', 'Montana', 'joe.monty@gm.com', '1234898', 1, 'San Fran', 'UT'),
(23, 'Jim', 'jim', 'Jim', 'Halpert', 'jimjim@halpert.com', '', 0, 'Utica', 'UT'),
(24, 'admin', 'admin', 'admin', 'admin', 'admin@bookbazaar.com', '1234567890', 1, 'NA', 'NA'),
(25, 'johnnyt', 'joe', 'John', 'Travolta', 'johnnyt@t.com', '132413897', 0, 'LA', 'UT'),
(26, 'user', 'user', 'User', 'User', 'user@user.com', '1233454564', 0, 'Logan', 'UT');

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

--
-- Constraints for table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `post_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
