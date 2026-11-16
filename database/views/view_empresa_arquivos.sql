CREATE VIEW view_empresa_arquivos AS

SELECT
    a.nome,
    a.tipo,
    a.tamanho,
    a.data_ultima_mod,
    u.login AS login_usuario,
    i.nome AS instituicao

FROM Arquivo a

JOIN Usuario u ON u.id = a.id_usuario

JOIN Instituicao i ON i.id = u.id_instituicao

WHERE i.id = id_instituicao_atual();
