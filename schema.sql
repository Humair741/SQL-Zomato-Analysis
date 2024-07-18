-- Drop tables if they already exist
DROP TABLE IF EXISTS goldusers_signup;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS product;

-- Create tables
CREATE TABLE goldusers_signup (
    userid INTEGER,
    gold_signup_date DATE
);

CREATE TABLE users (
    userid INTEGER,
    signup_date DATE
);

CREATE TABLE sales (
    userid INTEGER,
    created_date DATE,
    product_id INTEGER
);

CREATE TABLE product (
    product_id INTEGER,
    product_name TEXT,
    price INTEGER
);
