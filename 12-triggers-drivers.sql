use metro_cdmx;

-- tabla de conductores
CREATE TABLE `drivers` (

    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,

    `name` VARCHAR(10) NOT NULL,
    `status` BOOLEAN NOT NULL DEFAULT FALSE,

    `created_at` timestamp NOT NULL default current_timestamp,
    `updated_at` timestamp NOT NULL default current_timestamp ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)

)
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

-- tabla para saber si un conductor está activo
CREATE TABLE `active_drivers` (

    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,

    `drivers_id` BIGINT(20) UNSIGNED NOT NULL,

    `created_at` timestamp NOT NULL default current_timestamp,
    `updated_at` timestamp NOT NULL default current_timestamp ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    CONSTRAINT `active_drivers_drivers_id_foreing`
    FOREIGN KEY (`drivers_id`) REFERENCES `drivers` (`id`) 

)
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;


-- llenar trabla de conductores
INSERT INTO `drivers` (name) VALUES
("Pedro"),
("Pablo"),
("José"),
("María"),
("Amanda");


-- triger para actualizar el estado de los conductores
DELIMITER //
CREATE TRIGGER update_active_drivers
AFTER UPDATE
ON `drivers`
FOR EACH ROW
BEGIN

    IF NEW.status = 1 THEN
        INSERT INTO `active_drivers` (drivers_id) VALUES (NEW.id);
    ELSE
        DELETE FROM `active_drivers` WHERE drivers_id = NEW.id;
    END IF;

END; //

DELIMITER ;
