-- SQL Sales Analysis Project
-- Database: PostgreSQL
-- Script: 15 Sales Analysis Queries

-- =====================================================
-- SECTION 1: OVERALL SALES ANALYSIS
-- =====================================================

-- Task 1: Overall Sales Performance
SELECT
    COUNT(order_id) AS tot_orders,
    SUM(quantity) AS tot_qty_sold,
    SUM(quantity * unit_price) AS gross_revenue,
    SUM(quantity * (discount_pct * unit_price / 100)) AS tot_discount_amt,
    SUM((quantity * unit_price) - quantity * (discount_pct * unit_price / 100)) AS net_revenue
FROM orders;


-- Task 2: Product Performance Analysis
SELECT
    o.product_id,
    p.product_name,
    p.category,
    SUM(o.quantity) AS tot_qty_sold,
    SUM(o.quantity * o.unit_price) AS tot_rev
FROM orders o
INNER JOIN products p
    ON p.product_id = o.product_id
GROUP BY o.product_id, p.product_name, p.category
ORDER BY tot_rev DESC;


-- Task 3: Category Performance Analysis
-- Profit is calculated after deducting discounts and product costs.
SELECT
    p.category,
    SUM(o.quantity) AS tot_qty,
    SUM(o.quantity * o.unit_price) AS tot_revenue,
    SUM(o.quantity * p.unit_cost) AS tot_cost,
    ROUND(
        SUM(o.quantity * o.unit_price)
        - SUM(o.quantity * p.unit_cost)
        - SUM(o.quantity * (o.discount_pct * o.unit_price / 100)),
        2
    ) AS tot_profit
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY tot_revenue DESC;


-- =====================================================
-- SECTION 2: SALES TRENDS AND CHANNEL ANALYSIS
-- =====================================================

-- Task 4: Monthly Sales Trend Analysis
SELECT
    TO_CHAR(DATE_TRUNC('MONTH', order_date), 'FMMONTH YYYY') AS months,
    COUNT(order_id) AS total_order,
    SUM(quantity * unit_price) AS total_revenue,
    SUM(quantity) AS tot_qty
FROM orders
GROUP BY DATE_TRUNC('MONTH', order_date)
ORDER BY DATE_TRUNC('MONTH', order_date) ASC;


-- Task 5: Payment Status Analysis
SELECT
    payment_status,
    COUNT(order_id) AS total_orders,
    SUM(quantity * unit_price) AS total_revenue,
    SUM(quantity) AS total_quantity
FROM orders
GROUP BY payment_status
ORDER BY total_revenue DESC;


-- Task 6: Sales Channel Performance
SELECT
    sales_channel,
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS total_qty_sold,
    SUM(quantity * unit_price) AS total_revenue,
    AVG(quantity * unit_price) AS average_ord_rev
FROM orders
GROUP BY sales_channel
ORDER BY total_revenue DESC;


-- =====================================================
-- SECTION 3: CUSTOMER ANALYSIS
-- =====================================================

-- Task 7: Customer Revenue Analysis (Top 10)
SELECT
    o.customer_id,
    c.customer_name,
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity * o.unit_price) AS total_revenue
FROM orders o
INNER JOIN customers c
    ON c.customer_id = o.customer_id
GROUP BY o.customer_id, c.customer_name, c.city
ORDER BY total_revenue DESC
LIMIT 10;


-- Task 8: Customer Segment Analysis
SELECT
    c.customer_segment,
    COUNT(DISTINCT c.customer_id) AS tot_customers,
    COUNT(o.order_id) AS tot_orders,
    SUM(o.quantity * o.unit_price) AS tot_revenue
FROM orders o
INNER JOIN customers c
    ON c.customer_id = o.customer_id
GROUP BY c.customer_segment
ORDER BY tot_revenue DESC;


-- Task 9: Customer Purchase Frequency Analysis (Top 10)
SELECT
    o.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS tot_orders,
    SUM(o.quantity) AS tot_qty_purchased
FROM orders o
INNER JOIN customers c
    ON c.customer_id = o.customer_id
GROUP BY o.customer_id, c.customer_name
ORDER BY tot_orders DESC
LIMIT 10;


-- =====================================================
-- SECTION 4: REGIONAL AND CHANNEL ANALYSIS
-- =====================================================

-- Task 10: Regional Sales Performance
SELECT
    c.region,
    COUNT(DISTINCT c.customer_id) AS tot_customers,
    COUNT(o.order_id) AS tot_orders,
    SUM(o.quantity * o.unit_price) AS tot_revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.region
ORDER BY tot_revenue DESC;


-- Task 11: Sales Channel and Payment Status Analysis
SELECT
    sales_channel,
    payment_status,
    COUNT(order_id) AS total_orders,
    SUM(quantity * unit_price) AS total_revenue
FROM orders
GROUP BY sales_channel, payment_status
ORDER BY total_revenue DESC;


-- =====================================================
-- SECTION 5: ADVANCED ANALYSIS
-- =====================================================

-- Task 12: Product Ranking Within Each Category
WITH revenue AS (
    SELECT
        p.category,
        o.product_id,
        p.product_name,
        SUM(o.quantity * o.unit_price) AS tot_revenue
    FROM orders o
    INNER JOIN products p
        ON p.product_id = o.product_id
    GROUP BY p.category, o.product_id, p.product_name
)
SELECT
    *,
    DENSE_RANK() OVER (
        PARTITION BY category
        ORDER BY tot_revenue DESC
    ) AS revenue_rank
FROM revenue;


-- Task 13: Customer Lifetime Revenue Ranking
SELECT
    o.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity * o.unit_price) AS total_revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(o.quantity * o.unit_price) DESC
    ) AS customer_rank
FROM orders o
INNER JOIN customers c
    ON c.customer_id = o.customer_id
GROUP BY o.customer_id, c.customer_name;


-- Task 14: Running Monthly Revenue
WITH revenue AS (
    SELECT
        TO_CHAR(DATE_TRUNC('MONTH', order_date), 'FMMONTH YYYY') AS months,
        DATE_TRUNC('MONTH', order_date) AS mon,
        SUM(quantity * unit_price) AS tot_revenue
    FROM orders
    GROUP BY DATE_TRUNC('MONTH', order_date)
)
SELECT
    months,
    tot_revenue,
    SUM(tot_revenue) OVER (ORDER BY mon) AS running_tot_revenue
FROM revenue
ORDER BY mon;


-- Task 15: Customer Revenue Contribution Analysis
WITH revenue AS (
    SELECT
        o.customer_id,
        c.customer_name,
        SUM(o.quantity * o.unit_price) AS tot_revenue
    FROM orders o
    INNER JOIN customers c
        ON c.customer_id = o.customer_id
    GROUP BY o.customer_id, c.customer_name
)
SELECT
    *,
    ROUND(
        (tot_revenue * 100.0 / SUM(tot_revenue) OVER())::NUMERIC,
        2
    ) AS revenue_contribution_percent
FROM revenue;
