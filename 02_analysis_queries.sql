-- =====================================================
-- AMAZON SALES ANALYSIS PROJECT
-- Author: Puneet Kaur
-- Tools Used: MySQL, Power BI
-- =====================================================

-- =====================================================
-- 1. DATA EXPLORATION
-- =====================================================

-- Total Records
SELECT COUNT(*) AS total_records
FROM amazon_sale;

-- Table Structure
DESCRIBE amazon_sale;

-- Sample Data
SELECT *
FROM amazon_sale
LIMIT 5;

-- Unique Orders
SELECT COUNT(DISTINCT Order_ID) AS unique_orders
FROM amazon_sale;

-- =====================================================
-- 2. DATA QUALITY CHECKS
-- =====================================================

SELECT
SUM(CASE WHEN Amount IS NULL THEN 1 ELSE 0 END) AS missing_amount,
SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS missing_category,
SUM(CASE WHEN ship_state IS NULL THEN 1 ELSE 0 END) AS missing_state,
SUM(CASE WHEN Courier_Status IS NULL THEN 1 ELSE 0 END) AS missing_courier_status
FROM amazon_sale;

-- =====================================================
-- 3. KEY PERFORMANCE INDICATORS (KPIs)
-- =====================================================

-- Total Revenue
SELECT ROUND(SUM(Amount),2) AS total_revenue
FROM amazon_sale
WHERE Status NOT LIKE '%Cancelled%';

-- Total Quantity Sold
SELECT SUM(Qty) AS total_quantity_sold
FROM amazon_sale
WHERE Qty > 0;

-- Total Orders
SELECT COUNT(DISTINCT Order_ID) AS total_orders
FROM amazon_sale;

-- Average Order Value
SELECT ROUND(
     SUM(Amount) /
     COUNT(DISTINCT Order_ID),2) AS avg_order_value
FROM amazon_sale
WHERE Status NOT LIKE '%Cancelled%';

-- =====================================================
-- 4. ORDER STATUS ANALYSIS
-- =====================================================

SELECT
Status,
COUNT(*) AS order_count
FROM amazon_sale
GROUP BY Status
ORDER BY order_count DESC;

-- =====================================================
-- 5. CATEGORY PERFORMANCE ANALYSIS
-- =====================================================

SELECT
Category,
ROUND(SUM(Amount),2) AS revenue
FROM amazon_sale
WHERE Status NOT LIKE '%Cancelled%'
GROUP BY Category
ORDER BY revenue DESC;

-- Categories generating revenue above ₹100,000
SELECT
Category,
ROUND(SUM(Amount),2) AS Revenue
FROM amazon_sale
WHERE Status NOT LIKE '%Cancelled%'
GROUP BY Category
HAVING SUM(Amount) > 100000;

-- =====================================================
-- 6. STATE-WISE REVENUE ANALYSIS
-- =====================================================

SELECT
ship_state,
ROUND(SUM(Amount),2) AS revenue
FROM amazon_sale
WHERE Status NOT LIKE '%Cancelled%'
GROUP BY ship_state
ORDER BY revenue DESC
LIMIT 10;

-- =====================================================
-- 7. FULFILMENT ANALYSIS
-- =====================================================

SELECT
Fulfilment,
COUNT(*) AS Orders,
ROUND(SUM(Amount),2) AS Revenue
FROM amazon_sale
WHERE Status NOT LIKE '%Cancelled%'
GROUP BY Fulfilment;

-- =====================================================
-- 8. MONTHLY SALES TREND ANALYSIS
-- =====================================================

SELECT
DATE_FORMAT(STR_TO_DATE(Date,'%Y-%m-%d'),'%Y-%m') AS month,
ROUND(SUM(Amount),2) AS revenue
FROM amazon_sale
WHERE Status NOT LIKE '%Cancelled%'
GROUP BY month
ORDER BY month;

-- =====================================================
-- 9. TOP PERFORMING PRODUCTS
-- =====================================================

SELECT
SKU,
ROUND(SUM(Amount),2) AS revenue
FROM amazon_sale
WHERE Status NOT LIKE '%Cancelled%'
GROUP BY SKU
ORDER BY revenue DESC
LIMIT 10;

-- =====================================================
-- 10. SUBQUERY ANALYSIS
-- =====================================================

-- Orders with value higher than average order amount

SELECT *
FROM amazon_sale
WHERE Amount >
(
SELECT AVG(Amount)
FROM amazon_sale
);

-- =====================================================
-- 11. WINDOW FUNCTION ANALYSIS
-- =====================================================

SELECT
SKU,
ROUND(SUM(Amount),2) AS Revenue,
RANK() OVER (
ORDER BY SUM(Amount) DESC
) AS Revenue_Rank
FROM amazon_sale
WHERE Status NOT LIKE '%Cancelled%'
GROUP BY SKU;


-- =====================================================
-- 12. B2B VS B2C ANALYSIS
-- =====================================================

SELECT
    CASE WHEN B2B = 'TRUE' THEN 'B2B' ELSE 'B2C' END AS business_type,
    ROUND(SUM(Amount),2) AS revenue,
    COUNT(DISTINCT Order_ID) AS orders
FROM amazon_sale
WHERE Status NOT LIKE '%Cancelled%'
GROUP BY business_type;
