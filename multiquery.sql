SELECT DISTINCT
    p.purchase_date,
    c.first_name,
    c.last_name,
    p.total_price
FROM
    Customer c
JOIN
    Purchase p ON c.customer_id = p.customer_id
JOIN
    Purchase_Items pi ON p.purchase_id = pi.purchase_id
WHERE
    p.total_price > 500;



SELECT DISTINCT
    p.purchase_date,
    c.first_name,
    c.last_name,
    p.total_price
FROM
    Customer c
JOIN
    Purchase p ON c.customer_id = p.customer_id
JOIN
    Purchase_Items pi ON p.purchase_id = pi.purchase_id