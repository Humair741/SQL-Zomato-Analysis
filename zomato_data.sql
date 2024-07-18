-- Insert data into goldusers_signup
INSERT INTO goldusers_signup (userid, gold_signup_date) VALUES 
(1, '2017-09-22'),
(3, '2017-04-21');

-- Insert data into users
INSERT INTO users (userid, signup_date) VALUES 
(1, '2014-09-02'),
(2, '2015-01-15'),
(3, '2014-04-11');

-- Insert data into sales
INSERT INTO sales (userid, created_date, product_id) VALUES 
(1, '2017-04-19', 2),
(3, '2019-12-18', 1),
(2, '2020-07-20', 3),
(1, '2019-10-23', 2),
(1, '2018-03-19', 3),
(3, '2016-12-20', 2),
(1, '2016-11-09', 1),
(1, '2016-05-20', 3),
(2, '2017-09-24', 1),
(1, '2017-03-11', 2),
(1, '2016-03-11', 1),
(3, '2016-11-10', 1),
(3, '2017-12-07', 2),
(3, '2016-12-15', 2),
(2, '2017-11-08', 2),
(2, '2018-09-10', 3);

-- Insert data into product
INSERT INTO product (product_id, product_name, price) VALUES
(1, 'p1', 980),
(2, 'p2', 870),
(3, 'p3', 330);

-- Queries to verify data insertion (optional)
SELECT * FROM sales;
SELECT * FROM product;
SELECT * FROM goldusers_signup;
SELECT * FROM users;
