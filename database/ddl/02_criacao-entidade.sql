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

CREATE TABLE IF NOT EXISTS Administrador(
    id INT PRIMARY KEY AUTO_INCREMENT,
    
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
);

CREATE TABLE IF NOT EXISTS Arquivo(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    permissoes_acesso VARCHAR(255) NOT NULL,
    tamanho BIGINT NOT NULL,
    data_ultima_mod DATE NOT NULL,
    localizacao VARCHAR(255) NOT NULL,
    url VARCHAR(500) NOT NULL,

    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
);

CREATE TABLE IF NOT EXISTS Suporte(
    id INT PRIMARY KEY AUTO_INCREMENT,
    dia DATE NOT NULL,
    hora TIME NOT NULL,
    descricao VARCHAR(255) NOT NULL,

    id_usuario INT NOT NULL,
    id_admin INT NOT NULL,
    id_arquivo INT,

    FOREIGN KEY (id_usuario) REFERENCES Usuario(id),
    FOREIGN KEY (id_admin) REFERENCES Administrador(id),
    FOREIGN KEY (id_arquivo) REFERENCES Arquivo(id)
);

CREATE TABLE IF NOT EXISTS Opera(
    operacao VARCHAR(255),
    
    id_usuario INT NOT NULL,
    id_arquivo INT NOT NULL,
    id_receptor INT NOT NULL,

    FOREIGN KEY (id_usuario) REFERENCEs Usuario(id),
    FOREIGN KEY (id_arquivo) REFERENCES Arquivo(id),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
);

CREATE TABLE IF NOT EXISTS Comentario(
    id INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    hora TIME NOT NULL,
    conteudo VARCHAR(500) NOT NULL,

    id_usuario INT NOT NULL,
    id_arquivo INT NOT NULL,

    FOREIGN KEY (id_usuario) REFERENCES Usuario(id),
    FOREIGN KEY (id_arquivo) REFERENCES Arquivo(id)
);

CREATE TABLE IF NOT EXISTS Historico(
    id INT PRIMARY KEY AUTO_INCREMENT,
    conteudo_alterado TEXT NOT NULL,
    operacao VARCHAR(255) NOT NULL,
    data DATE NOT NULL,
    hora TIME NOT NULL,

    id_arquivo INT NOT NULL,
    id_usuario INT NOT NULL,

    FOREIGN KEY (id_arquivo) REFERENCES Arquivo(id),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
);