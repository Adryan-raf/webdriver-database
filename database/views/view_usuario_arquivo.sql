CREATE VIEW view_usuario_arquivo AS

SELECT
    a.id,
    a.nome,
    a.tipo,
    a.permissao_acesso,
    a.tamanho,
    a.data_ultima_mod,
    a.localizacao,
    a.url,
    a.id_usuario

FROM Arquivo a

WHERE a.id_usuario = id_usuario_atual()

WITH CHECK OPTION;
