/*
Question: What are the top-paying data scientist jobs?
- Identify the top 10 highest-paying Data Scientist roles that are available remotely.(job_title_short/Order/salary_year_avg)
- Focuses on job postings with specified salaries.(NOT NULL)
- Why? Aims to highlight the top-paying opportunities for Data Scientists, offering insights into employment options(job_schedule) and location flexibility. (job_location - Anywahere)
*/

SELECT 
     job_id,
     job_title,
     job_location,
     job_schedule_type,
     salary_year_avg,
     job_posted_date,
     name AS compoany_name
FROM
     job_postings_fact
   LEFT JOIN
      company_dim ON job_postings_fact.company_id = company_dim.company_id --Join to get company_name
WHERE
     job_title = 'Data Scientist'
     AND salary_year_avg IS NOT NULL
     AND job_location = 'Anywhere'
ORDER BY
     salary_year_avg DESC 
LIMIT 10;