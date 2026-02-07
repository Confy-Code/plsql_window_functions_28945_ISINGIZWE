-- INNER JOIN (exisiting transactions)

SELECT
    s.sale_id,
    c.customer_name,
    p.product_name,
    r.region_name,
    s.sale_date,
    s.total_amount
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
INNER JOIN regions r ON s.region_id = r.region_id;

-- LEFT JOIN (inactive customers)

SELECT
    c.customer_name,
    r.region_name
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
LEFT JOIN regions r ON c.region_id = r.region_id
WHERE s.sale_id IS NULL;

-- RIGHT JOIN (unpurchased products)
SELECT
    p.product_name,
    s.sale_id
FROM sales s
RIGHT JOIN products p ON s.product_id = p.product_id
WHERE s.sale_id IS NULL;

-- FULL OUTER JOIN(Left + right join)
SELECT
    c.customer_name,
    p.product_name,
    s.sale_id
FROM customers c
FULL OUTER JOIN sales s ON c.customer_id = s.customer_id
FULL OUTER JOIN products p ON s.product_id = p.product_id;


-- SELF JOIN (Customers of the same region)
SELECT
    c1.customer_name AS customer_1,
    c2.customer_name AS customer_2,
    c1.region_id
FROM customers c1
JOIN customers c2
    ON c1.region_id = c2.region_id
   AND c1.customer_id < c2.customer_id;















