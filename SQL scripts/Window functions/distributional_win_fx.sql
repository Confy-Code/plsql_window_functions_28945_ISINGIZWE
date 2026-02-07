--distribution window functions(NTILE, SUME_DIST)

SELECT
    c.customer_name,
    SUM(s.total_amount) AS total_spent,

    --Quartiles generation

    NTILE(4) OVER (
        ORDER BY SUM(s.total_amount) DESC
    ) AS spending_quartile,

    --cumulative distribution up to 1

    CUME_DIST() OVER (
        ORDER BY SUM(s.total_amount) DESC
    ) AS cumulative_distribution

FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_name;

