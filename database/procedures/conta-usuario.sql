DELIMITER $$

CREATE PROCEDURE Conta_usuarios(IN id_arq INT)
BEGIN
        DECLARE cont INT;
    SELECT COUNT(DISTINCT id_usuario) INTO cont FROM web_driver.Acesso_Arquivo WHERE id_arquivo = id_arq;
    SET cont := cont+1;
    SELECT cont AS qtd_usuarios;
END $$

DELIMITER ;

CALL Conta_usuarios(1);
DROP PROCEDURE Conta_usuarios;