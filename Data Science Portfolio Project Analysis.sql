-- Initial Data Overview 

SELECT * 
FROM `Portfolio-Projects`.`data science salaries`
LIMIT 10



-- Processing & Cleaning Data For Further Analysis

-- Viewing Unique Countries From the Data Set

SELECT DISTINCT company_location
FROM `portfolio-projects`.`data science salaries`



-- Creating an external table for the countries in relation to country code

USE `Portfolio-Projects`;

CREATE TABLE `Countries` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `code` VARCHAR(2) NOT NULL,
  `name` VARCHAR(255) NOT NULL
);

INSERT INTO `Countries` (`code`, `name`)
VALUES
    ('ES', 'Spain'),
    ('US', 'United States'),
    ('CA', 'Canada'),
    ('DE', 'Germany'),
    ('GB', 'United Kingdom'),
    ('NG', 'Nigeria'),
    ('IN', 'India'),
    ('HK', 'Hong Kong'),
    ('NL', 'Netherlands'),
    ('CH', 'Switzerland'),
    ('CF', 'Central African Republic'),
    ('FR', 'France'),
    ('FI', 'Finland'),
    ('UA', 'Ukraine'),
    ('IE', 'Ireland'),
    ('IL', 'Israel'),
    ('GH', 'Ghana'),
    ('CO', 'Colombia'),
    ('SG', 'Singapore'),
    ('AU', 'Australia'),
    ('SE', 'Sweden'),
    ('SI', 'Slovenia'),
    ('MX', 'Mexico'),
    ('BR', 'Brazil'),
    ('PT', 'Portugal'),
    ('RU', 'Russia'),
    ('TH', 'Thailand'),
    ('HR', 'Croatia'),
    ('VN', 'Vietnam'),
    ('EE', 'Estonia'),
    ('AM', 'Armenia'),
    ('BA', 'Bosnia and Herzegovina'),
    ('KE', 'Kenya'),
    ('GR', 'Greece'),
    ('MK', 'North Macedonia'),
    ('LV', 'Latvia'),
    ('RO', 'Romania'),
    ('PK', 'Pakistan'),
    ('IT', 'Italy'),
    ('MA', 'Morocco'),
    ('PL', 'Poland'),
    ('AL', 'Albania'),
    ('AR', 'Argentina'),
    ('LT', 'Lithuania'),
    ('AS', 'American Samoa'),
    ('CR', 'Costa Rica'),
    ('IR', 'Iran'),
    ('BS', 'Bahamas'),
    ('HU', 'Hungary'),
    ('AT', 'Austria'),
    ('SK', 'Slovakia'),
    ('CZ', 'Czech Republic'),
    ('TR', 'Turkey'),
    ('PR', 'Puerto Rico'),
    ('DK', 'Denmark'),
    ('BO', 'Bolivia'),
    ('PH', 'Philippines'),
    ('BE', 'Belgium'),
    ('ID', 'Indonesia'),
    ('EG', 'Egypt'),
    ('AE', 'United Arab Emirates'),
    ('LU', 'Luxembourg'),
    ('MY', 'Malaysia'),
    ('HN', 'Honduras'),
    ('JP', 'Japan'),
    ('DZ', 'Algeria'),
    ('IQ', 'Iraq'),
    ('CN', 'China'),
    ('NZ', 'New Zealand'),
    ('CL', 'Chile'),
    ('MD', 'Moldova'),
    ('MT', 'Malta');
    
    
    
    
-- Replacing Country Codes with Country Names in both Columns of "employee_residence" & "company_location" 
    
UPDATE `portfolio-projects`.`data science salaries`
JOIN Countries ON `data science salaries`.company_location = Countries.code
SET `data science salaries`.company_location = Countries.name;

UPDATE `portfolio-projects`.`data science salaries`
JOIN Countries ON `data science salaries`.employee_residence = Countries.code
SET `data science salaries`.employee_residence = Countries.name;




-- Replacing abbreviations in experience_level Column with full name "Update Function"

UPDATE `portfolio-projects`.`data science salaries`
SET `experience_level` = CASE
WHEN `experience_level` = 'MI' THEN 'Mid Level'
WHEN `experience_level`= 'EN' THEN 'Entry Level'
WHEN `experience_level`= 'SE' THEN 'Senior Level'
WHEN `experience_level`= 'EX' THEN 'Expert Level'
END;



-- Replacing abbreviations in employement_type Column with full name "Replace Function"

UPDATE `portfolio-projects`.`data science salaries`
SET `employment_type` = REPLACE(REPLACE(REPLACE(REPLACE
(`employment_type`, 'FT', 'Full Time'),
 'PT', 'Part Time'), 'CT', 'Contract'),
 'FL', 'Freelance');
 
 
 
 -- Replacing abbreviations in compnay_size Column with full name "Update Function"
 
 
 UPDATE `portfolio-projects`.`data science salaries`
 SET `company_size` = CASE
WHEN `company_size` = 'L' THEN 'Large'
WHEN `company_size` = 'M' THEN 'Medium'
WHEN `company_size` = 'S' THEN 'Small'
END;




-- Replacing abbreviations in remote_rate Column with full name "Replace Function"
-- Note: (Altering table because current 'remote_ratio' column is in integer format & it 
-- should be converted to string value for the function to work)


ALTER TABLE `portfolio-projects`.`data science salaries` MODIFY COLUMN `remote_ratio` VARCHAR(50);

UPDATE `portfolio-projects`.`data science salaries`
SET `remote_ratio` = REPLACE(REPLACE(REPLACE
(`remote_ratio`, '100', 'Fully Remote'), '50', 'Half Remote'), '0', 'On Site');




-- Data Set Overview After Data Enhancing & Processcing

SELECT * 
FROM `Portfolio-Projects`.`data science salaries`
LIMIT 10




-- ** Project Analysis to gather insight **

-- Number of jobs available as per job title cathegory

SELECT job_title, COUNT(*) As Number_of_Jobs
FROM `portfolio-projects`.`data science salaries`
GROUP BY job_title 
ORDER BY Number_of_Jobs DESC
LIMIT 10



-- Top Highest Paying Job Titles

SELECT job_title, MAX(salary_in_usd) As Salary
FROM `portfolio-projects`.`data science salaries`
GROUP BY job_title
ORDER BY Salary DESC
LIMIT 10



-- Finding Top 10 Salaries & Number of Jobs Available as Per Job Title by ordering by Average Salaries Paid

SELECT job_title, AVG(salary_in_usd) As Average_Salary, COUNT(*) as Number_of_Jobs 
FROM `portfolio-projects`.`data science salaries`
GROUP BY job_title
ORDER BY Average_Salary DESC
LIMIT 10



-- Job Availability as per Location

SELECT company_location, COUNT(*) As Number_of_Jobs
FROM `portfolio-projects`.`data science salaries`
GROUP BY company_location
ORDER BY Number_of_Jobs DESC
LIMIT 10


-- Finding Job Availability as Per Experince Level 

SELECT experience_level , COUNT(*) as Number_of_Jobs
FROM `portfolio-projects`.`data science salaries`
GROUP BY experience_level
ORDER BY Number_of_Jobs DESC
LIMIT 10


-- Finding Type of Employement Contracts

SELECT employment_type, COUNT(*) as Type_of_Employment
FROM `portfolio-projects`.`data science salaries`
GROUP BY employment_type
ORDER BY Type_of_Employment DESC
LIMIT 10



-- Overall Job Growth Analysis as Per Year

SELECT work_year, COUNT(*) as Number_of_Jobs
FROM `portfolio-projects`.`data science salaries`
GROUP BY work_year
ORDER BY Number_of_Jobs DESC
LIMIT 10



-- Salaries Paid As Per Experience Level & Job Title

SELECT experience_level as Level_of_Experience, salary_in_usd as Salary, job_title as Job_Title
FROM `portfolio-projects`.`data science salaries`
ORDER BY Salary DESC
LIMIT 10



-- Salaries Paid based on Company Size

SELECT company_size as Company_Size, COUNT(*) as Jobs_Available, MAX(salary_in_usd) as Salary
FROM `portfolio-projects`.`data science salaries`
GROUP BY company_size
ORDER BY Salary DESC
LIMIT 10



-- Ranking Total Number of Jobs Available as Per Job Category & Location

SELECT job_title, company_location, COUNT(*) as Number_of_Jobs,
	RANK() OVER (PARTITION BY company_location ORDER BY COUNT(*) DESC) AS Job_Rank
FROM `portfolio-projects`.`data science salaries`
GROUP BY job_title, company_location
ORDER BY Number_of_Jobs DESC
LIMIT 20



-- Ranking Total Number of Jobs as Per Experience Level By Location

SELECT experience_level, company_location, COUNT(*) as Number_of_Jobs,
	RANK() OVER (PARTITION BY company_location ORDER BY COUNT(*) DESC) AS Experience_Rank
FROM `portfolio-projects`.`data science salaries`
GROUP BY experience_level, company_location
ORDER BY Experience_Rank
LIMIT 100

-- Performing same Querry with the use of Subquery

SELECT experience_level, company_location, Number_of_Jobs,
    (SELECT COUNT(*) + 1
     FROM (SELECT experience_level, company_location, COUNT(*) AS Number_of_Jobs
          FROM `portfolio-projects`.`data science salaries`
          GROUP BY experience_level, company_location
          HAVING company_location = t.company_location
          ORDER BY Number_of_Jobs DESC) AS subquery
    WHERE Number_of_Jobs > t.Number_of_Jobs) AS Experience_Rank
FROM (SELECT experience_level, company_location, COUNT(*) AS Number_of_Jobs
      FROM `portfolio-projects`.`data science salaries`
      GROUP BY experience_level, company_location) AS t
ORDER BY company_location, Number_of_Jobs DESC
LIMIT 0, 100;












 
