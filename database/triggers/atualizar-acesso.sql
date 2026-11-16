DELIMITER $$

CREATE TRIGGER Atualizar_acesso
AFTER INSERT ON Acesso_Arquivo
FOR EACH ROW
BEGIN
    UPDATE Arquivo
    SET data_ultima_mod = NOW()
    WHERE id = NEW.id_arquivo;
END$$

DELIMITER ;