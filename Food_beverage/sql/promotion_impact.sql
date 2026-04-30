-- Analyse impact des promotions

SELECT
    product_category,
    
    AVG(CASE WHEN is_promo_active = 1 THEN amount END) AS avg_sales_promo,
    AVG(CASE WHEN is_promo_active = 0 THEN amount END) AS avg_sales_no_promo,

    COUNT(CASE WHEN is_promo_active = 1 THEN 1 END) AS promo_transactions,
    COUNT(CASE WHEN is_promo_active = 0 THEN 1 END) AS non_promo_transactions

FROM anycompany_lab.analytics.fact_sales_enriched
GROUP BY product_category
ORDER BY avg_sales_promo DESC;