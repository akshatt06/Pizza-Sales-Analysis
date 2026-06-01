CREATE DATABASE IF NOT EXISTS pizza_dataset;
USE pizza_dataset;

CREATE TABLE IF NOT EXISTS pizza_sales(
Pizza_ID INT PRIMARY KEY,
Order_ID INT,
Pizza_Name_ID VARCHAR(100),
Quantity INT,
Order_Date TEXT,
Order_Time TIME,
Unit_Price FLOAT,
Total_Price FLOAT,
Pizza_Size VARCHAR(100),
Pizza_Category VARCHAR(100),
Pizza_Ingredients TEXT,
Pizza_Name VARCHAR(100)
);

SELECT * FROM pizza_sales;

-- KPI's
-- 1. Total Revenue:
SELECT SUM(Total_Price) AS Total_Revenue FROM pizza_sales;


-- 2. Average Order Value:
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales;


-- 3. Total Pizzas Sold:
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;


-- 4. Total Orders:
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;


-- 5. Average Pizzas Per Order:
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;


-- B. Daily Trend for Total :
SELECT 
    DAYNAME(order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYOFWEEK(order_date), DAYNAME(order_date)
ORDER BY DAYOFWEEK(order_date);


-- C. Monthly Trend for Orders:
SELECT 
    MONTHNAME(order_date) AS Month_Name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);


-- D. Percentage of Sales by Pizza Category:
SELECT Pizza_Category, sum(Total_Price) AS Total_Sales, Sum(Total_Price) * 100 / (SELECT Sum(Total_Price) FROM pizza_sales WHERE MONTH(Order_Date) = 1) AS Percentage
FROM pizza_sales
WHERE MONTH(Order_Date) = 1
GROUP BY Pizza_Category;


-- E. Percentage of Sales by Pizza Size:
SELECT Pizza_Size, SUM(Total_price) AS Total_Sales, CAST(sum(Total_Price) * 100 / (SELECT SUM(Total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Percentage
FROM pizza_sales
GROUP BY Pizza_Size
ORDER BY Percentage DESC;


-- F. Total Pizzas Sold by Pizza Category:
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- G. Top 5 Pizzas by Revenue:
SELECT pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

-- H. Bottom 5 Pizzas by Revenue:
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;


-- I. Top 5 Pizzas by Quantity:
SELECT pizza_name, SUM(Quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC
LIMIT 5;

-- J. Bottom 5 Pizzas by Quantity:
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;


-- K. Top 5 Pizzas by Total Orders:
SELECT pizza_name, COUNT(DISTINCT Order_ID) AS Total_Orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;


-- L. Bottom 5 Pizzas by Total Orders:
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;
