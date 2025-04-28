
-- See that :: signal will have the function of inform the data type
SELECT 
    '2023-02-19'::DATE,
    '123'::INTEGER,
    'true'::BOOLEAN,
    '3.14'::REAL;


-- changing data type for date
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date
FROM
    job_postings_fact
LIMIT 10

-- seeing normal date how it is
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AS date_time
FROM
    job_postings_fact
LIMIT 10


-- specifc time zone (The data don't have one, so we'll going to specify first)
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM
    job_postings_fact
LIMIT 10

-- Extract the month from the column date
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
        EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM
    job_postings_fact
LIMIT 10

-- Agregation 1 by count job_id per month
SELECT
    COUNT(job_id),
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM
    job_postings_fact
GROUP BY
    date_month
LIMIT 12

-- Agregation 2 by count job_id per month
SELECT
    COUNT(job_id) AS job_id_counting,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    date_month
ORDER BY
    job_id_counting DESC



-- PRACTICE ------------------------------------------------------------------

/*
(Practe Problem 1)
Write a query to find the average salary both yearly (salary_year_avg)
and hourly (salary_hour_avg) for job postings that were posted after June 1, 2023.
Group the results by job schedule type.
*/

SELECT
    AVG(salary_year_avg) AS avg_salary_year,
    AVG(salary_hour_avg) AS avg_hour_year,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01'
GROUP BY
    date_year


/*
(Practe Problem 2)
Write a query to count the number of job postings for each month in 2023, adjusting
the job_posted_date to be in 'America/New York' time zone before extracting (hint)
the month. Assume the job_posted_date is stored in UTC. Group by and order by the
month.
*/

--Format 1
SELECT
    COUNT(job_id) AS job_counting,
    DATE_TRUNC('month', job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month_date
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY
    month_date
ORDER BY
    month_date

--Format 2
-- The TO_CHAR(..., 'Month') output is padded with spaces for alignment. Extract the caracter of month
SELECT
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month_number,
    TO_CHAR(job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York', 'FMMonth') AS month_name,
    COUNT(job_id) AS job_counting
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY
    month_number, month_name
ORDER BY
    month_number;


/*
(Practe Problem 3)
Write a query to find companies (include company name) that have posted jobs
offering health insurance, where these postings were made in the second quarter
of 2023. Use date extraction to filter by quarter.
*/

SELECT
    companies.name AS company_name,
    COUNT(job_postings.job_id) AS job_count
FROM
    job_postings_fact AS job_postings
LEFT JOIN company_dim as companies ON job_postings.company_id = companies.company_id
WHERE
    job_postings.job_health_insurance = TRUE
    AND EXTRACT(YEAR FROM job_postings.job_posted_date) = 2023
    AND EXTRACT(QUARTER FROM job_postings.job_posted_date) = 2
GROUP BY
    companies.name
ORDER BY
    job_count DESC
LIMIT 10


/*
(Practe Problem 6)
Create three tables:
- Jan 2023 jobs
- Fev 2023 jobs
- Mar 2023 jobs
Foreshadowing: this will be used in another practice problem below
Hints:
- Use CREATE TABLE table_name AS systax to create your table
- Look at a way to filter out only specific months (EXTRACT)
*/

-- January
CREATE TABLE Jan_2023_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 1
        AND EXTRACT(YEAR FROM job_posted_date) = 2023;

-- February
CREATE TABLE Fev_2023_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 2
        AND EXTRACT(YEAR FROM job_posted_date) = 2023;

-- March
CREATE TABLE Mar_2023_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 3
        AND EXTRACT(YEAR FROM job_posted_date) = 2023;



