-- Question 1 Achieving 1NF (First Normal Form) 🛠️
USE sales_database;

-- ProductDetail Table
CREATE TABLE productdetail(
orderID INT PRIMARY KEY AUTO_INCREMENT,
customername VARCHAR(100),
products VARCHAR(100)
);

-- Test Data
INSERT INTO productdetail(customername, products)
VALUES
("John Doe", "Laptop, Mouse"),
("Jane Smith", "Tablet, Keyboard, Mouse"),
("Emily Clark", "Phone");

-- Set Auto_Increment to start at 101
ALTER TABLE productdetail
AUTO_INCREMENT = 101;

-- Retrieve Table productdetail
SELECT * FROM productdetail;

-- Deleting Products Column from the Table
ALTER TABLE productdetail
DROP COLUMN products;

-- Create Products Table
CREATE TABLE products(
productid INT PRIMARY KEY AUTO_INCREMENT,
productname VARCHAR(100),
order_id INT,
FOREIGN KEY(order_id) REFERENCES productdetail(orderID)
);

-- Insert Data into Products table
INSERT INTO products(productname, order_id)
VALUES
("Laptop", 101),
("Mouse", 101),
("Tablet", 102),
("Keyboard", 102),
("Mouse", 102),
("Phone", 103);

-- Retrieve Data from Produccts table
SELECT * FROM products;




-- Question 2 Achieving 2NF (Second Normal Form)
USE productsalesdb;

-- Create Order Details Table
CREATE TABLE OrderDetails(
OrderID INT,
CustomerName VARCHAR(100),
Product VARCHAR(100),
Quantity INT
);

-- Insert Data in Table OrderDetails
INSERT INTO OrderDetails(OrderID, CustomerName, Product, Quantity)
VALUES
(101, "John Doe", "Laptop", 2),
(101, "John Doe", "Mouse", 1),
(102, "Jane Smith", "Tablet", 3),
(102, "Jane Smith", "Keyboard", 1),
(102, "Jane Smith", "Mouse", 2),
(103, "Emily Clark", "Phone", 1);

-- Retrieve OrderDetails Table
SELECT * FROM OrderDetails;

-- Create Orders Table from the given Table
CREATE TABLE orders(
OrderID INT PRIMARY KEY,
CustomerName VARCHAR(100)
);

-- Populate Orders table
INSERT INTO orders(OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Retrieve Table Orders
SELECT * FROM orders;

-- Create Table of Products Ordered
CREATE TABLE productsOrdered(
order_id INT,
Product VARCHAR(100),
Quantity INT,
PRIMARY KEY (order_id, Product),
FOREIGN KEY(order_id) REFERENCES orders(OrderID)
);

-- Populate Products Ordered Table From OrderDetails
INSERT INTO productsOrdered(order_id, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Retrieve Table productsOrdered
SELECT * FROM productsOrdered;

-- Retrieving Orders For ID 102 ONLY
SELECT orders.OrderID, productsOrdered.Product, productsOrdered.Quantity
FROM Orders
JOIN productsOrdered ON orders.OrderID = productsOrdered.order_id
WHERE orders.OrderID = 102;