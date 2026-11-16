CREATE VIEW view_empresa_usuarios AS

SELECT
    u.id,
    u.login,
    u.nome,
    u.email,
    u.data_ingresso,
    i.id AS id_instituicao,
    i.nome AS instituicao

FROM Usuario u

JOIN Instituicao i ON i.id = u.id_instituicao;
