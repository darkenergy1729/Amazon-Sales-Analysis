-- =====================================================
-- AMAZON SALES ANALYSIS PROJECT
-- DATABASE SETUP
-- =====================================================

-- =====================================================
-- 1. CREATE DATABASE
-- =====================================================

CREATE DATABASE amazon_sale_analysis;

USE amazon_sale_analysis;

-- =====================================================
-- 2. CREATE TABLE
-- =====================================================

CREATE TABLE amazon_sale (
index_val TEXT,
Order_ID TEXT,
Date TEXT,
Status TEXT,
Fulfilment TEXT,
Sales_Channel TEXT,
ship_service_level TEXT,
Style TEXT,
SKU TEXT,
Category TEXT,
Size TEXT,
ASIN TEXT,
Courier_Status TEXT,
Qty INT,
currency TEXT,
Amount DECIMAL(10,2),
ship_city TEXT,
ship_state TEXT,
ship_postal_code VARCHAR(20),
ship_country TEXT,
promotion_ids TEXT,
B2B TEXT,
fulfilled_by TEXT,
Unnamed_22 TEXT
);

-- =====================================================
-- 3. IMPORT DATA
-- =====================================================
-- Replace the file path below with the location
-- of the dataset on your own machine.

SET GLOBAL local_infile = 1;


LOAD DATA LOCAL INFILE 'path_to_your_dataset/Amazon_Sale_Report.csv'
INTO TABLE amazon_sale
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@col1, @col2, @col3, @col4, @col5, @col6,
@col7, @col8, @col9, @col10, @col11, @col12,
@col13, @col14, @col15, @col16, @col17, @col18,
@col19, @col20, @col21, @col22, @col23, @col24)

SET
index_val = @col1,
Order_ID = @col2,
Date = @col3,
Status = @col4,
Fulfilment = @col5,
Sales_Channel = @col6,
ship_service_level = @col7,
Style = @col8,
SKU = @col9,
Category = @col10,
Size = @col11,
ASIN = @col12,
Courier_Status = @col13,
Qty = NULLIF(@col14, ''),
currency = @col15,
Amount = NULLIF(@col16, ''),
ship_city = @col17,
ship_state = @col18,
ship_postal_code = @col19,
ship_country = @col20,
promotion_ids = @col21,
B2B = @col22,
fulfilled_by = @col23,
Unnamed_22 = @col24;

-- =====================================================
-- 4. VERIFY DATA LOAD
-- =====================================================

SELECT COUNT(*) AS total_records
FROM amazon_sale;

SELECT *
FROM amazon_sale
LIMIT 5;
