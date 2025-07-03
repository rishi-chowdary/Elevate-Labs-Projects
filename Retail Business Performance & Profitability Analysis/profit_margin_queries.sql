
-- Remove NULLs and duplicates
DELETE FROM retail_data
WHERE Transaction_ID IS NULL
   OR Category IS NULL
   OR Sub_Category IS NULL
   OR Revenue IS NULL;

DELETE FROM retail_data
WHERE ctid NOT IN (
  SELECT MIN(ctid)
  FROM retail_data
  GROUP BY Transaction_ID
);

--Calculate profit margin by Category and Sub-Category
SELECT 
  Category,
  Sub_Category,
  ROUND(SUM(Profit), 2) AS Total_Profit,
  ROUND(SUM(Revenue), 2) AS Total_Revenue,
  ROUND(AVG(Profit / NULLIF(Revenue, 0)), 2) AS Profit_Margin
FROM retail_data
GROUP BY Category, Sub_Category
ORDER BY Profit_Margin ASC;
