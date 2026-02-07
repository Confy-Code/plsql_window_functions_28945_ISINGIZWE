-- RANK FUNCTIONS (ROW_NUMBER, RANK, DENSE_RANK, PERCENT_RANK)
SELECT
    c.customer_name,
    SUM(s.total_amount) AS total_revenue,

    ROW_NUMBER() OVER (
        ORDER BY SUM(s.total_amount) DESC
    ) AS row_num,

    RANK() OVER (
        ORDER BY SUM(s.total_amount) DESC
    ) AS rank_value,

    DENSE_RANK() OVER (
        ORDER BY SUM(s.total_amount) DESC
    ) AS dense_rank_value,

    PERCENT_RANK() OVER (
        ORDER BY SUM(s.total_amount) DESC
    ) AS percent_rank

FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_name;






