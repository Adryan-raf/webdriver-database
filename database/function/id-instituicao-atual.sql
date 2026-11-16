DELIMITER $$

CREATE FUNCTION id_instituicao_atual()

RETURNS INT
READS SQL DATA
BEGIN

    RETURN (
        SELECT ce.id_instituicao
        FROM Conta_Empresa ce
        WHERE ce.login = SUBSTRING_INDEX(USER(), '@', 1)
    );

END $$

DELIMITER ;
