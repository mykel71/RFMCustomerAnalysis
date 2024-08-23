USE CustomerAnalysisDB;


-- Create a table to store RFM values
IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[RFM_Customer_Dataset_2]') AND type = N'U'
)
BEGIN
CREATE TABLE RFM_Customer_Dataset_2 (
    customer_id NVARCHAR(50) PRIMARY KEY,
    recency INT,
    frequency INT,
    monetary DECIMAL(10, 2)
);

-- Calculate Recency, Frequency, and Monetary values
WITH RFM_CTE AS (
    SELECT
        customer_id,
        DATEDIFF(DAY, MAX(transact_date), GETDATE()) AS recency,
        COUNT(transaction_id) AS frequency,
        SUM(revenue) AS monetary
    FROM
        dbo.Customer_Dataset_2
    GROUP BY
        customer_id
)
INSERT INTO RFM_Customer_Dataset_2
SELECT
    customer_id,
    recency,
    frequency,
    monetary
FROM
    RFM_CTE;

END;

select * 
from RFM_Customer_Dataset_2;