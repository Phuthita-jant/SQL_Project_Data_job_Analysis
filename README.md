# Introduction
📊 Exploring the data job market! This project takes a deep dive into data scientist roles to explore 💰 top-paying jobs, 🔥 in-demand skills, and 📈 the sweet spots where demand meets pay.

🔍 Curious about the queries? Check out the [project_sql folder](/project_sql/)!

# Background
This project was designed to explore the data scientist job market more effectively by identifying top-paying and in-demand skills.

The dataset is derived from my [SQL Course](https://www.lukebarousse.com/sql) and contains valuable insights into job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data scientist jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data scientists?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
To conduct an in-depth analysis of the data scientist job market, I utilized a range of essential tools:

- **SQL:** The foundation of my analysis, enabling me to retrieve data and uncover vital insights.
- **PostgreSQL:** The selected database management system, helping me to manage the job posting datasets.
- **Visual Studio Code:** My preferred tool for managing databases and running SQL queries efficiently.
- **Git & GitHub:** Crucial for version control and sharing my SQL scripts and analyses, facilitating collaboration and tracking progress.

# The Analysis
This project used a series of queries to examine specific aspects of the data scientist job market. Here’s my answer to each question

### 1. Top Paying Data Scientist Jobs
This query identified the top 10 highest-paying remote data scientist jobs by filtering for the job title, excluding entries without salary data, and ordering by average yearly salary.

```sql
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
```
Here's the breakdown of the top data scientist jobs in 2023:
- **Wide Salary Range:** Top 10 data scientist jobs offer salaries ranging from $185,000 to $375,000, demonstrating the earning potential in this career.
- **Diverse Employers:** High-paying companies like Algo Capital Group, Smith Hanley Associates, and Grammarly are recognized for offering competitive salaries, highlighting the diversity of companies that value data scientist roles.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, revealing what skills employers prioritize in top-paying roles

```sql
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
SELECT
    top_paying_jobs.job_id,
    job_title,
    salary_year_avg,
    skills AS required_skills
FROM
    top_paying_jobs
   INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
   INNER JOIN
    skills_dim ON  skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC;
```
Here’s the breakdown of the most demanded skills for the top 10 highest data scientist jobs in 2023:
- **Python** is mentioned 5 times, highlighting its importance as a core skill in data science.
- **SQL** is mentioned 4 times, reflecting its essential role in data querying and management.
- **AWS** is mentioned 3 times.
- **Other skills** such as **GCP**, **Java**, **Cassandra**, **Spark**, and more demonstrate varied demand across the data science field.

### 3. In-Demand Skills for Data Scientist
This query highlighted the most frequently requested skills in job postings, helping focus on areas with high demanded.

```sql
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
```

| **Skill** | **Demand Count** |
| --------- | ---------------- |
| Python    | 114,016          |
| SQL       | 79,174           |
| R         | 59,754           |
| SAS       | 29,642           |
| Tableau   | 29,513           |
*Table of the demand for the top 5 skills in data scientist job postings*

Here’s a breakdown of the most in-demand skills for data scientists in 2023:
- **Python**, **SQL**, **R**, and **SAS** are still essential programming and statistical tools widely required across roles.
- **Tableau** remains a key data visualization tool highly valued in the job market.

### 4. Skills Based on Salary
This query focused on identifying the average salaries associated with different skills and revealed which skills are the highest paying.

```sql
SELECT
     skills_dim.skills,
     ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
     job_postings_fact
    INNER JOIN
       skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
     job_postings_fact.job_title_short = 'Data Scientist'
     AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
     skills_dim.skills
ORDER BY
     avg_salary DESC;
```
| **Skill**     | **Average Salary (USD)** |
| ------------- | ------------------------ |
| Asana         | 215,477                  |
| Airtable      | 201,143                  |
| RedHat        | 189,500                  |
| Watson        | 187,417                  |
| Elixir        | 170,824                  |
| Lua           | 170,500                  |
| Slack         | 168,219                  |
| Solidity      | 166,980                  |
| Ruby on Rails | 166,500                  |
| RShiny        | 166,436                  |

*Table of the top 10 skills based on average salary for data scientists*

Here’s a breakdown of the results for top paying skills for Data Scientists:
- **Machine Learning Skills:** Top-paying data scientists often leverage tools (Watson, R Shiny) to build AI solutions and dashboards that turn data into actionable insights, reflecting their ability to translate complex data into business value.
- **Production-Ready Skills for Deployment:** Proficient in deployment platforms and development frameworks (Red Hat, Ruby on Rails) as well as project management tools (Airtable, Slack), indicating a capability to deliver scalable and reliable solutions in production environments.
- **Cloud & Collaboration Expertise:** Skilled in cloud platforms (Red Hat OpenShift) and collaboration tools (Slack, Airtable), integrating them within cloud systems to ensure smooth operation and scalable data projects, demonstrating the ability to enable efficient teamwork and growing workloads.

### 5. Most Optimal Skills to Learn
After analyzing insights from demand and salary data, this query identified skills that are both in high demand and offer high salaries, guiding job seekers on what to learn.

```sql
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
       INNER JOIN
          skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
       INNER JOIN
          skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
),
average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        AVG(job_postings_fact.salary_year_avg) AS avg_salary
    FROM
        job_postings_fact
        INNER JOIN
           skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        job_postings_fact.job_title_short = 'Data Scientist'
        AND job_postings_fact.salary_year_avg IS NOT NULL
        AND job_postings_fact.job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
)
SELECT
     skills_demand.skills,
     skills_demand.demand_count,
     ROUND(average_salary.avg_salary, 2) AS avg_salary
FROM
    skills_demand
        INNER JOIN 
            average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
      demand_count DESC,
      avg_salary DESC
LIMIT 10;
```

| **Skill** | **Demand Count** | **Average Salary (USD)** |
| --------- | ---------------- | ------------------------ |
| Python    | 763              | 143,827.93               |
| SQL       | 591              | 142,832.59               |
| R         | 394              | 137,885.37               |
| Tableau   | 219              | 146,970.05               |
| AWS       | 217              | 149,629.96               |
| Spark     | 149              | 150,188.49               |
| TensorFlow| 126              | 151,536.49               |
| Azure     | 122              | 142,305.83               |
| PyTorch   | 115              | 152,602.70               |
| Pandas    | 113              | 144,815.95               |
*Table of the top 10 optimal skills for data scientists*

Here's a breakdown of the most optimal skills for Data Scientists in 2023:
- **Core Programming Languages:** Python (763 job postings, average salary around $143,827) and SQL (591 job postings, average salary around $142,832) remain the foundation of data science, reflecting that these languages are essential for data scientist roles.
- **Statistical Tools and Visualization Platforms:** R (394 job postings, average salary around $137,885) and Tableau (219 job postings, average salary around $146,970) remain key tools for analysis and visualization, essential for communicating insights and enabling data-driven decisions.
- **Cloud and Big Data Technologies:** As data volumes continue to grow, skills in tools like AWS (217 job postings, average salary around $149,629), Azure (122 job postings, average salary around $142,305), and Spark (149 job postings, average salary around $150,188) are increasingly essential for scaling models and managing cloud-based data pipelines.
- **Machine Learning Frameworks:** Despite appearing in fewer job postings, TensorFlow and PyTorch offer average salaries of $151,536 and $152,602, underscoring the high demand for deep learning expertise in advanced data science positions.
- **Data Processing Libraries:** With 113 job mentions and an average salary of $144,815, Pandas plays a crucial role in the data science toolkit, enabling efficient data cleaning and transformation.

# What I Learned
On this journey, I’ve significantly enhanced my SQL skills with powerful tools:
- 🧩 **Advanced Query Building:** Developed skills in complex SQL queries by joining tables with various JOIN types and mastering WITH clauses to create ninja-level temporary tables. 
- 📊 **Data Aggregation:** Gained skills in GROUP BY, transforming aggregate functions like COUNT() and AVG() into my queries. 
- 💡 **Analytical Problem-Solving:** Enhanced my ability to solve real-world questions by turning complex challenges into actionable insights.

# Conclusions

### Insight
The analysis revealed several valuable insights:

1. **Top-Paying Data Scientist Jobs:** Remote data scientist roles offer salaries ranging from $185,000 to $375,000, with top companies such as Algo Capital Group and Grammarly leading the market.
2. **Skills for Top-Paying Jobs:** Python and SQL are the most essential skills, with cloud platforms like AWS and GCP also frequently required.
3. **Most In-Demand Skills:** Python and SQL remain core skills in high demand across data scientist roles.
4. **Skills with Higher Salaries:** Project management tools like Asana and Airtable among the highest-paying skills, highlighting their value in MLOps and streamlined project workflows
5. **Optimal Skills for Data Scientist jobs:** Python and SQL are among the most optimal skills for data scientists to learn to boost their value in the job market.

### 📝Closing Thoughts✨
This project improved my SQL skills while discovering valuable insights into the data scientist job market. The findings serve as a practical guide for developing in-demand skills and navigating job opportunities more strategically. It also highlights the importance of continuous growth in a fast-changing field. Moreover, these insights are beneficial not only for current professionals aiming to boost their salary and advance their careers, but also for individuals looking to transition into the data science field with a clearer understanding of what the job market truly values.
