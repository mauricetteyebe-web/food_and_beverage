-- Table de features pour Machine Learning

CREATE OR REPLACE TABLE anycompany_lab.analytics.features_marketing AS
SELECT
    region,
    product_category,

    COUNT(*) AS total_transactions,
    SUM(amount) AS total_revenue,
    AVG(amount) AS avg_basket,

    AVG(is_promo_active) AS promo_ratio,
    COUNT(DISTINCT campaign_name) AS nb_campaigns,

    MONTH(transaction_date) AS month,
    DAYOFWEEK(transaction_date) AS day_of_week,

    -- RFM features
    DATEDIFF(day, MAX(transaction_date), CURRENT_DATE) AS recency,
    COUNT(*) AS frequency,
    SUM(amount) AS monetary

FROM anycompany_lab.analytics.fact_sales_enriched
GROUP BY 
    region, 
    product_category, 
    month, 
    day_of_week;