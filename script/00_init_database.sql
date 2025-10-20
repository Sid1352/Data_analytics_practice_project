/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'datawarehouseanalytics' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, this script creates a schema called gold.
	
WARNING:
    Running this script will drop the entire 'datawarehouseanalytics' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
=============================================================
*/

-- Connect to default 'postgres' database
\c postgres;

-- Drop and recreate the 'datawarehouseanalytics' database
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_database WHERE datname = 'datawarehouseanalytics') THEN
        PERFORM pg_terminate_backend(pid)
        FROM pg_stat_activity
        WHERE datname = 'datawarehouseanalytics';
        EXECUTE 'DROP DATABASE datawarehouseanalytics';
    END IF;
END $$;

CREATE DATABASE datawarehouseanalytics;

-- Connect to the new database
\c datawarehouseanalytics;

-- Create schema
CREATE SCHEMA IF NOT EXISTS gold;

-- =============================================================
-- Create Tables
-- =============================================================

CREATE TABLE gold.dim_customers(
	customer_key     INT,
	customer_id      INT,
	customer_number  VARCHAR(50),
	first_name       VARCHAR(50),
	last_name        VARCHAR(50),
	country          VARCHAR(50),
	marital_status   VARCHAR(50),
	gender           VARCHAR(50),
	birthdate        DATE,
	create_date      DATE
);

CREATE TABLE gold.dim_products(
	product_key     INT,
	product_id      INT,
	product_number  VARCHAR(50),
	product_name    VARCHAR(50),
	category_id     VARCHAR(50),
	category        VARCHAR(50),
	subcategory     VARCHAR(50),
	maintenance     VARCHAR(50),
	cost            INT,
	product_line    VARCHAR(50),
	start_date      DATE
);

CREATE TABLE gold.fact_sales(
	order_number   VARCHAR(50),
	product_key    INT,
	customer_key   INT,
	order_date     DATE,
	shipping_date  DATE,
	due_date       DATE,
	sales_amount   INT,
	quantity       SMALLINT,
	price          INT
);

-- =============================================================
-- Load Data from CSV Files
-- =============================================================

-- Empty tables before loading data
TRUNCATE TABLE gold.dim_customers;
TRUNCATE TABLE gold.dim_products;
TRUNCATE TABLE gold.fact_sales;

-- Import CSV data (ensure paths are accessible to PostgreSQL server)
\copy gold.dim_customers FROM 'C:/sql/sql-data-analytics-project/datasets/csv-files/gold.dim_customers.csv' DELIMITER ',' CSV HEADER;
\copy gold.dim_products  FROM 'C:/sql/sql-data-analytics-project/datasets/csv-files/gold.dim_products.csv'  DELIMITER ',' CSV HEADER;
\copy gold.fact_sales    FROM 'C:/sql/sql-data-analytics-project/datasets/csv-files/gold.fact_sales.csv'    DELIMITER ',' CSV HEADER;

