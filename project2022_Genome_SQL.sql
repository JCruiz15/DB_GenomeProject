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
  `Lab` VARCHAR(45) NULL DEFAULT 'Unknown',
  `Release_date` DATE NULL,
  `Release number` INT NOT NULL,
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
  INDEX `fk_Bookshelf_Genome1_idx` (`Genome_idGenome` ASC) VISIBLE,
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
