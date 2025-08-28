USE phonepe_insights;
-- =====================
-- AGGREGATED TABLES
-- =====================

-- 1. Aggregated Users per State per Year/Quarter
SELECT state, year, quarter, SUM(registered_users) AS total_registered_users, SUM(app_opens) AS total_app_opens
FROM aggregated_user
GROUP BY state, year, quarter
ORDER BY year, quarter, state;

-- 2. Aggregated Transactions per State per Year/Quarter
SELECT state, year, quarter, transaction_name, SUM(count) AS total_count, SUM(amount) AS total_amount
FROM aggregated_transaction
GROUP BY state, year, quarter, transaction_name
ORDER BY year, quarter, state, transaction_name;

-- 3. Aggregated Insurance per State per Year/Quarter
SELECT state, year, quarter, name AS insurance_type, SUM(count) AS total_count, SUM(amount) AS total_amount
FROM aggregated_insurance
GROUP BY state, year, quarter, name
ORDER BY year, quarter, state, name;


-- =====================
-- MAP TABLES
-- =====================

-- 4. Map Users per District
SELECT state, district, year, quarter, SUM(registered_users) AS total_registered_users, SUM(app_opens) AS total_app_opens
FROM map_user
GROUP BY state, district, year, quarter
ORDER BY year, quarter, state, district;

-- 5. Map Transactions per District
SELECT state, district, year, quarter, SUM(count) AS total_count, SUM(amount) AS total_amount
FROM map_transaction
GROUP BY state, district, year, quarter
ORDER BY year, quarter, state, district;

-- 6. Map Insurance per District
SELECT state, district, year, quarter, SUM(count) AS total_count, SUM(amount) AS total_amount
FROM map_insurance
GROUP BY state, district, year, quarter
ORDER BY year, quarter, state, district;


-- =====================
-- TOP TABLES
-- =====================

-- 7. Top Users (State/District/Pincode)
SELECT entity_type, entity_name, state, year, quarter, SUM(registered_users) AS total_registered_users
FROM top_user
GROUP BY entity_type, entity_name, state, year, quarter
ORDER BY year, quarter, total_registered_users DESC;

-- 8. Top Transactions (State/District/Pincode)
SELECT entity_type, entity_name, state, year, quarter, SUM(count) AS total_count, SUM(amount) AS total_amount
FROM top_transaction
GROUP BY entity_type, entity_name, state, year, quarter
ORDER BY year, quarter, total_amount DESC;

-- 9. Top Insurance (State/District/Pincode)
SELECT entity_type, entity_name, state, year, quarter, SUM(count) AS total_count, SUM(amount) AS total_amount
FROM top_insurance
GROUP BY entity_type, entity_name, state, year, quarter
ORDER BY year, quarter, total_amount DESC;
