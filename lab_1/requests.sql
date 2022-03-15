
SELECT * FROM customers;


SELECT company, city FROM customers
  JOIN addresses ON customers.address_id = addresses.id
    ORDER BY company ASC;


SELECT company, city FROM customers
  JOIN addresses ON customers.address_id = addresses.id
    ORDER BY company DESC;


SELECT * FROM customers 
  JOIN addresses ON customers.address_id = addresses.id 
    WHERE city =  'HI';


SELECT * FROM customers 
  JOIN addresses ON customers.address_id = addresses.id 
    WHERE city IN ('HI', 'CA');


SELECT * FROM customers 
  JOIN orders ON customers.id = orders.customer_id 
    WHERE created_at::text LIKE '1995-01%'::text;


SELECT * FROM customers 
    WHERE company LIKE 'B%s';


SELECT * FROM customers 
    JOIN addresses ON customers.address_id = addresses.id 
        WHERE zip LIKE '9___0';


SELECT company, tax_rate * 1.02 
    FROM customers;


SELECT COUNT(city) 
    FROM customers 
        JOIN addresses ON customers.address_id = addresses.id 
            GROUP BY city;


UPDATE customers 
    SET tax_rate = tax_rate * 1.01;


INSERT INTO customers (
    address_id, 
    fax_id, 
    phone_id, 
    tax_rate, 
    contact, 
    last_invoice_date, 
    company
) VALUES (
    2, 2, 2,
    20,'{"msg":"None"}'::jsonb, 
    now(), 'Company'
);


DELETE FROM customers CASCADE 
  WHERE id IN (
    SELECT customer_id FROM orders 
      WHERE created_at > '2011-01-01'::date
  );  


SELECT * FROM orders 
  JOIN customers ON customers.id = orders.customer_id 
    WHERE amount_paid < 1000::money;


SELECT customers.company, employees.last_name, vendors.name 
  FROM customers 
    JOIN orders ON customers.id = orders.customer_id 
    JOIN employees ON orders.employee_id = employees.id 
    JOIN items ON orders.id = items.order_id 
    JOIN parts ON items.part_id = parts.id 
    JOIN vendors ON parts.vendor_id = vendors.id;


SELECT customers.company, parts.description 
  FROM customers 
    JOIN orders ON customers.id = orders.customer_id 
    JOIN items ON orders.id = items.order_id 
    JOIN parts ON items.part_id = parts.id 
      WHERE items.quantity < 10;


SELECT parts.description, parts.cost, customers.company 
  FROM customers 
    JOIN orders ON customers.id = orders.customer_id 
    JOIN items ON orders.id = items.order_id 
    JOIN parts ON items.part_id = parts.id 
      WHERE  parts.on_hand < parts.on_order 
      ORDER BY items.quantity ASC, parts.on_hand DESC;
