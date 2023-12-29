-- AKASH SRIVASTAVA--

-- Assignment Name - ecommerce --



CREATE DATABASE e_com_assignment;
USE e_com_assignment;

--Cstomers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    description TEXT,
    stockQuantity INT
);

-- Cart Table
CREATE TABLE cart (
    cart_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10, 2),
    shipping_address VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);



-- Insert data into Products Table
INSERT INTO products (product_id, name, description, price, stockQuantity)
VALUES
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);


-- Insert data into Customers Table
INSERT INTO customers (customer_id, name, email, password)
VALUES
(1, 'John Doe', 'johndoe@example.com', 'password1'),
(2, 'Jane Smith', 'janesmith@example.com', 'password2'),
(3, 'Robert Johnson', 'robert@example.com', 'password3'),
(4, 'Sarah Brown', 'sarah@example.com', 'password4'),
(5, 'David Lee', 'david@example.com', 'password5'),
(6, 'Laura Hall', 'laura@example.com', 'password6'),
(7, 'Michael Davis', 'michael@example.com', 'password7'),
(8, 'Emma Wilson', 'emma@example.com', 'password8'),
(9, 'William Taylor', 'william@example.com', 'password9'),
(10, 'Olivia Adams', 'olivia@example.com', 'password10');


-- Insert data into Orders Table
INSERT INTO orders (order_id, customer_id, order_date, total_price, shipping_address)
VALUES
(1, 1, '2023-01-05', 1200.00, '123 Main St, City'),
(2, 2, '2023-02-10', 900.00, '456 Elm St, Town'),
(3, 3, '2023-03-15', 300.00, '789 Oak St, Village'),
(4, 4, '2023-04-20', 150.00, '101 Pine St, Suburb'),
(5, 5, '2023-05-25', 1800.00, '234 Cedar St, District'),
(6, 6, '2023-06-30', 400.00, '567 Birch St, County'),
(7, 7, '2023-07-05', 700.00, '890 Maple St, State'),
(8, 8, '2023-08-10', 160.00, '321 Redwood St, Country'),
(9, 9, '2023-09-15', 140.00, '432 Spruce St, Province'),
(10, 10, '2023-10-20', 1400.00, '765 Fir St, Territory');


-- Insert data into OrderItems Table
INSERT INTO order_items (order_item_id, order_id, product_id, quantity)
VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 5, 2),
(5, 4, 4, 4),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 5, 2, 2),
(9, 6, 10, 2),
(10, 6, 9, 3);


-- Insert data into Cart Table
INSERT INTO cart (cart_id, customer_id, product_id, quantity)
VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);



--1. Update refrigerator product price to 800:
UPDATE products
SET price = 800.00
WHERE product_id = (SELECT product_id FROM products WHERE name = 'Refrigerator');


--2. Remove all cart items for a specific customer:
DELETE FROM cart
WHERE customer_id = 5;


--3. Retrieve Products Priced Below $100:
SELECT * FROM products
WHERE price < 100.00;


--4. Find Products with Stock Quantity Greater Than 5:
SELECT * FROM products
WHERE stockQuantity > 5;


--5. Retrieve Orders with Total Amount Between $500 and $1000:
SELECT * FROM orders
WHERE total_price BETWEEN 500.00 AND 1000.00;


--6. Find Products which name ends with the letter ‘r’:
SELECT * FROM products
WHERE name LIKE '%r';


--7. Retrieve Cart Items for Customer 5:
SELECT * FROM cart
WHERE customer_id = 5;


--8. Find Customers Who Placed Orders in 2023:
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.order_date) = 2023;


--9. Determine the Minimum Stock Quantity for Each Product Category:
SELECT product_id, MIN(stockQuantity) as min_stock
FROM products
GROUP BY product_id;


--10. Calculate the Total Amount Spent by Each Customer:
SELECT c.customer_id, c.name, SUM(o.total_price) as total_amount_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;


--11. Find the Average Order Amount for Each Customer:
SELECT c.customer_id, c.name, AVG(o.total_price) as avg_order_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;


--12. Count the Number of Orders Placed by Each Customer:
SELECT c.customer_id, c.name, COUNT(o.order_id) as order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;


--13. Find the Maximum Order Amount for Each Customer:
SELECT c.name, MAX(o.total_price) as max_order_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;


--14. Get Customers Who Placed Orders Totaling Over $1000:
SELECT c.customer_id, c.name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_price > 1000.00;


--15. Subquery to Find Products Not in the Cart:
SELECT * FROM products
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM cart);


--16. Subquery to Find Customers Who Haven't Placed Orders:
SELECT * FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);


--17. Subquery to Calculate the Percentage of Total Revenue for a Product:
DECLARE @totalRevenue DECIMAL(10, 2);
SELECT @totalRevenue = SUM(oi.quantity * p.price)
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;


SELECT p.*, 
       (oi.quantity * p.price / @totalRevenue) * 100 AS revenue_percentage
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id;


--18. Subquery to Find Products with Low Stock:
SELECT * FROM products
WHERE stockQuantity < (SELECT AVG(stockQuantity) FROM products);


--19. Subquery to Find Customers Who Placed High-Value Orders:
SELECT DISTINCT c.customer_id, c.name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_price > 1000.00;
