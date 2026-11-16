CREATE VIEW view_usuario_arquivo AS

SELECT
    a.nome,
    a.tipo,
    a.permissao_acesso,
    a.tamanho,
    a.data_ultima_mod,
    a.localizacao,
    a.url

FROM Arquivo a

WHERE a.id_usuario = id_usuario_atual()

OR

a.id IN (
    SELECT ac.id_arquivo
    FROM Acesso_Arquivo ac
    WHERE ac.id_usuario = id_usuario_atual()
)

WITH CHECK OPTION;
