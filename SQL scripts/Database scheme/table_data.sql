-- Insert into products

INSERT ALL 

 INTO products VALUES(1, 'AKANDI', 'Food')
 INTO products VALUES(2, 'AKARABO', 'Beverage')
 INTO products VALUES(3, 'URWIBUTSO', 'Juice')
 INTO products VALUES(4, 'AGASHYA', 'Snack')
 INTO products VALUES(5, 'AKABANGA', 'Chili')
 INTO products VALUES(6, 'AKARUSHO', 'Flour')

SELECT * FROM dual;

-- Insert into regions

INSERT ALL 

 INTO regions VALUES(1, 'Kigali')
 INTO regions VALUES(2, 'Southern')
 INTO regions VALUES(3, 'Northern')
 INTO regions VALUES(4, 'Eastern')
 INTO regions VALUES(5, 'Western')

SELECT * FROM dual;

-- Insert into customers

INSERT ALL 

 INTO customers VALUES(1, 'Alpha Supermarket', 1)
 INTO customers VALUES(2, 'Beta Shop', 2)
 INTO customers VALUES(3, 'Gamma Traders', 3)
 INTO customers VALUES(4, 'Delta Stores', 4)
 INTO customers VALUES(5, 'Epsilon Market', 5)


SELECT * FROM dual;

-- Insert into sales

INSERT ALL 

 INTO sales VALUES(1, 1, 1, 1, TO_DATE('2025-01-15','YYYY-MM-DD'), 50, 250000)
 INTO sales VALUES(2, 2, 2, 2, TO_DATE('2025-01-18','YYYY-MM-DD'), 40, 200000)
 INTO sales VALUES(3, 3, 3, 3, TO_DATE('2025-02-10', 'YYYY-MM-DD'), 60, 360000)
 INTO sales VALUES(4, 4, 4, 4, TO_DATE('2025-02-15', 'YYYY-MM-DD'), 30, 150000)
 INTO sales VALUES(5, 5, 5, 5, TO_DATE('2025-03-05', 'YYYY-MM-DD'), 20, 180000)
 INTO sales VALUES(6, 1, 1, 1, TO_DATE('2025-02-20', 'YYYY-MM-DD'), 70, 350000)
 INTO sales VALUES(7, 2, 2, 2, TO_DATE('2025-03-12', 'YYYY-MM-DD'), 50, 250000)
 INTO sales VALUES(8, 3, 3, 3, TO_DATE('2025-03-18', 'YYYY-MM-DD'), 80, 480000)



SELECT * FROM dual;