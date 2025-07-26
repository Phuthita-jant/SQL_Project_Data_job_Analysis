/*
Question: What are the most in-demand skills for data scientist?
- Identify the top 5 in-demand skills for a data scientist.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.
*/
--identify top 5 demanded skills for Data Scientist jobs
SELECT
     skills_dim.skills,
     COUNT(job_postings_fact.job_id) AS demand_count
FROM
     job_postings_fact
    INNER JOIN
       skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
     job_postings_fact.job_title_short = 'Data Scientist'
GROUP BY
     skills_dim.skills
ORDER BY
     demand_count DESC
LIMIT 5;
     