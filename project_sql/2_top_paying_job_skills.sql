/*
Question: What skills are required for the top-paying data scientist jobs?
- Identify the top 10 highest-paying Data Scientist jobs and the specific skills required for these roles.
- Filters for roles with specified salaries that are remote
- Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries
*/

--CTE finds the top-paying Data Scientist jobs
WITH top_paying_jobs AS (
  SELECT 
     job_id,
     job_title,
     salary_year_avg
  FROM
     job_postings_fact
  WHERE
     job_title_short = 'Data Scientist'
     AND salary_year_avg IS NOT NULL
     AND job_location = 'Anywhere'
  ORDER BY
     salary_year_avg DESC 
  LIMIT 10
)
--Skills required for data scientist jobs
SELECT
    top_paying_jobs.job_id,
    job_title,
    salary_year_avg,
    skills AS required_skills
FROM
    top_paying_jobs
--Join to get skills associated with the top-paying jobs
   INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
   INNER JOIN
    skills_dim ON  skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC
LIMIT 10;