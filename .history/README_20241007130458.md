# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [SQL_Project_DA](/https://github.com/Rabkhan/SQL_Project_Data_Analysis)


# Backgrounds

The questions I wanted to answer through my SQL queries were:

What are the top-paying data analyst jobs?
What skills are required for these top-paying jobs?
What skills are most in demand for data analysts?
Which skills are associated with higher salaries?
What are the most optimal skills to learn?

# Tools Used

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.

- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.

- **Visual Studio Code:** My go-to for database management and executing SQL queries.

- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Engineering(DE) Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
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

```

Here's the breakdown of the top data analyst jobs in 2023:

**Wide Salary Range:** 
Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.

**Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.

**Job Title Variety:** There's a high diversity in job titles, from DE to Director of DE reflecting varied roles and specializations within data analytics.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
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
```
### Top-Paying Job Skills Analysis

The analysis of top-paying job skills reveals that **Data Engineer** roles dominate in terms of salary. Below are the key skills associated with the highest average salaries:

1. **Numpy** – $325,000/year
2. **PySpark** – $325,000/year
3. **Kubernetes** – $325,000/year
4. **Pandas** – $283,333/year
5. **Spark** – $259,375/year
6. **Hadoop** – $259,375/year
7. **Python** – $249,500/year
8. **Kafka** – $248,700/year
9. **Scala** – $232,000/year
10. **SQL** – $222,875/year

### Key Insights
- **Data Engineering** is one of the most lucrative career paths, with strong demand for skills related to **big data** technologies such as **Numpy, PySpark, Spark, Hadoop, Kafka, and SQL**.
- **Python**, a versatile programming language, remains a crucial skill, highly sought after in Data Engineering roles.
- Mastery of **distributed computing** frameworks and **data manipulation libraries** (e.g., **Pandas**, **Spark**) significantly boosts earning potential.

Professionals skilled in **big data tools** and **programming languages** are well-positioned to secure some of the highest salaries in the tech industry.


### Top In-demand Skills for Data Engineers

```sql
SELECT 
    Skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Engineer' OR job_title_short = 'Data Analyst'
GROUP BY Skills
ORDER BY demand_count DESC
LIMIT 10;

```
The following are the most in-demand skills for Data Engineers, ranked by the number of job listings or demand occurrences:

1. **SQL** – 206,003 demand mentions
2. **Python** – 165,591 demand mentions
3. **Excel** – 75,550 demand mentions
4. **Azure** – 71,765 demand mentions
5. **AWS** – 71,237 demand mentions

### Key Insights
- **SQL** is the most in-demand skill for Data Engineers, essential for managing and querying databases.
- **Python** is crucial for data manipulation, automation, and building data pipelines.
- Skills in **cloud platforms** such as **Azure** and **AWS** are highly sought after as companies shift towards cloud-based infrastructures.
- Proficiency in **Excel** remains relevant, especially for quick data analysis and reporting.

These in-demand skills highlight the need for Data Engineers to be versatile, combining strong programming expertise with cloud and data management tools.


### Top Paying Skills

```sql
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
```
The following are the highest-paying technical skills, ranked by average salary:

**MongoDB–** $173,623 average salary
**Node.js–** $171,685 average salary
**Solidity–** $170,500 average salary

Key Insights

MongoDB leads the pack in compensation, reflecting high demand for NoSQL database expertise
Node.js demonstrates the premium value placed on full-stack JavaScript development skills
Solidity commands high salaries due to increasing blockchain and smart contract development needs


### Most Optimal Technical Skills 2024: Salary vs. Demand Analysis

```sql
WITH skills_demand AS (
    SELECT 
         skills_dim.skills,
         skills_dim.skill_id,
        COUNT (skills_job_dim.job_id) AS demand_count
    
    FROM job_postings_fact
    
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
   
    WHERE job_title_short = 'Data Engineer' OR job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    
    GROUP BY skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND (AVG (salary_year_avg), 0 ) AS Avg_salary
    
    FROM job_postings_fact
    
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
   
    WHERE (job_title_short = 'Data Engineer' OR job_title_short = 'Data Analyst')
    AND salary_year_avg IS NOT NULL
   
    GROUP BY skills_job_dim.skill_id  
) 

SELECT 
    skills_demand.skill_id,
    skills,
    demand_count,
    Avg_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count>10
ORDER BY
     Avg_salary DESC,
     demand_count DESC
LIMIT 25
```



#### Top Skills Rankings

Kafka
Average Salary: $142,512
Demand Count: 29,203
Focus Area: Leading message streaming platform

Scala
Average Salary: $141,246
Demand Count: 28,850
Focus Area: Popular for big data processing

Airflow
Average Salary: $135,427
Demand Count: 25,627
Focus Area: Essential for data pipeline orchestration










