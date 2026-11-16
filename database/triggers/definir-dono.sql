DELIMITER $$

CREATE TRIGGER Definir_dono
BEFORE INSERT ON Arquivo
FOR EACH ROW
BEGIN
    IF NEW.id_usuario IS NULL OR NEW.id_usuario = 0 THEN
        SET NEW.id_usuario = id_usuario_atual();
    END IF;
END$$

DELIMITER ;
