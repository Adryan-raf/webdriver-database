CREATE VIEW view_empresa_arquivos AS

SELECT
    a.nome,
    a.tipo,
    a.tamanho,
    a.data_ultima_mod,
    u.login AS login_usuario,
    i.id AS id_instituicao,
    i.nome AS instituicao

FROM Arquivo a

JOIN Usuario u ON u.id = a.id_usuario

JOIN Instituicao i ON i.id = u.id_instituicao;
