---List Dataset Tables---

SELECT table_name
FROM `bigquery-public-data.thelook_ecommerce.INFORMATION_SCHEMA.TABLES`
ORDER BY table_name;
---

---Preview (rows)---

SELECT * FROM `bigquery-public-data.thelook_ecommerce.orders` LIMIT 10;
SELECT * FROM `bigquery-public-data.thelook_ecommerce.order_items` LIMIT 10;
SELECT * FROM `bigquery-public-data.thelook_ecommerce.products` LIMIT 10;
SELECT * FROM `bigquery-public-data.thelook_ecommerce.users` LIMIT 10;
---
---Count Rows--

SELECT 'orders' AS table, COUNT(*) AS rows FROM `bigquery-public-data.thelook_ecommerce.orders`
UNION ALL
SELECT 'order_items', COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.order_items`
UNION ALL
SELECT 'products', COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.products`
UNION ALL
SELECT 'users', COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.users`;

---