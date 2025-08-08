-- SQLite
CREATE TABLE Customer (
    customer_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT UNIQUE,
    street TEXT,
    city TEXT,
    state TEXT,
    zipcode TEXT
);
CREATE TABLE Staff (
    staff_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT
);
CREATE TABLE Product (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    price REAL,
    stock INTEGER
);
CREATE TABLE Category (
    category_id INTEGER PRIMARY KEY,
    category_name TEXT
);
CREATE TABLE Product_Category (
    product_id INTEGER,
    category_id INTEGER,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);
CREATE TABLE Credit_Card (
    card_id INTEGER PRIMARY KEY,
    credit_number TEXT UNIQUE,
    card_holder_name TEXT,
    exp_date TEXT,
    sec_code TEXT,
    zipcode TEXT,
    customer_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
CREATE TABLE Purchase (
    purchase_id INTEGER PRIMARY KEY,
    purchase_date TEXT,
    customer_id INTEGER,
    card_id INTEGER,
    total_price REAL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (card_id) REFERENCES Credit_Card(card_id)
);

-- Create PURCHASE_ITEMS linking table
CREATE TABLE Purchase_Items (
    purchase_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    price REAL,
    PRIMARY KEY (purchase_id, product_id),
    FOREIGN KEY (purchase_id) REFERENCES Purchase(purchase_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);


INSERT INTO Customer (customer_id, first_name, last_name, email, street, city, state, zipcode) VALUES
(1, 'Juliette', 'Garrett', 'juliette.garrett@gmail.com', ' 2504 W Clifton Ave', 'Cincinnati', 'OH', '45219'),
(2, 'Brendan', 'Howell', 'brendan.howell@gmail.com', '138 W McMillan St', 'Cincinnati', 'OH', '45219'),
(3, 'Khiem', 'Ha', 'khiem.ha@gmail.com', '518 Fortune Ave', 'Cincinnati', 'OH', '45219');

INSERT INTO Staff (staff_id, first_name, last_name) VALUES
(101, 'Camilla', 'Medina'),
(102, 'Angelina', 'Braun');

INSERT INTO Product (product_id, product_name, price, stock) VALUES
(201, 'Laptop', 1200.00, 20),
(202, 'Gaming Mouse', 75.00, 150),
(203, 'Gaming Headphones', 150.00, 80),
(204, 'Office Monitor', 300.00, 30);

INSERT INTO Category (category_id, category_name) VALUES
(301, 'Electronics'),
(302, 'Gaming'),
(303, 'Office');

INSERT INTO Product_Category (product_id, category_id) VALUES
(201, 301),
(201, 303),
(202, 301),
(202, 302),
(203, 301),
(203, 302),
(204, 303);

INSERT INTO Credit_Card (card_id, credit_number, card_holder_name, exp_date, sec_code, zipcode, customer_id) VALUES
(401, '1234567890123456', 'Juliette Garrett', '12/25', '123', '45219', 1),
(402, '9876543210987654', 'Khiem Ha', '07/27', '456', '77407', 3);

INSERT INTO Purchase (purchase_id, purchase_date, customer_id, card_id, total_price) VALUES
(501, '2024-07-25', 1, 401, 1350.00),
(502, '2024-07-26', 3, 402, 225.00),
(503, '2024-07-27', 1, 401, 450.00);

INSERT INTO Purchase_Items (purchase_id, product_id, quantity, price) VALUES
(501, 201, 1, 1200.00),
(501, 203, 1, 150.00),
(502, 202, 3, 75.00),
(503, 203, 1, 150.00),
(503, 204, 1, 300.00);

