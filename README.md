# Entreprise Urwibutso Industries – Sales Data Analysis
#### Author : ISINGIZWE Jean Confiance
#### ID : 28945
#### Institution : Adventist University of Central Africa(AUCA)

## 1. Business Problem
Entreprise Urwibutso Industries produces multiple food and beverage products, including AKANDI, AKARABO, URWIBUTSO, AGASHYA, AKABANGA, and AKARUSHO, sold across multiple regions in Rwanda.  

The company lacks detailed insights into:
- Which products perform best in which regions
- Customer purchasing behavior
- Sales trends and month-to-month growth
- Underperforming products or inactive customers

**Objective:**  
Analyze sales data to identify top-performing products, monitor trends, segment customers, and generate actionable insights to support marketing, inventory, and sales strategies.

---

## 2. Schema and ER Diagram

### Tables
- **Products:** `product_id`, `product_name`, `category`  
- **Customers:** `customer_id`, `customer_name`, `region_id`  
- **Regions:** `region_id`, `region_name`  
- **Sales:** `sale_id`, `product_id`, `customer_id`, `region_id`, `sale_date`, `quantity`, `total_amount`

The tables and their respective data are showcased in the folder of `Screenshots/Database Schema`

### ER Diagram

![E-R 3](https://github.com/user-attachments/assets/7b7a71c2-3d2d-409b-904a-86c72658c6d6)



---
## 3. JOIN Queries

### 3.1 INNER JOIN:
This retrives only valid transactions. Valid transactions are those transactions whose
consumer(s) and sale price are clearly shown.

    SELECT s.sale_id, c.customer_name, p.product_name, r.region_name, s.sale_date, s.total_amount
    FROM sales s
    INNER JOIN customers c ON s.customer_id = c.customer_id
    INNER JOIN products p ON s.product_id = p.product_id
    INNER JOIN regions r ON s.region_id = r.region_id;

<img width="1199" height="393" alt="Inner join" src="https://github.com/user-attachments/assets/c02ddac0-96bc-463c-83e8-ecd383bd4a17" />


### 3.2 LEFT JOIN 
In our case, this retrieved the customers who didn't buy anything(inactive customers). Here we assume that these customers bought
our products in a certain period of time BEFORE the recording of these transactions. They don't buy for us anymore

    SELECT c.customer_name, r.region_name
    FROM customers c
    LEFT JOIN sales s ON c.customer_id = s.customer_id
    LEFT JOIN regions r ON c.region_id = r.region_id
    WHERE s.sale_id IS NULL;


<img width="551" height="167" alt="Left join" src="https://github.com/user-attachments/assets/33498487-e89f-4eda-a63c-f654ac3cfe78" />

## 3.3 RIGHT JOIN 
In our case, this join worked for us to retrieve those products which were not sold at all. The products were there, 
but received no appreciation because of many factors that can be related to region  they are being sold in or their sale prices.

    SELECT p.product_name, s.sale_id
    FROM sales s
    RIGHT JOIN products p ON s.product_id = p.product_id
    WHERE s.sale_id IS NULL;

<img width="536" height="128" alt="Right join" src="https://github.com/user-attachments/assets/e6494a8e-44e7-4138-b200-7e944081d5c1" />


## 3.4 FULL OUTER JOIN
This is like the union of both Left and Right joins. It showcases both of these two cases: Products which were
not sold and customers who do not buy for us anymore(inactive customers).

    SELECT c.customer_name, p.product_name, s.sale_id
    FROM customers c
    FULL OUTER JOIN sales s ON c.customer_id = s.customer_id
    FULL OUTER JOIN products p ON s.product_id = p.product_id;


<img width="665" height="415" alt="Full outer join" src="https://github.com/user-attachments/assets/d3615c06-cb58-46e1-a3ce-817c15ec192a" />

## 3.5 SELF JOIN 
In our case, this showed those customers who are competing for the product in the same region. This competition-analysis helps
us to identify a region the business should focus on to supply many of its products.

    SELECT c1.customer_name AS customer_1, c2.customer_name AS customer_2, c1.region_id
    FROM customers c1
    JOIN customers c2
        ON c1.region_id = c2.region_id
       AND c1.customer_id < c2.customer_id;

<img width="588" height="153" alt="Self join" src="https://github.com/user-attachments/assets/ccd76d14-fe94-4798-a3d5-b28f6afeb6e9" />

---

## 4. Window Function Queries
### 4.1 Ranking Functions
These functions help us to inspect customers who generates high income for the business

    SELECT c.customer_name,
           SUM(s.total_amount) AS total_revenue,
           ROW_NUMBER() OVER (ORDER BY SUM(s.total_amount) DESC) AS row_num,
           RANK() OVER (ORDER BY SUM(s.total_amount) DESC) AS rank_val,
           DENSE_RANK() OVER (ORDER BY SUM(s.total_amount) DESC) AS dense_rank_val,
           PERCENT_RANK() OVER (ORDER BY SUM(s.total_amount) DESC) AS percent_rank
    FROM sales s
    JOIN customers c ON s.customer_id = c.customer_id
    GROUP BY c.customer_name;


<img width="1281" height="288" alt="Rank functions" src="https://github.com/user-attachments/assets/2e2aec8b-ab94-466c-abfa-b59140ca2e9f" />


### 4.2 Aggregate Functions
These functions help us to highlight different trends across periods of time. In our case, we used monthly periods.


    SELECT
        DATE_TRUNC('month', sale_date) AS sale_month,
        SUM(total_amount) AS monthly_sales,
        
        SUM(SUM(total_amount)) OVER (
            ORDER BY DATE_TRUNC('month', sale_date)
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_total,
    
        AVG(SUM(total_amount)) OVER (
            ORDER BY DATE_TRUNC('month', sale_date)
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS avg_sales,
    
        MIN(SUM(total_amount)) OVER () AS min_monthly_sales,
        MAX(SUM(total_amount)) OVER () AS max_monthly_sales
    FROM sales
    GROUP BY DATE_TRUNC('month', sale_date);


<img width="1348" height="205" alt="Aggregate window functions" src="https://github.com/user-attachments/assets/3befedcd-fa48-40bc-bc75-3a9313ce3e06" />

### 4.3 Navigation window functions
Functions such as LAG() and LEAD() manifests the month to month growth in revenues.

    SELECT
        DATE_TRUNC('month', sale_date) AS sale_month,
        SUM(total_amount) AS monthly_sales,
        
        LAG(SUM(total_amount)) OVER (
            ORDER BY DATE_TRUNC('month', sale_date)
        ) AS previous_month_sales,
    
        LEAD(SUM(total_amount)) OVER (
            ORDER BY DATE_TRUNC('month', sale_date)
        ) AS next_month_sales
    FROM sales
    GROUP BY DATE_TRUNC('month', sale_date);

<img width="1026" height="193" alt="Navigation window functions" src="https://github.com/user-attachments/assets/714bf1b6-9c52-412c-a0aa-4e929161de28" />


### 4.4 Distribution functions
Customers of the business in our case were divided into four quartiles, meaning depending on their level of spending.
4 classes are:
* 1 - High-level spenders
* 2 - High mid-level spenders
* 3 - Low mid-level spenders
* 4 - Low-level spenders
  

        SELECT
            c.customer_name,
            SUM(s.total_amount) AS total_spent,
        
            NTILE(4) OVER (
                ORDER BY SUM(s.total_amount) DESC
            ) AS spending_quartile,
        
            CUME_DIST() OVER (
                ORDER BY SUM(s.total_amount) DESC
            ) AS cumulative_distribution
        FROM sales s
        JOIN customers c ON s.customer_id = c.customer_id
        GROUP BY c.customer_name;

<img width="1146" height="266" alt="Distribution window functions" src="https://github.com/user-attachments/assets/432817aa-bb87-483d-b27c-0eca561c0940" />

---

### 5. Key Insights
#### 5.1 Descriptive — What happened?

* Top products and top customers identified by region.
* Monthly sales fluctuate with visible trends.
* Some products had no sales; some customers were inactive.

**5.2 Diagnostic — Why did it happen?**

* Regional preferences and product popularity explain top-selling items.
* Low or no sales for certain products suggest insufficient marketing or limited distribution.

**5.3 Prescriptive — What should be done next?**

* Target inactive customers with promotions.
* Focus marketing on underperforming products.
* Monitor monthly trends using running totals and moving averages for planning.
* Segment high-value customers for loyalty programs.

### References

- MySQL 8.0 Official Documentation – `https://dev.mysql.com/doc/`
- PostgreSQL Window Functions Tutorial – `https://www.postgresql.org/docs/current/tutorial-window.html`
- Oracle SQL Window Functions Guide – `Oracle Docs`
- Business Analytics with SQL – `FreeCode Camp`
- Google's `Gemini AI`
- Lecturer Eric M.'s Notes

---
All sources were properly cited. Implementation and analysis represent original work. No AI-generated content
was copied without attribution or adaption




    
    
    
        
