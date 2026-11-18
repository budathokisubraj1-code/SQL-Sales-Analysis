# SQL Sales Analysis Project

## Project Overview
This project uses PostgreSQL to analyze sales data and answer practical business questions about sales performance, products, customers, regions, and sales channels.

The analysis contains 15 SQL tasks, progressing from basic aggregations and joins to common advanced analytical techniques.

## Database
The project uses three tables:
- **customers** — customer details, location, region, segment, and signup date.
- **products** — product names, categories, unit costs, and list prices.
- **orders** — order dates, customer and product IDs, quantities, prices, discounts, payment status, and sales channels.

## Analysis Performed
1. Overall sales performance
2. Product performance
3. Category performance and profit after discounts
4. Monthly sales trends
5. Payment status analysis
6. Sales channel performance
7. Top customers by revenue
8. Customer segment analysis
9. Customer purchase frequency
10. Regional sales performance
11. Sales channel and payment status analysis
12. Product revenue ranking within categories
13. Customer lifetime revenue ranking
14. Running monthly revenue
15. Customer revenue contribution

## SQL Skills Demonstrated
- SELECT, filtering, sorting, and aliases
- Aggregate functions: COUNT, SUM, AVG
- GROUP BY and HAVING concepts
- INNER JOIN
- DISTINCT
- Common Table Expressions (CTEs)
- Date and formatting functions
- Window functions
- DENSE_RANK and PARTITION BY
- Running totals and revenue contribution calculations

## Repository Structure
```text
SQL-Sales-Analysis/
├── Create Table.sql
├── Sales Analysis.sql
├── Project Overview.md
└── README.md
```

## How to Use
1. Open PostgreSQL using pgAdmin or another PostgreSQL client.
2. Create or select a database for the project.
3. Run `Create_Tables.sql` to create the tables.
4. Import or insert the corresponding data into the three tables.
5. Run the queries in `Sales_Analysis_Queries.sql`.

**Note:** The repository contains SQL scripts and project documentation. The source dataset is not included in this repository.

## Project Objective
The objective is to demonstrate practical SQL skills by transforming order-level data into useful business insights that support sales, product, customer, and regional performance analysis.
