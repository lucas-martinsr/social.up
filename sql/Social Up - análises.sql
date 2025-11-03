-- ============================================================
-- Projeto: Social Up - Performance de Mídia Social
-- Etapa: 03 - Consulta de análise
-- Autor: Lucas Martins
-- ============================================================

USE socialup;

-- ============================================================
-- CONSULTA 01 - Total de alcance/cliques/engajamentos por plataforma
-- ============================================================

SELECT 
	cam.plataforma, 
	SUM(met.alcance) AS alcance, 
    SUM(met.cliques) AS cliques, 
    SUM(met.engajamentos) AS engajamentos
FROM campanhas cam 
JOIN metricas met ON cam.id_campanha = met.id_campanha
GROUP BY cam.plataforma;

-- ============================================================
-- CONSULTA 02 - Cálculo da taxa de engajamento
-- ============================================================

SELECT 
	cli.nome_cliente AS cliente,
    cam.plataforma,
   ROUND(SUM((met.engajamentos / met.alcance) * 100), 2) AS 'taxa engajamento' 
FROM clientes cli
JOIN campanhas cam ON cam.id_cliente = cli.id_cliente
JOIN metricas met ON met.id_campanha = cam.id_campanha
GROUP BY cli.nome_cliente, cam.plataforma, met.engajamentos, met.alcance
ORDER BY SUM((met.engajamentos / met.alcance) * 100) DESC;

-- ============================================================
-- CONSULTA 03 - Cálculo do CPC (Custo por Clique)
-- ============================================================

SELECT 
	cli.nome_cliente AS cliente,
	SUM(cam.orcamento) AS orcamento,
    SUM(met.investimento) AS investimento, 
    SUM(met.cliques) AS cliques, 
    ROUND(SUM(met.investimento) / SUM(met.cliques), 2) AS CPC
FROM clientes cli
JOIN campanhas cam ON cam.id_cliente = cli.id_cliente
JOIN metricas met ON cam.id_campanha = met.id_campanha
GROUP BY cli.nome_cliente
ORDER BY CPC DESC;

-- ============================================================
-- CONSULTA 04 - Cálculo do CPA (Custo por Aquisição)
-- ============================================================

SELECT 
	cli.nome_cliente AS cliente,
    SUM(cam.orcamento) AS orcamento,
    SUM(met.investimento) AS investimento, 
    SUM(met.conversoes) AS conversoes, 
    ROUND(SUM(met.investimento) / SUM(met.conversoes), 2) AS CPA
FROM clientes cli
JOIN campanhas cam ON cam.id_cliente = cli.id_cliente
JOIN metricas met ON cam.id_campanha = met.id_campanha
GROUP BY cli.nome_cliente
ORDER BY CPA DESC;

-- ============================================================
-- CONSULTA 05 - Top 3 campanhas com melhor CPA
-- ============================================================

SELECT
	cam.id_campanha AS campanha,
    cli.nome_cliente AS cliente,
    cam.plataforma,
    ROUND(SUM(met.investimento) / SUM(met.conversoes), 2) AS CPA
FROM campanhas cam
JOIN clientes cli ON cli.id_cliente = cam.id_cliente
JOIN metricas met ON cam.id_campanha = met.id_campanha
GROUP BY cam.id_campanha
ORDER BY CPA DESC
LIMIT 3;

-- ============================================================
-- CONSULTA 06 - Média de investimento por cliente e plataforma
-- ============================================================

SELECT
	cli.nome_cliente AS cliente,
    cam.plataforma,
    AVG (met.investimento) AS 'media investimento'
FROM clientes cli
JOIN campanhas cam ON cam.id_cliente = cli.id_cliente
JOIN metricas met ON cam.id_campanha = met.id_campanha
GROUP BY cli.nome_cliente, cam.plataforma
ORDER BY AVG (met.investimento) DESC