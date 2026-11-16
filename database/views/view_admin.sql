CREATE VIEW view_admin AS

SELECT 
    a.nome,
    a.tipo,
    a.tamanho,
    a.data_ultima_mod,
    a.localizacao,
    a.url

FROM Arquivo a;