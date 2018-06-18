-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema elections
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema elections
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `elections` DEFAULT CHARACTER SET utf8 ;
USE `elections` ;
USE `elections` ;

-- -----------------------------------------------------
-- Placeholder table for view `elections`.`cand_per_inst/sex`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`cand_per_inst/sex` (`Escolaridade` INT, `TotalMasc` INT, `TotalFem` INT, `Total` INT);

-- -----------------------------------------------------
-- Placeholder table for view `elections`.`cand_per_party`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`cand_per_party` (`partyAbbv` INT, `Presidentes` INT, `Governadores` INT, `Senadores` INT, `DepFederais` INT, `DepEstaduais` INT, `TotalPartido` INT);

-- -----------------------------------------------------
-- Placeholder table for view `elections`.`cand_per_region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`cand_per_region` (`Região` INT, `Presidentes` INT, `Governadores` INT, `Senadores` INT, `DepFederais` INT, `DepEstaduais` INT, `TotalRegião` INT);

-- -----------------------------------------------------
-- Placeholder table for view `elections`.`cand_per_state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`cand_per_state` (`Estado` INT, `Presidentes` INT, `Governadores` INT, `Senadores` INT, `DepFederais` INT, `DepEstaduais` INT, `TotalEstado` INT);

-- -----------------------------------------------------
-- Placeholder table for view `elections`.`global_participation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`global_participation` (`Eleitorado` INT, `Participantes1Turno` INT, `Participantes2Turno` INT, `PercPart1Turno` INT, `PercPart2Turno` INT, `Faltantes1Turno` INT, `Faltantes2Turno` INT, `Justificativas1Turno` INT, `Justificativas2Turno` INT, `TotalVotos` INT, `VotosValidos` INT, `PercVotosManuais` INT);

-- -----------------------------------------------------
-- Placeholder table for view `elections`.`participation_per_region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`participation_per_region` (`Região` INT, `PercVotante` INT, `NumVotos` INT);

-- -----------------------------------------------------
-- Placeholder table for view `elections`.`participation_per_state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`participation_per_state` (`Estado` INT, `PercVotante` INT, `NumVotos` INT);

-- -----------------------------------------------------
-- Placeholder table for view `elections`.`votes_per_party`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elections`.`votes_per_party` (`Partido` INT, `Votos1Turno` INT, `Votos2Turno` INT, `VotosTotais` INT, `CandVotados` INT);

-- -----------------------------------------------------
-- procedure get_candidates
-- -----------------------------------------------------

DELIMITER $$
USE `elections`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_candidates`(varState BIGINT, varCargo BIGINT)
BEGIN
	IF varCargo > 1 THEN    
		SELECT * FROM candidates WHERE idCity IN(
		SELECT idCity FROM cities WHERE idState = varState
		) AND idCargo = varCargo;
	ELSE
		SELECT * FROM candidates WHERE idCargo = 1;
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_result
-- -----------------------------------------------------

DELIMITER $$
USE `elections`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_result`(varCargo BIGINT, varState BIGINT, varRound BIGINT)
BEGIN
	IF varCargo > 1 THEN
		SELECT	personFirstName AS PrimeiroNome, 
        personLastName AS UltimoNome,
		candidateNumber AS Numero,
		partyAbbv AS Partido,
        COUNT(votes.idVote) AS Votos,
        (COUNT(votes.idVote)/total_votes(varCargo,varState,varRound))*100 AS PercVotes
		FROM zone_candidates AS votes
        INNER JOIN candidates AS cand ON votes.idCandidate = cand.idCandidate
        INNER JOIN parties AS part ON part.idParty = cand.idParty
        INNER JOIN people AS peop ON peop.idPerson = cand.idPerson
        INNER JOIN cities AS city ON city.idCity = cand.idCity
        INNER JOIN states AS stat ON stat.idState = city.idState
        WHERE votes.idCandidate > 0 AND cand.idCargo = varCargo AND stat.idState = varState AND idRound = varRound
        GROUP BY personFirstName ORDER BY PercVotes DESC;
	ELSE
		SELECT	personFirstName AS PrimeiroNome, 
        personLastName AS UltimoNome, 
		candidateNumber AS Numero,
		partyAbbv AS Partido,
        COUNT(votes.idVote) AS Votos,
        (COUNT(votes.idVote)/total_votes(varCargo,varState,varRound))*100 AS PercVotes
		FROM zone_candidates AS votes
        INNER JOIN candidates AS cand ON votes.idCandidate = cand.idCandidate
        INNER JOIN parties AS part ON part.idParty = cand.idParty
        INNER JOIN people AS peop ON peop.idPerson = cand.idPerson
        WHERE votes.idCandidate > 0 AND cand.idCargo = 1 AND idRound = varRound
        GROUP BY personFirstName ORDER BY PercVotes DESC;
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function total_votes
-- -----------------------------------------------------

DELIMITER $$
USE `elections`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `total_votes`(varCargo BIGINT, varState BIGINT, varRound BIGINT) RETURNS bigint(20)
BEGIN
	DECLARE num BIGINT;
    DECLARE cur1 CURSOR FOR
    SELECT COUNT(votes.idVote) AS Votos
    FROM zone_candidates AS votes
        INNER JOIN candidates AS cand ON votes.idCandidate = cand.idCandidate
        INNER JOIN cities AS city ON city.idCity = cand.idCity
        INNER JOIN states AS stat ON stat.idState = city.idState
        WHERE votes.idCandidate > 0 AND cand.idCargo = varCargo AND stat.idState = varState AND votes.idRound = varState;
        
	OPEN cur1;
    FETCH cur1 into num;
    CLOSE cur1;
RETURN num;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `elections`.`cand_per_inst/sex`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elections`.`cand_per_inst/sex`;
USE `elections`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `elections`.`cand_per_inst/sex` AS select `edu`.`educationName` AS `Escolaridade`,count((case when (`peop`.`personSex` = 'M') then 1 end)) AS `TotalMasc`,count((case when (`peop`.`personSex` = 'F') then 1 end)) AS `TotalFem`,count((case when `peop`.`idPerson` then 1 end)) AS `Total` from ((`elections`.`candidates` `cand` join `elections`.`people` `peop` on((`peop`.`idPerson` = `cand`.`idPerson`))) join `elections`.`educations` `edu` on((`edu`.`idEducation` = `peop`.`idEducation`))) group by `edu`.`educationName` order by `Total` desc;

-- -----------------------------------------------------
-- View `elections`.`cand_per_party`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elections`.`cand_per_party`;
USE `elections`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `elections`.`cand_per_party` AS select `elections`.`parties`.`partyAbbv` AS `partyAbbv`,count((case when (`elections`.`candidates`.`idCargo` = 1) then 1 end)) AS `Presidentes`,count((case when (`elections`.`candidates`.`idCargo` = 2) then 1 end)) AS `Governadores`,count((case when (`elections`.`candidates`.`idCargo` = 3) then 1 end)) AS `Senadores`,count((case when (`elections`.`candidates`.`idCargo` = 4) then 1 end)) AS `DepFederais`,count((case when (`elections`.`candidates`.`idCargo` = 5) then 1 end)) AS `DepEstaduais`,count(0) AS `TotalPartido` from (`elections`.`candidates` join `elections`.`parties` on((`elections`.`candidates`.`idParty` = `elections`.`parties`.`idParty`))) group by `elections`.`parties`.`partyAbbv`;

-- -----------------------------------------------------
-- View `elections`.`cand_per_region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elections`.`cand_per_region`;
USE `elections`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `elections`.`cand_per_region` AS select `elections`.`regions`.`regionName` AS `Região`,count((case when (`elections`.`candidates`.`idCargo` = 1) then 1 end)) AS `Presidentes`,count((case when (`elections`.`candidates`.`idCargo` = 2) then 1 end)) AS `Governadores`,count((case when (`elections`.`candidates`.`idCargo` = 3) then 1 end)) AS `Senadores`,count((case when (`elections`.`candidates`.`idCargo` = 4) then 1 end)) AS `DepFederais`,count((case when (`elections`.`candidates`.`idCargo` = 5) then 1 end)) AS `DepEstaduais`,count(0) AS `TotalRegião` from (((`elections`.`candidates` join `elections`.`cities` on((`elections`.`cities`.`idCity` = `elections`.`candidates`.`idCity`))) join `elections`.`states` on((`elections`.`states`.`idState` = `elections`.`cities`.`idState`))) join `elections`.`regions` on((`elections`.`regions`.`idRegion` = `elections`.`states`.`idRegion`))) group by `elections`.`regions`.`regionName`;

-- -----------------------------------------------------
-- View `elections`.`cand_per_state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elections`.`cand_per_state`;
USE `elections`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `elections`.`cand_per_state` AS select `elections`.`states`.`stateName` AS `Estado`,count((case when (`elections`.`candidates`.`idCargo` = 1) then 1 end)) AS `Presidentes`,count((case when (`elections`.`candidates`.`idCargo` = 2) then 1 end)) AS `Governadores`,count((case when (`elections`.`candidates`.`idCargo` = 3) then 1 end)) AS `Senadores`,count((case when (`elections`.`candidates`.`idCargo` = 4) then 1 end)) AS `DepFederais`,count((case when (`elections`.`candidates`.`idCargo` = 5) then 1 end)) AS `DepEstaduais`,count(0) AS `TotalEstado` from ((`elections`.`candidates` join `elections`.`cities` on((`elections`.`cities`.`idCity` = `elections`.`candidates`.`idCity`))) join `elections`.`states` on((`elections`.`states`.`idState` = `elections`.`cities`.`idState`))) group by `elections`.`states`.`stateName`;

-- -----------------------------------------------------
-- View `elections`.`global_participation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elections`.`global_participation`;
USE `elections`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `elections`.`global_participation` AS select (select count(0) from `elections`.`electors`) AS `Eleitorado`,(select count(0) from `elections`.`round_electors` where ((`elections`.`round_electors`.`electorVoted` = 1) and (`elections`.`round_electors`.`idRound` = 1))) AS `Participantes1Turno`,(select count(0) from `elections`.`round_electors` where ((`elections`.`round_electors`.`electorVoted` = 1) and (`elections`.`round_electors`.`idRound` = 2))) AS `Participantes2Turno`,(select (avg(`elections`.`round_electors`.`electorVoted`) * 100) from `elections`.`round_electors` where (`elections`.`round_electors`.`idRound` = 1)) AS `PercPart1Turno`,(select (avg(`elections`.`round_electors`.`electorVoted`) * 100) from `elections`.`round_electors` where (`elections`.`round_electors`.`idRound` = 2)) AS `PercPart2Turno`,(select count(0) from `elections`.`round_electors` where ((`elections`.`round_electors`.`electorVoted` = 0) and (`elections`.`round_electors`.`idRound` = 1))) AS `Faltantes1Turno`,(select count(0) from `elections`.`round_electors` where ((`elections`.`round_electors`.`electorVoted` = 0) and (`elections`.`round_electors`.`idRound` = 2))) AS `Faltantes2Turno`,(select count(0) from `elections`.`round_electors` where ((`elections`.`round_electors`.`electorJustified` = 1) and (`elections`.`round_electors`.`idRound` = 1))) AS `Justificativas1Turno`,(select count(0) from `elections`.`round_electors` where ((`elections`.`round_electors`.`electorJustified` = 1) and (`elections`.`round_electors`.`idRound` = 2))) AS `Justificativas2Turno`,(select count(0) from `elections`.`zone_candidates`) AS `TotalVotos`,(select count(0) from `elections`.`zone_candidates` where (`elections`.`zone_candidates`.`idCandidate` <> 0)) AS `VotosValidos`,(select (avg(`elections`.`zone_candidates`.`voteIsManual`) * 100) from `elections`.`zone_candidates`) AS `PercVotosManuais`;

-- -----------------------------------------------------
-- View `elections`.`participation_per_region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elections`.`participation_per_region`;
USE `elections`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `elections`.`participation_per_region` AS select `reg`.`regionName` AS `Região`,(avg(`part`.`electorVoted`) * 100) AS `PercVotante`,count((case when (`part`.`electorVoted` = 1) then 1 end)) AS `NumVotos` from ((((((`elections`.`electors` `elec` join `elections`.`round_electors` `part` on((`part`.`idElector` = `elec`.`idElector`))) join `elections`.`zones` `zon` on((`elec`.`idZone` = `zon`.`idZone`))) join `elections`.`addresses` `addr` on((`zon`.`idAddress` = `addr`.`idAddress`))) join `elections`.`cities` `city` on((`city`.`idCity` = `addr`.`idCity`))) join `elections`.`states` `stat` on((`stat`.`idState` = `city`.`idState`))) join `elections`.`regions` `reg` on((`reg`.`idRegion` = `stat`.`idRegion`))) group by `reg`.`regionName` order by `PercVotante`;

-- -----------------------------------------------------
-- View `elections`.`participation_per_state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elections`.`participation_per_state`;
USE `elections`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `elections`.`participation_per_state` AS select `stat`.`stateName` AS `Estado`,(avg(`part`.`electorVoted`) * 100) AS `PercVotante`,count((case when (`part`.`electorVoted` = 1) then 1 end)) AS `NumVotos` from (((((`elections`.`electors` `elec` join `elections`.`round_electors` `part` on((`part`.`idElector` = `elec`.`idElector`))) join `elections`.`zones` `zon` on((`elec`.`idZone` = `zon`.`idZone`))) join `elections`.`addresses` `addr` on((`zon`.`idAddress` = `addr`.`idAddress`))) join `elections`.`cities` `city` on((`city`.`idCity` = `addr`.`idCity`))) join `elections`.`states` `stat` on((`stat`.`idState` = `city`.`idState`))) group by `stat`.`stateName` order by `PercVotante`;

-- -----------------------------------------------------
-- View `elections`.`votes_per_party`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elections`.`votes_per_party`;
USE `elections`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `elections`.`votes_per_party` AS select `part`.`partyAbbv` AS `Partido`,count((case when (`votes`.`idCandidate` and (`votes`.`idRound` = 1)) then 1 end)) AS `Votos1Turno`,count((case when (`votes`.`idCandidate` and (`votes`.`idRound` = 2)) then 1 end)) AS `Votos2Turno`,count((case when `votes`.`idCandidate` then 1 end)) AS `VotosTotais`,count(distinct `votes`.`idCandidate`) AS `CandVotados` from ((`elections`.`candidates` `cand` join `elections`.`zone_candidates` `votes` on((`votes`.`idCandidate` = `cand`.`idCandidate`))) join `elections`.`parties` `part` on((`part`.`idParty` = `cand`.`idParty`))) where (`votes`.`idCandidate` > 0) group by `part`.`partyAbbv` order by `VotosTotais` desc;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
