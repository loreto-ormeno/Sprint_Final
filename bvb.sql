-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb1` DEFAULT CHARACTER SET utf8 ;
USE `mydb1` ;

-- -----------------------------------------------------
-- Table `mydb1`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb1`.`clientes` (
  `idcliente` INT NOT NULL,
  `nombres` VARCHAR(50) NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `direccion` VARCHAR(70) NULL,
  `telefono` INT NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE INDEX `idcliente_UNIQUE` (`idcliente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb1`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb1`.`ventas` (
  `idventa` INT NOT NULL,
  `vendedor` VARCHAR(50) NULL,
  `cantarticulos` INT NOT NULL,
  `subtotal` INT NOT NULL,
  `impuesto` INT NOT NULL,
  `total` INT NOT NULL,
  `clientes_idcliente` INT NOT NULL,
  UNIQUE INDEX `idventas_UNIQUE` (`idventa` ASC) VISIBLE,
  PRIMARY KEY (`idventa`, `clientes_idcliente`),
  INDEX `fk_ventas_clientes_idx` (`clientes_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_clientes`
    FOREIGN KEY (`clientes_idcliente`)
    REFERENCES `mydb1`.`clientes` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb1`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb1`.`producto` (
  `idproducto` INT NOT NULL,
  `nombreprod` VARCHAR(50) NOT NULL,
  `valor` INT NOT NULL,
  PRIMARY KEY (`idproducto`),
  UNIQUE INDEX `idproducto_UNIQUE` (`idproducto` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb1`.`detalleventa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb1`.`detalleventa` (
  `cantidad` INT NULL,
  `ventas_idventa` INT NOT NULL,
  `producto_idproducto` INT NOT NULL,
  PRIMARY KEY (`ventas_idventa`, `producto_idproducto`),
  INDEX `fk_detalleventa_producto` (`producto_idproducto` ASC) VISIBLE,
  CONSTRAINT `fk_detalleventa_ventas1`
    FOREIGN KEY (`ventas_idventa`)
    REFERENCES `mydb1`.`ventas` (`idventa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleventa_producto1`
    FOREIGN KEY (`producto_idproducto`)
    REFERENCES `mydb1`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- consultas tarea 4 --
ALTER TABLE producto ADD CONSTRAINT unique_nombreprod UNIQUE (nombreprod);
SET foreign_key_checks = 0;
ALTER TABLE producto 
MODIFY COLUMN idproducto int AUTO_INCREMENT;
SET foreign_key_checks = 1;

INSERT INTO producto (nombreprod, valor) VALUES ("cargador", 2000);
INSERT INTO producto (nombreprod, valor) VALUES ("celular", 2550);
INSERT INTO producto (nombreprod, valor) VALUES ("tablet", 10000);
INSERT INTO producto (nombreprod, valor) VALUES ("reloj", 5000);

INSERT INTO clientes VALUES (1, "Aldo", "Castro", "El Alamo 25, Viña del Mar", 32456);
INSERT INTO clientes VALUES (2, "Loreto", "Ormeño", "El Ficus 22, Viña del Mar", 32446);

INSERT INTO ventas VALUES (1, "pepe", 5, 5000, 500, 5500, 1);
INSERT INTO ventas VALUES (2, "pepa", 3, 1000, 100, 1100, 2);
INSERT INTO ventas VALUES (3, "pepe", 5, 5000, 500, 5500, 1);

INSERT INTO detalleventa VALUES (1, 1, 2);
INSERT INTO detalleventa VALUES (1, 1, 4);
INSERT INTO detalleventa VALUES (1, 1, 3);
INSERT INTO detalleventa VALUES (2, 1, 1);
INSERT INTO detalleventa VALUES (3, 3, 2);
INSERT INTO detalleventa VALUES (1, 2, 4);
INSERT INTO detalleventa VALUES (1, 2, 3);
INSERT INTO detalleventa VALUES (1, 2, 1);

SELECT * FROM mydb1.detalleventa;