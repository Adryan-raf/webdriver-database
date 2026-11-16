CREATE VIEW view_usuario AS

SELECT
    a.nome,
    a.tipo,
    a.tamanho,
    a.localizacao,
    a.url,
    a.data_ultima_mod

FROM Arquivo a

WHERE a.id IN(
    SELECT id_arquivo FROM possui WHERE id_usuario = 1 -- Implementar depois: id_usuario_atual()

    UNION

    SELECT id_arquivo FROM Opera WHERE id_receptor = 1 -- Implementar depois: id_usuario_atual()
)
