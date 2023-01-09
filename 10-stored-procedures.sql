-- Procedimiento almacenado

use metro_cdmx;

DELIMITER //
CREATE PROCEDURE Calculate_distace_between_estations(
    IN station_one POINT,
    IN station_two POINT,
    IN meters BOOLEAN
)
BEGIN
    -- existe el if
    IF meters THEN
        SELECT
        ST_Distance_Sphere(station_one, station_two) AS distance;
    ELSE
        SELECT
        ST_Distance_Sphere(station_one, station_two) / 1000 AS distance;
    END IF;

END//
DELIMITER ;



-- Usando un prepared statement para buscar una lista de los nombres de las estaciones de una linea

DELIMITER //
CREATE PROCEDURE get_line_stations(
    IN line_name VARCHAR(15)
)
BEGIN


    -- se pueden guardar valores de una consulta dentro de una variable
    DECLARE line_id BIGINT(20);

    SELECT id
    INTO line_id
    FROM `lines`
    WHERE name = line_name
    COLLATE utf8mb4_unicode_ci;

    -- se puede usar una variable y concatenar strings

    SET @sql = CONCAT("
        SELECT
            `lines_stations`.`id` AS relation_id,
            `lines`.`name` AS line_name,
            `stations`.`name` AS station_name
        FROM `lines_stations`
        INNER JOIN `stations`
        ON `stations`.`id` = `lines_stations`.`station_id`
        INNER JOIN `lines`
        ON `lines`.`id` = `lines_stations`.`line_id`
        WHERE `lines_stations`.`line_id` = ", line_id);

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

END //

DELIMITER ;


-- otra forma usando solo un metodo de variables como parametros

DELIMITER //
CREATE PROCEDURE get_line_stations_other( IN line_name VARCHAR(15) )
BEGIN
        SELECT
            `lines_stations`.`id` AS relation_id,
            `lines`.`name` AS line_name,
            `stations`.`name` AS station_name
        FROM `lines_stations`
        INNER JOIN `stations`
        ON `stations`.`id` = `lines_stations`.`station_id`
        INNER JOIN `lines`
        ON `lines`.`id` = `lines_stations`.`line_id`
        WHERE `lines`.`name` = line_name
        COLLATE utf8mb4_unicode_ci;

END //

DELIMITER ;