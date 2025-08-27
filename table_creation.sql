CREATE DATABASE phonepe_insights;
USE phonepe_insights;
-- AGGREGATED TABLES
CREATE TABLE aggregated_user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(100),
    year INT,
    quarter INT,
    registered_users BIGINT,
    app_opens BIGINT
);
CREATE TABLE aggregated_transaction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(100),
    year INT,
    quarter INT,
    transaction_name VARCHAR(100),  -- e.g. Peer-to-peer, Recharge
    count BIGINT,
    amount DOUBLE
);
CREATE TABLE aggregated_insurance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(100),
    year INT,
    quarter INT,
    name VARCHAR(50),         -- “Insurance"
    count BIGINT,
    amount DOUBLE
);
-- MAP TABLES
CREATE TABLE map_transaction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(100),
    district VARCHAR(100),
    year INT,
    quarter INT,
    count BIGINT,
    amount DOUBLE
);
CREATE TABLE map_user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(100),
    district VARCHAR(100),
    year INT,
    quarter INT,
    registered_users BIGINT,
    app_opens BIGINT
);
CREATE TABLE map_insurance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(100),
    district VARCHAR(100),
    year INT,
    quarter INT,
    count BIGINT,
    amount DOUBLE
);
-- TOP TABLES
CREATE TABLE top_transaction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(100),
    entity_name VARCHAR(100),    -- state/district/pincode
    entity_type VARCHAR(50),     -- 'state','district','pincode'
    year INT,
    quarter INT,
    count BIGINT,
    amount DOUBLE
);
CREATE TABLE top_user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(100),
    entity_name VARCHAR(100),    -- state/district/pincode
    entity_type VARCHAR(50),
    year INT,
    quarter INT,
    registered_users BIGINT
);
CREATE TABLE top_insurance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(100),
    entity_name VARCHAR(100),    -- district/pincode
    entity_type VARCHAR(50),
    year INT,
    quarter INT,
    count BIGINT,
    amount DOUBLE
);



