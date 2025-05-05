/*
Question: How many jobs are published per month?
Why? This way you can confirm whether there is seasonality between publications.
And prepare yourself better to take advantage of.
*/

-- Extracting counting for month

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
    EXTRACT(MONTH FROM job_posted_date)


-- Extracting counting for quarter

SELECT
    COUNT(job_id) AS job_counting,
    EXTRACT(QUARTER FROM job_posted_date) AS quarter_date
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND EXTRACT(YEAR FROM job_posted_date) = '2023'
GROUP BY
    quarter_date
ORDER BY
    quarter_date;
