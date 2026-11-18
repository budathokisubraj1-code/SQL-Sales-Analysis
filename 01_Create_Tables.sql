-- SQL Sales Analysis Project
-- Database: PostgreSQL
-- Script: Table creation

CREATE TABLE customers(
    Customer_ID VARCHAR(10) PRIMARY KEY,
    Customer_Name VARCHAR(20),
    City VARCHAR(20),
    Region VARCHAR(10),
    Customer_Segment VARCHAR(15),
    Signup_Date DATE
);

CREATE TABLE products(
    Product_ID VARCHAR(10) PRIMARY KEY,
    Product_Name VARCHAR(20),
    Category VARCHAR(15),
    Unit_Cost NUMERIC(10,2),
    List_Price NUMERIC(10,2)
);

CREATE TABLE orders(
    Order_ID VARCHAR(10) PRIMARY KEY,
    Order_Date DATE,
    Customer_ID VARCHAR(10),
    Product_ID VARCHAR(10),
    Quantity INTEGER,
    Unit_Price NUMERIC(10,2),
    Discount_Pct NUMERIC(5,2),
    Payment_Status VARCHAR(10),
    Sales_Channel VARCHAR(15)
);

-- Note:
-- This script creates the three tables. Run it in a database where
-- these tables do not already exist.
