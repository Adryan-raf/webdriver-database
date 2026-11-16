-- INSERT INTO Plano(nome, duracao, data_aquisicao, espaco_por_usuario) 
 -- VALUES ('Semestre 2026.2', '6 meses', '2026-07-15', 100);

-- INSERT INTO Instituicao(nome, endereco, causa_social, id_plano)
-- VALUES ('Universidade Catolica de Pernambuco', 'Rua do Principe', 'Ensino', 1);

-- INSERT INTO Usuario(login, senha, data_ingresso, email, nome, id_instituicao) VALUES 
-- ('m0235','vinipes','2026-08-02','m0235@unicap.com.br','Vinicius Talis', 1),
-- ('m0163','cd005c','2026-08-02','m0163@unicap.com.br','Ana Clara', 1),
-- ('m0222','cdcda','2026-08-02','m0222@unicap.com.br','Roberta Lima', 1),
-- ('m0224','sffsf','2026-08-02','m0224@unicap.com.br','Gilberto Rosa', 1),
-- ('m0233','dqdwq','2026-08-02','m0233@unicap.com.br','Lucas Emanuel', 1);


-- INSERT INTO Arquivo(nome, tipo, permissao_acesso, tamanho, data_ultima_mod, localizacao, url, id_usuario) VALUES
-- ('plano-ensino-edl1', 'pdf', FALSE ,'1.2MB', '2026-08-02 10:00:00', '/docs', 'url.com/doc1', 1),
-- ('plano-ensino-edl2', 'pdf', FALSE ,'1.2MB', '2026-08-02 10:00:00', '/docs', 'url.com/doc2', 3),
-- ('plano-ensino-edl3', 'pdf', FALSE , '1.2MB', '2026-08-02 10:00:00', '/docs', 'url.com/doc3', 2),
-- ('convite-programacao-compet','png', FALSE ,'1.5MB', '2026-08-02 10:20:00', '/docs', 'url.com/file-png', 1);