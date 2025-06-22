USE phonepe;
CREATE TABLE aggregated_user (
    year INT,
    quarter INT,
    state VARCHAR(50),
    brand VARCHAR(50),
    user_count BIGINT,
    user_percentage FLOAT
);
CREATE TABLE aggregated_transaction (
    year INT,
    quarter INT,
    state VARCHAR(50),
    transaction_type VARCHAR(50),
    transaction_count BIGINT,
    transaction_amount DECIMAL  
);
CREATE TABLE aggregated_insurance (
    year INT,
    quarter INT,
    state VARCHAR(50),
    insurance_type VARCHAR(50),
    insurance_count BIGINT,
    insurance_amount DECIMAL 
);

SELECT state, year, SUM(user_count) AS total_users
FROM aggregated_user
GROUP BY state, year
ORDER BY total_users DESC;

SELECT state, year, quarter, SUM(transaction_count) AS total_transactions
FROM aggregated_transaction
GROUP BY state, year, quarter
ORDER BY total_transactions DESC;

SELECT state, year, SUM(insurance_count) AS total_insurance, SUM(insurance_amount) AS total_amount
FROM aggregated_insurance
GROUP BY state, year
ORDER BY total_insurance DESC;

SELECT COUNT(*) FROM aggregated_insurance;
SELECT * FROM aggregated_insurance LIMIT 10;
