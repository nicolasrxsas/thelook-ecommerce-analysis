# Project 2 – E-commerce Analysis with BigQuery and Power BI

This project uses the public **`thelook_ecommerce`** dataset from Google BigQuery to perform a business analysis focused on discovering patterns in sales, customers, and products.

The main objective is to move beyond descriptive metrics and answer analytical questions that provide **strategic value** for decision-making.
## Project Progress
- [x] Explore dataset in BigQuery
- [x] Define key KPIs
- [ ] Build queries for KPIs ***(In Progress)***
- [ ] Create derived tables in BigQuery
- [ ] Connect with Power BI
- [ ] Design dashboards
- [ ] Draft business conclusions
## How to Navigate
``` MARKDOWN
├─ README.md
├─ sql/
   └─01_business_overview_metrics.sql
   └─02_sales_and_margin_drivers.sql
   └─03_customer_dynamics_and_cohorts.sql
   └─Exploration.sql
   
   
   
├─ docs/
│   └─ exploration_notes.md
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
- Top 10 customers by revenue

📄 SQL File:[01_business_overview_metrics.sql](sql/01_business_overview_metrics.sql)

### 📊 2. Sales & Profitability Analysis
* Revenue by category
* Profit margin by category
* Top 20 products by revenue or profit

📄 SQL File: [02_sales_profit_analysis.sql](sql/02_sales_profit_analysis.sql) 

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


