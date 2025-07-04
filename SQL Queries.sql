-- Create and Select Database
CREATE DATABASE Customer_payment;

-- Use the newly created database
USE Customer_payment;

------------------------------------------------------------- Basic Data Analysis

-- Check rows where customer_id is missing
SELECT * 
FROM customer_orders 
WHERE customer_id IS NULL;

-- View all distinct rows in customer_orders table
SELECT DISTINCT * 
FROM customer_orders;

----------------------------------------------- Customer Orders Queries

-- 1. Total order amount
SELECT SUM(order_amount) AS total_order_amount 
FROM customer_orders;

-- 2. Customers whose orders were successfully delivered
SELECT DISTINCT customer_id 
FROM customer_orders 
WHERE order_status = 'delivered';

-- 3. Count total number of unique orders
SELECT COUNT(DISTINCT order_id) AS total_orders 
FROM customer_orders;

-- 4. List of unique order statuses
SELECT DISTINCT order_status 
FROM customer_orders;

-- 5. Count of unique customers who placed orders
SELECT COUNT(DISTINCT customer_id) AS total_customers 
FROM customer_orders;

-- 6. Total order amount grouped by each order status
SELECT 
    order_status,
    ROUND(SUM(order_amount), 2) AS total_order_amount  
FROM customer_orders
GROUP BY order_status;

-- 7. Top month by total order amount
SELECT TOP 1 
    DATENAME(MONTH, order_date) AS month,
    ROUND(SUM(order_amount), 2) AS total_amount 
FROM customer_orders
GROUP BY 
    MONTH(order_date), 
    DATENAME(MONTH, order_date)
ORDER BY total_amount DESC;

-- 8. Total number of orders grouped by weekday
SELECT 
    DATENAME(WEEKDAY, order_date) AS day,
    COUNT(order_id) AS total_orders 
FROM customer_orders
GROUP BY DATENAME(WEEKDAY, order_date)
ORDER BY total_orders DESC;


------------------------------------------------------------- Payments Table Queries


-- 9. Total payment amount
SELECT SUM(payment_amount) AS total_payment_amount 
FROM payments;

-- 10. List of distinct payment methods used
SELECT DISTINCT payment_method 
FROM payments;

-- 11. Total payment amount grouped by payment status
SELECT 
    payment_status,  
    ROUND(SUM(payment_amount), 2) AS total_payment 
FROM payments 
GROUP BY payment_status;

-- 12. Count of customers by payment status (completed, failed, etc.)
SELECT 
    p.payment_status,
    COUNT(c.customer_id) AS total_customers_with_status 
FROM customer_orders c
INNER JOIN payments p ON c.order_id = p.order_id
GROUP BY p.payment_status;

-- 13. Year with the highest total payments
SELECT 
    YEAR(payment_date) AS year,
    ROUND(SUM(payment_amount), 2) AS total_amount 
FROM payments 
GROUP BY YEAR(payment_date)
ORDER BY total_amount DESC;
