USE web_driver;

CREATE TABLE IF NOT EXISTS Plano(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    duracao VARCHAR(255) NOT NULL,
    data_aquisicao DATE NOT NULL, -- O modelo lógico definiu o tipo desse atributo como STRING/VARCHAR, no modelo físico isso foi corrigido
    espaco_por_usuario INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Instituicao(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    causa_social VARCHAR(255) NOT NULL,

    id_plano INT NOT NULL,
    FOREIGN KEY (id_plano) REFERENCES Plano(id)
);

CREATE TABLE IF NOT EXISTS Usuario(
    id INT PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_ingresso DATE NOT NULL,
    email VARCHAR(255) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    
    id_instituicao INT NOT NULL,
    FOREIGN KEY (id_instituicao) REFERENCES Instituicao(id)
);