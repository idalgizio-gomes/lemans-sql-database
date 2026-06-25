CREATE DATABASE IF NOT EXISTS lemans;
USE lemans;

CREATE TABLE fabricantes (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE equipas (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    fabricante_id INT,
    FOREIGN KEY (fabricante_id) REFERENCES fabricantes(id)
);

CREATE TABLE pilotos (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)
);

CREATE TABLE corridas (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    ano  INT  NOT NULL,
    data DATE NOT NULL
);

CREATE TABLE carros (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    modelo        VARCHAR(100),
    fabricante_id INT,
    FOREIGN KEY (fabricante_id) REFERENCES fabricantes(id)
);

CREATE TABLE participacoes (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    corrida_id    INT,
    equipa_id     INT,
    carro_id      INT,
    classe        VARCHAR(50),
    posicao_final INT,
    tempo_total   TIME,
    FOREIGN KEY (corrida_id) REFERENCES corridas(id),
    FOREIGN KEY (equipa_id)  REFERENCES equipas(id),
    FOREIGN KEY (carro_id)   REFERENCES carros(id)
);

CREATE TABLE participacao_pilotos (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    participacao_id  INT,
    piloto_id        INT,
    ultima_volta     BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (participacao_id) REFERENCES participacoes(id),
    FOREIGN KEY (piloto_id)       REFERENCES pilotos(id)
);

