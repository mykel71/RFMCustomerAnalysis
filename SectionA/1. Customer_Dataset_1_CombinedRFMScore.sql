USE CustomerAnalysisDB;

/****************************************************************************************************************************************/
    -- <GenericCodeName>CustomerAnalysis_V001</GenericCodeName>
    -- <CreatedDate>2024-08-17 10:09:13.230</CreatedDate>
    -- <CreatedBy>Michael Shepherd Munemo</CreatedBy>
    -- <GenericCodeAssetTemplate>Transactional Fact</GenericCodeAssetTemplate>  
/****************************************************************************************************************************************/

-- Create a table to store RFM values
IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[RFM_Customer_Dataset_1]') AND type = N'U'
)
BEGIN
    CREATE TABLE RFM_Customer_Dataset_1 (
        customer_id INT PRIMARY KEY,
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
        SUM(revenue - discount_amount) AS monetary
    FROM
        dbo.Customer_Dataset_1
    GROUP BY
        customer_id
)
INSERT INTO RFM_Customer_Dataset_1 (customer_id, recency, frequency, monetary)
SELECT
    customer_id,
    recency,
    frequency,
    monetary
FROM
    RFM_CTE;

END;

-- Select the calculated RFM values
SELECT *
FROM RFM_Customer_Dataset_1;
