use metro_cdmx;

CREATE TRIGGER updated_at_field
BEFORE UPDATE
ON `lines`
FOR EACH ROW
SET NEW.updated_at = NOW();

-- una forma de marcar la actualización de las tablas en update_at es:

ALTER TABLE `stations`
MODIFY `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;