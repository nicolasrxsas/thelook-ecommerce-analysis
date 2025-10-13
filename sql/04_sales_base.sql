-- This is the query used to create a base table that allows for making DAX measures in Power BI in a faster way.

CREATE OR REPLACE TABLE your_dataset.sales_base AS
SELECT
  -- Order
  o.order_id,
  o.user_id AS customer_id,
  o.created_at AS order_date,
  o.status,

  -- Customer
  u.gender AS customer_gender,
  u.age AS customer_age,
  u.country AS customer_country,
  u.state AS customer_state,

  -- Product
  p.id AS product_id,
  p.name AS product_name,
  p.category,
  p.brand,
  p.department,
  p.retail_price,
  p.cost,

  -- Order item 
  oi.id AS order_item_id,
  oi.sale_price AS sale_price,

  -- Derived 
  oi.sale_price AS total_revenue,
  p.cost AS total_cost,
  (oi.sale_price - p.cost) AS total_profit,
  ROUND(SAFE_DIVIDE(oi.sale_price - p.cost, oi.sale_price) * 100, 2) AS profit_margin_percent

FROM `bigquery-public-data.thelook_ecommerce.orders` o
JOIN `bigquery-public-data.thelook_ecommerce.order_items` oi
  ON o.order_id = oi.order_id
JOIN `bigquery-public-data.thelook_ecommerce.products` p
  ON oi.product_id = p.id
LEFT JOIN `bigquery-public-data.thelook_ecommerce.users` u
  ON o.user_id = u.id
WHERE o.status = 'Complete';
