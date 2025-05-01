# SQL_Project_Data_Job_Analysis

## 📚 Sobre o Projeto
Este repositório foi criado como parte do meu treinamento prático em SQL, seguindo o projeto proposto pelo Luke Barousse no vídeo SQL Project for Beginners | Data Job Analysis.
LINK Curso/Material: https://www.youtube.com/watch?v=7mz73uXD9DA

O objetivo do projeto é explorar e praticar a construção de consultas/queries SQL (Local consultas: [project_sql](/project_sql/)) em um banco de dados fictício relacionado ao mercado de trabalho na área de dados, incluindo vagas para:

- Analistas de Dados (Data Analysts)
- Engenheiros de Dados (Data Engineers)
- Cientistas de Dados (Data Scientists)
- Outros profissionais de tecnologia e dados

## 🛠️ O que foi trabalhado
Ao longo do projeto, foram desenvolvidas habilidades práticas em:

- Criação de consultas SQL para extração de insights
- Utilização de cláusulas como SELECT, WHERE, GROUP BY, ORDER BY, JOIN, entre outras
- Criação de subqueries e CTEs (Common Table Expressions)
- Análise de salários, habilidades exigidas, tipos de vagas e outras informações relevantes
- Aplicação de filtros para análises específicas (como ano, localidade, tipo de vaga, etc.)
- Git e Github para gestão de alterações e publicação do projeto.

## 📊 Base de Dados
A base de dados contém informações realistas (mas fictícias) sobre vagas de emprego, incluindo:

- Cargo e título da vaga
- Empresa contratante
- Localização
- Faixa salarial
- Habilidades e tecnologias exigidas
- Tipo de vaga (tempo integral, remoto, presencial, etc.)
- Data de postagem

## 🎯 Objetivo do Treinamento
O foco principal é desenvolver habilidades práticas em SQL, reforçando conceitos fundamentais e preparando para situações do mundo real, como:

- Analisar grandes volumes de dados
- Criar relatórios e dashboards
- Tomar decisões baseadas em dados extraídos via consultas SQL
- Este projeto não tem fins comerciais — é puramente educacional e voltado para prática pessoal.

Material do treinamento [sql_load](/sql_load/)


## 📚 Insights do projeto

### 1. Top Paying Data Analyst Jobs
Além de identificar o top10 salários para Analista de Dados realizei filtros de cargo, média salarial e trabalhos remotos visando adequar à minha área de interesse.

``` sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    c.name AS company_name
FROM
    job_postings_fact AS j
LEFT JOIN company_dim AS c ON j.company_id = c.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Detalhamento da análise:
-  **Variação:** Top 10 salários de Analista de Dados varia entre $184,000 a $650,000 / ano. Indicando um potencial significativo para esta área.

-  **Diversidade de Empregadores:** Empresas como SmartAsset, Meta, and AT&T estão entre as que pagam os grandes salários. Isso demonstra o interesse mesmo entre diferentes segmentos.

-  **Variedade em nomes de cargos:** Não existe um nome padrão para o título deste cargo. De Analista de Dados até Diretor of Analytics refletem a diversidade de cargos e especialização nesta área.
