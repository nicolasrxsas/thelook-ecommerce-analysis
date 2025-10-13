
/*  Total Revenue (excluding returns) */
SELECT 
  ROUND(SUM(oi.sale_price), 2) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
WHERE oi.status = 'Complete';


/* Total Orders */
SELECT 
  COUNT(DISTINCT order_id) AS total_orders
FROM `bigquery-public-data.thelook_ecommerce.orders`
WHERE status = 'Complete';


/* Total Customers */
SELECT 
  COUNT(DISTINCT user_id) AS total_customers
FROM `bigquery-public-data.thelook_ecommerce.orders`
WHERE status = 'Complete';


/* Average Order Value (AOV) */
SELECT 
  ROUND(SUM(oi.sale_price) / COUNT(DISTINCT oi.order_id), 2) AS avg_order_value
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
WHERE oi.status = 'Complete';


/*  Revenue by Month */
SELECT
  FORMAT_DATE('%Y-%m', DATE(o.created_at)) AS month,
  ROUND(SUM(oi.sale_price), 2) AS monthly_revenue
FROM `bigquery-public-data.thelook_ecommerce.orders` o
JOIN `bigquery-public-data.thelook_ecommerce.order_items` oi
  ON o.order_id = oi.order_id
WHERE oi.status = 'Complete'
GROUP BY month
ORDER BY month;


/* Number of New Customers per Month */
WITH first_purchase AS (
  SELECT
    user_id,
    MIN(DATE(created_at)) AS first_purchase_date
  FROM `bigquery-public-data.thelook_ecommerce.orders`
  WHERE status = 'Complete'
  GROUP BY user_id
)
SELECT
  FORMAT_DATE('%Y-%m', first_purchase_date) AS month,
  COUNT(DISTINCT user_id) AS new_customers
FROM first_purchase
GROUP BY month
ORDER BY month;


/* Revenue by Country */
SELECT
  u.country,
  ROUND(SUM(oi.sale_price), 2) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.orders` o
  ON oi.order_id = o.order_id
JOIN `bigquery-public-data.thelook_ecommerce.users` u
  ON o.user_id = u.id
WHERE oi.status = 'Complete'
GROUP BY u.country
ORDER BY total_revenue DESC;


/* Top 10 Customers by Revenue */
SELECT
  o.user_id,
  CONCAT(u.first_name, ' ', u.last_name) AS customer_name,
  ROUND(SUM(oi.sale_price), 2) AS total_spent
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.orders` o
  ON oi.order_id = o.order_id
JOIN `bigquery-public-data.thelook_ecommerce.users` u
  ON o.user_id = u.id
WHERE oi.status = 'Complete'
GROUP BY o.user_id, customer_name
ORDER BY total_spent DESC
LIMIT 10;

