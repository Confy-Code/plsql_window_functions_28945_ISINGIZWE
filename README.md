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
