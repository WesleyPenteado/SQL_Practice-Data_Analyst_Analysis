-- To use the Union the columns have to match (Data Type and names)
-- UNION will bring the data without DUPLICATES and UNION ALL return all the data

-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM
   jan_2023_jobs

UNION ALL

-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM
   fev_2023_jobs

UNION ALL

-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM
   mar_2023_jobs;


/*
Practice Problem 1

- Get the corresponding skill and skill type for each job posting in q1
- Includes those without any skills, too
- Why? Look at the skills and the type for each job in the first quarter that has a salary > 70K

*/

WITH jobs_q1 AS (
    SELECT job_id, salary_year_avg FROM jan_2023_jobs
    UNION ALL
    SELECT job_id, salary_year_avg FROM fev_2023_jobs
    UNION ALL
    SELECT job_id, salary_year_avg FROM mar_2023_jobs
)
SELECT
    j.job_id,
    j.salary_year_avg,
    s.skills,
    s.type
FROM 
    jobs_q1 AS j
LEFT JOIN skills_job_dim AS sj ON j.job_id = sj.job_id
LEFT JOIN skills_dim AS s ON sj.skill_id = s.skill_id
WHERE 
    j.salary_year_avg > 70000
ORDER BY 
    j.salary_year_avg DESC;


/*
Practice Problem 8

Find job postings from the first quarter that have a salary greater
than $70K
- Combine job postings tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000
*/


SELECT
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE,
    quarter1_job_postings.salary_year_avg
FROM (
    SELECT *
    FROM jan_2023_jobs
    UNION ALL
    SELECT *
    FROM fev_2023_jobs
    UNION ALL
    SELECT *
    FROM mar_2023_jobs
) AS quarter1_job_postings
WHERE
    quarter1_job_postings.salary_year_avg > 70000 AND
    quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
     quarter1_job_postings.salary_year_avg DESC;

    
