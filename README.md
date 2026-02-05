# Entreprise Urwibutso Industries – Sales Data Analysis

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

### ER Diagram

## 3. JOIN Queries

### 3.1 INNER JOIN – Retrieve valid transactions
`
SELECT s.sale_id, c.customer_name, p.product_name, r.region_name, s.sale_date, s.total_amount
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
INNER JOIN regions r ON s.region_id = r.region_id;
`


