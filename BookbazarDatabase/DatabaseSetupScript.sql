SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bookBazaar
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bookBazaar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bookBazaar` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `bookBazaar` ;

-- -----------------------------------------------------
-- Table `bookBazaar`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookBazaar`.`Users` (
  `PhoneNum` VARCHAR(10) NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Street` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `ZipCode` VARCHAR(45) NOT NULL,
  `IsAdmin` TINYINT(1) NOT NULL DEFAULT 0,
  `AvatarFileName` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PhoneNum`),
  UNIQUE INDEX `PhoneNum_UNIQUE` (`PhoneNum` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookBazaar`.`Books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookBazaar`.`Books` (
  `ISBN` INT(13) NOT NULL,
  `BookName` VARCHAR(45) NULL,
  `Author` VARCHAR(45) NULL,
  `FileName` VARCHAR(45) NULL,
  `Condition` VARCHAR(45) NULL,
  `Edition` VARCHAR(45) NULL,
  PRIMARY KEY (`ISBN`),
  UNIQUE INDEX `idBooks_UNIQUE` (`ISBN` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookBazaar`.`Postings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookBazaar`.`Postings` (
  `Books_ISBN` INT(13) NOT NULL,
  `User_PhoneNum` VARCHAR(10) NOT NULL,
  `Timeposted` DATETIME NOT NULL,
  PRIMARY KEY (`Books_ISBN`, `User_PhoneNum`),
  INDEX `fk_Postings_Books_idx` (`Books_ISBN` ASC),
  INDEX `fk_Postings_Users1_idx` (`User_PhoneNum` ASC),
  UNIQUE INDEX `Books_ISBN_UNIQUE` (`Books_ISBN` ASC),
  UNIQUE INDEX `User_PhoneNum_UNIQUE` (`User_PhoneNum` ASC),
  CONSTRAINT `fk_Postings_Books`
    FOREIGN KEY (`Books_ISBN`)
    REFERENCES `bookBazaar`.`Books` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Postings_Users1`
    FOREIGN KEY (`User_PhoneNum`)
    REFERENCES `bookBazaar`.`Users` (`PhoneNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookBazaar`.`Login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookBazaar`.`Login` (
  `UsersName` VARCHAR(12) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `User_PhoneNum` VARCHAR(10) NOT NULL,
  `Baned` TINYINT(1) NOT NULL DEFAULT 0,
  UNIQUE INDEX `UsersName_UNIQUE` (`UsersName` ASC),
  PRIMARY KEY (`User_PhoneNum`),
  CONSTRAINT `fk_Login_Users1`
    FOREIGN KEY (`User_PhoneNum`)
    REFERENCES `bookBazaar`.`Users` (`PhoneNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookBazaar`.`Abuse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookBazaar`.`Abuse` (
  `AbUsersNumber` INT NOT NULL AUTO_INCREMENT,
  `Report` VARCHAR(8000) NULL,
  `User_PhoneNum` VARCHAR(10) NOT NULL,
  `Solved` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`AbUsersNumber`, `User_PhoneNum`),
  UNIQUE INDEX `Abuse_UNIQUE` (`AbUsersNumber` ASC),
  INDEX `fk_Abuse_Users1_idx` (`User_PhoneNum` ASC),
  CONSTRAINT `fk_Abuse_Users1`
    FOREIGN KEY (`User_PhoneNum`)
    REFERENCES `bookBazaar`.`Users` (`PhoneNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookBazaar`.`timestamps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookBazaar`.`timestamps` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NULL);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
