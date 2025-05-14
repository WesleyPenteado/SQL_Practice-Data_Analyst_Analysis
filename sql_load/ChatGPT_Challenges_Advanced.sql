/*
🔹 PERGUNTAS AVANÇADAS (Insight mais profundo)
Existe uma correlação entre vagas remotas e exigência de certas habilidades (ex: Python, SQL)?

Qual é o tempo médio entre o início do mês e a postagem de uma vaga (indicando urgência)?

Crie uma lista das “vagas mais técnicas”, ou seja, com o maior número de skills associadas.

Qual o número médio de skills por vaga para cargos remotos vs. presenciais?

*/


/* Existe uma correlação entre vagas remotas e exigência de certas habilidades 
(ex: Python, SQL)?
*/

SELECT
    LOWER(sd.skills) AS skill,
    jpf.job_work_from_home AS is_remote,
    COUNT(DISTINCT jpf.job_id) AS job_count
FROM job_postings_fact AS jpf
JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE LOWER(sd.skills) IN ('python', 'sql')
GROUP BY skill, is_remote
ORDER BY skill, is_remote;


/* Qual é o tempo médio entre o início do mês e a postagem de uma vaga
 (indicando urgência)?
*/

SELECT 
    ROUND(
            AVG(
                DATE_PART('day', -- extrai somente o dia no intervalo
                    job_posted_date - DATE_TRUNC('month', job_posted_date) -- truca/trava a data para o primeiro dia de cada mês
                )
            )::numeric,
    2) AS avg_days_from_start
FROM job_postings_fact
WHERE job_posted_date IS NOT NULL;


/*
Crie uma lista das “vagas mais técnicas”, ou seja, com o maior número de 
skills associadas.
*/

SELECT
    j.job_id,
    j.job_title,
    COUNT(s.skill_id) AS skill_count
FROM skills_job_dim s
JOIN job_postings_fact j ON s.job_id = j.job_id
GROUP BY j.job_id, j.job_title
ORDER BY skill_count DESC
LIMIT 10;


/*
Qual o número médio de skills por vaga para cargos remotos vs. presenciais?
*/

WITH sjd_table AS (
SELECT
    job_id,
    COUNT(skill_id) AS skill_count
FROM skills_job_dim
GROUP BY job_id
ORDER BY skill_count DESC
)
SELECT
    j.job_work_from_home,
    ROUND(AVG(skill_count),2) AS avg_skill
FROM sjd_table AS sjd
LEFT JOIN job_postings_fact AS j ON j.job_id = sjd.job_id
GROUP BY
    j.job_work_from_home;
