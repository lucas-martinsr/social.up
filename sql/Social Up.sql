-- ============================================================
-- Projeto: Social Up - Performance de Mídia Social
-- Etapa: 01 - Criação das tabelas
-- Autor: Lucas Martins
-- ============================================================
CREATE DATABASE socialup;

USE socialup;

CREATE TABLE clientes (
	id_cliente INT NOT NULL AUTO_INCREMENT,
	nome_cliente VARCHAR (80),
	segmento VARCHAR (50),
	pais VARCHAR (40),
PRIMARY KEY (id_cliente));

CREATE TABLE campanhas (
	id_campanha INT NOT NULL AUTO_INCREMENT,
	id_cliente INT NOT NULL,
	plataforma VARCHAR (30),
	orcamento DECIMAL (10,2),
	data_inicio DATE,
	data_fim DATE,
PRIMARY KEY (id_campanha),
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente));

CREATE TABLE metricas (
	id_metrica INT NOT NULL AUTO_INCREMENT,
	id_campanha INT,
	alcance INT,
	cliques INT,
	engajamentos INT,
	conversoes INT,
	investimento DECIMAL (10,2),
PRIMARY KEY (id_metrica),
FOREIGN KEY (id_campanha) REFERENCES campanhas (id_campanha));

-- ============================================================
-- Etapa: 02 - Inserção de dados
-- ============================================================

INSERT INTO clientes (nome_cliente, segmento, pais)
VALUES
	('Lumina Beauty', 'Beleza', 'Brasil'),
    ('TechNova', 'Tecnologia', 'Brasil'),
    ('FitWear', 'Vestuário', 'EUA'),
    ('Conecta Telecom', 'Telefonia', 'Alemanha'),
    ('GreenSpark', 'Sustentabilidade', 'Holanda');
    
INSERT INTO campanhas (id_cliente, plataforma, orcamento, data_inicio, data_fim)
VALUES
	(1, 'Instagram', 10000.00, '2025-03-01', '2025-03-31'),
    (2, 'YouTube', 20000.00, '2025-04-01', '2025-04-30'),
    (3, 'TikTok', 18000.00, '2025-05-01', '2025-05-31'),
    (4, 'Instagram', 15000.00, '2025-06-01', '2025-06-30'),
    (5, 'YouTube', 22000.00, '2025-07-01', '2025-07-31'),
    (1, 'TikTok', 12000.00, '2025-08-01', '2025-08-31');
    
INSERT INTO metricas (id_campanha, alcance, cliques, engajamentos, conversoes, investimento)
VALUES
	(1, 900000, 6000, 7200, 400, 9800.00),
    (2, 1200000, 9500, 8800, 520, 19500.00),
    (3, 1100000, 8000, 9100, 480, 17800.00),
    (4, 950000, 7500, 8500, 450, 14500.00),
    (5, 1400000, 10200, 9500, 610, 21500.00),
    (6, 1000000, 6800, 7900, 420, 11800.00);