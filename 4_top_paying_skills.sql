SELECT 
    Skills,
    ROUND (AVG (salary_year_avg), 0 ) AS Avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE (job_title_short = 'Data Engineer' OR job_title_short = 'Data Analyst')
AND salary_year_avg IS NOT NULL
GROUP BY Skills
ORDER BY Avg_salary DESC
LIMIT 50;