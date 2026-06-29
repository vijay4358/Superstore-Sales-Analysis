/*====================================================================
                    SUPERSTORE SALES & PROFIT ANALYSIS
                            SQL ANALYSIS
----------------------------------------------------------------------
Author      : Vijay Vishwakarma
Database    : Superstore
Tools        : MySQL
Description : SQL queries used for business analysis and KPI generation
====================================================================*/

USE superstore;

/*====================================================================
SECTION 1 : DATABASE EXPLORATION
====================================================================*/

-- View table structure

DESCRIBE store;

------------------------------------------------------------

-- Display all column names

SHOW COLUMNS FROM store;

------------------------------------------------------------

-- Preview Furniture records

SELECT *
FROM store
WHERE Category = 'Furniture'
LIMIT 5;


/*====================================================================
SECTION 2 : KPI ANALYSIS
====================================================================*/

-- Total Sales

SELECT ROUND(SUM(Sales),2) AS Total_Sales
FROM store;

------------------------------------------------------------

-- Total Profit

SELECT ROUND(SUM(Profit),2) AS Total_Profit
FROM store;

------------------------------------------------------------

-- Total Customers

SELECT COUNT(DISTINCT `Customer ID`) AS Total_Customers
FROM store;

------------------------------------------------------------

-- Total Orders

SELECT COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM store;

------------------------------------------------------------

-- Total Products

SELECT COUNT(DISTINCT `Product ID`) AS Total_Products
FROM store;

------------------------------------------------------------

-- Average Order Value (AOV)

SELECT ROUND(
    SUM(Sales) / COUNT(DISTINCT `Order ID`),
    2
) AS Average_Order_Value
FROM store;


/*====================================================================
SECTION 3 : CATEGORY ANALYSIS
====================================================================*/

-- Sales Contribution by Category

WITH Category_Sales AS
(
    SELECT
        Category,
        ROUND(SUM(Sales),2) AS Total_Sales,
        ROUND(
            SUM(Sales)*100 / SUM(SUM(Sales)) OVER(),
            2
        ) AS Contribution_Pct
    FROM store
    GROUP BY Category
)

SELECT *
FROM Category_Sales
ORDER BY Total_Sales DESC;

------------------------------------------------------------

-- Profit by Category

SELECT
    Category,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM store
GROUP BY Category
ORDER BY Total_Profit DESC;


/*====================================================================
SECTION 4 : SUB-CATEGORY ANALYSIS
====================================================================*/

-- Furniture Sub-Category Profit

SELECT
    `Sub-Category`,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(AVG(Discount)*100,2) AS Average_Discount
FROM store
WHERE Category='Furniture'
GROUP BY `Sub-Category`
ORDER BY Total_Profit DESC;

------------------------------------------------------------

-- Profit by Discount (Furniture)

SELECT
    Discount,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM store
WHERE Category='Furniture'
GROUP BY Discount
ORDER BY Discount;

------------------------------------------------------------

-- Discount Analysis for Loss-Making Products

SELECT
    `Sub-Category`,
    Discount*100 AS Discount_Pct,
    Profit
FROM store
WHERE `Sub-Category`
IN ('Tables','Bookcases');


/*====================================================================
SECTION 5 : REGIONAL ANALYSIS
====================================================================*/

-- Sales by Region

SELECT
    Region,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM store
GROUP BY Region
ORDER BY Total_Sales DESC;

------------------------------------------------------------

-- Profit by Region

SELECT
    Region,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM store
GROUP BY Region
ORDER BY Total_Profit DESC;

------------------------------------------------------------

-- Regional Sales Contribution

SELECT
    Region,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(
        SUM(Sales)*100 / SUM(SUM(Sales)) OVER(),
        2
    ) AS Contribution_Pct
FROM store
GROUP BY Region
ORDER BY Contribution_Pct DESC;


/*====================================================================
SECTION 6 : SEGMENT ANALYSIS
====================================================================*/

-- Sales by Segment

SELECT
    Segment,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM store
GROUP BY Segment
ORDER BY Total_Sales DESC;

------------------------------------------------------------

-- Profit by Segment

SELECT
    Segment,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM store
GROUP BY Segment
ORDER BY Total_Profit DESC;

------------------------------------------------------------

-- Segment Contribution

SELECT
    Segment,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(
        SUM(Sales)*100 / SUM(SUM(Sales)) OVER(),
        2
    ) AS Contribution_Pct
FROM store
GROUP BY Segment
ORDER BY Contribution_Pct DESC;


/*====================================================================
SECTION 7 : TIME TREND ANALYSIS
====================================================================*/

-- Year-wise Sales Trend

SELECT
    YEAR(
        STR_TO_DATE(`Order Date`, '%m/%d/%Y')
    ) AS Order_Year,

    ROUND(SUM(Sales),2) AS Total_Sales
FROM store
GROUP BY Order_Year
ORDER BY Total_Sales DESC;

/*====================================================================
END OF SQL ANALYSIS
====================================================================*/

