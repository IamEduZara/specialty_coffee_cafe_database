-- This view is for employees who do not need access to full sales history but need to see daily sales (e.g., cashiers, baristas).
CREATE VIEW VW_TODAY_PURCHASES AS
SELECT *
FROM sales
WHERE DATE = CURRENT_DATE();

SELECT *
FROM VW_TODAY_PURCHASES;
-- This view us for providing easy access to information of active reservations with the customer details, useful for employees who do not need full access to customer details (e.g front-of-house stadd like hosts)
CREATE VIEW VW_ACTIVE_RESERVATIONS AS
SELECT r.reservationId, r.date, c.name, c.phone, c.email, t.typeDescription, ct.capacity
FROM reservations AS r
JOIN customers AS c ON r.customerId = c.customerId
JOIN reservation_types AS t ON r.reservationTypeId = t.reservatoniTypeId
JOIN c_tables AS ct ON r.tableId = ct.tableId
WHERE r.cancellation = FALSE
AND r.date >= CURRENT_DATE();

-- This view is for managing inventory by showing product detals, including the origin and supplier, for employees who require access to data regarding inventory (e.g purchasing manager, inventory clerk)
CREATE VIEW VW_PRODUCT_INVENTORY AS
SELECT p.productId, p.name, p.size, p.origin, s.name AS supplierName, s.phone, s.email, 
       CASE WHEN p.beansId IS NOT NULL THEN 'Coffee'
            WHEN p.teaId IS NOT NULL THEN 'Tea'
            ELSE 'Other' END AS productType,
       b.quantity AS stockQuantity, t.ingredients
FROM products p
LEFT JOIN beans b ON p.beansId = b.beansId
LEFT JOIN tea t ON p.teaId = t.teaId
LEFT JOIN suppliers s ON (b.beansId IS NOT NULL AND s.supplierId = (SELECT supplierId FROM transportation WHERE beansId = b.beansId))
                        OR (t.teaId IS NOT NULL AND s.supplierId = (SELECT supplierId FROM transportation WHERE teaId = t.teaId));

-- Function to calculate total sales for a specific day in MySQL
DELIMITER //
CREATE FUNCTION GetTotalSalesForDay(sales_date DATE)
RETURNS DECIMAL(10, 2)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE total_sales DECIMAL(10, 2);
    SELECT SUM(amount) INTO total_sales
    FROM sales 
    WHERE date = sales_date;
    RETURN total_sales;
END//
DELIMITER ;

-- Function to retrieve customer email by customer ID in MySQL
DELIMITER //
CREATE FUNCTION GetCustomerEmail(customer_id INT)
RETURNS VARCHAR(255)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE customer_email VARCHAR(255);
    SELECT email INTO customer_email
    FROM customers 
    WHERE customerId = customer_id;
    RETURN customer_email;
END//
DELIMITER ;

-- Function to check if a table is available on a specific date in MySQL
DELIMITER //
CREATE FUNCTION IsTableAvailable(table_id INT, check_date DATE)
RETURNS BOOLEAN
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE availability BOOLEAN DEFAULT FALSE;
    SELECT NOT EXISTS (
        SELECT 1 
        FROM reservations 
        WHERE tableId = table_id AND date = check_date AND cancellation = FALSE
    ) INTO availability;
    RETURN availability;
END//
DELIMITER ;

-- Procedure to add a new customer to the database in MySQL
DELIMITER //
CREATE PROCEDURE AddNewCustomer(IN customer_name VARCHAR(255), IN customer_phone VARCHAR(20), IN customer_email VARCHAR(255))
BEGIN
    INSERT INTO customers (name, phone, email) 
    VALUES (customer_name, customer_phone, customer_email);
END//
DELIMITER ;

-- Procedure to update the cancellation status of a reservation in MySQL
DELIMITER //
CREATE PROCEDURE UpdateReservationCancellation(IN reservation_id INT, IN new_status BOOLEAN)
BEGIN
    UPDATE reservations
    SET cancellation = new_status
    WHERE reservationId = reservation_id;
END//
DELIMITER ;

-- Procedure to update inventory when a new shipment arrives in MySQL
DELIMITER //
CREATE PROCEDURE RecordProductArrival(IN product_id INT, IN quantity_received DECIMAL(10, 2))
BEGIN
    UPDATE products
    SET quantity = quantity + quantity_received
    WHERE productId = product_id;
END//
DELIMITER ;
