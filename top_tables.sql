use phonepe;

CREATE TABLE top_user (
    year INT,
    quarter INT,
    state VARCHAR(50),
    pincode VARCHAR(10),
    registered_users BIGINT
);

CREATE TABLE top_map (
    year INT,
    quarter INT,
    state VARCHAR(50),
    pincode VARCHAR(10),
    transaction_count BIGINT,
    transaction_amount FLOAT
);

CREATE TABLE top_insurance (
    year INT,
    quarter INT,
    state VARCHAR(50),
    pincode VARCHAR(10),
    insurance_count BIGINT,
    insurance_amount FLOAT
);


INSERT INTO top_user (year, quarter, state, pincode, registered_users)
SELECT year, quarter, state, '' AS pincode, SUM(user_count) AS registered_users
FROM aggregated_user
GROUP BY year, quarter, state
ORDER BY registered_users DESC
LIMIT 10;

INSERT INTO top_map (year, quarter, state, pincode, transaction_count, transaction_amount)
SELECT year, quarter, state, '' AS pincode,
       SUM(transaction_count) AS total_count,
       SUM(transaction_amount) AS total_amount
FROM aggregated_transaction
GROUP BY year, quarter, state
ORDER BY total_amount DESC
LIMIT 10;


INSERT INTO top_insurance (year, quarter, state, pincode, insurance_count, insurance_amount)
SELECT year, quarter, state, '' AS pincode, SUM(insurance_count) AS total_count,
SUM(insurance_amount) AS total_amount FROM aggregated_insurance
GROUP BY year, quarter, state ORDER BY total_amount DESC LIMIT 10;

-- Total registered users by state
SELECT state, SUM(user_count) AS total_users  FROM aggregated_user GROUP BY state 
ORDER BY total_users DESC;

-- Top transaction types
SELECT transaction_type, SUM(transaction_amount) AS total_amount 
FROM aggregated_transaction 
GROUP BY transaction_type 
ORDER BY total_amount DESC;

-- Top 5 states by insurance amount
SELECT state, SUM(insurance_amount) AS total_insurance FROM aggregated_insurance
GROUP BY state ORDER BY total_insurance DESC LIMIT 5;
