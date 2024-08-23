USE [CustomerAnalysisDB];
/****************************************************************************************************************************************
	-- <GenericCodeName>CustomerAnalysis_V001</GenericCodeName>
	-- <CreatedDate>2024-08-17 10:28:48.733</CreatedDate>
	-- <CreatedBy>Michael Shepherd Munemo</CreatedBy>
	-- <GenericCodeAssetTemplate>Segment Analysis</GenericCodeAssetTemplate>  
****************************************************************************************************************************************/
/****************************************************************************************************************************************
	-- IMPORTANT NOTE: 
	-- Assigning Segment Logic as follows:
	-- Champions: These are best customers. We might consider rewarding them with exclusive offers or early access to products
	-- Loyal Customers: Engage them further with loyalty programs or incentives to continue purchasing frequently
	-- At Risk: These customers were once valuable but haven't made a purchase recently -> we can target them with reactivation campaigns or personalized offers to bring them back
	-- Others: Explore what might convert them into more valuable customers. This could involve targeted promotions or education about your product/service benefits.
****************************************************************************************************************************************/
/****************************************************************************************************************************************/

WITH RFM_Scores_Customer_Dataset_2 AS (
    SELECT
        customer_id,
        NTILE(5) OVER (ORDER BY Recency ASC) AS RecencyScore, 
        NTILE(5) OVER (ORDER BY Frequency DESC) AS FrequencyScore, 
        NTILE(5) OVER (ORDER BY Monetary DESC) AS MonetaryScore 
    FROM (
        SELECT
            customer_id,
            Recency,
            Frequency,
            Monetary
        FROM
            [dbo].[RFM_Customer_Dataset_2]
    ) AS RFMValues
),
Segmented_Customers AS (
    SELECT
        customer_id,
        RecencyScore,
        FrequencyScore,
        MonetaryScore,
        CASE
            WHEN RecencyScore = 5 AND FrequencyScore = 5 AND MonetaryScore = 5 THEN 'Champions'
            WHEN RecencyScore >= 4 AND FrequencyScore >= 4 AND MonetaryScore >= 4 THEN 'Loyal Customers'
            WHEN RecencyScore <= 2 AND FrequencyScore >= 4 AND MonetaryScore >= 4 THEN 'At Risk'
            WHEN RecencyScore <= 2 AND FrequencyScore <= 2 AND MonetaryScore <= 2 THEN 'Lost Customers'
            WHEN FrequencyScore = 1 AND MonetaryScore = 1 THEN 'Low Value'
            WHEN FrequencyScore >= 3 AND MonetaryScore <= 2 THEN 'Potential Loyalists'
            ELSE 'Others'
        END AS Segment
    FROM
        RFM_Scores_Customer_Dataset_2
)
SELECT
    Segment,
    COUNT(customer_id) AS CustomerCount,
    AVG(MonetaryScore) AS AvgMonetaryScore,
    AVG(FrequencyScore) AS AvgFrequencyScore,
    AVG(RecencyScore) AS AvgRecencyScore
FROM
    Segmented_Customers
GROUP BY
    Segment
ORDER BY
    CustomerCount DESC;