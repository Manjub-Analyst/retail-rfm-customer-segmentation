# Retail Sales Performance & Customer Segmentation (RFM Analysis)

## Overview
This project analyzes customer purchase behavior using the Online Retail II (UCI) dataset 
to segment customers based on Recency, Frequency, and Monetary (RFM) value. 
The goal is to identify high-value customers, at-risk customers, and lost customers 
to support targeted marketing and retention strategies.

## Tools Used
- SQLite (data cleaning, RFM calculation, segmentation logic)
- Power BI (dashboard and visualization)

## Process
1. **Data Cleaning** — Removed null CustomerIDs, cancelled orders, and invalid quantity/price entries
2. **RFM Calculation** — Computed Recency, Frequency, and Monetary value per customer
3. **Quartile Scoring** — Scored each RFM metric into quartiles (1-4) using NTILE
4. **Customer Segmentation** — Classified customers into segments: Champions, Loyal Customers, 
   Regular, At Risk, and Lost
5. **Dashboard** — Built an interactive Power BI dashboard to visualize segment distribution, 
   customer count, and revenue contribution by segment

## Key Insights
- Total customers analyzed: 5,878
- Champions and Regular customers make up the largest segments (~32% each)
- Revenue is heavily concentrated in the Champions segment, highlighting the importance 
  of retention strategies for top-tier customers

## Files
- `queries.sql` — SQL scripts for data cleaning, RFM calculation, and segmentation
- `Retail_RFM_Dashboard.pbix` — Power BI dashboard file
- `dashboard_screenshot.png` — Dashboard preview image

## Dataset
[Online Retail II — UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/502/online+retail+ii)