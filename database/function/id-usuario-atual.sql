DELIMITER $$

CREATE FUNCTION id_usuario_atual()

RETURNS INT
READS SQL DATA
BEGIN

    RETURN (
        SELECT u.id
        FROM Usuario u
        WHERE u.login = SUBSTRING_INDEX(USER(), '@', 1)
    );

END $$

DELIMITER ;
