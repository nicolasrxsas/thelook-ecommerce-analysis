-- Query: Category profitability analysis
-- Description: Calculates total profit and revenue per product category
-- Output table: `analisis-retail.thelook_analysis_project2.category_profit_revenue`

SELECT
  SUM(oi.sale_price - p.cost) AS total_profit,
  SUM(oi.sale_price) AS total_revenue,
  p.category
FROM
  `bigquery-public-data.thelook_ecommerce.products` p
JOIN `bigquery-public-data.thelook_ecommerce.order_items` oi 
  ON p.id = oi.product_id
JOIN `bigquery-public-data.thelook_ecommerce.orders` o 
  ON o.order_id = oi.order_id
WHERE oi.status = 'Complete'
GROUP BY category
ORDER BY total_profit DESC;
 
-- Query: profit margin percent
-- Description: Identify which categories not only sell a lot, but also leave a higher percentage of profit.
-- Output table: `analisis-retail.thelook_analysis_project2.profit_margin_percent`

SELECT 
  p.category,
  ROUND(SUM(oi.sale_price - p.cost), 2) AS total_profit,
  ROUND(SUM(oi.sale_price), 2) AS total_revenue,
  ROUND(SUM(oi.sale_price - p.cost) / SUM(oi.sale_price), 4) AS profit_margin_percent,
  COUNT(DISTINCT oi.id) AS total_items_sold
FROM 
  `bigquery-public-data.thelook_ecommerce.products` p
JOIN 
  `bigquery-public-data.thelook_ecommerce.order_items` oi 
  ON p.id = oi.product_id
JOIN 
  `bigquery-public-data.thelook_ecommerce.orders` o 
  ON o.order_id = oi.order_id
WHERE 
  oi.status = 'Complete'
GROUP BY 
  p.category
ORDER BY 
  profit_margin_percent DESC;

-- Query: Margin to Volume Relationship (by Category)
-- Description: will allow to classify categories by margin type and compare visually.
-- Output table:  `analisis-retail.thelook_analysis_project2.margin_vs_volume`

WITH category_summary AS (
  SELECT 
    p.category,
    p.id,
    SUM(oi.sale_price - p.cost) AS total_profit,
    SUM(oi.sale_price) AS total_revenue,
    ROUND(SUM(oi.sale_price - p.cost) / SUM(oi.sale_price) * 100, 2) AS profit_margin_percent,
    COUNT(oi.id) AS total_items_sold,
  FROM 
    `bigquery-public-data.thelook_ecommerce.products` p
  JOIN 
    `bigquery-public-data.thelook_ecommerce.order_items` oi 
    ON p.id = oi.product_id
  WHERE 
    oi.status = 'Complete'
  GROUP BY 
    p.category,
    p.id
    
)
SELECT
  category,
  id,
  total_items_sold,
  total_revenue,
  total_profit,
  profit_margin_percent,
  CASE
    WHEN profit_margin_percent >= 40 THEN 'High Margin'
    WHEN profit_margin_percent BETWEEN 20 AND 39.99 THEN 'Medium Margin'
    ELSE 'Low Margin'
  END AS margin_segment
FROM category_summary
ORDER BY total_revenue DESC;

-- Query: Top 20 Products
-- Description: Allow to identify the most sold products and group it by category, units sold, etc.
-- Output table:  `analisis-retail.thelook_analysis_project2.top_20_products`

SELECT
  p.id AS product_id,
  p.name AS product_name,
  p.category AS category,
  COUNT(oi.id) AS units_sold,
  SUM(oi.sale_price) AS revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
LEFT JOIN `bigquery-public-data.thelook_ecommerce.products` p
  ON oi.product_id = p.id
WHERE oi.returned_at IS NULL
GROUP BY product_id, product_name, category
ORDER BY revenue DESC
LIMIT 20;





