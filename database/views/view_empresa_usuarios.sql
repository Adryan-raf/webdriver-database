CREATE VIEW view_empresa_usuarios AS

SELECT
    u.login,
    u.nome,
    u.email,
    u.data_ingresso,
    i.nome AS instituicao

FROM Usuario u

JOIN Instituicao i ON i.id = u.id_instituicao

WHERE i.id = id_instituicao_atual();
