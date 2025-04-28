SELECT
    job_title_short,
    job_location
FROM job_postings_fact
LIMIT 50;

/*

Label new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York, Ny' jobs as 'Local'
- Otherwise 'Onsite'

*/

SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Other'
    END AS location_category
FROM job_postings_fact
LIMIT 50;

-- Now agregating by category

SELECT
    COUNT (job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Other'
    END AS location_category
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;



/*
Practice problem

I want to categorize the salaries from each job posting.
To see if fits in my desired salary range.
1) Put salary into diferent buckets
2) Define what's high, standard, or low salary with our own conditions
3) Why? It is easy determine which job postings are worth looking at based on salary
Bucketing is a common practice in data analysis when viewing categories
4) I only want to look at data analyst roles
5) Order from highest to lowest

*/

-- Verificando tabela
SELECT
    salary_year_avg,
    job_title_short
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
LIMIT 50;


-- Código respondendo ao exercício
SELECT
    COUNT (job_id) AS number_of_jobs,
    CASE
        WHEN salary_year_avg < 60000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 60000 AND 100000 THEN 'Standard'
        WHEN salary_year_avg > 100000 THEN 'High'
        ELSE 'Not Informed'
    END AS salary_category
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    salary_category
ORDER BY
    number_of_jobs DESC;


-- Conferindo se está calculando corretamente
SELECT
    salary_year_avg,
    CASE
        WHEN salary_year_avg < 60000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 60000 AND 100000 THEN 'Standard'
        WHEN salary_year_avg > 100000 THEN 'High'
        ELSE 'Not Informed'
    END AS salary_category
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
LIMIT 200;

