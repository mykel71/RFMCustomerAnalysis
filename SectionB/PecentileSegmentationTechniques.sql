USE [CustomerAnalysisDB];
/****************************************************************************************************************************************/
	-- <GenericCodeName>CustomerAnalysis_V001</GenericCodeName>
	-- <CreatedDate>2024-08-17 10:28:48.733</CreatedDate>
	-- <CreatedBy>Michael Shepherd Munemo</CreatedBy>
	-- <GenericCodeAssetTemplate>Advanced Segment Analysis</GenericCodeAssetTemplate>  
/****************************************************************************************************************************************/
/****************************************************************************************************************************************/
	-- IMPORTANT NOTE: 
	-- Assigning Segment Logic using Percentile-Based Scoring:
	-- Instead of using NTILE for even distribution, we can use percentiles for scoring
	-- This allows more flexibility in setting thresholds and that reflect business-specific needs
	-- If aspects like Monetary are more important to THE business, then we can apply weights to the score
/****************************************************************************************************************************************/
/****************************************************************************************************************************************/

WITH RFM_Scores_Customer_Dataset_1 AS (
    SELECT
        customer_id,
        NTILE(5) OVER (ORDER BY Recency ASC) AS RecencyScore, 
        NTILE(5) OVER (ORDER BY Frequency DESC) AS FrequencyScore, 
        Monetary,
        PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY Monetary) OVER () AS Monetary_80th,
        PERCENTILE_CONT(0.6) WITHIN GROUP (ORDER BY Monetary) OVER () AS Monetary_60th,
        PERCENTILE_CONT(0.4) WITHIN GROUP (ORDER BY Monetary) OVER () AS Monetary_40th,
        PERCENTILE_CONT(0.2) WITHIN GROUP (ORDER BY Monetary) OVER () AS Monetary_20th
    FROM
        [dbo].[RFM_Customer_Dataset_1]
),
RFM_Scores_With_MonetaryScore AS (
    SELECT
        customer_id,
        RecencyScore,
        FrequencyScore,
        CASE
            WHEN Monetary >= Monetary_80th THEN 5
            WHEN Monetary >= Monetary_60th THEN 4
            WHEN Monetary >= Monetary_40th THEN 3
            WHEN Monetary >= Monetary_20th THEN 2
            ELSE 1
        END AS MonetaryScore
    FROM
        RFM_Scores_Customer_Dataset_1
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
		-- If aspects like Monetary are more important to THE business, then we can apply weights to the score
	,(0.5 * RecencyScore) + (0.3 * FrequencyScore) + (0.2 * MonetaryScore) AS WeightedRFMScore
FROM
    RFM_Scores_With_MonetaryScore
)
SELECT
    Segment,
    COUNT(customer_id) AS CustomerCount,
    AVG(MonetaryScore) AS AvgMonetaryScore,
    AVG(FrequencyScore) AS AvgFrequencyScore,
    AVG(RecencyScore) AS AvgRecencyScore
	,AVG(WeightedRFMScore) AS WeightedRFMScore
FROM
    Segmented_Customers
GROUP BY
    Segment
ORDER BY
    CustomerCount DESC;
