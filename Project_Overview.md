# Project Overview

## Project Title
SQL Sales Analysis

## Objective
Analyze sales data using PostgreSQL to understand overall sales performance and identify patterns across products, customers, regions, and sales channels.

## Database Structure
The project contains three tables:

- **customers:** Customer_ID, Customer_Name, City, Region, Customer_Segment, Signup_Date
- **products:** Product_ID, Product_Name, Category, Unit_Cost, List_Price
- **orders:** Order_ID, Order_Date, Customer_ID, Product_ID, Quantity, Unit_Price, Discount_Pct, Payment_Status, Sales_Channel

## Analysis Scope
The project is organized into five areas:

1. Overall sales analysis
2. Sales trends and channel analysis
3. Customer analysis
4. Regional and channel analysis
5. Advanced analysis

A total of 15 business questions are answered using SQL queries.

## Key Techniques
The queries demonstrate table joins, aggregate functions, grouping, common table expressions, date functions, ranking window functions, running totals, and percentage contribution calculations.

## Profit Definition
Category profit is calculated after deducting both product cost and discounts from gross revenue:

**Profit = Gross Revenue - Product Cost - Discount Amount**

## Tools
- PostgreSQL
- SQL
- GitHub
