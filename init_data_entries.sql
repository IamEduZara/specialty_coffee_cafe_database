-- Inserting sample data into 'customers'
INSERT INTO customers (customerId, name, phone, email, salary, medicalInsuranceNumber)
VALUES
(1, 'John Doe', '123-456-7890', 'john.doe@example.com', 50000.00, '1234567890'),
(2, 'Jane Smith', '987-654-3210', 'jane.smith@example.com', 52000.00, '9876543211'),
(3, 'Alice Brown', '555-666-7777', 'alice.brown@example.com', 53000.00, '9876543212');

-- Inserting sample data into 'c_tables'
INSERT INTO c_tables (tableId, capacity, availability)
VALUES
(1, 4, TRUE),
(2, 2, TRUE),
(3, 6, FALSE);

-- Inserting sample data into 'employees'
INSERT INTO employees (employeeId, name, phone, email, salary, socialSecurityNumber, assignedShift)
VALUES
(1, 'Alice Johnson', '111-222-3333', 'alice.j@example.com', 30000.00, 'SSN123', 'Morning'),
(2, 'Bob Brown', '444-555-6666', 'bob.b@example.com', 32000.00, 'SSN456', 'Evening'),
(3, 'Charlie Green', '777-888-9999', 'charlie.g@example.com', 35000.00, 'SSN789', 'Night');

-- Inserting sample data into 'beans'
INSERT INTO beans (beansId, process, region, farm, altitude, varietal, tastingScore, roastingDate, quantity)
VALUES
(1, 'Washed', 'Latin America', 'Farm1', 1200, 'Arabica', 85.5, '2022-01-15', 100.00),
(2, 'Natural', 'Africa', 'Farm2', 1300, 'Robusta', 80.0, '2022-02-20', 150.00),
(3, 'Honey', 'Asia', 'Farm3', 1400, 'Liberica', 82.5, '2022-03-25', 120.00);

-- Inserting sample data into 'beans_profiles'
INSERT INTO beans_profiles (beansId, flavors, acidity, body, aftertaste, roast)
VALUES
(1, 'Chocolate, Caramel', 'Medium', 'Full', 'Long', 'Medium-Dark'),
(2, 'Fruity, Berry', 'High', 'Medium', 'Short', 'Light'),
(3, 'Floral, Herbal', 'Low', 'Heavy', 'Medium', 'Dark');

-- Inserting sample data into 'tea'
INSERT INTO tea (teaId, type, region, ingredients)
VALUES
(1, 'Green Tea', 'China', 'Green tea leaves'),
(2, 'Black Tea', 'India', 'Black tea leaves, bergamot essence'),
(3, 'Herbal Tea', 'Egypt', 'Chamomile, mint leaves');

-- Inserting sample data into 'tea_profiles'
INSERT INTO tea_profiles (teaId, flavors, acidity, body, aftertaste)
VALUES
(1, 'Fresh, Floral', 'Low', 'Light', 'Refreshing'),
(2, 'Bold, Citrus', 'High', 'Full', 'Lingering'),
(3, 'Mild, Soothing', 'None', 'Light', 'Gentle');

-- Inserting sample data into 'reservations'
INSERT INTO reservations (reservationId, customerId, tableId, employeeId, reservationTypeId, date, cancellation)
VALUES
(1, 1, 1, 1, 1, '2023-05-10 19:00:00', FALSE),
(2, 2, 2, 2, 2, '2023-05-11 19:00:00', FALSE),
(3, 3, 3, 3, 3, '2023-05-12 19:00:00', TRUE);

-- Inserting sample data into 'reservation_types'
INSERT INTO reservation_types (reservationTypeId, reservationId, typeDescription)
VALUES
(1, 1, 'Dinner'),
(2, 2, 'Lunch'),
(3, 3, 'Breakfast');

-- Inserting sample data into 'transportation'
INSERT INTO transportation (transportationId, teaId, beansId, name, company, region, phone, email)
VALUES
(1, 1, NULL, 'Tea Import', 'TeaCo', 'East Region', '777-888-9999', 'contact@teaco.com'),
(2, NULL, 1, 'Beans Import', 'CoffeeCo', 'South Region', '888-999-1111', 'beans@coffeeco.com'),
(3, 2, NULL, 'Herbal Tea Import', 'HerbalCo', 'North Region', '999-111-2222', 'herbal@herbalco.com');

-- Inserting sample data into 'suppliers'
INSERT INTO suppliers (supplierId, name, product, phone, email)
VALUES
(1, 'BeanSupplier', 'Coffee Beans', '999-888-7777', 'info@beansupplier.com'),
(2, 'TeaSupplier', 'Tea Leaves', '666-555-4444', 'contact@teasupplier.com'),
(3, 'HerbalSupplier', 'Herbal Mixes', '555-444-3333', 'info@herbalsupplier.com');

-- Inserting sample data into 'service_logs'
INSERT INTO service_logs (equipmentId, employeeId, supplierId, type, lastMaintenanceDate, nextMaintenanceDate, maintenanceFrequency)
VALUES
(1, 1, 1, 'Coffee Machine', '2023-04-01', '2023-06-01', 60),
(2, 2, 2, 'Tea Brewer', '2023-04-15', '2023-06-15', 30),
(3, 3, 3, 'Herbal Infuser', '2023-05-01', '2023-07-01', 90);

-- Inserting sample data into 'products'
INSERT INTO products (productId, name, size, origin, beansId, teaId)
VALUES
(1, 'Premium Arabica Coffee', 500.00, 'Latin America', 1, NULL),
(2, 'Exquisite Black Tea', 300.00, 'India', NULL, 2),
(3, 'Refreshing Herbal Tea', 250.00, 'Egypt', NULL, 3);

-- Inserting sample data into 'sales'
INSERT INTO sales (saleId, customerId, productId, beansId, teaId, reservationId, date, concept, amount)
VALUES
(1, 1, 1, 1, NULL, 1, '2023-05-10', 'Coffee Sale', 15.75),
(2, 2, 2, NULL, 2, 2, '2023-05-11', 'Tea Sale', 12.00),
(3, 3, 3, NULL, 3, 3, '2023-05-12', 'Herbal Tea Sale', 9.50);

-- Inserting sample data into 'costs'
INSERT INTO costs (costId, supplierId, date, concept, amount)
VALUES
(1, 1, '2023-05-01', 'Beans Purchase', 500.00),
(2, 2, '2023-05-02', 'Tea Purchase', 400.00),
(3, 3, '2023-05-03', 'Herbals Purchase', 300.00);

-- Inserting sample data into 'expenses'
INSERT INTO expenses (expenseId, supplierId, date, concept, amount)
VALUES
(1, 1, '2023-04-15', 'Equipment Maintenance', 200.00),
(2, 2, '2023-04-16', 'Tea Equipment Upgrade', 300.00),
(3, 3, '2023-04-17', 'Herbal Supplies Restock', 150.00);
