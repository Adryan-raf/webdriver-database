DELIMITER $$

CREATE PROCEDURE Chavear(IN id_arq INT)
BEGIN
        IF(SELECT Atividades_Recentes.acesso FROM Atividades_Recentes WHERE id_arquivo = id_arq) = 'prioritario' THEN
            UPDATE Atividades_Recentes SET acesso = 'nao-prioritario' WHERE id_arquivo = id_arq;
        ELSE
            UPDATE Atividades_Recentes SET acesso = 'prioritario' WHERE id_arquivo = id_arq;
        END IF;
END $$

DELIMITER ;

CALL Chavear(1);
DROP PROCEDURE Chavear;