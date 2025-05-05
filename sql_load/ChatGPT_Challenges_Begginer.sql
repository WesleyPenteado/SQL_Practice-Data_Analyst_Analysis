/*
🔹 PERGUNTAS INICIANTES (Básico a Intermediário)
Quantas vagas de Data Analyst foram postadas em 2023 por mês?

Quais são os 5 títulos de vagas mais comuns postadas em 2024?

Qual a média de vagas postadas por empresa?

Quantas vagas são 100% remotas vs. presenciais?

Quantas empresas diferentes postaram vagas em 2023?

Quais são as top 10 skills mais requisitadas no total de vagas?

Qual o número de vagas que exigem SQL?

Qual o total de skills únicas associadas a vagas remotas?

Quantas vagas cada empresa postou nos últimos 6 meses?
*/



-- Quantas vagas de Data Analyst foram postadas em 2023 por mês?

SELECT
    COUNT(job_id) AS job_counting,
    TO_CHAR(job_posted_date, 'Mon') AS month_abbr
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND EXTRACT(YEAR FROM job_posted_date) = '2023'
GROUP BY
    month_abbr,
    EXTRACT(MONTH FROM job_posted_date)
ORDER BY
    EXTRACT(MONTH FROM job_posted_date);


--  Quais são os 5 títulos de vagas mais comuns postadas?

SELECT
    TO_CHAR(COUNT(job_id), 'FM999,999,999') AS job_counting,
    job_title_short
FROM job_postings_fact
GROUP BY
    job_title_short
ORDER BY
    COUNT(job_id) DESC;


-- Qual a média de vagas postadas por empresa?

SELECT
    ROUND(AVG(job_count), 2) AS avg_jobs_per_company
FROM (
    SELECT
            company_id,
            COUNT(job_id) AS job_count
    FROM job_postings_fact
    GROUP BY company_id
) AS sub;