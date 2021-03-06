-- MySQL Script generated by MySQL Workbench
-- Tue Nov 24 10:55:08 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`auto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`auto` (
  `id_auto` INT NOT NULL AUTO_INCREMENT,
  `manufacturer` VARCHAR(20) NOT NULL,
  `mileage` INT NOT NULL,
  `power` INT NOT NULL,
  `equipment` VARCHAR(20) NOT NULL,
  `body_type` VARCHAR(20) NOT NULL,
  `production_year` SMALLINT(4) NOT NULL,
  `number` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id_auto`),
  UNIQUE INDEX `id_auto_UNIQUE` (`id_auto` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id_user` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `login` VARCHAR(16) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`parking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`parking` (
  `parking_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`parking_id`),
  UNIQUE INDEX `address_UNIQUE` (`address` ASC) VISIBLE,
  UNIQUE INDEX `parking_id_UNIQUE` (`parking_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tariff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tariff` (
  `tariff_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `price` FLOAT UNSIGNED NOT NULL,
  `duration` TIME NOT NULL,
  `content` VARCHAR(300) NOT NULL,
  UNIQUE INDEX `tariff_id_UNIQUE` (`tariff_id` ASC) VISIBLE,
  PRIMARY KEY (`tariff_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`additional_service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`additional_service` (
  `add_service_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `price` FLOAT UNSIGNED NOT NULL,
  `title` VARCHAR(20) NOT NULL,
  `description` VARCHAR(300) NOT NULL,
  `type_of_service` ENUM('type1', 'type2', 'type3') NOT NULL,
  PRIMARY KEY (`add_service_id`),
  UNIQUE INDEX `add_service_id_UNIQUE` (`add_service_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`offer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`offer` (
  `id_offer` INT NOT NULL AUTO_INCREMENT,
  `auto_id` INT NOT NULL,
  `tariff_id` INT UNSIGNED NOT NULL,
  `parking_id` INT UNSIGNED NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `landlord_id` INT UNSIGNED NOT NULL,
  `image` VARCHAR(200) NOT NULL,
  `additional_service_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id_offer`),
  INDEX `auto_id_idx` (`auto_id` ASC) VISIBLE,
  INDEX `landlord_id_idx` (`landlord_id` ASC) VISIBLE,
  UNIQUE INDEX `id_offer_UNIQUE` (`id_offer` ASC) VISIBLE,
  INDEX `parking_id_idx` (`parking_id` ASC) VISIBLE,
  INDEX `tariff_id_idx` (`tariff_id` ASC) VISIBLE,
  INDEX `additional_service_id_idx` (`additional_service_id` ASC) VISIBLE,
  CONSTRAINT `auto_id`
    FOREIGN KEY (`auto_id`)
    REFERENCES `mydb`.`auto` (`id_auto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `landlord_id`
    FOREIGN KEY (`landlord_id`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `parking_id`
    FOREIGN KEY (`parking_id`)
    REFERENCES `mydb`.`parking` (`parking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tariff_id`
    FOREIGN KEY (`tariff_id`)
    REFERENCES `mydb`.`tariff` (`tariff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `additional_service_id`
    FOREIGN KEY (`additional_service_id`)
    REFERENCES `mydb`.`additional_service` (`add_service_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `id_order` INT NOT NULL AUTO_INCREMENT,
  `offer_id` INT NOT NULL,
  `booking_time` TIME NOT NULL,
  `total_cost` FLOAT NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_order`),
  INDEX `sentence_id_idx` (`offer_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `id_order_UNIQUE` (`id_order` ASC) VISIBLE,
  CONSTRAINT `offer_id`
    FOREIGN KEY (`offer_id`)
    REFERENCES `mydb`.`offer` (`id_offer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wallet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wallet` (
  `id_wallet` INT NOT NULL AUTO_INCREMENT,
  `balance` FLOAT NOT NULL,
  `user_wallet_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_wallet`),
  INDEX `user_id_idx` (`user_wallet_id` ASC) VISIBLE,
  UNIQUE INDEX `id_wallet_UNIQUE` (`id_wallet` ASC) VISIBLE,
  CONSTRAINT `user_wallet_id`
    FOREIGN KEY (`user_wallet_id`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`consultant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`consultant` (
  `consultant_id` INT(255) UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `login` VARCHAR(16) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `rating` DOUBLE UNSIGNED NOT NULL DEFAULT 0.00,
  `experience` TINYINT(100) UNSIGNED NOT NULL,
  PRIMARY KEY (`consultant_id`),
  UNIQUE INDEX `consultant_id_UNIQUE` (`consultant_id` ASC) VISIBLE,
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE,
  UNIQUE INDEX `mail_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dialog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dialog` (
  `dialog_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_dialog_id` INT UNSIGNED NOT NULL,
  `consultant_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`dialog_id`),
  UNIQUE INDEX `dialog_id_UNIQUE` (`dialog_id` ASC) VISIBLE,
  UNIQUE INDEX `user_dialog_id_UNIQUE` (`user_dialog_id` ASC) VISIBLE,
  UNIQUE INDEX `konsulent_id_UNIQUE` (`consultant_id` ASC) VISIBLE,
  CONSTRAINT `user_dialog_id`
    FOREIGN KEY (`user_dialog_id`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `consultant_id`
    FOREIGN KEY (`consultant_id`)
    REFERENCES `mydb`.`consultant` (`consultant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`message` (
  `message_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dialog_id` INT UNSIGNED NOT NULL,
  `content` VARCHAR(1000) NOT NULL,
  `send_time` DATETIME NOT NULL,
  PRIMARY KEY (`message_id`),
  UNIQUE INDEX `message_id_UNIQUE` (`message_id` ASC) VISIBLE,
  UNIQUE INDEX `sender_id_UNIQUE` (`dialog_id` ASC) VISIBLE,
  CONSTRAINT `dialog_id`
    FOREIGN KEY (`dialog_id`)
    REFERENCES `mydb`.`dialog` (`dialog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`props`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`props` (
  `props_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` ENUM("online_wallet", "mobile", "bank_card") NOT NULL,
  `number_online_wallet` VARCHAR(20) NULL DEFAULT NULL,
  `number_mobile` VARCHAR(20) NULL DEFAULT NULL,
  `number_bank_card` VARCHAR(45) NULL DEFAULT NULL,
  `name_type` VARCHAR(20) NOT NULL,
  `wallet_id` INT NOT NULL,
  PRIMARY KEY (`props_id`),
  UNIQUE INDEX `number_online_wallet_UNIQUE` (`number_online_wallet` ASC) VISIBLE,
  UNIQUE INDEX `number_mobile_UNIQUE` (`number_mobile` ASC) VISIBLE,
  UNIQUE INDEX `number_bank_card_UNIQUE` (`number_bank_card` ASC) VISIBLE,
  UNIQUE INDEX `props_id_UNIQUE` (`props_id` ASC) VISIBLE,
  INDEX `wallet_id_idx` (`wallet_id` ASC) VISIBLE,
  CONSTRAINT `wallet_id`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `mydb`.`wallet` (`id_wallet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reception_point`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reception_point` (
  `reception_point_id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(60) NOT NULL,
  `working_time` TIME NOT NULL,
  PRIMARY KEY (`reception_point_id`),
  UNIQUE INDEX `idreception_point_id_UNIQUE` (`reception_point_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`question_answer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`question_answer` (
  `question_answer_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(50) NOT NULL,
  `content` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`question_answer_id`),
  UNIQUE INDEX `question_answer_id_UNIQUE` (`question_answer_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`appeal_ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`appeal_ticket` (
  `appeal_ticket_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `content` VARCHAR(1000) NOT NULL,
  `user_ticket_id` INT UNSIGNED NOT NULL,
  `status` TINYINT(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`appeal_ticket_id`),
  UNIQUE INDEX `appeal_ticket_id_UNIQUE` (`appeal_ticket_id` ASC) VISIBLE,
  INDEX `user_ticket_id_idx` (`user_ticket_id` ASC) VISIBLE,
  CONSTRAINT `user_ticket_id`
    FOREIGN KEY (`user_ticket_id`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
