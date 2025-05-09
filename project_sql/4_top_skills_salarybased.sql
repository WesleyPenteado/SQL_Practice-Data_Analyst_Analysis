/*
Question: What are the top skills based on salary for my role?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of job_location
- Why? It reveals how different skills impact salary levels for Data Analyst
    and helps identify the most financially rewarding skills to acquire or 
    improve
*/

-- Most demanded skills for data analysts higher salaries
SELECT
    skills,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
    -- AND job_work_from_home = True --To use whenever you want
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/*

Chat GPT Answer about the results:

Key Trends from the Data:
Niche skills command higher salaries
Tools like svn, solidity, couchbase, and datarobot are among the top-paying, with average salaries exceeding $150,000/year. These are not mainstream tools for typical data analysts, suggesting that specialized or cross-functional knowledge is highly valued.

Modern programming & engineering tools are in demand
Skills like golang, scala, terraform, and spark indicate that analysts who can bridge the gap between data analysis and data engineering or DevOps tend to earn more.

Big data stack is well-represented
Technologies like spark, airflow, kafka, and hadoop highlight a trend toward handling large-scale data workflows — a sign that data infrastructure skills can boost compensation for analysts.

Machine learning tools boost earning potential
Tools such as datarobot and h2o appear in the top ranks, suggesting that knowledge of ML platforms is a strong asset even for those with a data analyst title.

Basic tools like Excel or SQL are absent
Traditional tools don't show up in the top-paying list, reinforcing that advanced or less common tools lead to higher compensation.


Results:
[
  {
    "skills": "svn",
    "avg_salary": "400000"
  },
  {
    "skills": "solidity",
    "avg_salary": "179000"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "golang",
    "avg_salary": "155000"
  },
  {
    "skills": "mxnet",
    "avg_salary": "149000"
  },
  {
    "skills": "dplyr",
    "avg_salary": "147633"
  },
  {
    "skills": "vmware",
    "avg_salary": "147500"
  },
  {
    "skills": "terraform",
    "avg_salary": "146734"
  },
  {
    "skills": "twilio",
    "avg_salary": "138500"
  },
  {
    "skills": "gitlab",
    "avg_salary": "134126"
  },
  {
    "skills": "kafka",
    "avg_salary": "129999"
  },
  {
    "skills": "puppet",
    "avg_salary": "129820"
  },
  {
    "skills": "keras",
    "avg_salary": "127013"
  },
  {
    "skills": "pytorch",
    "avg_salary": "125226"
  },
  {
    "skills": "perl",
    "avg_salary": "124686"
  },
  {
    "skills": "ansible",
    "avg_salary": "124370"
  },
  {
    "skills": "hugging face",
    "avg_salary": "123950"
  },
  {
    "skills": "tensorflow",
    "avg_salary": "120647"
  },
  {
    "skills": "cassandra",
    "avg_salary": "118407"
  },
  {
    "skills": "notion",
    "avg_salary": "118092"
  },
  {
    "skills": "atlassian",
    "avg_salary": "117966"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "116712"
  },
  {
    "skills": "airflow",
    "avg_salary": "116387"
  },
  {
    "skills": "scala",
    "avg_salary": "115480"
  }
]
*/


-- Most demanded skills for data analysts higher salaries (San Francisco)
SELECT
    skills,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location LIKE '%San Francisco%'
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;






