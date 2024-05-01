-- Creating the database
CREATE DATABASE IF NOT EXISTS management_sc_cafe
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Selecting the database
USE management_sc_cafe;

-- Table for customers
CREATE TABLE IF NOT EXISTS customers (
    customerId INT PRIMARY KEY,
    name VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255),
    salary DECIMAL(10, 2),
    medicalInsuranceNumber VARCHAR(255)
);

-- Table for c_tables
CREATE TABLE IF NOT EXISTS c_tables (
    tableId INT PRIMARY KEY,
    capacity INT,
    availability BOOLEAN
);

-- Table for employees
CREATE TABLE IF NOT EXISTS employees (
    employeeId INT PRIMARY KEY,
    name VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255),
    salary DECIMAL(10, 2),
    socialSecurityNumber VARCHAR(255),
    assignedShift VARCHAR(255)
);

-- Table for reservations
CREATE TABLE IF NOT EXISTS reservations (
    reservationId INT PRIMARY KEY,
    customerId INT,
    tableId INT,
    employeeId INT,
    reservationTypeId INT,
    date DATETIME,
    cancellation BOOLEAN,
    FOREIGN KEY (customerId) REFERENCES customers(customerId),
    FOREIGN KEY (tableId) REFERENCES c_tables(tableId),
    FOREIGN KEY (employeeId) REFERENCES employees(employeeId)
);

-- Table for reservation types
CREATE TABLE IF NOT EXISTS reservation_types (
    reservationTypeId INT PRIMARY KEY,
    reservationId INT,
    typeDescription VARCHAR(255),
    FOREIGN KEY (reservationId) REFERENCES reservations(reservationId)
);

-- Tables for beans and beans_profiles
CREATE TABLE IF NOT EXISTS beans (
    beansId INT PRIMARY KEY,
    process VARCHAR(255),
    region VARCHAR(255),
    farm VARCHAR(255),
    altitude INT,
    varietal VARCHAR(255),
    tastingScore DECIMAL(5, 2),
    roastingDate DATE,
    quantity DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS beans_profiles (
    beansId INT PRIMARY KEY,
    flavors VARCHAR(255),
    acidity VARCHAR(255),
    body VARCHAR(255),
    aftertaste VARCHAR(255),
    roast VARCHAR(255),
    FOREIGN KEY (beansId) REFERENCES beans(beansId)
);

-- Tables for tea and tea_profiles
CREATE TABLE IF NOT EXISTS tea (
    teaId INT PRIMARY KEY,
    type VARCHAR(255),
    region VARCHAR(255),
    ingredients VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS tea_profiles (
    teaId INT PRIMARY KEY,
    flavors VARCHAR(255),
    acidity VARCHAR(255),
    body VARCHAR(255),
    aftertaste VARCHAR(255),
    FOREIGN KEY (teaId) REFERENCES tea(teaId)
);

-- Table for products
CREATE TABLE IF NOT EXISTS products (
    productId INT PRIMARY KEY,
    name VARCHAR(255),
    size DECIMAL(10, 2),
    origin VARCHAR(255),
    beansId INT,
    teaId INT,
    FOREIGN KEY (beansId) REFERENCES beans(beansId),
    FOREIGN KEY (teaId) REFERENCES tea(teaId)
);

-- Table for transportation log
CREATE TABLE IF NOT EXISTS transportation (
    transportationId INT PRIMARY KEY,
    teaId INT,
    beansId INT,
    name VARCHAR(255),
    company VARCHAR(255),
    region VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255),
    FOREIGN KEY (teaId) REFERENCES tea(teaId),
    FOREIGN KEY (beansId) REFERENCES beans(beansId)
);

-- Table for suppliers
CREATE TABLE IF NOT EXISTS suppliers (
    supplierId INT PRIMARY KEY,
    name VARCHAR(255),
    product VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255)
);

-- Table for service logs
CREATE TABLE IF NOT EXISTS service_logs (
    equipmentId INT PRIMARY KEY,
    employeeId INT,
    supplierId INT,
    type VARCHAR(255),
    lastMaintenanceDate DATE,
    nextMaintenanceDate DATE,
    maintenanceFrequency INT,
    FOREIGN KEY (employeeId) REFERENCES employees(employeeId),
    FOREIGN KEY (supplierId) REFERENCES suppliers(supplierId)
);

-- Table for sales
CREATE TABLE IF NOT EXISTS sales (
    saleId INT PRIMARY KEY,
    customerId INT,
    productId INT,
    beansId INT,
    teaId INT,
    reservationId INT,
    date DATE,
    concept VARCHAR(255),
    amount DECIMAL(10, 2),
    FOREIGN KEY (customerId) REFERENCES customers(customerId),
    FOREIGN KEY (productId) REFERENCES products(productId),
    FOREIGN KEY (beansId) REFERENCES beans(beansId),
    FOREIGN KEY (teaId) REFERENCES tea(teaId),
    FOREIGN KEY (reservationId) REFERENCES reservations(reservationId)
);

-- Table for costs
CREATE TABLE IF NOT EXISTS costs (
    costId INT PRIMARY KEY,
    supplierId INT,
    date DATE,
    concept VARCHAR(255),
    amount DECIMAL(10, 2),
    FOREIGN KEY (supplierId) REFERENCES suppliers(supplierId)
);

-- Table for expenses
CREATE TABLE IF NOT EXISTS expenses (
    expenseId INT PRIMARY KEY,
    supplierId INT,
    date DATE,
    concept VARCHAR(255),
    amount DECIMAL(10, 2),
    FOREIGN KEY(supplierId) REFERENCES suppliers(supplierId)
);
