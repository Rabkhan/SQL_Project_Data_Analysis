/**
- What top paying skills in Data Engineering field.
- What are the most in demand Skills.
- Top Skills based on salary.
-Most optimal skills to learn. Optimal - High Demand AND High paying

**/

With top_paying_jobs AS (
    SELECT 
        job_postings_fact.job_id,
        job_postings_fact.job_title,
        job_postings_fact.salary_year_avg,
        company_dim.name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title = 'Data Engineer' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    Skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC

