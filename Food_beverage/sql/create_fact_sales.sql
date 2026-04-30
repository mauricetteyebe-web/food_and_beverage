-- Table centrale des ventes enrichies

CREATE OR REPLACE TABLE anycompany_lab.analytics.fact_sales_enriched AS
SELECT
    t.transaction_id,
    t.transaction_date,
    t.amount,
    t.payment_method,

    t.region,
    LOWER(t.entity) AS product_category,

    -- Promotions
    p.promotion_type,
    p.discount_percentage,

    -- Marketing
    m.campaign_name,
    m.campaign_type,
    m.budget,

    -- Flag promo
    CASE 
        WHEN p.promotion_id IS NOT NULL THEN 1 
        ELSE 0 
    END AS is_promo_active

FROM anycompany_lab.silver.financial_transactions_clean t

LEFT JOIN anycompany_lab.silver.promotions_clean p
    ON LOWER(t.entity) = LOWER(p.product_category)
    AND t.transaction_date BETWEEN p.start_date AND p.end_date

LEFT JOIN anycompany_lab.silver.marketing_campaigns_clean m
    ON LOWER(t.entity) = LOWER(m.product_category)
    AND t.region = m.region
    AND t.transaction_date BETWEEN m.start_date AND m.end_date;