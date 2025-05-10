/*
🔹 PERGUNTAS INTERMEDIÁRIAS
Quais são as 5 empresas com mais vagas de Data Analyst com exigência de Python?

Quais empresas estão contratando mais para posições remotas?

Quais são as top 10 combinações de habilidades mais frequentes em vagas?

Em que mês de 2023 houve o pico de postagens de vagas?

Quantas vagas têm 3 ou mais skills associadas?

Existe alguma relação entre tamanho da empresa (company_dim.size) e o número de vagas abertas?

Qual a distribuição de vagas por setor/indústria?

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