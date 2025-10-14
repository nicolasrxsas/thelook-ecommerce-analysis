# 📊DAX Measures - The look Ecommerce Analysis

This document compiles the **most relevant** DAX metrics used in developing the look_ecommerce analysis dashboard.
Each metric includes its definition, its use within the report, and the information it provides.

---
# 📌 Overview 
## 🧮 New Customers
```DAX
New Customers = 
VAR FirstPurchase = 
    ADDCOLUMNS(
        SUMMARIZE(Sales_Base, Sales_Base[customer_id], "FirstDate", MIN(Sales_Base[order_date])),
        "IsNew", IF([FirstDate] = MIN(Sales_Base[order_date]), 1, 0)
    )
RETURN COUNTROWS(FILTER(FirstPurchase, [IsNew] = 1))
```
Uso: KPI en la página "Ventas por Zona".

Insight: Identifica la ciudad con mayores ventas.
## 🧮 Average Order Value (AOV)
```DAX
Average Order Value (AOV) =
 DIVIDE([Total Revenue], [Total Orders])
```
Uso: KPI en la página "Ventas por Zona".

Insight: Identifica la ciudad con mayores ventas.
## 🧮 Monthly Revenue 
```DAX
Monthly Revenue =
CALCULATE([Total Revenue], DATESMTD(Sales_Base[order_date]))
```
Uso: KPI en la página "Ventas por Zona".

Insight: Identifica la ciudad con mayores ventas.

# 📌 Sales 
## 🧮 Profit by Category
```DAX
Profit by Category =
SUM(margin_vs_volume[total_profit])
```
Uso: KPI en la página "Ventas por Zona".

Insight: Identifica la ciudad con mayores ventas.
## 🧮 Profit Margin %
```DAX
Profit Margin % = 
DIVIDE([Profit by Category], [Revenue by Category]) * 100
```
Uso: KPI en la página "Ventas por Zona".

Insight: Identifica la ciudad con mayores ventas.
## 🧮 Revenue by Category
```DAX
Revenue by Category =
SUM(margin_vs_volume[total_revenue])
```
Uso: KPI en la página "Ventas por Zona".

Insight: Identifica la ciudad con mayores ventas.

# 📌 Clients 
## 🧮 Average Measures
```DAX
Average Frequency = AVERAGE(RFM[frequency])

Average Monetary = AVERAGE(RFM[monetary])

Average Recency = AVERAGE(RFM[recency_days])

Average Retention Rate = AVERAGE(monthly_retention[retention_rate])

Avg Orders per Customer = AVERAGE(AVG_purchase_freq_per_customer[avg_orders_per_customer])

```
Uso: KPI en la página "Ventas por Zona".

Insight: Identifica la ciudad con mayores ventas.
## 🧮 Average Frequency
```DAX
Average Frequency =
 AVERAGE(RFM[frequency])

```
Uso: KPI en la página "Ventas por Zona".

Insight: Identifica la ciudad con mayores ventas.
