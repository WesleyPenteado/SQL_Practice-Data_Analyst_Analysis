/*
🔹 PERGUNTAS AVANÇADAS (Insight mais profundo)
Existe uma correlação entre vagas remotas e exigência de certas habilidades (ex: Python, SQL)?

Qual é o tempo médio entre o início do mês e a postagem de uma vaga (indicando urgência)?

Empresas grandes (size = 'Enterprise') exigem mais skills por vaga que pequenas empresas?

Crie uma lista das “vagas mais técnicas”, ou seja, com o maior número de skills associadas.

Crie um ranking das skills mais associadas a vagas com título que contenha ‘Data’.

Qual o número médio de skills por vaga para cargos remotos vs. presenciais?

Qual o “skill gap” entre o que é exigido em vagas de Junior, Pleno e Sênior (baseado em título)?

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
                DATE_PART('day', -- extract only day of interval
                    job_posted_date - DATE_TRUNC('month', job_posted_date) -- truncate job data to the first day of each month
                )
            )::numeric,
    2) AS avg_days_from_start
FROM job_postings_fact
WHERE job_posted_date IS NOT NULL;