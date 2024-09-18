-- MySQL Script generated by MySQL Workbench
-- Wed Sep 18 18:01:09 2024
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
-- Table `mydb`.`hotel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`hotel` ;

CREATE TABLE IF NOT EXISTS `mydb`.`hotel` (
  `idhotel` INT NOT NULL,
  `hotel_name` VARCHAR(45) NOT NULL,
  `hotel_address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idhotel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`status` ;

CREATE TABLE IF NOT EXISTS `mydb`.`status` (
  `idstatus` INT NOT NULL,
  `status_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idstatus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`special_amenity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`special_amenity` ;

CREATE TABLE IF NOT EXISTS `mydb`.`special_amenity` (
  `idspecial_amenity` INT NOT NULL,
  `special_amenity_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idspecial_amenity`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `idcustomer` INT NOT NULL,
  `surname` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `booking_history` VARCHAR(250) NULL,
  `hotel_idhotel` INT NOT NULL,
  PRIMARY KEY (`idcustomer`),
  INDEX `fk_customer_hotel1_idx` (`hotel_idhotel` ASC) VISIBLE,
  CONSTRAINT `fk_customer_hotel1`
    FOREIGN KEY (`hotel_idhotel`)
    REFERENCES `mydb`.`hotel` (`idhotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reservation_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`reservation_status` ;

CREATE TABLE IF NOT EXISTS `mydb`.`reservation_status` (
  `idreservation_status` INT NOT NULL,
  `reservation_status_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idreservation_status`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`room_reservation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`room_reservation` ;

CREATE TABLE IF NOT EXISTS `mydb`.`room_reservation` (
  `reservation_id` INT NOT NULL,
  `arrival` DATE NOT NULL,
  `departure` DATE NOT NULL,
  `number_of_guests` INT NOT NULL,
  `customer_idcustomer` INT NOT NULL,
  `reservation_status_idreservation_status` INT NOT NULL,
  PRIMARY KEY (`reservation_id`, `customer_idcustomer`, `reservation_status_idreservation_status`),
  INDEX `fk_room_reservation_customer1_idx` (`customer_idcustomer` ASC) VISIBLE,
  INDEX `fk_room_reservation_reservation_status1_idx` (`reservation_status_idreservation_status` ASC) VISIBLE,
  CONSTRAINT `fk_room_reservation_customer1`
    FOREIGN KEY (`customer_idcustomer`)
    REFERENCES `mydb`.`customer` (`idcustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_reservation_reservation_status1`
    FOREIGN KEY (`reservation_status_idreservation_status`)
    REFERENCES `mydb`.`reservation_status` (`idreservation_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`room` ;

CREATE TABLE IF NOT EXISTS `mydb`.`room` (
  `idroom` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `price_per_night` DECIMAL NOT NULL,
  `hotel_idhotel` INT NOT NULL,
  `status_idstatus` INT NOT NULL,
  `special_amenity_idspecial_amenity` INT NOT NULL,
  `room_reservation_reservation_id` INT NOT NULL,
  `room_reservation_customer_idcustomer` INT NOT NULL,
  PRIMARY KEY (`idroom`, `hotel_idhotel`, `status_idstatus`),
  INDEX `fk_room_hotel_idx` (`hotel_idhotel` ASC) VISIBLE,
  INDEX `fk_room_status1_idx` (`status_idstatus` ASC) VISIBLE,
  INDEX `fk_room_special_amenity1_idx` (`special_amenity_idspecial_amenity` ASC) VISIBLE,
  INDEX `fk_room_room_reservation1_idx` (`room_reservation_reservation_id` ASC, `room_reservation_customer_idcustomer` ASC) VISIBLE,
  CONSTRAINT `fk_room_hotel`
    FOREIGN KEY (`hotel_idhotel`)
    REFERENCES `mydb`.`hotel` (`idhotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_status1`
    FOREIGN KEY (`status_idstatus`)
    REFERENCES `mydb`.`status` (`idstatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_special_amenity1`
    FOREIGN KEY (`special_amenity_idspecial_amenity`)
    REFERENCES `mydb`.`special_amenity` (`idspecial_amenity`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_room_reservation1`
    FOREIGN KEY (`room_reservation_reservation_id` , `room_reservation_customer_idcustomer`)
    REFERENCES `mydb`.`room_reservation` (`reservation_id` , `customer_idcustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer_feedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customer_feedback` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customer_feedback` (
  `idcustomer_feedback` INT NOT NULL,
  `overall_rating` VARCHAR(45) NOT NULL,
  `customer_feedbackcol` VARCHAR(45) NOT NULL,
  `customer_idcustomer` INT NOT NULL,
  PRIMARY KEY (`idcustomer_feedback`),
  INDEX `fk_customer_feedback_customer1_idx` (`customer_idcustomer` ASC) VISIBLE,
  CONSTRAINT `fk_customer_feedback_customer1`
    FOREIGN KEY (`customer_idcustomer`)
    REFERENCES `mydb`.`customer` (`idcustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bill_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`bill_status` ;

CREATE TABLE IF NOT EXISTS `mydb`.`bill_status` (
  `idbill_status` INT NOT NULL,
  `status_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idbill_status`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`billing_and_payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`billing_and_payment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`billing_and_payment` (
  `idbilling_and_payment` INT NOT NULL,
  `cost_of_rooms` DECIMAL NOT NULL,
  `additional_service_used` VARCHAR(45) NULL,
  `applicable_taxes` DECIMAL NULL,
  `payment_method` VARCHAR(45) NOT NULL,
  `bill_status_idbill_status` INT NOT NULL,
  `customer_idcustomer` INT NOT NULL,
  PRIMARY KEY (`idbilling_and_payment`, `bill_status_idbill_status`, `customer_idcustomer`),
  INDEX `fk_billing_and_payment_bill_status1_idx` (`bill_status_idbill_status` ASC) VISIBLE,
  INDEX `fk_billing_and_payment_customer1_idx` (`customer_idcustomer` ASC) VISIBLE,
  CONSTRAINT `fk_billing_and_payment_bill_status1`
    FOREIGN KEY (`bill_status_idbill_status`)
    REFERENCES `mydb`.`bill_status` (`idbill_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_billing_and_payment_customer1`
    FOREIGN KEY (`customer_idcustomer`)
    REFERENCES `mydb`.`customer` (`idcustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hotel_service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`hotel_service` ;

CREATE TABLE IF NOT EXISTS `mydb`.`hotel_service` (
  `idhotel_service` INT NOT NULL,
  `service_name` VARCHAR(100) NOT NULL,
  `price` DECIMAL NOT NULL,
  `hotel_idhotel` INT NOT NULL,
  `customer_idcustomer` INT NOT NULL,
  PRIMARY KEY (`idhotel_service`, `hotel_idhotel`),
  INDEX `fk_hotel_service_hotel1_idx` (`hotel_idhotel` ASC) VISIBLE,
  INDEX `fk_hotel_service_customer1_idx` (`customer_idcustomer` ASC) VISIBLE,
  CONSTRAINT `fk_hotel_service_hotel1`
    FOREIGN KEY (`hotel_idhotel`)
    REFERENCES `mydb`.`hotel` (`idhotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hotel_service_customer1`
    FOREIGN KEY (`customer_idcustomer`)
    REFERENCES `mydb`.`customer` (`idcustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
