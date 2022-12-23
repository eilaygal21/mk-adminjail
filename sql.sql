CREATE TABLE IF NOT EXISTS `admin_jail` (
    `name` VARCHAR(50) NULL DEFAULT NULL,
    `time` VARCHAR(50) NULL DEFAULT NULL,
    `jailedby` VARCHAR(50) NULL DEFAULT NULL
)

COLLATE = 'latin1_swedish_ci'
ENGINE = INNODB
;