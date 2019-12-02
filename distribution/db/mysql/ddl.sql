-- FARM --

CREATE TABLE IF NOT EXISTS `FARM_EVENT` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `FARM_UID` BINARY(16),
    `VERSION` INT,
    `CREATED_DATE` DATETIME,
    `EVENT` JSON
) ENGINE=InnoDB;

CREATE INDEX `FARM_EVENT_FARM_UID_INDEX` ON `FARM_EVENT` (`FARM_UID`);

CREATE TABLE IF NOT EXISTS `FARM_READ` (
    `UID` BINARY(16) PRIMARY KEY,
    `USERID` BINARY(16),
    `NAME` VARCHAR(255),
    `LATITUDE` VARCHAR(255),
    `LONGITUDE` VARCHAR(255),
    `TYPE` VARCHAR(255),
    `COUNTRY` VARCHAR(255),
    `CITY` VARCHAR(255),
    `IS_ACTIVE` INT,
    `CREATED_DATE` DATETIME
) ENGINE=InnoDB;

CREATE UNIQUE INDEX `FARM_READ_UID_UNIQUE_INDEX` ON `FARM_READ` (`UID`);

-- RESERVOIR --

CREATE TABLE IF NOT EXISTS `RESERVOIR_EVENT` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `RESERVOIR_UID` BINARY(16),
    `VERSION` INT,
    `CREATED_DATE` DATETIME,
    `EVENT` JSON
) ENGINE=InnoDB;

CREATE INDEX `RESERVOIR_EVENT_RESERVOIR_UID_INDEX` ON `RESERVOIR_EVENT` (`RESERVOIR_UID`);

CREATE TABLE IF NOT EXISTS `RESERVOIR_READ` (
    `UID` BINARY(16) PRIMARY KEY,
    `NAME` VARCHAR(255),
    `WATERSOURCE_TYPE` VARCHAR(255),
    `WATERSOURCE_CAPACITY` FLOAT,
    `FARM_UID` BINARY(16),
    `FARM_NAME` VARCHAR(255),
    `CREATED_DATE` DATETIME
) ENGINE=InnoDB;

CREATE INDEX `RESERVOIR_READ_UID_UNIQUE_INDEX` ON `RESERVOIR_READ` (`UID`);

CREATE TABLE IF NOT EXISTS `RESERVOIR_READ_NOTES` (
    `UID` BINARY(16) PRIMARY KEY,
    `RESERVOIR_UID` BINARY(16),
    `CONTENT` TEXT,
    `CREATED_DATE` DATETIME,
    FOREIGN KEY(`RESERVOIR_UID`) REFERENCES `RESERVOIR_READ`(`UID`)
) ENGINE=InnoDB;

CREATE UNIQUE INDEX `RESERVOIR_READ_NOTES_UID_UNIQUE_INDEX` ON `RESERVOIR_READ_NOTES` (`UID`);
CREATE INDEX `RESERVOIR_READ_NOTES_RESERVOIR_UID_INDEX` ON `RESERVOIR_READ_NOTES` (`RESERVOIR_UID`);

-- AREA --

CREATE TABLE IF NOT EXISTS `AREA_EVENT` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `AREA_UID` BINARY(16),
    `VERSION` INT,
    `CREATED_DATE` DATETIME,
    `EVENT` JSON
) ENGINE=InnoDB;

CREATE INDEX `FARM_EVENT_AREA_UID_INDEX` ON `AREA_EVENT` (`AREA_UID`);

CREATE TABLE IF NOT EXISTS `AREA_READ` (
    `UID` BINARY(16) PRIMARY KEY,
    `NAME` VARCHAR(255),
    `SIZE_UNIT` VARCHAR(255),
    `SIZE` FLOAT,
    `TYPE` VARCHAR(255),
    `POLYGON` TEXT,
    `LOCATION` VARCHAR(255),
    `PHOTO_FILENAME` VARCHAR(255),
    `PHOTO_MIMETYPE` VARCHAR(255),
    `PHOTO_SIZE` INT,
    `PHOTO_WIDTH` INT,
    `PHOTO_HEIGHT` INT,
    `CREATED_DATE` DATETIME,
    `RESERVOIR_UID` BINARY(16),
    `RESERVOIR_NAME` VARCHAR(255),
    `FARM_UID` BINARY(16),
    `FARM_NAME` VARCHAR(255)
) ENGINE=InnoDB;

CREATE UNIQUE INDEX `AREA_READ_UID_UNIQUE_INDEX` ON `AREA_READ` (`UID`);
CREATE INDEX `AREA_READ_RESERVOIR_UID_INDEX` ON `AREA_READ` (`RESERVOIR_UID`);
CREATE INDEX `AREA_READ_FARM_UID_INDEX` ON `AREA_READ` (`FARM_UID`);

CREATE TABLE IF NOT EXISTS `AREA_READ_NOTES` (
    `UID` BINARY(16) PRIMARY KEY,
    `AREA_UID` BINARY(16),
    `CONTENT` TEXT,
    `CREATED_DATE` DATETIME,
    FOREIGN KEY(`AREA_UID`) REFERENCES `AREA_READ`(`UID`)
) ENGINE=InnoDB;

CREATE UNIQUE INDEX `AREA_READ_NOTES_UID_UNIQUE_INDEX` ON `AREA_READ_NOTES` (`UID`);
CREATE INDEX `AREA_READ_NOTES_AREA_UID_INDEX` ON `AREA_READ_NOTES` (`AREA_UID`);

-- MATERIAL --

CREATE TABLE IF NOT EXISTS `MATERIAL_EVENT` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `MATERIAL_UID` BINARY(16),
    `VERSION` INT,
    `CREATED_DATE` DATETIME,
    `EVENT` JSON
);

CREATE INDEX `MATERIAL_EVENT_MATERIAL_UID_INDEX` ON `MATERIAL_EVENT` (`MATERIAL_UID`);

CREATE TABLE IF NOT EXISTS `MATERIAL_READ` (
    `UID` BINARY(16) PRIMARY KEY,
    `NAME` VARCHAR(255),
    `PRICE_PER_UNIT` VARCHAR(255),
    `CURRENCY_CODE` VARCHAR(255),
    `TYPE` VARCHAR(255),
    `TYPE_DATA` VARCHAR(255),
    `QUANTITY` FLOAT,
    `QUANTITY_UNIT` VARCHAR(255),
    `EXPIRATION_DATE` VARCHAR(255),
    `NOTES` VARCHAR(255),
    `PRODUCED_BY` VARCHAR(255),
    `CREATED_DATE` DATETIME
);

CREATE INDEX `MATERIAL_READ_UID_UNIQUE_INDEX` ON `MATERIAL_READ` (`UID`);

-- CROP --

CREATE TABLE IF NOT EXISTS `CROP_EVENT` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `CROP_UID` BINARY(16),
    `VERSION` INT,
    `CREATED_DATE` DATETIME,
    `EVENT` JSON
);

CREATE INDEX `CROP_EVENT_CROP_UID_INDEX` ON `CROP_EVENT` (`CROP_UID`);

CREATE TABLE IF NOT EXISTS `CROP_READ` (
    `UID` BINARY(16) PRIMARY KEY,
    `BATCH_ID` VARCHAR(255),
    `STATUS` VARCHAR(255),
    `TYPE` VARCHAR(255),
    `CONTAINER_QUANTITY` INT,
    `CONTAINER_TYPE` VARCHAR(255),
    `CONTAINER_CELL` INT,
    `INVENTORY_UID` BINARY(16),
    `INVENTORY_TYPE` VARCHAR(255),
    `INVENTORY_PLANT_TYPE` VARCHAR(255),
    `INVENTORY_NAME` VARCHAR(255),
    `AREA_STATUS_SEEDING` INT,
    `AREA_STATUS_GROWING` INT,
    `AREA_STATUS_DUMPED` INT,
    `FARM_UID` BINARY(16),
    `INITIAL_AREA_UID` BINARY(16),
    `INITIAL_AREA_NAME` VARCHAR(255),
    `INITIAL_AREA_INITIAL_QUANTITY` INT,
    `INITIAL_AREA_CURRENT_QUANTITY` INT,
    `INITIAL_AREA_LAST_WATERED` DATETIME,
    `INITIAL_AREA_LAST_FERTILIZED` DATETIME,
    `INITIAL_AREA_LAST_PESTICIDED` DATETIME,
    `INITIAL_AREA_LAST_PRUNED` DATETIME,
    `INITIAL_AREA_CREATED_DATE` DATETIME,
    `INITIAL_AREA_LAST_UPDATED` DATETIME
);

CREATE TABLE IF NOT EXISTS `CROP_READ_PHOTO` (
    `UID` BINARY(16) PRIMARY KEY,
    `CROP_UID` BINARY(16),
    `FILENAME` VARCHAR(255),
    `MIMETYPE` VARCHAR(255),
    `SIZE` INT,
    `WIDTH` INT,
    `HEIGHT` INT,
    `DESCRIPTION` TEXT,
    FOREIGN KEY(`CROP_UID`) REFERENCES `CROP_READ`(`UID`)
);

CREATE TABLE IF NOT EXISTS `CROP_READ_MOVED_AREA` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `CROP_UID` BINARY(16),
    `AREA_UID` BINARY(16),
    `NAME` VARCHAR(255),
    `INITIAL_QUANTITY` INT,
    `CURRENT_QUANTITY` INT,
    `LAST_WATERED` DATETIME,
    `LAST_FERTILIZED` DATETIME,
    `LAST_PESTICIDED` DATETIME,
    `LAST_PRUNED` DATETIME,
    `CREATED_DATE` DATETIME,
    `LAST_UPDATED` DATETIME,
    FOREIGN KEY(`CROP_UID`) REFERENCES `CROP_READ`(`UID`)
);

CREATE TABLE IF NOT EXISTS `CROP_READ_HARVESTED_STORAGE` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `CROP_UID` BINARY(16),
    `QUANTITY` INT,
    `PRODUCED_GRAM_QUANTITY` FLOAT,
    `SOURCE_AREA_UID` BINARY(16),
    `SOURCE_AREA_NAME` VARCHAR(255),
    `CREATED_DATE` DATETIME,
    `LAST_UPDATED` DATETIME,
    FOREIGN KEY(`CROP_UID`) REFERENCES `CROP_READ`(`UID`)
);

CREATE TABLE IF NOT EXISTS `CROP_READ_TRASH` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `CROP_UID` BINARY(16),
    `QUANTITY` INT,
    `SOURCE_AREA_UID` BINARY(16),
    `SOURCE_AREA_NAME` VARCHAR(255),
    `CREATED_DATE` DATETIME,
    `LAST_UPDATED` DATETIME,
    FOREIGN KEY(`CROP_UID`) REFERENCES `CROP_READ`(`UID`)
);

CREATE TABLE IF NOT EXISTS `CROP_READ_NOTES` (
    `UID` BINARY(16) PRIMARY KEY,
    `CROP_UID` BINARY(16),
    `CONTENT` TEXT,
    `CREATED_DATE` DATETIME,
    FOREIGN KEY(`CROP_UID`) REFERENCES `CROP_READ`(`UID`)
);

CREATE UNIQUE INDEX `CROP_READ_NOTES_UID_UNIQUE_INDEX` ON `CROP_READ_NOTES` (`UID`);
CREATE INDEX `CROP_READ_NOTES_CROP_UID_INDEX` ON `CROP_READ_NOTES` (`CROP_UID`);


CREATE TABLE IF NOT EXISTS `CROP_ACTIVITY` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `CROP_UID` BINARY(16),
    `BATCH_ID` VARCHAR(255),
    `CONTAINER_TYPE` VARCHAR(255),
    `ACTIVITY_TYPE` JSON,
    `ACTIVITY_TYPE_CODE` VARCHAR(255),
    `CREATED_DATE` DATETIME,
    `DESCRIPTION` TEXT,
    FOREIGN KEY(`CROP_UID`) REFERENCES `CROP_READ`(`UID`)
);

-- TASK --

CREATE TABLE IF NOT EXISTS `TASK_EVENT` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `TASK_UID` BINARY(16),
    `VERSION` INT,
    `CREATED_DATE` DATETIME,
    `EVENT` JSON
);

CREATE INDEX `TASK_EVENT_TASK_UID_INDEX` ON `TASK_EVENT` (`TASK_UID`);

CREATE TABLE IF NOT EXISTS `TASK_READ` (
    `UID` BINARY(16) PRIMARY KEY,
    `TITLE` VARCHAR(255),
    `DESCRIPTION` TEXT,
    `CREATED_DATE` DATETIME,
    `DUE_DATE` DATETIME,
    `COMPLETED_DATE` DATETIME,
    `CANCELLED_DATE` DATETIME,
    `PRIORITY` VARCHAR(255),
    `STATUS` VARCHAR(255),
    `DOMAIN_CODE` VARCHAR(255),
    `DOMAIN_DATA_MATERIAL_ID` BINARY(16),
    `DOMAIN_DATA_AREA_ID` BINARY(16),
    `DOMAIN_DATA_CROP_ID` BINARY(16),
    `CATEGORY` VARCHAR(255),
    `IS_DUE` TINYINT(1),
    `ASSET_ID` BINARY(16)
);

CREATE INDEX `TASK_READ_UID_UNIQUE_INDEX` ON `TASK_READ` (`UID`);

-- USER --

CREATE TABLE IF NOT EXISTS `USER_EVENT` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `USER_UID` BINARY(16),
    `VERSION` INT,
    `CREATED_DATE` DATETIME,
    `EVENT` JSON
);

CREATE INDEX `USER_EVENT_USER_UID_INDEX` ON `USER_EVENT` (`USER_UID`);

CREATE TABLE IF NOT EXISTS `USER_READ` (
    `UID` BINARY(16) PRIMARY KEY,
    `USERNAME` VARCHAR(255),
    `PASSWORD` TEXT,
    `CREATED_DATE` DATETIME,
    `LAST_UPDATED` DATETIME
);

CREATE INDEX `USER_READ_UID_UNIQUE_INDEX` ON `USER_READ` (`UID`);

CREATE TABLE IF NOT EXISTS `USER_AUTH` (
    `USER_UID` BINARY(16) PRIMARY KEY,
    `ACCESS_TOKEN` VARCHAR(255),
    `TOKEN_EXPIRES` INT,
    `CREATED_DATE` DATETIME,
    `LAST_UPDATED` DATETIME
);

CREATE UNIQUE INDEX `USER_AUTH_USER_UID_UNIQUE_INDEX` ON `USER_AUTH` (`USER_UID`);
CREATE UNIQUE INDEX `USER_AUTH_ACCESS_TOKEN_UNIQUE_INDEX` ON `USER_AUTH` (`ACCESS_TOKEN`);
