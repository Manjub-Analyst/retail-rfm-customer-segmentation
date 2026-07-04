-- ============================================
-- Retail Sales Performance & Customer Segmentation
-- RFM Analysis using Online Retail II UCI Dataset
-- ============================================

-- 1. DATA CLEANING
-- Remove nulls, cancelled orders (invoice starting with 'C'), 
-- negative/zero quantity and price
CREATE TABLE SALES_Clean AS
SELECT *
FROM SALES
WHERE CustomerID IS NOT NULL
  AND Quantity > 0
  AND UnitPrice > 0
  AND InvoiceNo NOT LIKE 'C%';


-- 2. RFM CALCULATION
-- Recency = days since last purchase
-- Frequency = number of distinct invoices
-- Monetary = total spend
CREATE TABLE RFM_Scored AS
SELECT
    CustomerID,
    JULIANDAY((SELECT MAX(InvoiceDate) FROM SALES_Clean)) - JULIANDAY(MAX(InvoiceDate)) AS Recency,
    COUNT(DISTINCT InvoiceNo) AS Frequency,
    SUM(Quantity * UnitPrice) AS Monetary
FROM SALES_Clean
GROUP BY CustomerID;


-- 3. QUARTILE SCORING
-- Score each RFM metric 1-4 using NTILE
CREATE TABLE RFM_Quartiles AS
SELECT
    CustomerID,
    Recency,
    Frequency,
    Monetary,
    NTILE(4) OVER (ORDER BY Recency DESC) AS R_Score,
    NTILE(4) OVER (ORDER BY Frequency ASC) AS F_Score,
    NTILE(4) OVER (ORDER BY Monetary ASC) AS M_Score
FROM RFM_Scored;


-- 4. CUSTOMER SEGMENTATION
-- Combine RFM scores into segments
CREATE TABLE RFM_Segments AS
SELECT
    CustomerID,
    Recency,
    Frequency,
    Monetary,
    R_Score,
    F_Score,
    M_Score,
    CASE
        WHEN R_Score >= 3 AND F_Score >= 3 AND M_Score >= 3 THEN 'Champions'
        WHEN R_Score >= 3 AND F_Score >= 2 THEN 'Loyal Customers'
        WHEN R_Score >= 3 AND F_Score < 2 THEN 'Regular'
        WHEN R_Score <= 2 AND F_Score >= 3 THEN 'At Risk'
        ELSE 'Lost'
    END AS Segment
FROM RFM_Quartiles;


-- 5. VALIDATION QUERIES
SELECT Segment, COUNT(*) AS num_customers
FROM RFM_Segments
GROUP BY Segment
ORDER BY num_customers DESC;

SELECT * FROM RFM_Segments;