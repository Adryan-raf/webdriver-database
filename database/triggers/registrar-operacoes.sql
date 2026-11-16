DELIMITER $$

CREATE TRIGGER Registrar_operacao
AFTER INSERT ON Opera
FOR EACH ROW
BEGIN
    UPDATE Atividades_Recentes
    SET ultima_versao = CURDATE()
    WHERE id_arquivo = NEW.id_arquivo;
END$$

DELIMITER ;