-- MySQL Script generated by MySQL Workbench
-- Mon Nov 29 14:34:41 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
 DROP DATABASE IF EXISTS OnlineRetailDB2; 
 CREATE DATABASE IF NOT EXISTS OnlineRetailDB2; 
 USE OnlineRetailDB2; 
-- -----------------------------------------------------
-- Table `general_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `general_user` ;

CREATE TABLE IF NOT EXISTS `general_user` (
  `user_id` INT(9) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `is_registered` TINYINT(2) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `region` ;

CREATE TABLE IF NOT EXISTS `region` (
  `region_id` INT(9) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip_code` INT(5) NOT NULL,
  PRIMARY KEY (`region_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payment_method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `payment_method` ;

CREATE TABLE IF NOT EXISTS `payment_method` (
  `payment_id` INT(10) NOT NULL COMMENT 'PaymentType - 1. Credit card, 2. Debit Card, 3. GooglePay',
  `billing_address` VARCHAR(100) NOT NULL,
  `payment_type` VARCHAR(30) NOT NULL,
  `billing_amount` INT(5) NOT NULL,
  PRIMARY KEY (`payment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `account` ;

CREATE TABLE IF NOT EXISTS `account` (
  `account_id` INT(9) NOT NULL,
  `general_user` INT(9) NOT NULL,
  `account_type` TINYINT(2) NOT NULL,
  `region` INT(9) NULL,
  `date_created` DATETIME NOT NULL,
  `default_payment_method_id` INT(10) NULL,
  PRIMARY KEY (`account_id`),
  INDEX `ACCOUNT_GENERAL_USER_FK_idx` (`general_user` ASC) VISIBLE,
  INDEX `ACCOUNT_REGION_FK_idx` (`region` ASC) VISIBLE,
  INDEX `ACCOUNT_DEFAULT_PAYMENT_METHOD_ID_FK_idx` (`default_payment_method_id` ASC) VISIBLE,
  UNIQUE INDEX `default_payment_method_id_UNIQUE` (`default_payment_method_id` ASC) VISIBLE,
  CONSTRAINT `ACCOUNT_GENERAL_USER_FK`
    FOREIGN KEY (`general_user`)
    REFERENCES `general_user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ACCOUNT_REGION_FK`
    FOREIGN KEY (`region`)
    REFERENCES `region` (`region_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `ACCOUNT_DEFAULT_PAYMENT_METHOD_ID_FK`
    FOREIGN KEY (`default_payment_method_id`)
    REFERENCES `payment_method` (`payment_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mailing_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mailing_list` ;

CREATE TABLE IF NOT EXISTS `mailing_list` (
  `mailing_list_id` INT(9) NOT NULL,
  `mailing_list_name` VARCHAR(50) NOT NULL,
  `mailing_list_category` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`mailing_list_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_register_mail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_register_mail` ;

CREATE TABLE IF NOT EXISTS `user_register_mail` (
  `user` INT(9) NOT NULL,
  `mailing_list` INT(9) NOT NULL,
  INDEX `USER_REGISTER_MAIL_USER_FK_idx` (`user` ASC) VISIBLE,
  INDEX `USER_REGISTER_MAIL_MAILING_LIST_idx` (`mailing_list` ASC) VISIBLE,
  CONSTRAINT `USER_REGISTER_MAIL_USER_FK`
    FOREIGN KEY (`user`)
    REFERENCES `general_user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `USER_REGISTER_MAIL_MAILING_LIST`
    FOREIGN KEY (`mailing_list`)
    REFERENCES `mailing_list` (`mailing_list_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orders` ;

CREATE TABLE IF NOT EXISTS `orders` (
  `order_number` INT(10) NOT NULL,
  `general_user` INT(9) NOT NULL,
  `order_date` DATE NOT NULL,
  `order_status` INT(3) NOT NULL COMMENT 'order_status - (1) processing, (2) shipped, (3) out for delivery',
  `address_line1` VARCHAR(45) NOT NULL,
  `address_line2` VARCHAR(45) NULL,
  `state` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `phone` INT(10) NOT NULL,
  `payment_method` INT(10) NULL,
  PRIMARY KEY (`order_number`),
  INDEX `ORDER_GENERAL_USER_FK_idx` (`general_user` ASC) VISIBLE,
  INDEX `ORDER_PAYMENT_METHODS_FK_idx` (`payment_method` ASC) VISIBLE,
  CONSTRAINT `ORDER_GENERAL_USER_FK`
    FOREIGN KEY (`general_user`)
    REFERENCES `general_user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ORDER_PAYMENT_METHODS_FK`
    FOREIGN KEY (`payment_method`)
    REFERENCES `payment_method` (`payment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `products` ;

CREATE TABLE IF NOT EXISTS `products` (
  `product_id` INT(9) NOT NULL,
  `product_name` VARCHAR(45) NOT NULL,
  `product_price` INT(5) NOT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `order_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order_details` ;

CREATE TABLE IF NOT EXISTS `order_details` (
  `order_details_id` INT(9) NOT NULL,
  `products` INT(9) NOT NULL,
  `orders` INT(10) NOT NULL,
  `quantity_ordered` INT(2) NOT NULL,
  `price_each` INT(5) NOT NULL,
  INDEX `ORDER_DETAILS_PRODUCTS_FK_idx` (`products` ASC) VISIBLE,
  INDEX `ORDER_DETAILS_ORDER_FK_idx` (`orders` ASC) VISIBLE,
  PRIMARY KEY (`order_details_id`),
  CONSTRAINT `ORDER_DETAILS_PRODUCTS_FK`
    FOREIGN KEY (`products`)
    REFERENCES `products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ORDER_DETAILS_ORDERS_FK`
    FOREIGN KEY (`orders`)
    REFERENCES `orders` (`order_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `deliverers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `deliverers` ;

CREATE TABLE IF NOT EXISTS `deliverers` (
  `deliverer_id` INT(9) NOT NULL,
  `package_weight` INT(3) NOT NULL,
  `package_height` INT(3) NOT NULL,
  `service_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`deliverer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orders_delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orders_delivery` ;

CREATE TABLE IF NOT EXISTS `orders_delivery` (
  `deliverers` INT(9) NOT NULL,
  `orders` INT(9) NOT NULL,
  INDEX `ORDERS_DELIVERY_DELIVERERS_FK_idx` (`deliverers` ASC) VISIBLE,
  INDEX `ORDERS_DELIVERY_ORDERS_FK_idx` (`orders` ASC) VISIBLE,
  CONSTRAINT `ORDERS_DELIVERY_DELIVERERS_FK`
    FOREIGN KEY (`deliverers`)
    REFERENCES `deliverers` (`deliverer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ORDERS_DELIVERY_ORDERS_FK`
    FOREIGN KEY (`orders`)
    REFERENCES `orders` (`order_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `categories` ;

CREATE TABLE IF NOT EXISTS `categories` (
  `category_id` INT(9) NOT NULL,
  `category_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `categories_products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `categories_products` ;

CREATE TABLE IF NOT EXISTS `categories_products` (
  `products` INT(9) NOT NULL,
  `categories` INT(9) NOT NULL,
  UNIQUE INDEX `products_UNIQUE` (`products` ASC) VISIBLE,
  UNIQUE INDEX `categories_UNIQUE` (`categories` ASC) VISIBLE,
  CONSTRAINT `CATEGORIES_PRODUCTS_PRODUCTS_FK`
    FOREIGN KEY (`products`)
    REFERENCES `products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CATEGORIES_PRODUCTS_CATEGORIES_FK`
    FOREIGN KEY (`categories`)
    REFERENCES `categories` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assemblers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assemblers` ;

CREATE TABLE IF NOT EXISTS `assemblers` (
  `assembler_id` INT(9) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `assembly_line` TINYINT(2) NOT NULL,
  PRIMARY KEY (`assembler_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product_assembly`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_assembly` ;

CREATE TABLE IF NOT EXISTS `product_assembly` (
  `products` INT(9) NOT NULL,
  `assemblers` INT(9) NOT NULL,
  INDEX `PRODUCT_ASSEMBLY_PRODUCTS_idx` (`products` ASC) VISIBLE,
  PRIMARY KEY (`products`, `assemblers`),
  CONSTRAINT `PRODUCT_ASSEMBLY_PRODUCTS`
    FOREIGN KEY (`products`)
    REFERENCES `products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PRODUCT_ASSEMBLY_ASSEMBLERS`
    FOREIGN KEY (`assemblers`)
    REFERENCES `assemblers` (`assembler_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stock` ;

CREATE TABLE IF NOT EXISTS `stock` (
  `stock_id` INT(9) NOT NULL,
  `quantity` INT(5) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`stock_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stock_products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stock_products` ;

CREATE TABLE IF NOT EXISTS `stock_products` (
  `stock` INT(9) NOT NULL,
  `products` INT(9) NULL,
  UNIQUE INDEX `stock_UNIQUE` (`stock` ASC) VISIBLE,
  UNIQUE INDEX `products_UNIQUE` (`products` ASC) VISIBLE,
  CONSTRAINT `STOCK_PRODUCTS_STOCK_FK`
    FOREIGN KEY (`stock`)
    REFERENCES `stock` (`stock_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `STOCK_PRODUCTS_PRODUCTS_FK`
    FOREIGN KEY (`products`)
    REFERENCES `products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supplier` ;

CREATE TABLE IF NOT EXISTS `supplier` (
  `supplier_id` INT(9) NOT NULL,
  `supplier_name` VARCHAR(45) NOT NULL,
  `supplier_email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supplier_stock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supplier_stock` ;

CREATE TABLE IF NOT EXISTS `supplier_stock` (
  `supplier` INT(9) NULL,
  `stock` INT(9) NULL,
  `supplier_stock_id` INT(9) NOT NULL AUTO_INCREMENT,
  UNIQUE INDEX `supplier_UNIQUE` (`supplier` ASC) VISIBLE,
  UNIQUE INDEX `stock_UNIQUE` (`stock` ASC) VISIBLE,
  PRIMARY KEY (`supplier_stock_id`),
  CONSTRAINT `SUPPLIER_STOCK_SUPPLIER_FK`
    FOREIGN KEY (`supplier`)
    REFERENCES `supplier` (`supplier_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `SUPPLIER_STOCK_STOCK_FK`
    FOREIGN KEY (`stock`)
    REFERENCES `stock` (`stock_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `utilities_supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `utilities_supplier` ;

CREATE TABLE IF NOT EXISTS `utilities_supplier` (
  `utilities_supplier_id` INT(9) NOT NULL,
  `supplier_name` VARCHAR(45) NOT NULL,
  `utility_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`utilities_supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `warehouse` ;

CREATE TABLE IF NOT EXISTS `warehouse` (
  `warehouse_id` INT(9) NOT NULL,
  `region` INT(9) NULL,
  `utilities` INT(9) NULL,
  PRIMARY KEY (`warehouse_id`),
  INDEX `WAREHOUSE_REGION_FK_idx` (`region` ASC) VISIBLE,
  UNIQUE INDEX `region_UNIQUE` (`region` ASC) VISIBLE,
  UNIQUE INDEX `utilities_UNIQUE` (`utilities` ASC) VISIBLE,
  CONSTRAINT `WAREHOUSE_REGION_FK`
    FOREIGN KEY (`region`)
    REFERENCES `region` (`region_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `WAREHOUSE_UTILITES_FK`
    FOREIGN KEY (`utilities`)
    REFERENCES `utilities_supplier` (`utilities_supplier_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `finance_dept`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `finance_dept` ;

CREATE TABLE IF NOT EXISTS `finance_dept` (
  `finance_dept_id` INT(9) NOT NULL,
  `payment_date` DATETIME NOT NULL,
  `pay_to` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`finance_dept_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `financedept_paymentmethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financedept_paymentmethod` ;

CREATE TABLE IF NOT EXISTS `financedept_paymentmethod` (
  `finance_dept` INT(9) NOT NULL,
  `payment_method` INT(9) NOT NULL,
  PRIMARY KEY (`payment_method`, `finance_dept`),
  CONSTRAINT `FINANCEDEPT_PAYMENTMETHOD_FINANCE_DEPT_PK/FK`
    FOREIGN KEY (`finance_dept`)
    REFERENCES `finance_dept` (`finance_dept_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FINANICEDEPT_PAYMENT_METHOD_PAYMENT_METHOD_FK/PK`
    FOREIGN KEY (`payment_method`)
    REFERENCES `payment_method` (`payment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company_payables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company_payables` ;

CREATE TABLE IF NOT EXISTS `company_payables` (
  `company_payables_id` INT(9) NOT NULL,
  `amount_owed` INT(10) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`company_payables_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `finance_payables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `finance_payables` ;

CREATE TABLE IF NOT EXISTS `finance_payables` (
  `company_payables` INT(9) NOT NULL,
  `finance_dept` INT(9) NOT NULL,
  PRIMARY KEY (`company_payables`, `finance_dept`),
  INDEX `FINANCE_PAYABLES_COMPANY_PAYABLES_FINANCE_DEPT_PK/FK_idx` (`finance_dept` ASC) VISIBLE,
  CONSTRAINT `FINANCE_PAYABLES_COMPANY_PAYABLES`
    FOREIGN KEY (`company_payables`)
    REFERENCES `company_payables` (`company_payables_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FINANCE_PAYABLES_COMPANY_PAYABLES_FINANCE_DEPT_PK/FK`
    FOREIGN KEY (`finance_dept`)
    REFERENCES `finance_dept` (`finance_dept_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `receipt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `receipt` ;

CREATE TABLE IF NOT EXISTS `receipt` (
  `receipt_id` INT(9) NOT NULL,
  `orders` INT(10) NOT NULL,
  `general_user` INT(9) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`receipt_id`),
  INDEX `RECEIPT_ORDERS_FK_idx` (`orders` ASC) VISIBLE,
  INDEX `RECEIPT_GENERAL_USER_FK_idx` (`general_user` ASC) VISIBLE,
  CONSTRAINT `RECEIPT_ORDERS_FK`
    FOREIGN KEY (`orders`)
    REFERENCES `orders` (`order_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `RECEIPT_GENERAL_USER_FK`
    FOREIGN KEY (`general_user`)
    REFERENCES `general_user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `device`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `device` ;

CREATE TABLE IF NOT EXISTS `device` (
  `device_id` INT(9) NOT NULL,
  `device_type` VARCHAR(100) NOT NULL,
  `device_ip` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`device_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `session` ;

CREATE TABLE IF NOT EXISTS `session` (
  `session_id` INT(9) NOT NULL,
  `general_user` INT(9) NOT NULL,
  `expiration` DATETIME NOT NULL,
  `device_id` INT(9) NOT NULL,
  PRIMARY KEY (`session_id`),
  INDEX `SESSION_GENERAL_USER_FK_idx` (`general_user` ASC) VISIBLE,
  INDEX `SESSION_DEVICE_FK_idx` (`device_id` ASC) VISIBLE,
  CONSTRAINT `SESSION_GENERAL_USER_FK`
    FOREIGN KEY (`general_user`)
    REFERENCES `general_user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `SESSION_DEVICE_FK`
    FOREIGN KEY (`device_id`)
    REFERENCES `device` (`device_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `promotion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `promotion` ;

CREATE TABLE IF NOT EXISTS `promotion` (
  `promotion_id` INT(9) NOT NULL,
  `promotion_type` VARCHAR(100) NOT NULL,
  `promotion_limit` INT(5) NOT NULL,
  PRIMARY KEY (`promotion_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product_promotion_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_promotion_info` ;

CREATE TABLE IF NOT EXISTS `product_promotion_info` (
  `products` INT(9) NOT NULL,
  `promotion` INT(9) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`products`, `promotion`),
  INDEX `PRODUCT_PROMOTION_INFO_PROMOTION_PK/FK_idx` (`promotion` ASC) VISIBLE,
  CONSTRAINT `PRODUCT_PROMOTION_INFO_PRODUCTS_PK/FK`
    FOREIGN KEY (`products`)
    REFERENCES `products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PRODUCT_PROMOTION_INFO_PROMOTION_PK/FK`
    FOREIGN KEY (`promotion`)
    REFERENCES `promotion` (`promotion_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `promotion_account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `promotion_account` ;

CREATE TABLE IF NOT EXISTS `promotion_account` (
  `promotion` INT(9) NOT NULL,
  `account` INT(9) NOT NULL,
  PRIMARY KEY (`promotion`, `account`),
  INDEX `PROMOTION_ACCOUNT_ACCOUNT_PK/FK_idx` (`account` ASC) VISIBLE,
  CONSTRAINT `PROMOTION_ACCOUNT_PROMOTION_PK/FK`
    FOREIGN KEY (`promotion`)
    REFERENCES `promotion` (`promotion_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PROMOTION_ACCOUNT_ACCOUNT_PK/FK`
    FOREIGN KEY (`account`)
    REFERENCES `account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `system`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `system` ;

CREATE TABLE IF NOT EXISTS `system` (
  `system_id` INT(9) NOT NULL,
  `system_software` INT(3) NOT NULL,
  `system_status` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`system_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warehouse_request`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `warehouse_request` ;

CREATE TABLE IF NOT EXISTS `warehouse_request` (
  `request_id` INT(9) NOT NULL,
  `warehouse` INT(9) NOT NULL,
  `supplier` INT(9) NULL,
  `stock` INT(9) NULL,
  UNIQUE INDEX `warehouse_UNIQUE` (`warehouse` ASC) VISIBLE,
  UNIQUE INDEX `supplier_UNIQUE` (`supplier` ASC) VISIBLE,
  UNIQUE INDEX `stock_UNIQUE` (`stock` ASC) VISIBLE,
  CONSTRAINT `WAREHOUSE_REQUEST_WAREHOUSE_PK/FK`
    FOREIGN KEY (`warehouse`)
    REFERENCES `warehouse` (`warehouse_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `WAREHOUSE_REQUEST_SUPPLIER_PK/FK`
    FOREIGN KEY (`supplier`)
    REFERENCES `supplier` (`supplier_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `WAREHOUSE_REQUEST_STOCK_PK/FK`
    FOREIGN KEY (`stock`)
    REFERENCES `stock` (`stock_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rewardPoints`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rewardPoints` ;

CREATE TABLE IF NOT EXISTS `rewardPoints` (
  `rewardPoints_id` INT(9) NOT NULL AUTO_INCREMENT,
  `rewardType` VARCHAR(255) NOT NULL,
  `dollarAmount` INT(10) NOT NULL,
  PRIMARY KEY (`rewardPoints_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `regUser_rewardPoints`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `regUser_rewardPoints` ;

CREATE TABLE IF NOT EXISTS `regUser_rewardPoints` (
  `user` INT(9) NOT NULL,
  `rewardPoint` INT(9) NOT NULL,
  `regUser_rewardPointscol` VARCHAR(45) NULL,
  INDEX `REGUSER_REWARDPOINTS_REWARDPOINTS_PK/FK_idx` (`rewardPoint` ASC) VISIBLE,
  CONSTRAINT `REGUSER_REWARDPOINTS_GENERAL_USER_PK/FK`
    FOREIGN KEY (`user`)
    REFERENCES `general_user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `REGUSER_REWARDPOINTS_REWARDPOINTS_PK/FK`
    FOREIGN KEY (`rewardPoint`)
    REFERENCES `rewardPoints` (`rewardPoints_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
