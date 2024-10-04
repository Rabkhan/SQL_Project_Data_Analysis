/**
What are top paying Data Engineering(DE) jobs
- Identify to 10 high paying DE jobs available remotely
- Focus on job posting with specified salaries removed NULLS
- Highlight top-paying opportunities for DE
**/

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title = 'Data Engineer' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;

