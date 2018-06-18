-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema elections
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `elections` ;

-- -----------------------------------------------------
-- Schema elections
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `elections` DEFAULT CHARACTER SET utf8 ;
USE `elections` ;

-- -----------------------------------------------------
-- Table `elections`.`regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`regions` (
  `idRegion` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `regionName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idRegion`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`states` (
  `idState` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `stateName` VARCHAR(20) NOT NULL,
  `stateAbbv` VARCHAR(2) NOT NULL,
  `idRegion` BIGINT(20) NOT NULL,
  `stateFlag` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`idState`),
  INDEX `State_Region_idx` (`idRegion` ASC),
  CONSTRAINT `State_Region`
    FOREIGN KEY (`idRegion`)
    REFERENCES `elections`.`regions` (`idRegion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`cities` (
  `idCity` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `cityName` VARCHAR(50) NOT NULL,
  `idState` BIGINT(20) NOT NULL,
  PRIMARY KEY (`idCity`),
  INDEX `City_State_idx` (`idState` ASC),
  CONSTRAINT `City_State`
    FOREIGN KEY (`idState`)
    REFERENCES `elections`.`states` (`idState`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2081
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`addresses` (
  `idAddress` BIGINT(20) NOT NULL,
  `addressName` VARCHAR(70) NOT NULL,
  `idCity` BIGINT(20) NOT NULL,
  PRIMARY KEY (`idAddress`),
  INDEX `Address_City_idx` (`idCity` ASC),
  CONSTRAINT `Address_City`
    FOREIGN KEY (`idCity`)
    REFERENCES `elections`.`cities` (`idCity`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`cargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`cargos` (
  `idCargo` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `cargoName` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idCargo`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`educations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`educations` (
  `idEducation` BIGINT(20) NOT NULL,
  `educationName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idEducation`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`people` (
  `idPerson` BIGINT(20) NOT NULL,
  `personFirstName` VARCHAR(20) NOT NULL,
  `personLastName` VARCHAR(40) NOT NULL,
  `personBirthDate` DATE NOT NULL,
  `personSex` ENUM('M', 'F') NOT NULL,
  `idAddress` BIGINT(20) NOT NULL,
  `idEducation` BIGINT(20) NOT NULL,
  PRIMARY KEY (`idPerson`),
  INDEX `Elector_Address_idx` (`idAddress` ASC),
  INDEX `Elector_Scholar_idx` (`idEducation` ASC),
  CONSTRAINT `Elector_Address`
    FOREIGN KEY (`idAddress`)
    REFERENCES `elections`.`addresses` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Elector_Scholar`
    FOREIGN KEY (`idEducation`)
    REFERENCES `elections`.`educations` (`idEducation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`parties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`parties` (
  `idParty` BIGINT(20) NOT NULL,
  `partyName` VARCHAR(60) NOT NULL,
  `partyAbbv` VARCHAR(7) NOT NULL,
  `idPerson` BIGINT(20) NOT NULL,
  `partyLogo` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`idParty`),
  UNIQUE INDEX `partyAbbv_UNIQUE` (`partyAbbv` ASC),
  INDEX `Party_Person_idx` (`idPerson` ASC),
  CONSTRAINT `Party_Person`
    FOREIGN KEY (`idPerson`)
    REFERENCES `elections`.`people` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`candidates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`candidates` (
  `idCandidate` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `candidateNumber` BIGINT(20) NOT NULL,
  `idPerson` BIGINT(20) NOT NULL,
  `idParty` BIGINT(20) NOT NULL,
  `idCargo` BIGINT(20) NOT NULL,
  `idCity` BIGINT(20) NOT NULL,
  `candidatePhoto` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`idCandidate`),
  INDEX `Candidate_Cargo_idx` (`idCargo` ASC),
  INDEX `Candidate_Party_idx` (`idParty` ASC),
  INDEX `Candidate_Person_idx` (`idPerson` ASC),
  INDEX `Candidate_City_idx` (`idCity` ASC),
  CONSTRAINT `Candidate_Cargo`
    FOREIGN KEY (`idCargo`)
    REFERENCES `elections`.`cargos` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Candidate_City`
    FOREIGN KEY (`idCity`)
    REFERENCES `elections`.`cities` (`idCity`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Candidate_Party`
    FOREIGN KEY (`idParty`)
    REFERENCES `elections`.`parties` (`idParty`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Candidate_Person`
    FOREIGN KEY (`idPerson`)
    REFERENCES `elections`.`people` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 20689
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`cargo_states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`cargo_states` (
  `idCargo` BIGINT(20) NOT NULL,
  `idState` BIGINT(20) NOT NULL,
  `cargoAmount` INT(11) NOT NULL,
  PRIMARY KEY (`idCargo`, `idState`),
  INDEX `Amount_State_idx` (`idState` ASC),
  CONSTRAINT `Amount_Cargo`
    FOREIGN KEY (`idCargo`)
    REFERENCES `elections`.`cargos` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Amount_State`
    FOREIGN KEY (`idState`)
    REFERENCES `elections`.`states` (`idState`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`zones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`zones` (
  `idZone` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `numZone` INT(11) NOT NULL,
  `idAddress` BIGINT(20) NOT NULL,
  PRIMARY KEY (`idZone`, `numZone`, `idAddress`),
  INDEX `Zone_Addr_idx` (`idAddress` ASC),
  CONSTRAINT `Zone_Addr`
    FOREIGN KEY (`idAddress`)
    REFERENCES `elections`.`addresses` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2388
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`electors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`electors` (
  `idElector` BIGINT(20) NOT NULL,
  `idPerson` BIGINT(20) NOT NULL,
  `idZone` BIGINT(20) NOT NULL,
  `issueDate` DATE NOT NULL,
  PRIMARY KEY (`idElector`),
  INDEX `Elector_Zone_idx` (`idZone` ASC),
  INDEX `Elector_Person_idx` (`idPerson` ASC),
  CONSTRAINT `Elector_Person`
    FOREIGN KEY (`idPerson`)
    REFERENCES `elections`.`people` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Elector_Zone`
    FOREIGN KEY (`idZone`)
    REFERENCES `elections`.`zones` (`idZone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`rounds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`rounds` (
  `idRound` BIGINT(20) NOT NULL DEFAULT '1',
  `roundDate` DATE NOT NULL,
  PRIMARY KEY (`idRound`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`round_candidates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`round_candidates` (
  `idRound` BIGINT(20) NOT NULL,
  `idCandidate` BIGINT(20) NOT NULL,
  PRIMARY KEY (`idRound`, `idCandidate`),
  INDEX `Round_Candidate_idx` (`idCandidate` ASC),
  CONSTRAINT `CRound`
    FOREIGN KEY (`idRound`)
    REFERENCES `elections`.`rounds` (`idRound`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Round_Candidate`
    FOREIGN KEY (`idCandidate`)
    REFERENCES `elections`.`candidates` (`idCandidate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`round_electors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`round_electors` (
  `idRound` BIGINT(20) NOT NULL,
  `idElector` BIGINT(20) NOT NULL,
  `electorVoted` TINYINT(4) NOT NULL DEFAULT '0',
  `electorJustified` TINYINT(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idRound`, `idElector`),
  INDEX `Round_Elector_idx` (`idElector` ASC),
  CONSTRAINT `ERound`
    FOREIGN KEY (`idRound`)
    REFERENCES `elections`.`rounds` (`idRound`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Round_Elector`
    FOREIGN KEY (`idElector`)
    REFERENCES `elections`.`electors` (`idElector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `elections`.`zone_candidates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`zone_candidates` (
  `idVote` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `idCandidate` BIGINT(20) NOT NULL DEFAULT '0',
  `idZone` BIGINT(20) NOT NULL,
  `idRound` BIGINT(20) NOT NULL,
  `voteTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `voteIsManual` TINYINT(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idVote`),
  INDEX `Vote_Zone_idx` (`idZone` ASC),
  INDEX `Vote_Round_idx` (`idRound` ASC),
  INDEX `Vote_Candidate_idx` (`idCandidate` ASC),
  CONSTRAINT `Vote_Candidate`
    FOREIGN KEY (`idCandidate`)
    REFERENCES `elections`.`candidates` (`idCandidate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Vote_Round`
    FOREIGN KEY (`idRound`)
    REFERENCES `elections`.`rounds` (`idRound`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Vote_Zone`
    FOREIGN KEY (`idZone`)
    REFERENCES `elections`.`zones` (`idZone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5001
DEFAULT CHARACTER SET = utf8;

USE `elections`;

DELIMITER $$
USE `elections`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `elections`.`candidates_AFTER_INSERT`
AFTER INSERT ON `elections`.`candidates`
FOR EACH ROW
BEGIN
	INSERT INTO round_candidates VALUES(1, NEW.idCandidate);
END$$

USE `elections`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `elections`.`electors_AFTER_INSERT`
AFTER INSERT ON `elections`.`electors`
FOR EACH ROW
BEGIN
	INSERT INTO `round_electors`(idRound, idElector) VALUES(1, NEW.idElector);
    INSERT INTO `round_electors`(idRound, idElector) VALUES(2, NEW.idElector);
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
