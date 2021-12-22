CREATE DATABASE `absence_per_month`;
USE `absence_per_month`;
SHOW DATABASES;
DROP DATABASE `absence_per_month`;

CREATE TABLE `employee`(
	`employee_id` INT PRIMARY KEY, 
	`name` VARCHAR(30)
);
DESCRIBE `employee`;
SELECT * FROM `employee`;
DROP TABLE `employee`;

INSERT INTO `employee` VALUES(1, '小蔡');
INSERT INTO `employee` VALUES(2, '小明');
INSERT INTO `employee` VALUES(3, '小璋');

ALTER TABLE `employee` ADD method VARCHAR(10);
ALTER TABLE `employee` ADD ocean VARCHAR(10);
ALTER TABLE `employee` ADD class VARCHAR(10);
UPDATE `employee` set `class`='其他' where `employee_id`=3;
DELETE FROM `employee` where `employee_id`=3;


CREATE TABLE `calendar`(
	`date` INT PRIMARY KEY,
    `0000_0030` INT,
    `0030_0100` INT,
    `0100_0130` INT,
    `0130_0200` INT,
    `0200_0230` INT,
    `0230_0300` INT,
    `0300_0330` INT,
    `0330_0400` INT,
    `0400_0430` INT,
    `0430_0500` INT,
    `0500_0530` INT,
    `0530_0600` INT,
    `0600_0630` INT,
    `0630_0700` INT,
    `0700_0730` INT,
    `0730_0800` INT,
    `0800_0830` INT,
    `0830_0900` INT,
    `0900_0930` INT,
    `0930_1000` INT,
    `1000_1030` INT,
    `1030_1100` INT,
    `1100_1130` INT,
    `1130_1200` INT,
    `1200_1230` INT,
    `1230_1300` INT,
    `1300_1330` INT,
    `1330_1400` INT,
	`1400_1430` INT,
    `1430_1500` INT,
    `1500_1530` INT,
    `1530_1600` INT,
    `1600_1630` INT,
    `1630_1700` INT,
    `1700_1730` INT,
    `1730_1800` INT,
    `1800_1830` INT,
    `1830_1900` INT,
    `1900_1930` INT,
    `1930_2000` INT,
    `2000_2030` INT,
    `2030_2100` INT,
    `2100_2130` INT,
    `2130_2200` INT,
    `2200_2230` INT,
    `2230_2300` INT,
    `2300_2330` INT,
    `2330_2400` INT
);

INSERT INTO `calendar`(`date`) VALUES(1);
INSERT INTO `calendar`(`date`) VALUES(2);
INSERT INTO `calendar`(`date`) VALUES(3);
INSERT INTO `calendar`(`date`) VALUES(4);
INSERT INTO `calendar`(`date`) VALUES(5);
INSERT INTO `calendar`(`date`) VALUES(6);
INSERT INTO `calendar`(`date`) VALUES(7);
INSERT INTO `calendar`(`date`) VALUES(8);
INSERT INTO `calendar`(`date`) VALUES(9);
INSERT INTO `calendar`(`date`) VALUES(10);
INSERT INTO `calendar`(`date`) VALUES(11);
INSERT INTO `calendar`(`date`) VALUES(12);
INSERT INTO `calendar`(`date`) VALUES(13);
INSERT INTO `calendar`(`date`) VALUES(14);
INSERT INTO `calendar`(`date`) VALUES(15);
INSERT INTO `calendar`(`date`) VALUES(16);
INSERT INTO `calendar`(`date`) VALUES(17);
INSERT INTO `calendar`(`date`) VALUES(18);
INSERT INTO `calendar`(`date`) VALUES(19);
INSERT INTO `calendar`(`date`) VALUES(20);
INSERT INTO `calendar`(`date`) VALUES(21);
INSERT INTO `calendar`(`date`) VALUES(22);
INSERT INTO `calendar`(`date`) VALUES(23);
INSERT INTO `calendar`(`date`) VALUES(24);
INSERT INTO `calendar`(`date`) VALUES(25);
INSERT INTO `calendar`(`date`) VALUES(26);
INSERT INTO `calendar`(`date`) VALUES(27);
INSERT INTO `calendar`(`date`) VALUES(28);
INSERT INTO `calendar`(`date`) VALUES(29);
INSERT INTO `calendar`(`date`) VALUES(30);
INSERT INTO `calendar`(`date`) VALUES(31);

SELECT * FROM `calendar` WHERE `date`=1 AND `0000_0300`;

SELECT * FROM `calendar`;
DESCRIBE `calendar`;
