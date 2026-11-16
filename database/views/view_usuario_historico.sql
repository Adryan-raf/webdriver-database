CREATE VIEW view_usuario_historico AS

SELECT
    h.conteudo_alterado,
    h.operacao,
    h.data,
    h.hora
FROM Historico h;