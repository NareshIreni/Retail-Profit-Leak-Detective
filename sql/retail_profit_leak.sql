-- ============================================================
-- RETAIL PROFIT LEAK DETECTIVE
-- SQL Analysis
-- Database: MySQL
-- ============================================================

-- 1. Create database
CREATE DATABASE IF NOT EXISTS retail_profit_leak;

-- 2. Select database
USE retail_profit_leak;


-- 3. Create main table
CREATE TABLE IF NOT EXISTS superstore (
    `Row ID` INT,
    `Order ID` VARCHAR(20),
    `Order Date` DATE,
    `Ship Date` DATE,
    `Ship Mode` VARCHAR(30),
    `Customer ID` VARCHAR(20),
    `Customer Name` VARCHAR(100),
    `Segment` VARCHAR(30),
    `Country` VARCHAR(100),
    `City` VARCHAR(100),
    `State` VARCHAR(100),
    `Postal Code` INT,
    `Region` VARCHAR(30),
    `Product ID` VARCHAR(30),
    `Category` VARCHAR(50),
    `Sub-Category` VARCHAR(50),
    `Product Name` VARCHAR(255),
    `Sales` DECIMAL(12,2),
    `Quantity` INT,
    `Discount` DECIMAL(4,2),
    `Profit` DECIMAL(12,2)
);

-- Data was loaded into MySQL using Python/Pandas.
-- This script contains the database structure and analytical SQL queries.

-- ============================================================
-- BUSINESS ANALYSIS
-- ============================================================
-- OVERALL BUSINESS PERFORMANCE

SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS total_quantity,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    COUNT(DISTINCT `Customer ID`) AS total_customers,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore;

-- PROFITABILITY BY CATEGORY

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY Category
ORDER BY total_profit ASC;

-- FURNITURE SUB-CATEGORY ANALYSIS

SELECT
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
WHERE Category = 'Furniture'
GROUP BY `Sub-Category`
ORDER BY total_profit ASC;

-- TABLES DISCOUNT ANALYSIS

SELECT
    `Discount`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
WHERE `Sub-Category` = 'Tables'
GROUP BY `Discount`
ORDER BY `Discount`;

-- SUB-CATEGORY × DISCOUNT ANALYSIS

SELECT
    `Sub-Category`,
    `Discount`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY `Sub-Category`, `Discount`
HAVING SUM(Sales) > 5000
ORDER BY `Sub-Category`, `Discount`;

-- OVERALL HIGH-DISCOUNT ANALYSIS

SELECT
    CASE
        WHEN Discount >= 0.30 THEN 'High Discount (30%+)'
        ELSE 'Lower Discount (<30%)'
    END AS discount_group,
    COUNT(*) AS transactions,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY discount_group
ORDER BY total_profit;

-- HIGH-DISCOUNT BY SUB-CATEGORY

SELECT
    `Sub-Category`,
    COUNT(*) AS high_discount_transactions,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
WHERE Discount >= 0.30
GROUP BY `Sub-Category`
ORDER BY total_profit ASC;

-- HIGH-DISCOUNT BY REGION

SELECT
    Region,
    COUNT(*) AS high_discount_transactions,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
WHERE Discount >= 0.30
GROUP BY Region
ORDER BY total_profit ASC;

-- HIGH-DISCOUNT BY REGION × SUB-CATEGORY

SELECT
    Region,
    `Sub-Category`,
    COUNT(*) AS transactions,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
WHERE Discount >= 0.30
GROUP BY Region, `Sub-Category`
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC;

-- TOP LOSS-MAKING PRODUCTS

SELECT
    `Product Name`,
    `Sub-Category`,
    Region,
    COUNT(*) AS transactions,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Discount) * 100, 2) AS avg_discount_pct
FROM superstore
WHERE Discount >= 0.30
GROUP BY `Product Name`, `Sub-Category`, Region
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC
LIMIT 10;

-- YEARLY PERFORMANCE

SELECT
    YEAR(`Order Date`) AS order_year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY YEAR(`Order Date`)
ORDER BY order_year;

-- LOSS-MAKING CUSTOMERS

SELECT
    `Customer ID`,
    `Customer Name`,
    COUNT(DISTINCT `Order ID`) AS orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY `Customer ID`, `Customer Name`
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC
LIMIT 10;

-- CUSTOMER LOSS TRANSACTIONS

SELECT
    `Customer Name`,
    COUNT(*) AS loss_transactions,
    ROUND(SUM(Sales), 2) AS loss_sales,
    ROUND(SUM(Profit), 2) AS total_loss,
    ROUND(AVG(Discount) * 100, 2) AS avg_discount_pct
FROM superstore
WHERE Profit < 0
GROUP BY `Customer Name`
ORDER BY total_loss ASC
LIMIT 10;

-- REGION × DISCOUNT ANALYSIS

SELECT
    Region,
    CASE
        WHEN Discount >= 0.30 THEN 'High Discount (30%+)'
        ELSE 'Lower Discount (<30%)'
    END AS discount_group,
    COUNT(*) AS transactions,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY
    Region,
    discount_group
ORDER BY
    Region,
    discount_group;

