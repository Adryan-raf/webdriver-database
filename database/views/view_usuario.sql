CREATE VIEW view_usuario AS

SELECT
    a.nome,
    a.tipo,
    a.tamanho,
    a.localizacao,
    a.url,
    a.data_ultima_mod

FROM Arquivo a

WHERE a.permissao_acesso = TRUE

OR

a.id_usuario = (
    SELECT u.id
    FROM Usuario u
    WHERE u.login = SUBSTRING_INDEX(USER(), '@', 1)
);

OR

a.id IN (
    SELECT ac.id_arquivo
    FROM Acesso_Arquivo ac
    WHERE ac.id_usuario = (
        SELECT u.id
        FROM Usuario u
        WHERE u.login = SUBSTRING_INDEX(USER(), '@', 1)
    )
);