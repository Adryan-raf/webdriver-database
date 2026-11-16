DELIMITER $$

CREATE FUNCTION Verificar_data(id_arquivo INT)

RETURNS BOOLEAN
READS SQL DATA
BEGIN 

        DECLARE data_comp DATETIME;

        SET data_comp := (
            SELECT Arquivo.data_ultima_mod
            FROM Arquivo
            WHERE id = id_arquivo
        );

        IF DATEDIFF(CURDATE(), data_comp) > 100 THEN
                RETURN TRUE;
        ELSE
                RETURN FALSE;
        END IF;

END $$

DELIMITER ;

SELECT Verificar_data(1);