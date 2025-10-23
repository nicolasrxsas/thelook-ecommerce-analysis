# Project 2 – E-commerce Analysis with BigQuery and Power BI

This project uses the public **`thelook_ecommerce`** dataset from Google BigQuery to perform a business analysis focused on discovering patterns in sales, customers, and products.

The main objective is to move beyond descriptive metrics and answer analytical questions that provide **strategic value** for decision-making.
## Project Progress
- [x] Explore dataset in BigQuery
- [x] Define key KPIs
- [X] Build queries for KPIs 
- [x] Create derived tables in BigQuery 
- [x] Connect with Power BI
- [ ] Design dashboards ***(In Progress)***
- [ ] Draft business conclusions
## How to Navigate
``` MARKDOWN
├─ docs/
   └─ exploration_notes.md
├─ powerbi/
   └─ DAX_Measures.md
   └─ Data_Model_Overview.md
├─ sql/
   └─01_business_overview_metrics.sql
   └─02_sales_and_margin_drivers.sql
   └─03_customer_dynamics_and_cohorts.sql
   └─04_sales_base.sql
   └─Exploration.sql
├─ README.md
```

## 🎯 Analysis Objectives

### 🧭 1. Business Overview / Key Metrics
This section provides a high-level overview of the business performance and customer base.
**Queries included:**
- Total revenue, orders, and customers
- Average order value (AOV)
- Monthly revenue trend
- New customers per month
- Revenue by country
- Revenue by category

📄 SQL File:[01_business_overview_metrics.sql](sql/01_business_overview_metrics.sql)
## 📊 2. Sales & Profitability Analysis

### 🎯 Objective
This section explores the core profitability drivers of the business — identifying **which categories and products generate the most revenue and profit**, and whether the company relies on **high sales volume** or **high margins** for growth.

---

### 🧱 Data Sources
- **Sales_Base:** Main sales table containing key transaction data (`order_id`, `product_id`, `category`, `sale_price`, `cost`, `order_date`, `customer_id`).
- **margin_vs_volume:** Aggregated data showing profitability and sales volume per category.
- **top_20_products:** Filtered dataset containing the 20 products with the highest revenue or profit.
- 📄 SQL File: [02_sales_profit_analysis.sql](sql/02_sales_profit_analysis.sql) 

---

### ⚙️ DAX Measures Used

#### Core Metrics
```DAX
Total Revenue = SUM(Sales_Base[sale_price])

Total Cost = SUM(Sales_Base[cost])

Total Profit = [Total Revenue] - [Total Cost]

Profit Margin % =
DIVIDE([Total Profit], [Total Revenue], 0)
```
### 🌍 3. Customer & Market Insights
* These queries focus on understanding user behavior, retention, and purchasing patterns through cohort analysis and retention metrics. 
  
📄 SQL File: [03_customer_dynamics_and_cohorts.sql](sql/03_customer_dynamics_and_cohorts.sql) 

---

## 🛠️ Tools Used
* **SQL (BigQuery):** For data extraction, transformation, and exploration.
* **Power BI:** For interactive visualization and insight presentation.
* **GitHub:** For version control and project documentation.

---

## 🚀 Project Value

This analysis aims to simulate a real-world business analytics scenario within an e-commerce context by:

* **Identifying strategic products** (revenue vs. profitability).
* **Understanding customer retention** and behavior.
* **Discovering high-value customer profiles.**

Thus, the project delivers not only dashboards but also **data-supported business stories**.
thelook-ecommerce-analysis/


