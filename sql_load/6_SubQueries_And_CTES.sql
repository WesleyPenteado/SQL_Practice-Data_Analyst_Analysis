
-- Example of Subquery
SELECT *
FROM (-- SubQuery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;
-- SubQuery ends here


--Example

SELECT
    company_id,
    name AS company_name
FROM
    company_dim
WHERE company_id IN (
        SELECT
                company_id
        FROM
                job_postings_fact
        WHERE
                job_no_degree_mention = TRUE
        ORDER BY
                company_id
);



-- Example of CTE (Common Table Expressions)
WITH january_jobs AS ( -- CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) -- CTE definition ends here
SELECT *
FROM january_jobs;


/*
Example

Find the companies that have the most job openings
- Get the total number of job postings per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)

*/

WITH company_job_count AS( --creating the CTE
        SELECT
            company_id,
            COUNT (*) AS total_jobs --counting number of rolls
        FROM
            job_postings_fact
        GROUP BY
            company_id
)
SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_Id = company_dim.company_id
ORDER BY
    total_jobs DESC;





/*
Practice problem 1

Identify the top 5 skills that are most frequently mentioned in job postings.
Use a subquery to find skill IDs with the highest counts in the skills_job_dim table
and then join this result with the skills_dim table to get the skill names.

*/


SELECT
    countingjob_by_skill.skill_id,
    skills_dim.skills,
    countingjob_by_skill.job_counting
FROM skills_dim
LEFT JOIN (
    SELECT
        skill_id,
        count(job_id) AS job_counting
    FROM 
        skills_job_dim
    GROUP BY
        skill_id
    ) AS countingjob_by_skill ON countingjob_by_skill.skill_id = skills_dim.skill_id
ORDER BY
    countingjob_by_skill.job_counting DESC
LIMIT 5;




/*
Practice problem 2

Determine the size category ('Small', 'Medium', or 'Large') for each company by
first identifying the number of job postings they have. Use a subquery to calculate
the total job postings per company. A company is considered 'Small' if it has less
than 10 job postings, 'Medium' if is 10 to 50 and 'Large' if it is more than 50.
Implement a subquery to aggregate job counts per company before classifying them
based on size.

*/


SELECT
        company_dim.name AS companies,
    countingjob_by_companyid.job_counting,
    CASE
        WHEN countingjob_by_companyid.job_counting < 10 THEN 'Small'
        WHEN countingjob_by_companyid.job_counting BETWEEN 10 AND 50 THEN 'Medium'
        WHEN countingjob_by_companyid.job_counting > 50 THEN 'Large'
        ELSE 'Not Informed'
    END AS company_category
FROM company_dim
LEFT JOIN (
        SELECT
            company_id,
            count(job_id) AS job_counting
        FROM 
            job_postings_fact
        GROUP BY
            company_id
        ) AS countingjob_by_companyid ON countingjob_by_companyid.company_id = company_dim.company_id
ORDER BY
    countingjob_by_companyid.job_counting DESC
LIMIT 10;
    


/*
Practice problem 7

Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requirin the skills

*/

-- Feito por mim

WITH job_skill_remote AS (
        SELECT
            job_postings_fact.job_id,
            skills_job_dim.skill_id,
            job_postings_fact.job_location
        FROM
            skills_job_dim
        LEFT JOIN 
            job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id 
        WHERE
            job_postings_fact.job_location = 'Anywhere' AND
            job_postings_fact.job_title_short = 'Data Analyst'
        )
SELECT
    job_skill_remote.skill_id,
    skills_dim.skills AS skill_name,
    count(*) AS job_counting
FROM 
    job_skill_remote
LEFT JOIN 
    skills_dim ON skills_dim.skill_id = job_skill_remote.skill_id
GROUP BY
    job_skill_remote.skill_id, skills_dim.skills
ORDER BY
    job_counting DESC
LIMIT 5;

-- Feito pelo Luke Barousse

WITH remote_job_skills AS (
SELECT
    skill_id,
    COUNT(*) AS skill_count
FROM
 skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE
        job_postings.job_work_from_home = True AND
        job_postings.job_title_short = 'Data Analyst'
GROUP BY
    skill_id
)
SELECT
    skills.skill_id,
    skills as skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id --  utilizado inner join pois não preocupou-se com o que iria ficar de fora na junção
ORDER BY
    skill_count DESC
LIMIT 5;