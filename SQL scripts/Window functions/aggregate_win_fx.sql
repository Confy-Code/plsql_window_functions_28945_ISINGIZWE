-- Aggregate Window functions(SUM, AVG, MIN, MAX)

SELECT
    TRUNC(sale_date, 'MM') AS sale_month,
    SUM(total_amount) AS monthly_sales,
    
    -- Total accumulated revenue over months
    SUM(SUM(total_amount)) OVER (
        ORDER BY TRUNC(sale_date, 'MM')
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total,
    
    -- Average total revenue accumulated over months
    AVG(SUM(total_amount)) OVER (
        ORDER BY TRUNC(sale_date, 'MM')
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS avg_sales,
    
    --minimum and maximum revenue
    MIN(SUM(total_amount)) OVER () AS min_monthly_sales,
    MAX(SUM(total_amount)) OVER () AS max_monthly_sales
    
FROM sales
GROUP BY TRUNC(sale_date, 'MM');
