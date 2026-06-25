-- ============================================================
-- EXERCÍCIO PRÁTICO SQL — 24 Horas de Le Mans
-- Armazenamento e Acesso a Dados | IPCA 2025/2026
-- Todas as queries validadas ✓
-- ============================================================


-- ============================================================
-- PARTE 1: CRIAÇÃO DA BASE DE DADOS E TABELAS
-- ============================================================

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


-- ============================================================
-- PARTE 2: INSERÇÃO DE DADOS
-- ============================================================

INSERT INTO fabricantes (nome) VALUES
('Audi'), ('Porsche'), ('Toyota'), ('Ferrari'), ('Peugeot');

INSERT INTO equipas (nome, fabricante_id) VALUES
('Audi Sport Team Joest', 1),   -- id=1
('Porsche Team',          2),   -- id=2
('Toyota Gazoo Racing',   3),   -- id=3
('AF Corse',              4),   -- id=4
('Peugeot TotalEnergies', 5);   -- id=5

INSERT INTO pilotos (nome, nacionalidade) VALUES
('Andre Lotterer',         'Alemanha'),       -- id=1
('Benoit Treluyer',        'Franca'),         -- id=2
('Marcel Fassler',         'Suica'),          -- id=3
('Timo Bernhard',          'Alemanha'),       -- id=4
('Brendon Hartley',        'Nova Zelandia'),  -- id=5
('Mark Webber',            'Australia'),      -- id=6
('Neel Jani',              'Suica'),          -- id=7
('Romain Dumas',           'Franca'),         -- id=8
('Sebastien Buemi',        'Suica'),          -- id=9
('Kazuki Nakajima',        'Japao'),          -- id=10
('Fernando Alonso',        'Espanha'),        -- id=11
('Mike Conway',            'Reino Unido'),    -- id=12
('Kamui Kobayashi',        'Japao'),          -- id=13
('Jose Maria Lopez',       'Argentina'),      -- id=14
('Alessandro Pier Guidi',  'Italia'),         -- id=15
('James Calado',           'Reino Unido'),    -- id=16
('Antonio Giovinazzi',     'Italia');         -- id=17

INSERT INTO corridas (ano, data) VALUES
(2014,'2014-06-15'), (2015,'2015-06-14'), (2016,'2016-06-19'),
(2017,'2017-06-18'), (2018,'2018-06-17'), (2019,'2019-06-16'),
(2020,'2020-09-20'), (2021,'2021-08-22'), (2022,'2022-06-12'),
(2023,'2023-06-11');

INSERT INTO carros (modelo, fabricante_id) VALUES
('R18 e-tron quattro', 1),  -- id=1
('919 Hybrid',         2),  -- id=2
('TS050 Hybrid',       3),  -- id=3
('GR010 Hybrid',       3),  -- id=4
('499P',               4),  -- id=5
('9X8',                5);  -- id=6

INSERT INTO participacoes
    (corrida_id, equipa_id, carro_id, classe, posicao_final, tempo_total) VALUES
(1,1,1,'LMP1',1,'24:00:00'), (1,3,3,'LMP1',2,'24:02:00'),        -- 2014
(2,2,2,'LMP1',1,'24:00:00'), (2,1,1,'LMP1',2,'24:01:00'),        -- 2015
(3,2,2,'LMP1',1,'24:00:00'), (3,3,3,'LMP1',2,'24:03:00'),        -- 2016
(4,2,2,'LMP1',1,'24:00:00'), (4,1,1,'LMP1',2,'24:04:00'),        -- 2017
(5,3,3,'LMP1',1,'24:00:00'), (5,2,2,'LMP1',2,'24:02:00'),        -- 2018
(6,3,3,'LMP1',1,'24:00:00'), (6,2,2,'LMP1',2,'24:03:00'),        -- 2019
(7,3,3,'LMP1',1,'24:00:00'), (7,1,1,'LMP1',2,'24:05:00'),        -- 2020
(8,3,4,'Hypercar',1,'24:00:00'), (8,5,6,'Hypercar',2,'24:06:00'),-- 2021
(9,3,4,'Hypercar',1,'24:00:00'), (9,5,6,'Hypercar',2,'24:05:00'),-- 2022
(10,4,5,'Hypercar',1,'24:00:00'),(10,3,4,'Hypercar',2,'24:03:00');-- 2023

INSERT INTO participacao_pilotos (participacao_id, piloto_id, ultima_volta) VALUES
(1,1,TRUE),(1,2,FALSE),(1,3,FALSE),      -- 2014 Audi   (part=1)
(3,4,TRUE),(3,5,FALSE),(3,6,FALSE),      -- 2015 Porsche(part=3)
(5,7,TRUE),(5,4,FALSE),(5,8,FALSE),      -- 2016 Porsche(part=5)
(7,7,TRUE),(7,5,FALSE),(7,8,FALSE),      -- 2017 Porsche(part=7)
(9,10,TRUE),(9,11,FALSE),(9,9,FALSE),    -- 2018 Toyota (part=9)
(11,9,TRUE),(11,10,FALSE),(11,11,FALSE), -- 2019 Toyota (part=11)
(13,12,TRUE),(13,13,FALSE),(13,14,FALSE),-- 2020 Toyota (part=13)
(15,12,TRUE),(15,13,FALSE),(15,14,FALSE),-- 2021 Toyota (part=15)
(17,12,TRUE),(17,13,FALSE),(17,14,FALSE),-- 2022 Toyota (part=17)
(19,15,TRUE),(19,16,FALSE),(19,17,FALSE);-- 2023 Ferrari(part=19)


-- ============================================================
-- PARTE 3: QUERIES
-- ============================================================

-- ============================================================
-- EXPLORAÇÃO RELACIONAL
-- ============================================================

-- Q1. Qual a equipa que venceu mais vezes nos últimos 10 anos?
-- Resultado: Toyota Gazoo Racing — 5 vitórias (2018–2022)
-- Percurso de tabelas: participacoes → equipas + corridas
SELECT
    e.nome   AS equipa,
    COUNT(*) AS total_vitorias
FROM participacoes p
JOIN equipas  e ON e.id = p.equipa_id
JOIN corridas c ON c.id = p.corrida_id
WHERE p.posicao_final = 1
  AND c.ano BETWEEN 2014 AND 2023
GROUP BY e.id, e.nome
ORDER BY total_vitorias DESC
LIMIT 1;


-- Q2. Qual o fabricante com mais vitórias?
-- Resultado: Toyota 5 | Porsche 3 | Audi 1 | Ferrari 1
-- Percurso: participacoes → equipas → fabricantes
SELECT
    f.nome   AS fabricante,
    COUNT(*) AS total_vitorias
FROM participacoes p
JOIN equipas     e ON e.id = p.equipa_id
JOIN fabricantes f ON f.id = e.fabricante_id
WHERE p.posicao_final = 1
GROUP BY f.id, f.nome
ORDER BY total_vitorias DESC;


-- Q3. Que pilotos já venceram Le Mans mais do que uma vez?
-- Resultado: Conway/Kobayashi/Lopez (3x) | Bernhard/Hartley/Jani/Dumas/Buemi/Nakajima/Alonso (2x)
-- HAVING filtra pilotos com mais de 1 participação vencedora
SELECT
    p.nome   AS piloto,
    COUNT(*) AS vitorias
FROM participacao_pilotos pp
JOIN pilotos       p  ON p.id  = pp.piloto_id
JOIN participacoes pa ON pa.id = pp.participacao_id
WHERE pa.posicao_final = 1
GROUP BY p.id, p.nome
HAVING COUNT(*) > 1
ORDER BY vitorias DESC;


-- ============================================================
-- RELAÇÕES COMPLEXAS
-- ============================================================

-- Q4. Em que equipas correu Fernando Alonso?
-- Resultado: Toyota Gazoo Racing — 2018 e 2019
-- Percurso: pilotos → participacao_pilotos → participacoes → equipas + corridas
SELECT DISTINCT
    e.nome AS equipa,
    c.ano  AS ano
FROM participacao_pilotos pp
JOIN pilotos       p  ON p.id  = pp.piloto_id
JOIN participacoes pa ON pa.id = pp.participacao_id
JOIN equipas       e  ON e.id  = pa.equipa_id
JOIN corridas      c  ON c.id  = pa.corrida_id
WHERE p.nome = 'Fernando Alonso'
ORDER BY c.ano;


-- Q5. Que pilotos já correram com Kamui Kobayashi?
-- Resultado: Mike Conway e Jose Maria Lopez — 2020, 2021 e 2022
-- A subquery devolve os IDs de participacao onde Kobayashi esteve;
-- a query principal lista todos os outros pilotos nessas mesmas participações.
SELECT DISTINCT
    p.nome AS piloto_colega,
    c.ano  AS ano
FROM participacao_pilotos pp
JOIN pilotos       p  ON p.id  = pp.piloto_id
JOIN participacoes pa ON pa.id = pp.participacao_id
JOIN corridas      c  ON c.id  = pa.corrida_id
WHERE pp.participacao_id IN (
    SELECT pp2.participacao_id
    FROM participacao_pilotos pp2
    JOIN pilotos p2 ON p2.id = pp2.piloto_id
    WHERE p2.nome = 'Kamui Kobayashi'
)
  AND p.nome <> 'Kamui Kobayashi'
ORDER BY c.ano, p.nome;


-- ============================================================
-- HISTÓRICO
-- ============================================================

-- Q6. Que fabricante dominou mais anos consecutivos?
-- Resultado: Toyota — 5 anos (2018→2022) | Porsche — 3 anos (2015→2017)
--
-- Técnica "gaps and islands":
--   Numera-se cada linha globalmente (rn_global) e dentro de cada
--   fabricante (rn_fab). Quando um fabricante vence em anos consecutivos,
--   a diferença (rn_global - rn_fab) é constante — identifica a "ilha".
WITH vencedores_ano AS (
    SELECT c.ano, f.nome AS fabricante
    FROM participacoes p
    JOIN corridas    c ON c.id = p.corrida_id
    JOIN equipas     e ON e.id = p.equipa_id
    JOIN fabricantes f ON f.id = e.fabricante_id
    WHERE p.posicao_final = 1
),
numerados AS (
    SELECT
        ano,
        fabricante,
        ROW_NUMBER() OVER (ORDER BY ano)                         AS rn_global,
        ROW_NUMBER() OVER (PARTITION BY fabricante ORDER BY ano) AS rn_fab
    FROM vencedores_ano
),
grupos AS (
    SELECT
        fabricante,
        COUNT(*)  AS anos_consecutivos,
        MIN(ano)  AS ano_inicio,
        MAX(ano)  AS ano_fim
    FROM numerados
    GROUP BY fabricante, (rn_global - rn_fab)
)
SELECT fabricante, anos_consecutivos, ano_inicio, ano_fim
FROM grupos
ORDER BY anos_consecutivos DESC, ano_inicio;


-- Q7. Quantas equipas diferentes teve cada piloto?
-- Resultado: todos os pilotos tiveram 1 equipa (dataset apenas regista vencedores).
-- Nota: enriquecendo os dados com as 2as posições já teria mais variedade.
SELECT
    p.nome                       AS piloto,
    COUNT(DISTINCT pa.equipa_id) AS nr_equipas
FROM participacao_pilotos pp
JOIN pilotos       p  ON p.id  = pp.piloto_id
JOIN participacoes pa ON pa.id = pp.participacao_id
GROUP BY p.id, p.nome
ORDER BY nr_equipas DESC, p.nome;


-- ============================================================
-- ANÁLISE TÉCNICA
-- ============================================================

-- Q8. Que carro teve mais vitórias?
-- Resultado: 919 Hybrid (Porsche) e TS050 Hybrid (Toyota) — 3 vitórias cada
SELECT
    ca.modelo AS carro,
    f.nome    AS fabricante,
    COUNT(*)  AS vitorias
FROM participacoes p
JOIN carros      ca ON ca.id = p.carro_id
JOIN fabricantes f  ON f.id  = ca.fabricante_id
WHERE p.posicao_final = 1
GROUP BY ca.id, ca.modelo, f.nome
ORDER BY vitorias DESC;


-- Q9. Qual a média de posição da Toyota?
-- Resultado: 1.38 — Toyota quase sempre no top 2
SELECT
    ROUND(AVG(p.posicao_final), 2) AS media_posicao
FROM participacoes p
JOIN equipas     e ON e.id = p.equipa_id
JOIN fabricantes f ON f.id = e.fabricante_id
WHERE f.nome = 'Toyota';


-- ============================================================
-- DESAFIOS AVANÇADOS
-- ============================================================

-- D1. Pilotos que ganharam com mais do que um fabricante
-- Resultado: 0 linhas com os dados fornecidos.
-- Explicação: cada piloto vencedor pertenceu sempre ao mesmo
--   fabricante nas suas participações vencedoras. Para ter resultados
--   seria necessário que, por ex., Timo Bernhard (Porsche 2015-17)
--   também tivesse registos de vitória pela Audi.
SELECT
    p.nome                                        AS piloto,
    COUNT(DISTINCT f.id)                          AS fabricantes_distintos,
    GROUP_CONCAT(DISTINCT f.nome ORDER BY f.nome) AS fabricantes
FROM participacao_pilotos pp
JOIN pilotos       p  ON p.id  = pp.piloto_id
JOIN participacoes pa ON pa.id = pp.participacao_id
JOIN equipas       e  ON e.id  = pa.equipa_id
JOIN fabricantes   f  ON f.id  = e.fabricante_id
WHERE pa.posicao_final = 1
GROUP BY p.id, p.nome
HAVING COUNT(DISTINCT f.id) > 1
ORDER BY fabricantes_distintos DESC;


-- D2. Equipas que subiram do 2º lugar para 1º em anos consecutivos
-- Resultado: 0 linhas com os dados fornecidos.
-- Explicação: a Toyota ficou em 2º em 2015, 2016 e 2017 mas ganhou
--   em 2018, portanto a transição 2º(2017)→1º(2018) NÃO se verifica
--   porque em 2017 quem ficou em 2º foi a Audi, não a Toyota.
--   Porsche ficou em 2º em 2018 e 2019 mas nunca ganhou depois disso.
SELECT
    e.nome  AS equipa,
    c1.ano  AS ano_segundo_lugar,
    c2.ano  AS ano_primeira_vitoria
FROM participacoes p1
JOIN participacoes p2 ON p2.equipa_id   = p1.equipa_id
                      AND p2.posicao_final = 1
JOIN corridas c1 ON c1.id = p1.corrida_id
JOIN corridas c2 ON c2.id = p2.corrida_id
                AND c2.ano = c1.ano + 1
JOIN equipas  e  ON e.id  = p1.equipa_id
WHERE p1.posicao_final = 2
ORDER BY c1.ano;


-- D3. Detetar "dinastias" (3 ou mais vitórias consecutivas)
-- Resultado: Toyota 2018→2022 (5 anos) | Porsche 2015→2017 (3 anos)
-- Usa a mesma lógica de gaps-and-islands da Q6, filtrando >= 3.
WITH vencedores_ano AS (
    SELECT c.ano, f.nome AS fabricante
    FROM participacoes p
    JOIN corridas    c ON c.id = p.corrida_id
    JOIN equipas     e ON e.id = p.equipa_id
    JOIN fabricantes f ON f.id = e.fabricante_id
    WHERE p.posicao_final = 1
),
numerados AS (
    SELECT
        ano,
        fabricante,
        ROW_NUMBER() OVER (ORDER BY ano)                         AS rn_global,
        ROW_NUMBER() OVER (PARTITION BY fabricante ORDER BY ano) AS rn_fab
    FROM vencedores_ano
),
grupos AS (
    SELECT
        fabricante,
        COUNT(*)  AS anos_consecutivos,
        MIN(ano)  AS ano_inicio,
        MAX(ano)  AS ano_fim
    FROM numerados
    GROUP BY fabricante, (rn_global - rn_fab)
)
SELECT
    fabricante,
    anos_consecutivos,
    ano_inicio,
    ano_fim,
    CONCAT(ano_inicio, ' -> ', ano_fim) AS periodo
FROM grupos
WHERE anos_consecutivos >= 3
ORDER BY anos_consecutivos DESC, ano_inicio;


-- ============================================================
-- RESUMO DOS RESULTADOS VALIDADOS
-- ============================================================
-- Q1  Equipa mais vencedora:      Toyota Gazoo Racing (5 vitórias)
-- Q2  Fabricante mais vencedor:   Toyota(5) Porsche(3) Audi(1) Ferrari(1)
-- Q3  Pilotos multi-vitória:      Conway/Kobayashi/Lopez(3x) + 7 pilotos(2x)
-- Q4  Alonso correu em:           Toyota Gazoo Racing (2018 e 2019)
-- Q5  Colegas de Kobayashi:       Mike Conway e Jose Maria Lopez (2020-2022)
-- Q6  Mais anos consecutivos:     Toyota 5 anos (2018->2022)
-- Q7  Equipas por piloto:         1 equipa cada (dataset só tem vencedores)
-- Q8  Carro mais vencedor:        919 Hybrid e TS050 Hybrid — 3 vitórias cada
-- Q9  Media posicao Toyota:       1.38
-- D1  Pilotos multi-fabricante:   0 casos nos dados fornecidos
-- D2  Subida 2o->1o consecutivo:  0 casos nos dados fornecidos
-- D3  Dinastias (>=3 seguidas):   Toyota(5 anos) e Porsche(3 anos)
-- ============================================================
