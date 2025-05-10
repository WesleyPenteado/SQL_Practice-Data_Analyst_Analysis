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


-- Quantas vagas são 100% remotas vs. presenciais?

--Inicial
SELECT
    job_work_from_home AS is_romote,
    COUNT(job_id) AS job_count
    FROM job_postings_fact
GROUP BY
    job_work_from_home;

--Melhorado
SELECT
    CASE
        WHEN job_work_from_home = 'TRUE' THEN 'Remota'
        WHEN job_work_from_home = 'FALSE' THEN 'Presencial'
        ELSE 'Not Applied'
    END AS tipo_vaga,
    COUNT(job_id) AS job_count
    FROM job_postings_fact
GROUP BY
    tipo_vaga;


-- Quantas empresas diferentes postaram vagas em 2023?

SELECT
    COUNT(DISTINCT company_id) AS company_count
FROM job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = 2023;


-- Quais são as top 10 skills mais requisitadas no total de vagas?

SELECT
    skills_dim.skills AS skill_name,
    COUNT(skills_job_dim.skill_id) AS skill_count
FROM skills_job_dim
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY
    skill_name
ORDER BY
    skill_count DESC
LIMIT 10;

-- Qual o número de vagas que exigem SQL?

SELECT
    skills_dim.skills AS skill_name,
    COUNT(skills_job_dim.job_id) AS job_count
FROM skills_job_dim
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    skills_dim.skills = 'sql'
GROUP BY
    skills_dim.skills;

-- Qual o total de skills únicas associadas a vagas remotas?

SELECT
    COUNT(DISTINCT skills_job_dim.skill_id) AS unique_skill_count
FROM skills_job_dim
INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE
    job_work_from_home = 'True';



/*

🧠 O que essa query faz:
1) Seleciona as skills de vagas remotas (job_work_from_home = 'True').

2) Elimina todas as skills que também aparecem em vagas não-remotas (!= 'True').

3) Usa NOT IN com skill_id para garantir que a skill seja exclusiva de vagas remotas

*/

SELECT DISTINCT 
    sd.skill_id, 
    sd.skills
FROM skills_job_dim sjd
JOIN skills_dim sd ON sd.skill_id = sjd.skill_id
JOIN job_postings_fact jpf ON jpf.job_id = sjd.job_id
WHERE 
    jpf.job_work_from_home = 'True'
    AND sd.skill_id NOT IN (
        SELECT sjd2.skill_id
        FROM skills_job_dim sjd2
        JOIN job_postings_fact jpf2 ON jpf2.job_id = sjd2.job_id
        WHERE jpf2.job_work_from_home != 'True' -- != "diferente de"
        );



-- Quantas vagas cada empresa postou nos últimos 6 meses?

SELECT
    company_id,
    COUNT(job_id) AS job_count
FROM
    job_postings_fact
WHERE
    EXTRACT(MONTH FROM job_posted_date) BETWEEN 7 and 12
GROUP BY
    company_id
ORDER BY
    job_count DESC;