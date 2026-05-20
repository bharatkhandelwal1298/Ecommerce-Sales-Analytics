-- =========================================
-- BUSINESS INSIGHT:
-- Total revenue reflects overall business performance and growth.
-- =========================================

-- 1. TOTAL SALES
select 
round(sum(sales),2) as total_revenue
from ecommerce_sales;
---------------------------------------------------------------------------------------

-- =========================================
-- BUSINESS INSIGHT:
-- High-performing regions contribute significantly to revenue and profitability.
-- =========================================

-- 2. Top Performing Region
SELECT 
region, ROUND(sum(sales),2) as total_sales,
ROUND(sum(profit),2) as total_profit
from ecommerce_sales
group by region
order by total_sales desc;
---------------------------------------------------------------------------------------

-- =========================================
-- BUSINESS INSIGHT:
-- High-performing products drive overall business growth.
-- =========================================

-- 3. Top 10 Products by Sales
SELECT Product_Name,
      round(Sum(Sales),2) AS Revenue
FROM ecommerce_sales
GROUP BY Product_Name
ORDER BY Revenue DESC
LIMIT 10;
---------------------------------------------------------------------------------------
-- =========================================
-- BUSINESS INSIGHT:
-- Top customers play a critical role in driving overall business sales and revenue growth.
-- =========================================

-- 4. Top Customers
SELECT Customer_Name,
       round(SUM(Sales),2) AS Revenue
FROM ecommerce_sales
GROUP BY Customer_Name
ORDER BY Revenue DESC
LIMIT 10;
---------------------------------------------------------------------------------------

-- =========================================
-- BUSINESS INSIGHT:
-- A small percentage of customers contribute major revenue.
-- =========================================

-- 5. CUSTOMER LIFE TIME VALUE
SELECT 
customer_name , count(distinct Order_ID) as total_orders,
round(sum(sales),2) as Lifetime_value
from ecommerce_sales
group by customer_name
order by lifetime_value desc;
---------------------------------------------------------------------------------------

-- =========================================
-- BUSINESS INSIGHT:
-- Product ranking helps identify best-selling and low-performing products.
-- =========================================

-- 6. RANK PRODUCTS BY SALES
SELECT
product_name,
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit,
rank() over(order by sum(sales) desc) as product_rank
from ecommerce_sales
group  by product_name;
---------------------------------------------------------------------------------------

-- =========================================
-- BUSINESS INSIGHT:
-- Some products consistently generate losses and reduce profitability.
-- =========================================

-- 7. Loss Making products
SELECT Product_Name,
       ROUND(SUM(Profit),2) AS Loss
FROM ecommerce_sales
GROUP BY Product_Name
HAVING SUM(Profit) < 0;
---------------------------------------------------------------------------------------

-- =========================================
-- BUSINESS INSIGHT:
-- Consumer segment contributes the largest share of revenue.
-- =========================================

-- 8. CUSTOMER SEGMENT CONTRIBUTION
SELECT
segment,
round(sum(sales),2) as total_sales,
round(sum(sales) * 100 / (select sum(sales) from ecommerce_sales),2) as Total_Contribution
from ecommerce_sales
group by segment;
---------------------------------------------------------------------------------------

-- =========================================
-- BUSINESS INSIGHT:
-- Standard Class shipping is the most preferred shipping mode and contributes the highest shipping cost.
-- =========================================

-- 9. SHIPPING ANALYSIS
SELECT
ship_mode,
round(sum(shipping_cost),2) as Total_Shipping_Cost
from ecommerce_sales
group by Ship_Mode
order by Total_Shipping_Cost DESC;
---------------------------------------------------------------------------------------

-- =========================================
-- BUSINESS INSIGHT:
--  Monthly sales trends help identify seasonal patterns and growth opportunities.
-- =========================================

-- 10. Sales Over Time
SELECT
YEAR(Order_Date) AS Years,
MONTH(Order_Date) AS Months,
ROUND(SUM(Sales),2) AS Total_Sales
FROM ecommerce_sales
group by Years, Months
ORDER BY Years, Months;
---------------------------------------------------------------------------------------

-- =========================================
-- BUSINESS INSIGHT:
-- Customer segments show varying sales contributions across different months and business periods.
-- =========================================

-- 11. Sales by Customer Segment Over Time
SELECT
segment,
MONTHNAME(Order_Date) AS Month_Name,
ROUND(SUM(Sales),2) AS Total_Sales
FROM ecommerce_sales
GROUP BY Month_Name, Segment
order  by  Month_Name;
---------------------------------------------------------------------------------------

-- =========================================
-- BUSINESS INSIGHT:
-- The top-performing region contributes the largest share of total sales revenue.
-- =========================================

-- 12. Region Wise Highest Sale
SELECT 
region,
round(sum(sales),2) as total_sales
from ecommerce_sales
group by region
order by sum(sales) desc
limit 1;
---------------------------------------------------------------------------------------

-- =========================================
-- BUSINESS INSIGHT:
-- Cumulative sales analysis indicates continuous business growth and improving revenue performance over time.
-- =========================================

-- 13. Running Sales Query
SELECT
    Order_Date,
    ROUND(SUM(Sales),2) AS Daily_Sales,

    ROUND(
        SUM(SUM(Sales))
        OVER(ORDER BY Order_Date),
    2) AS Running_Total_Sales

FROM ecommerce_sales
GROUP BY Order_Date
ORDER BY Order_Date; 
---------------------------------------------------------------------------------------

-- =========================================
-- BUSINESS INSIGHT:
-- A small percentage of customers contribute a significant portion of the company’s total revenue.
-- =========================================

-- 14. TOP 20% CUSTOMER CONTRIBUTION
WITH customer_sales as 
(SELECT 
customer_name,
sum(sales) as total_sales
from ecommerce_sales
group by customer_name)

select customer_name,
ROUND(total_sales,2) as total_sales
from customer_sales
order by total_sales desc
limit 20;
---------------------------------------------------------------------------------------

-- =========================================
-- BUSINESS INSIGHT:
-- Profit margins differ across product categories, highlighting variations in category profitability and business efficiency.
-- =========================================
 
-- 15. CATEGORY WISE PROFIT MARGIN
SELECT
category,
round(sum(sales),2) as Total_Sales,
round(sum(profit),2) as Total_Profit,
round(sum(profit) / sum(sales) * 100,2) as Profit_Margin
from ecommerce_sales
group by category;
