CREATE DATABASE freshbasket_dbg;
USE freshbasket_dbg;
SELECT * FROM freshbasket_inventory_messy;

UPDATE freshbasket_inventory_messy
SET
  units_sold = NULLIF(TRIM(units_sold), ''),     -- If cell is just spaces or empty string, becomes NULL
  unit_price = NULLIF(TRIM(unit_price), ''),
  waste_units = NULLIF(TRIM(waste_units), ''),
  product_name = NULLIF(TRIM(product_name), ''),
  supplier = NULLIF(TRIM(supplier), ''),
  category = NULLIF(TRIM(category), '');
  
  SELECT * FROM freshbasket_inventory_messy;
  UPDATE freshbasket_inventory_messy
SET unit_price = REPLACE(unit_price, '$', '');

ALTER TABLE freshbasket_inventory_messy MODIFY COLUMN unit_price DECIMAL(10,2);
  SELECT * FROM freshbasket_inventory_messy;
  
  UPDATE freshbasket_inventory_messy
SET date = STR_TO_DATE(date, '%m/%d/%Y')
WHERE date IS NOT NULL;

SELECT DISTINCT delivery_date FROM freshbasket_inventory_messy LIMIT 10;
ALTER TABLE freshbasket_inventory_messy ADD COLUMN delivery_date_clean DATE;

UPDATE freshbasket_inventory_messy
SET delivery_date_clean = STR_TO_DATE(delivery_date, '%m/%d/%Y')
WHERE delivery_date REGEXP '^[0-1][0-9]/[0-3][0-9]/[0-9]{4}$';

UPDATE freshbasket_inventory_messy
SET delivery_date_clean = STR_TO_DATE(delivery_date, '%d-%m-%Y')
WHERE delivery_date REGEXP '^[0-3][0-9]-[0-1][0-9]-[0-9]{4}$';

UPDATE freshbasket_inventory_messy
SET delivery_date_clean = STR_TO_DATE(delivery_date, '%Y/%m/%d')
WHERE delivery_date REGEXP '^[0-9]{4}/[0-1][0-9]/[0-3][0-9]$';

UPDATE freshbasket_inventory_messy
SET delivery_date_clean = STR_TO_DATE(delivery_date, '%m-%d-%Y')
WHERE delivery_date REGEXP '^[0-1][0-9]-[0-3][0-9]-[0-9]{4}$';

SELECT delivery_date, delivery_date_clean
FROM freshbasket_inventory_messy
ORDER BY delivery_date_clean;

UPDATE freshbasket_inventory_messy
SET delivery_date_clean = STR_TO_DATE(delivery_date, '%Y-%m-%d')
WHERE delivery_date REGEXP '^[0-9]{4}-[0-1][0-9]-[0-3][0-9]$';


UPDATE freshbasket_inventory_messy
SET delivery_date_clean = STR_TO_DATE(delivery_date, '%Y-%m-%d')
WHERE delivery_date REGEXP '^[0-1][0-9]-[0-3][0-9]-[0-9]{4}$';

SELECT delivery_date, delivery_date_clean
FROM freshbasket_inventory_messy
ORDER BY delivery_date_clean;

ALTER TABLE freshbasket_inventory_messy
DROP COLUMN delivery_date;

ALTER TABLE freshbasket_inventory_messy
CHANGE delivery_date_clean delivery_date DATE;

SELECT * FROM freshbasket_inventory_messy;

UPDATE freshbasket_inventory_messy
SET category = CONCAT(UCASE(LEFT(category, 1)), LCASE(SUBSTRING(category, 2)));

SELECT * FROM freshbasket_inventory_messy;

SELECT * FROM freshbasket_inventory_messy WHERE units_sold < 0;

UPDATE freshbasket_inventory_messy SET units_sold = NULL WHERE units_sold < 0;

SELECT * FROM freshbasket_inventory_messy WHERE units_sold = NULL;

SELECT * FROM freshbasket_inventory_messy;

UPDATE freshbasket_inventory_messy
SET product_name = TRIM(product_name);

UPDATE freshbasket_inventory_messy
SET product_name = LOWER(product_name);

SELECT * FROM freshbasket_inventory_messy;

UPDATE freshbasket_inventory_messy
SET product_name = REPLACE(product_name, '(', '');
UPDATE freshbasket_inventory_messy
SET product_name = REPLACE(product_name, ')', '');

UPDATE freshbasket_inventory_messy
SET product_name = 'unknown'
WHERE product_name IS NULL OR TRIM(product_name) = '';

UPDATE freshbasket_inventory_messy
SET product_name = 'tomatoes'
WHERE product_name IN ('tomato', 'toms', 'tomatoes');

SELECT * FROM freshbasket_inventory_messy;

SELECT DISTINCT Product_Name FROM freshbasket_inventory_messy LIMIT 20;

UPDATE freshbasket_inventory_messy
SET product_name = 'tomatoes'
WHERE product_name LIKE 'tom%';

SELECT DISTINCT Product_Name FROM freshbasket_inventory_messy LIMIT 20;

UPDATE freshbasket_inventory_messy
SET product_name = 'bread-white'
WHERE product_name LIKE 'br%';

SELECT DISTINCT Product_Name FROM freshbasket_inventory_messy LIMIT 20;

UPDATE freshbasket_inventory_messy
SET product_name = 'eggs dozen'
WHERE product_name LIKE 'eggs%';

SELECT DISTINCT Product_Name FROM freshbasket_inventory_messy LIMIT 20;

UPDATE freshbasket_inventory_messy
SET product_name = 'chicken breast'
WHERE product_name LIKE 'chick%';

SELECT DISTINCT Product_Name FROM freshbasket_inventory_messy LIMIT 20;

UPDATE freshbasket_inventory_messy
SET product_name = 'lettuce'
WHERE product_name LIKE 'l%';

SELECT DISTINCT Product_Name FROM freshbasket_inventory_messy LIMIT 20;

UPDATE freshbasket_inventory_messy
SET product_name = 'banana'
WHERE product_name LIKE 'b@n@n@s';

SELECT DISTINCT Product_Name FROM freshbasket_inventory_messy LIMIT 20;

UPDATE freshbasket_inventory_messy
SET product_name = 'bananas'
WHERE product_name LIKE 'banana';

SELECT DISTINCT Product_Name FROM freshbasket_inventory_messy LIMIT 20;

SELECT * FROM freshbasket_inventory_messy;

CREATE TABLE freshbasket_inventory_cleaned AS
SELECT * FROM freshbasket_inventory_messy;

SELECT * FROM freshbasket_inventory_messy;

ALTER TABLE freshbasket_inventory_messy ADD COLUMN Sales_Date DATE;

SELECT * FROM freshbasket_inventory_messy;

UPDATE freshbasket_inventory_messy
SET Sales_Date = STR_TO_DATE( Date, '%m/%d/%Y')
WHERE delivery_date REGEXP '^[0-1][0-9]/[0-3][0-9]/[0-9]{4}$';

SELECT * FROM freshbasket_inventory_messy;

UPDATE freshbasket_inventory_messy
SET Sales_Date = STR_TO_DATE(Date, '%d-%m-%Y')
WHERE Date REGEXP '^[0-3][0-9]-[0-1][0-9]-[0-9]{4}$';

SELECT * FROM freshbasket_inventory_messy;

UPDATE freshbasket_inventory_messy
SET Sales_Date = STR_TO_DATE(Date, '%Y/%m/%d')
WHERE Date REGEXP '^[0-9]{4}/[0-1][0-9]/[0-3][0-9]$';

SELECT * FROM freshbasket_inventory_messy;

UPDATE freshbasket_inventory_messy
SET Sales_Date = STR_TO_DATE(Date, '%m-%d-%Y')
WHERE Date REGEXP '^[0-1][0-9]-[0-3][0-9]-[0-9]{4}$';

UPDATE freshbasket_inventory_messy
SET Sales_Date = STR_TO_DATE(Date, '%Y-%m-%d')
WHERE Date REGEXP '^[0-9]{4}-[0-1][0-9]-[0-3][0-9]$';


UPDATE freshbasket_inventory_messy
SET Sales_Date = STR_TO_DATE(Date, '%Y-%m-%d')
WHERE Date REGEXP '^[0-1][0-9]-[0-3][0-9]-[0-9]{4}$';

SELECT * FROM freshbasket_inventory_messy;

UPDATE freshbasket_inventory_messy
SET Sales_Date = STR_TO_DATE(Date, '%m/%d/%Y')
WHERE Date REGEXP '^[0-1]?[0-9]/[0-3]?[0-9]/[0-9]{4}$';

SELECT * FROM freshbasket_inventory_messy;

ALTER TABLE freshbasket_inventory_messy
DROP COLUMN Date;

SELECT * FROM freshbasket_inventory_messy;
