CREATE VIEW view_usuario_historico AS

SELECT
    h.conteudo_alterado,
    h.operacao,
    h.data,
    h.hora
FROM Historico h 

WHERE h.id_arquivo IN (
    SELECT a.id 
    FROM Arquivo a
    WHERE a.id_usuario = 1 -- Implementar depois: id_usuario_atual()

    UNION

    SELECT ac.id_arquivo
    FROM Acesso_Arquivo ac
    WHERE ac.id_usuario = 1 -- Implementar depois: id_usuario_atual()
)