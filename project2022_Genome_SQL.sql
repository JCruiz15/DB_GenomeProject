-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Project2022_GenomicBD
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Project2022_GenomicBD` ;

-- -----------------------------------------------------
-- Schema Project2022_GenomicBD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Project2022_GenomicBD` DEFAULT CHARACTER SET utf8 ;
USE `Project2022_GenomicBD` ;

-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Organism`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Organism` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Organism` (
  `idOrganism` INT NOT NULL AUTO_INCREMENT,
  `Common name` VARCHAR(45) NULL,
  `Family` VARCHAR(45) NULL,
  `Spieces` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`idOrganism`),
  UNIQUE INDEX `idOrganism_UNIQUE` (`idOrganism` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Genome`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Genome` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Genome` (
  `idGenome` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL DEFAULT 'Unnamed',
  `Assembly` VARCHAR(45) NOT NULL,
  `Release_date` DATE NULL,
  `Release number` INT NOT NULL DEFAULT -1,
  `Organism_idOrganism` INT NOT NULL,
  PRIMARY KEY (`idGenome`),
  UNIQUE INDEX `idGenoma_UNIQUE` (`idGenome` ASC) VISIBLE,
  INDEX `fk_Genome_Organism_idx` (`Organism_idOrganism` ASC) VISIBLE,
  CONSTRAINT `fk_Genome_Organism`
    FOREIGN KEY (`Organism_idOrganism`)
    REFERENCES `Project2022_GenomicBD`.`Organism` (`idOrganism`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Gene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Gene` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Gene` (
  `idGene` INT NOT NULL AUTO_INCREMENT,
  `Location_start` INT NOT NULL DEFAULT 0,
  `Location_end` INT NOT NULL,
  `Sequence` LONGTEXT NOT NULL,
  `Description` VARCHAR(200) NULL,
  `Author` MEDIUMTEXT NULL,
  PRIMARY KEY (`idGene`),
  UNIQUE INDEX `idGene_UNIQUE` (`idGene` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Book` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Book` (
  `idBook` INT NOT NULL AUTO_INCREMENT,
  `TItle` VARCHAR(45) NOT NULL DEFAULT 'Untitled',
  `Author` VARCHAR(250) NOT NULL DEFAULT 'Anonymus',
  `Description` VARCHAR(200) NULL,
  PRIMARY KEY (`idBook`))
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Bookshelf`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Bookshelf` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Bookshelf` (
  `Genome_idGenome` INT NOT NULL,
  `Book_idBook` INT NOT NULL,
  PRIMARY KEY (`Genome_idGenome`, `Book_idBook`),
  INDEX `fk_Bookshelf_Book1_idx` (`Book_idBook` ASC) VISIBLE)
ENGINE = BLACKHOLE
COMMENT = 'B';


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Chromosome`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Chromosome` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Chromosome` (
  `Gene_idGene` INT NOT NULL,
  `ChromosomeNum` INT NOT NULL,
  `Genome_idGenome` INT NOT NULL,
  PRIMARY KEY (`Gene_idGene`, `Genome_idGenome`),
  INDEX `fk_Genome_has_Gene_Gene1_idx` (`Gene_idGene` ASC) VISIBLE,
  INDEX `fk_Chromosome_Genome1_idx` (`Genome_idGenome` ASC) VISIBLE,
  CONSTRAINT `fk_Genome_has_Gene_Gene1`
    FOREIGN KEY (`Gene_idGene`)
    REFERENCES `Project2022_GenomicBD`.`Gene` (`idGene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Chromosome_Genome1`
    FOREIGN KEY (`Genome_idGenome`)
    REFERENCES `Project2022_GenomicBD`.`Genome` (`idGenome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Protein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Protein` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Protein` (
  `idProtein` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Function` VARCHAR(200) NULL DEFAULT 'Unknown',
  `Transcript` LONGTEXT NULL,
  `Proteincol` VARCHAR(45) NULL,
  `Gene_idGene` INT NOT NULL,
  PRIMARY KEY (`idProtein`, `Gene_idGene`),
  INDEX `fk_Protein_Gene1_idx` (`Gene_idGene` ASC) VISIBLE,
  CONSTRAINT `fk_Protein_Gene1`
    FOREIGN KEY (`Gene_idGene`)
    REFERENCES `Project2022_GenomicBD`.`Gene` (`idGene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Sequence`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Sequence` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Sequence` (
  `RefSeq` INT NOT NULL AUTO_INCREMENT,
  `Sequence` LONGTEXT NOT NULL,
  `Type` VARCHAR(45) NULL DEFAULT 'Unknown',
  `Size` INT NULL,
  `Anomaly` VARCHAR(200) NULL,
  `Gene_idGene` INT NOT NULL,
  `Protein_idProtein` INT NOT NULL,
  PRIMARY KEY (`RefSeq`, `Gene_idGene`, `Protein_idProtein`),
  UNIQUE INDEX `RefSeq_UNIQUE` (`RefSeq` ASC) VISIBLE,
  INDEX `fk_Sequence_Gene1_idx` (`Gene_idGene` ASC) VISIBLE,
  INDEX `fk_Sequence_Protein1_idx` (`Protein_idProtein` ASC) VISIBLE,
  CONSTRAINT `fk_Sequence_Gene1`
    FOREIGN KEY (`Gene_idGene`)
    REFERENCES `Project2022_GenomicBD`.`Gene` (`idGene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sequence_Protein1`
    FOREIGN KEY (`Protein_idProtein`)
    REFERENCES `Project2022_GenomicBD`.`Protein` (`idProtein`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Project2022_GenomicBD`.`Organism`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project2022_GenomicBD`;
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (1, 'human', 'Homininae', 'Homo sapiens');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (2, 'mouse', 'Murinae', 'Mus musculus');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (3, 'dog', 'Laurasiatheria', 'Canis lupus');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (4, 'cattle', 'Bovidae', 'Bos taurus');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (5, 'sheep', 'Bovidae', 'Ovis aries');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (6, 'fruit fly', 'Diptera', 'Drosophila melanogaster');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (7, 'nematode', 'Ecdysozoa', 'Caenorhabditis');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (8, 'arabidopsis', 'rosids', 'Arabidopsis thaliana');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (9, 'zebrafish', 'Euteleostomi', 'Danio rerio');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (10, 'rice', 'Poaceae', 'Oryza sativa');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project2022_GenomicBD`.`Genome`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project2022_GenomicBD`;
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (1, 'Homo sapiens', 'GRCh38.p14', '2021-11-22', 109, 1);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (2, 'Mus musculus', 'GRCm39', '2020-09-22', 109, 2);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (3, 'Canis lupus', 'ROS_Cfam_1.0', '2021-01-08', 106, 3);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (4, 'Bos taurus', 'ARS-UCD1.2', '2018-05-11', 106, 4);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (5, 'Ovis aries', 'ARS-UI_Ramb_v2.0', '2021-06-03', 104, 5);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (6, 'Drosophila melanogaster', 'RELEASE 6 plus ISO1 MT', '2014-08-08', DEFAULT, 6);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (7, 'Caenorhabditis', 'WBcel235', '2013-03-04', DEFAULT, 7);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (8, 'Arabidopsis thaliana', 'TAIR10.1', '2018-06-04', DEFAULT, 8);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (9, 'Danio rerio', 'GRCz11', '2017-06-26', 106, 9);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (10, 'Oryza sativa', 'IRGSP-1.0', '2018-08-07', 102, 10);

COMMIT;

