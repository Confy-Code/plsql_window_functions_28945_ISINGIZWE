-- Navigation window functions

SELECT
    TRUNC(sale_date, 'MM') AS sale_month,
    SUM(total_amount) AS monthly_sales,

    -- total revenue for past month
    LAG(SUM(total_amount)) OVER (
        ORDER BY TRUNC(sale_date, 'MM')
    ) AS previous_month_sales,
    
    -- total revenue for next month
    LEAD(SUM(total_amount)) OVER (
        ORDER BY TRUNC(sale_date, 'MM')
    ) AS next_month_sales

FROM sales
GROUP BY TRUNC(sale_date, 'MM');
