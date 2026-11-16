CREATE VIEW view_usuario_historico AS

SELECT
    h.conteudo_alterado,
    h.operacao,
    h.data,
    h.hora
FROM Historico h 

WHERE h.id IN (
    SELECT id_arquivo FROM possui WHERE id_usuario = 1

    UNION

    SELECT id_arquivo FROM Opera WHERE id_receptor = 1;
)