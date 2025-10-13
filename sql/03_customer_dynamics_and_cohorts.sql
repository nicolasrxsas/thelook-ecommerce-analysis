/* RFM per User */
SELECT
  oi.user_id,
  CONCAT(u.first_name," ", u.last_name) AS customer_name,
  u.age,
  u.gender,
  u.country,
  DATE_DIFF(CURRENT_DATE(), MAX(DATE(o.created_at)), DAY) AS recency_days,
  COUNT(DISTINCT o.order_id) AS frequency,
  SUM(oi.sale_price) AS monetary
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.orders` o USING(order_id)
JOIN `bigquery-public-data.thelook_ecommerce.users` u ON u.id = o.user_id
WHERE oi.returned_at IS NULL
GROUP BY customer_name, 
oi.user_id,
u.age,
  u.gender,
  u.country
ORDER BY monetary DESC
LIMIT 1000;

/* The ultimate goal of the query is to group customers by the month in which they made 
their first purchase and then count how many of those original customers made another purchase in each subsequent month./*/

WITH first_purchase AS (
  SELECT 
    user_id,
    MIN(DATE(created_at)) AS first_purchase_date
  FROM `bigquery-public-data.thelook_ecommerce.orders`
  WHERE status = 'Complete'
  GROUP BY user_id
),
cohorts AS (
  SELECT
    fp.user_id,
    DATE_TRUNC(fp.first_purchase_date, MONTH) AS cohort_month,
    DATE_TRUNC(o.created_at, MONTH) AS purchase_month
  FROM first_purchase fp
  JOIN `bigquery-public-data.thelook_ecommerce.orders` o
    ON fp.user_id = o.user_id
  WHERE o.status = 'Complete'
)
SELECT
  cohort_month,
  purchase_month,
  COUNT(DISTINCT user_id) AS customers
FROM cohorts
GROUP BY cohort_month, purchase_month
ORDER BY cohort_month, purchase_month;


/* The ultimate goal of the query is to group customers by the month in which they made their first purchase and then count how many of those original customers made another purchase in each subsequent month. /*/


WITH first_purchase AS (
  SELECT 
    user_id,
    MIN(DATE(created_at)) AS first_purchase_date
  FROM `bigquery-public-data.thelook_ecommerce.orders`
  WHERE status = 'Complete'
  GROUP BY user_id
),
cohorts AS (
  SELECT
    fp.user_id,
    DATE_TRUNC(fp.first_purchase_date, MONTH) AS cohort_month,
    DATE_TRUNC(o.created_at, MONTH) AS purchase_month
  FROM first_purchase fp
  JOIN `bigquery-public-data.thelook_ecommerce.orders` o
    ON fp.user_id = o.user_id
  WHERE o.status = 'Complete'
),
customers_per_cohort AS (
  SELECT
    cohort_month,
    COUNT(DISTINCT user_id) AS cohort_size
  FROM cohorts
  GROUP BY cohort_month
)
SELECT
  c.cohort_month,
  c.purchase_month,
  COUNT(DISTINCT c.user_id) AS active_customers,
  cp.cohort_size,
  ROUND(COUNT(DISTINCT c.user_id) / cp.cohort_size * 100, 2) AS retention_rate
FROM cohorts c
JOIN customers_per_cohort cp
  ON c.cohort_month = cp.cohort_month
GROUP BY c.cohort_month, c.purchase_month, cp.cohort_size
ORDER BY c.cohort_month, c.purchase_month;

/* It shows the average number of orders per customer, grouped by month of first purchase. /*/

SELECT
  DATE_TRUNC(MIN(o.created_at), MONTH) AS cohort_month,
  COUNT(o.order_id) / COUNT(DISTINCT o.user_id) AS avg_orders_per_customer
FROM `bigquery-public-data.thelook_ecommerce.orders` o
WHERE o.status = 'Complete'
GROUP BY cohort_month
ORDER BY cohort_month;


