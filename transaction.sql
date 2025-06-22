CREATE DATABASE phonepe;
USE phonepe;

CREATE TABLE aggregated_transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(255),
    year INT,
    quarter INT,
    transaction_type VARCHAR(255),
    transaction_count BIGINT,
    transaction_amount DOUBLE
);
CREATE TABLE aggregated_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(255),
    year INT,
    quarter INT,
    brand VARCHAR(255),
    count BIGINT,
    percentage DOUBLE
);
SELECT * FROM aggregated_transactions LIMIT 10;
SELECT COUNT(*) FROM aggregated_transactions;
SELECT * FROM aggregated_transactions LIMIT 5;
SELECT state, SUM(transaction_amount) AS total_amount FROM aggregated_transactions GROUP BY state ORDER BY total_amount DESC LIMIT 5;
SELECT year, quarter, SUM(transaction_amount) AS total_amount
FROM aggregated_transactions
GROUP BY year, quarter
ORDER BY year, quarter;

DESCRIBE aggregated_transactions;

SHOW COLUMNS FROM aggregated_transactions;

SELECT year, quarter, SUM(transaction_amount) AS total_amount
FROM aggregated_transactions
GROUP BY year, quarter
ORDER BY year, quarter;

SELECT state, SUM(transaction_amount) AS total_amount
FROM aggregated_transactions
GROUP BY state
ORDER BY total_amount DESC;

SELECT transaction_type, SUM(transaction_amount) AS total_amount
FROM aggregated_transactions
GROUP BY transaction_type
ORDER BY total_amount DESC;




