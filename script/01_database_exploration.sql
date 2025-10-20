/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Tables Used:
    - information_schema.tables
    - information_schema.columns
===============================================================================
*/

-- Retrieve a list of all tables in the current database
SELECT 
    table_catalog, 
    table_schema, 
    table_name, 
    table_type
FROM information_schema.tables
ORDER BY table_schema, table_name;

-- Retrieve all columns for a specific table (gold.dim_customers)
SELECT 
    column_name, 
    data_type, 
    is_nullable, 
    character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'gold'
  AND table_name = 'dim_customers';

