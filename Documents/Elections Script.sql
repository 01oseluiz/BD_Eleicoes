-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Elections
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Elections` ;

-- -----------------------------------------------------
-- Schema Elections
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Elections` DEFAULT CHARACTER SET utf8 ;
USE `Elections` ;

-- -----------------------------------------------------
-- Table `Elections`.`regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`regions` (
  `idRegion` BIGINT NOT NULL AUTO_INCREMENT,
  `regionName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idRegion`));


-- -----------------------------------------------------
-- Table `Elections`.`states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`states` (
  `idState` BIGINT NOT NULL AUTO_INCREMENT,
  `stateName` VARCHAR(20) NOT NULL,
  `stateAbbv` VARCHAR(2) NOT NULL,
  `idRegion` BIGINT NOT NULL,
  `stateFlag` BLOB NULL,
  PRIMARY KEY (`idState`),
  INDEX `State_Region_idx` (`idRegion` ASC),
  CONSTRAINT `State_Region`
    FOREIGN KEY (`idRegion`)
    REFERENCES `Elections`.`regions` (`idRegion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elections`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`cities` (
  `idCity` BIGINT NOT NULL AUTO_INCREMENT,
  `cityName` VARCHAR(50) NOT NULL,
  `idState` BIGINT NOT NULL,
  PRIMARY KEY (`idCity`),
  INDEX `City_State_idx` (`idState` ASC),
  CONSTRAINT `City_State`
    FOREIGN KEY (`idState`)
    REFERENCES `Elections`.`states` (`idState`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elections`.`cargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`cargos` (
  `idCargo` BIGINT NOT NULL AUTO_INCREMENT,
  `cargoName` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idCargo`));


-- -----------------------------------------------------
-- Table `Elections`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`addresses` (
  `idAddress` BIGINT NOT NULL,
  `addressName` VARCHAR(70) NOT NULL,
  `idCity` BIGINT NOT NULL,
  PRIMARY KEY (`idAddress`),
  INDEX `Address_City_idx` (`idCity` ASC),
  CONSTRAINT `Address_City`
    FOREIGN KEY (`idCity`)
    REFERENCES `Elections`.`cities` (`idCity`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elections`.`educations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`educations` (
  `idEducation` BIGINT NOT NULL,
  `educationName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idEducation`));


-- -----------------------------------------------------
-- Table `Elections`.`people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`people` (
  `idPerson` BIGINT NOT NULL,
  `personFirstName` VARCHAR(20) NOT NULL,
  `personLastName` VARCHAR(40) NOT NULL,
  `personBirthDate` DATE NOT NULL,
  `personSex` ENUM('M', 'F') NOT NULL,
  `idAddress` BIGINT NOT NULL,
  `idEducation` BIGINT NOT NULL,
  PRIMARY KEY (`idPerson`),
  INDEX `Elector_Address_idx` (`idAddress` ASC),
  INDEX `Elector_Scholar_idx` (`idEducation` ASC),
  CONSTRAINT `Elector_Address`
    FOREIGN KEY (`idAddress`)
    REFERENCES `Elections`.`addresses` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Elector_Scholar`
    FOREIGN KEY (`idEducation`)
    REFERENCES `Elections`.`educations` (`idEducation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elections`.`parties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`parties` (
  `idParty` BIGINT NOT NULL,
  `partyName` VARCHAR(60) NOT NULL,
  `partyAbbv` VARCHAR(7) NOT NULL,
  `idPerson` BIGINT NOT NULL,
  `partyLogo` BLOB NULL,
  PRIMARY KEY (`idParty`),
  UNIQUE INDEX `partyAbbv_UNIQUE` (`partyAbbv` ASC),
  INDEX `Party_Person_idx` (`idPerson` ASC),
  CONSTRAINT `Party_Person`
    FOREIGN KEY (`idPerson`)
    REFERENCES `Elections`.`people` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elections`.`candidates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`candidates` (
  `idCandidate` BIGINT NOT NULL,
  `idPerson` BIGINT NOT NULL,
  `idParty` BIGINT NOT NULL,
  `idCargo` BIGINT NOT NULL,
  `idCity` BIGINT NOT NULL,
  `candidatePhoto` BLOB NULL,
  INDEX `Candidate_Cargo_idx` (`idCargo` ASC),
  INDEX `Candidate_Party_idx` (`idParty` ASC),
  INDEX `Candidate_Person_idx` (`idPerson` ASC),
  PRIMARY KEY (`idCandidate`),
  INDEX `Candidate_City_idx` (`idCity` ASC),
  CONSTRAINT `Candidate_Cargo`
    FOREIGN KEY (`idCargo`)
    REFERENCES `Elections`.`cargos` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Candidate_Party`
    FOREIGN KEY (`idParty`)
    REFERENCES `Elections`.`parties` (`idParty`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Candidate_Person`
    FOREIGN KEY (`idPerson`)
    REFERENCES `Elections`.`people` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Candidate_City`
    FOREIGN KEY (`idCity`)
    REFERENCES `Elections`.`cities` (`idCity`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elections`.`zones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`zones` (
  `idZone` BIGINT NOT NULL AUTO_INCREMENT,
  `numZone` INT NOT NULL,
  `idAddress` BIGINT NOT NULL,
  PRIMARY KEY (`idZone`, `numZone`, `idAddress`),
  INDEX `Zone_Addr_idx` (`idAddress` ASC),
  CONSTRAINT `Zone_Addr`
    FOREIGN KEY (`idAddress`)
    REFERENCES `Elections`.`addresses` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elections`.`electors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`electors` (
  `idElector` BIGINT NOT NULL,
  `idPerson` BIGINT NOT NULL,
  `idZone` BIGINT NOT NULL,
  `issueDate` DATE NOT NULL,
  PRIMARY KEY (`idElector`),
  INDEX `Elector_Zone_idx` (`idZone` ASC),
  INDEX `Elector_Person_idx` (`idPerson` ASC),
  CONSTRAINT `Elector_Zone`
    FOREIGN KEY (`idZone`)
    REFERENCES `Elections`.`zones` (`idZone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Elector_Person`
    FOREIGN KEY (`idPerson`)
    REFERENCES `Elections`.`people` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elections`.`rounds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`rounds` (
  `idRound` BIGINT NOT NULL DEFAULT 1,
  `roundDate` DATE NOT NULL,
  PRIMARY KEY (`idRound`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elections`.`zone_candidates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`zone_candidates` (
  `idVote` BIGINT NOT NULL AUTO_INCREMENT,
  `idCandidate` BIGINT NOT NULL DEFAULT 0,
  `idZone` BIGINT NOT NULL,
  `idRound` BIGINT NOT NULL,
  `voteTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `voteIsManual` TINYINT NOT NULL DEFAULT 0,
  INDEX `Vote_Zone_idx` (`idZone` ASC),
  INDEX `Vote_Round_idx` (`idRound` ASC),
  PRIMARY KEY (`idVote`),
  CONSTRAINT `Vote_Candidate`
    FOREIGN KEY (`idCandidate`)
    REFERENCES `Elections`.`candidates` (`idCandidate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Vote_Zone`
    FOREIGN KEY (`idZone`)
    REFERENCES `Elections`.`zones` (`idZone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Vote_Round`
    FOREIGN KEY (`idRound`)
    REFERENCES `Elections`.`rounds` (`idRound`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elections`.`cargo_states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`cargo_states` (
  `idCargo` BIGINT NOT NULL,
  `idState` BIGINT NOT NULL,
  `cargoAmount` INT NOT NULL,
  PRIMARY KEY (`idCargo`, `idState`),
  INDEX `Amount_State_idx` (`idState` ASC),
  CONSTRAINT `Amount_Cargo`
    FOREIGN KEY (`idCargo`)
    REFERENCES `Elections`.`cargos` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Amount_State`
    FOREIGN KEY (`idState`)
    REFERENCES `Elections`.`states` (`idState`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elections`.`round_electors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`round_electors` (
  `idRound` BIGINT NOT NULL,
  `idElector` BIGINT NOT NULL,
  `electorVoted` TINYINT NOT NULL DEFAULT 0,
  `electorJustified` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idRound`, `idElector`),
  INDEX `Round_Elector_idx` (`idElector` ASC),
  CONSTRAINT `ERound`
    FOREIGN KEY (`idRound`)
    REFERENCES `Elections`.`rounds` (`idRound`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Round_Elector`
    FOREIGN KEY (`idElector`)
    REFERENCES `Elections`.`electors` (`idElector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elections`.`round_candidates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elections`.`round_candidates` (
  `idRound` BIGINT NOT NULL,
  `idCandidate` BIGINT NOT NULL,
  PRIMARY KEY (`idRound`, `idCandidate`),
  INDEX `Round_Candidate_idx` (`idCandidate` ASC),
  CONSTRAINT `CRound`
    FOREIGN KEY (`idRound`)
    REFERENCES `Elections`.`rounds` (`idRound`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Round_Candidate`
    FOREIGN KEY (`idCandidate`)
    REFERENCES `Elections`.`candidates` (`idCandidate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
