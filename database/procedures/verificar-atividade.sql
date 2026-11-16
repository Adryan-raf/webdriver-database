DELIMITER $$

CREATE PROCEDURE Verificar_atividades()
BEGIN 
    UPDATE Atividades_Recentes SET ultima_versao = CURDATE();
END $$

DELIMITER ;

CALL Verificar_atividades();
