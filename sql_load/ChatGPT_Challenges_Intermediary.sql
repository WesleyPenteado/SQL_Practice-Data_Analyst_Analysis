/*
🔹 PERGUNTAS INTERMEDIÁRIAS
Quais são as 5 empresas com mais vagas de Data Analyst com exigência de Python?

Quais empresas estão contratando mais para posições remotas?

Quais são as top 10 combinações de habilidades mais frequentes em vagas?

Em que mês de 2023 houve o pico de postagens de vagas?

Quantas vagas têm 3 ou mais skills associadas?

Quais são as empresas que mais contrataram vagas com a skill "Power BI"?
*/

-- Quais são as 5 empresas com mais vagas de Data Analyst com exigência de Python?

SELECT 
    cd.name AS company_name,
    COUNT(jpf.job_id) AS job_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
INNER JOIN company_dim AS cd ON cd.company_id = jpf.company_id
WHERE
    jpf.job_title_short = 'Data Analyst'
    AND LOWER(sd.skills) = 'python' -- garante Python, PYTHON e etc sejam tratados igualmente
GROUP BY
    company_name
ORDER BY
    job_count DESC
LIMIT
    5;


-- Quais empresas estão contratando mais para posições remotas?

SELECT 
    cd.name AS company_name,
    COUNT(jpf.job_id) AS job_count
FROM job_postings_fact AS jpf
INNER JOIN company_dim AS cd ON cd.company_id = jpf.company_id
WHERE
    jpf.job_work_from_home = 'Yes'
GROUP BY
    company_name
ORDER BY
    job_count DESC
LIMIT
    5;


Quais são as top 10 combinações de habilidades mais frequentes em vagas?

SELECT 
    skills_combination,
    COUNT(*) AS frequency
FROM (
    SELECT
        jpf.job_id,
        STRING_AGG(sd.skills, ', ' ORDER BY sd.skills) AS skills_combination
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
    INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
    GROUP BY jpf.job_id
) AS job_skills
GROUP BY skills_combination
ORDER BY frequency DESC
LIMIT 10;


-- Em que mês de 2023 houve o pico de postagens de vagas?

SELECT
    EXTRACT(MONTH FROM job_posted_date) AS month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = '2023'
GROUP BY
    month
ORDER BY
    job_count DESC LIMIT 1;


-- Quantas vagas têm 3 ou mais skills associadas?

SELECT
    COUNT(*) AS job_count
FROM (
    SELECT
        job_id,
        COUNT(skill_id) AS count_skill
    FROM skills_job_dim
    GROUP BY job_id
    ) AS frequency
WHERE
    count_skill >= 3;


-- Quais são as empresas que mais contrataram vagas com a skill "Power BI"?

SELECT 
    cd.name AS company_name,
    COUNT(jpf.job_id) AS job_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
INNER JOIN company_dim AS cd ON cd.company_id = jpf.company_id
WHERE
        LOWER(sd.skills)IN ('powerbi', 'power bi') -- lower garante maiúsculas e minusculas
GROUP BY
    company_name
ORDER BY
    job_count DESC
LIMIT
    10;




