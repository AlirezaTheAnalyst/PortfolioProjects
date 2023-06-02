-- Checking Data Overview

SELECT *
FROM `Portfolio-Projects`.`airbnb data points`
LIMIT 50


-- ** Data Processing to Varify the Integrity of the Data Points **

-- Checking Data Points for Null Values For Host Details & Price Points

SELECT * 
FROM `Portfolio-Projects`.`airbnb data points`
WHERE id IS NULL or host_id IS NULL or host_name IS NULL or price IS NULL



-- Checking for Null Values In Geo-Tag Locations & Neighbourhoods

SELECT * 
FROM `Portfolio-Projects`.`airbnb data points`
WHERE neighbourhood IS NULL or latitude IS NULL or longitude IS NULL



-- Checking for Dublicate Values in Specific Columns of id, host_id

SELECT id, host_id, COUNT(*) as Count
FROM `Portfolio-Projects`.`airbnb data points`
GROUP BY id, host_id
HAVING COUNT(*) > 1



-- Removing Columns with No Values

ALTER TABLE `Portfolio-Projects`.`airbnb data points`
DROP COLUMN neighbourhood_group



-- Altering Price Points to Decimal For Higher Level of Precision and Accuracy

ALTER TABLE `Portfolio-Projects`.`airbnb data points`
MODIFY price DECIMAL(6,2)



-- Fixing the Date Formate For Purpose of Accurate Data Analysis & Visualization

UPDATE `Portfolio-Projects`.`airbnb data points`
SET last_review = DATE_FORMAT(last_review, '%m/%d/%Y')



-- ** Data Analysis to Aid Visualization Process**

-- Checking the the Top 10 highest reviewed Hosts

SELECT host_id, host_name, number_of_reviews
FROM `Portfolio-Projects`.`airbnb data points`
ORDER BY number_of_reviews DESC
LIMIT 10



-- Checking Top 50 Price Points Per Unit

SELECT host_id, host_name, price
FROM `Portfolio-Projects`.`airbnb data points`
ORDER BY price DESC
LIMIT 50



-- Checking The Most Expensive Unit Rented

SELECT host_id, host_name, price
FROM `Portfolio-Projects`.`airbnb data points`
WHERE price = (
  SELECT MAX(price)
  FROM `Portfolio-Projects`.`airbnb data points`
);


-- Checking Which Neighbourhood Has the Highest Price Points

SELECT DISTINCT host_id, host_name, neighbourhood, AVG(price) as Average_Price
FROM `Portfolio-Projects`.`airbnb data points`
GROUP BY host_id, host_name, neighbourhood
ORDER BY Average_price DESC
LIMIT 10



-- Checking The Lowest Unit Price Available for Rent Per Night

SELECT DISTINCT host_id, host_name, neighbourhood, AVG(price) as Average_Price
FROM `Portfolio-Projects`.`airbnb data points`
GROUP BY host_id, host_name, neighbourhood
ORDER BY Average_price
LIMIT 10



-- Checking Room Options Available For Rent

SELECT room_type, COUNT(*) AS Number_Of_Units
FROM `Portfolio-Projects`.`airbnb data points`
GROUP BY room_type
ORDER BY Number_Of_Units DESC



-- Checking Room Type, Number of Units Available For Rent as Per Neighbourhood

SELECT DISTINCT neighbourhood, room_type, COUNT(*) AS Number_Of_Units
FROM `Portfolio-Projects`.`airbnb data points`
GROUP BY room_type, neighbourhood
ORDER BY Number_Of_Units DESC
LIMIT 10



-- Data Extraction For Visualization By Using Tableau

SELECT *
FROM `Portfolio-Projects`.`airbnb data points`
LIMIT 4000




