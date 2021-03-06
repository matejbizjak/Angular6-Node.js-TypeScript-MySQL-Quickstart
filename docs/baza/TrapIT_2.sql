-- MySQL Script generated by MySQL Workbench
-- Tue Jun 19 13:01:23 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema trapit
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `trapit` ;

-- -----------------------------------------------------
-- Schema trapit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `trapit` DEFAULT CHARACTER SET utf8 ;
USE `trapit` ;

-- -----------------------------------------------------
-- Table `trapit`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trapit`.`role` ;

CREATE TABLE IF NOT EXISTS `trapit`.`role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE INDEX `role_UNIQUE` (`role` ASC),
  UNIQUE INDEX `role_id_UNIQUE` (`role_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trapit`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trapit`.`user` ;

CREATE TABLE IF NOT EXISTS `trapit`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(256) NOT NULL,
  `password` VARCHAR(64) NOT NULL,
  `role_id` INT NOT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `user_role_fk_idx` (`role_id` ASC),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC),
  CONSTRAINT `user_role_fk`
    FOREIGN KEY (`role_id`)
    REFERENCES `trapit`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trapit`.`site`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trapit`.`site` ;

CREATE TABLE IF NOT EXISTS `trapit`.`site` (
  `site_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`site_id`),
  UNIQUE INDEX `site_id_UNIQUE` (`site_id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trapit`.`path`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trapit`.`path` ;

CREATE TABLE IF NOT EXISTS `trapit`.`path` (
  `path_id` INT NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`path_id`),
  UNIQUE INDEX `path_id_UNIQUE` (`path_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trapit`.`media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trapit`.`media` ;

CREATE TABLE IF NOT EXISTS `trapit`.`media` (
  `media_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `name` VARCHAR(64) NOT NULL,
  `empty` TINYINT NOT NULL DEFAULT 1,
  `image` TINYINT NOT NULL DEFAULT 1,
  `interesting` TINYINT NOT NULL,
  `comment` TEXT NULL,
  `site_id` INT NOT NULL,
  `path_id` INT NOT NULL,
  PRIMARY KEY (`media_id`),
  UNIQUE INDEX `media_id_UNIQUE` (`media_id` ASC),
  INDEX `media_site_fk_idx` (`site_id` ASC),
  INDEX `media_path_fk_idx` (`path_id` ASC),
  CONSTRAINT `media_site_fk`
    FOREIGN KEY (`site_id`)
    REFERENCES `trapit`.`site` (`site_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `media_path_fk`
    FOREIGN KEY (`path_id`)
    REFERENCES `trapit`.`path` (`path_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trapit`.`tag_value`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trapit`.`tag_value` ;

CREATE TABLE IF NOT EXISTS `trapit`.`tag_value` (
  `tag_value_id` INT NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(64) NOT NULL,
  `input` TINYINT NOT NULL DEFAULT 0,
  `tag_id` INT NOT NULL,
  PRIMARY KEY (`tag_value_id`),
  UNIQUE INDEX `tag_value_id_UNIQUE` (`tag_value_id` ASC),
  INDEX `tag_tag_value_fk_idx` (`tag_id` ASC),
  CONSTRAINT `tag_tag_value_fk`
    FOREIGN KEY (`tag_id`)
    REFERENCES `trapit`.`tag` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trapit`.`tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trapit`.`tag` ;

CREATE TABLE IF NOT EXISTS `trapit`.`tag` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `parent_tag_value_id` INT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE INDEX `tag_id_UNIQUE` (`tag_id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_tag_parent_tag_value_idx` (`parent_tag_value_id` ASC),
  CONSTRAINT `fk_tag_parent_tag_value`
    FOREIGN KEY (`parent_tag_value_id`)
    REFERENCES `trapit`.`tag_value` (`tag_value_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trapit`.`media_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trapit`.`media_tag` ;

CREATE TABLE IF NOT EXISTS `trapit`.`media_tag` (
  `media_tag_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  `media_id` INT NOT NULL,
  `tag_value_id` INT NOT NULL,
  `input_value` INT NULL,
  UNIQUE INDEX `media_tag_id_UNIQUE` (`media_tag_id` ASC),
  PRIMARY KEY (`media_tag_id`),
  INDEX `media_tag_user_fk_idx` (`user_id` ASC),
  INDEX `media_tag_tag_fk_idx` (`tag_id` ASC),
  INDEX `media_tag_media_fk_idx` (`media_id` ASC),
  INDEX `media_tag_tag_value_fk_idx` (`tag_value_id` ASC),
  CONSTRAINT `media_tag_user_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `trapit`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `media_tag_tag_fk`
    FOREIGN KEY (`tag_id`)
    REFERENCES `trapit`.`tag` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `media_tag_media_fk`
    FOREIGN KEY (`media_id`)
    REFERENCES `trapit`.`media` (`media_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `media_tag_tag_value_fk`
    FOREIGN KEY (`tag_value_id`)
    REFERENCES `trapit`.`tag_value` (`tag_value_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trapit`.`project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trapit`.`project` ;

CREATE TABLE IF NOT EXISTS `trapit`.`project` (
  `project_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`project_id`),
  UNIQUE INDEX `project_id_UNIQUE` (`project_id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trapit`.`project_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trapit`.`project_tag` ;

CREATE TABLE IF NOT EXISTS `trapit`.`project_tag` (
  `project_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  PRIMARY KEY (`project_id`, `tag_id`),
  INDEX `project_tag_tag_idx` (`tag_id` ASC),
  CONSTRAINT `project_tag_project_fk`
    FOREIGN KEY (`project_id`)
    REFERENCES `trapit`.`project` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `project_tag_tag_fk`
    FOREIGN KEY (`tag_id`)
    REFERENCES `trapit`.`tag` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
