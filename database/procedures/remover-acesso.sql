DELIMITER $$

CREATE PROCEDURE Remover_acessos(IN id_arq INT)
BEGIN
    DELETE FROM Acesso_Arquivo
    WHERE id_arquivo = id_arq
    AND id_usuario < > (
        SELECT id_usuario
        FROM Arquivo
        WHERE id = id_arq
    );
END $$

DELIMITER ;

CALL Remover_acessos(1);