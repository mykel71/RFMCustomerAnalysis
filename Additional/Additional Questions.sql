/*********************************/
/*      ADDITIONAL QUESTION:     */
/*********************************/



/*******************************************************************************************************************************************************************************************************************************

 1. Explain why you set the thresholds to the values that you did.

   My Approach:
   - I used the `NTILE(5)` function to divide the customers into five buckets (percentiles) for each of the RFM metrics (Recency, Frequency, and Monetary).
   - This results in scores ranging from 1 to 5, where 5 typically represents the most favorable score for each metric (for example, most recent for Recency, most frequent for Frequency, and highest spending for Monetary).

   Explanation:
   - Reason for Using NTILE(5): The decision to use NTILE(5) is rooted in the desire to segment the customer base into quintiles, which provides a balanced distribution of customers across the RFM scores. 
   - This method is effective for analyzing large datasets because it ensures each segment contains a roughly equal number of customers.
   - Thresholds Rationale: By using NTILE(5), you inherently establish thresholds based on the distribution of the data. This means that the thresholds for each segment are dynamically determined by the data, allowing for a more data-driven segmentation process.

 2. Say which set(s) of customer group descriptions you decided to use and explain your reasoning for why you picked that set of descriptions.
   
   My Approach:
   - I have opted for a set of customer group descriptions that closely align with Set X from the instructions. Examples include 'Champions', 'Loyal Customers', 'At Risk', and 'Lost Customers'.

   Explanation:
   - Reason for Choosing Set X: Set X is a more conventional set of customer segments that are commonly used in RFM analysis. These segments are intuitive and widely recognized in business contexts, making them easier to interpret and act upon.
   - Alignment with Business Needs: These labels offer clear insights into customer behavior, which is essential for devising targeted marketing strategies. For instance, 'Champions' represent your best customers who need to be rewarded, 
   - while 'At Risk' customers may require re-engagement strategies.



 3. Do you observe any behavioral differences between Customer Dataset 1 and Customer Dataset 2? Please explain.


a.Customer Distribution (Customer Count):
   - Customer Dataset 1 -> has significantly higher customer counts across all segments compared to 'Customer Dataset 2'. For instance, the "Others" segment has 664 customers in Dataset 1, whereas Dataset 2 has only 76.
   - The "Loyal Customers" and "Champions" segments also show a noticeable difference, with Dataset 1 having 159 and 57 customers respectively, while Dataset 2 has only 27 and 15.
   - The "Potential Loyalists" segment is particularly striking, with 88 customers in Dataset 1 but only 2 in Dataset 2.

b. Segment Composition and Scores:
   - Both datasets have similar **AvgMonetaryScore**, **AvgFrequencyScore**, and **AvgRecencyScore** across corresponding segments, indicating similar spending, purchasing frequency, and recency behavior within each segment.
   - However, there are minor variations, such as the "Potential Loyalists" in Dataset 2 having an **AvgMonetaryScore** of 2 compared to 1 in Dataset 1.

c. Segment Presence:
   - Both datasets include the same segments, but the customer distribution within these segments is vastly different. This could imply different stages of customer engagement or the effectiveness of retention strategies in different periods or customer cohorts.

d. Behavioral Insights:
   - Dataset 1 has a larger and more diverse customer base with a significant number of "Loyal Customers" and "Champions." This might indicate better customer engagement and retention.
   - Dataset 2 shows a more condensed customer base, with fewer customers across all segments. The sharp reduction in the "Potential Loyalists" segment could suggest challenges in converting new or borderline customers into loyal ones.

Summary:
- Dataset 1 likely represents a broader and more established customer base with strong loyalty and engagement, whereas "Dataset 2"could represent a smaller, perhaps newer, or more segmented customer base with less overall engagement and loyalty.

*************************************************************************************************************************************************************************************************************************************/