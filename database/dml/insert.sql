INSERT INTO Plano(nome, duracao, data_aquisicao, espaco_por_usuario) 
 VALUES ('Semestre 2026.2', '6 meses', '2026-07-15', 100);

INSERT INTO Instituicao(nome, endereco, causa_social, id_plano)
VALUES ('Universidade Catolica de Pernambuco', 'Rua do Principe', 'Ensino', 1);

INSERT INTO Usuario(
    login,
    senha,
    data_ingresso,
    email,
    nome,
    id_instituicao
)
VALUES (
    'm0235',
    'vinipes',
    '2026-08-02',
    'm0235@unicap.com.br',
    'Vinicius Talis',
    1
);