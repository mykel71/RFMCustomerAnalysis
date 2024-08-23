USE [CustomerAnalysisDB];

/****************************************************************************************************************************************/
    -- <GenericCodeName>CustomerAnalysis_V001</GenericCodeName>
    -- <CreatedDate>2024-08-17 19:00:52.117</CreatedDate>
    -- <CreatedBy>Michael Shepherd Munemo</CreatedBy>
    -- <GenericCodeAssetTemplate>Assigning RFM Scores</GenericCodeAssetTemplate>  
/****************************************************************************************************************************************/
/****************************************************************************************************************************************/
	-- IMPORTANT NOTE: 
	-- Assigning scores to both datasets is as follows:



	-- Frequency: Customers who made more purchases get a higher score --> Frequency Score (1-5, with 5 being the most frequent)
	-- Monetary: Customers who spent more get a higher score --> Monetary Score (1-5, with 5 being the highest spending)
/****************************************************************************************************************************************/
/****************************************************************************************************************************************/

/***********************/
/*      CUSTOMER 1     */
/***********************/
WITH RFM_Scores_Customer_Dataset_1 AS (
    SELECT
        customer_id,
        NTILE(5) OVER (ORDER BY Recency ASC) AS RecencyScore, 
        NTILE(5) OVER (ORDER BY Frequency DESC) AS FrequencyScore, 
        NTILE(5) OVER (ORDER BY Monetary DESC) AS MonetaryScore 
    FROM (
        -- Combine RFM values
        SELECT
            customer_id,
            Recency,
            Frequency,
            Monetary
        FROM
            [dbo].[RFM_Customer_Dataset_1]
    ) AS RFMValues
)
 SELECT * FROM RFM_Scores_Customer_Dataset_1;

/***********************/
/*      CUSTOMER 2     */
/***********************/

 WITH RFM_Scores_Customer_Dataset_2 AS (
    SELECT
        customer_id,
        NTILE(5) OVER (ORDER BY Recency ASC) AS RecencyScore,
        NTILE(5) OVER (ORDER BY Frequency DESC) AS FrequencyScore,
        NTILE(5) OVER (ORDER BY Monetary DESC) AS MonetaryScore
    FROM (
        -- Combine RFM values
        SELECT
            customer_id,
            Recency,
            Frequency,
            Monetary
        FROM
            [dbo].[RFM_Customer_Dataset_2]
    ) AS RFMValues
)

 SELECT * FROM RFM_Scores_Customer_Dataset_2;


