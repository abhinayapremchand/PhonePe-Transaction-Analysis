USE phonepe;
CREATE TABLE map_insurance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year INT,
    quarter INT,
    state VARCHAR(50),
    district VARCHAR(100),
    insurance_count INT,
    insurance_amount FLOAT
);
CREATE TABLE map_user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year INT,
    quarter INT,
    state VARCHAR(50),
    district VARCHAR(100),
    registered_users BIGINT
);
CREATE TABLE map_transaction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year INT,
    quarter INT,
    state VARCHAR(50),
    district VARCHAR(100),
    map_count BIGINT,
    map_amount FLOAT
);

drop table map_transaction;

select * from map_insurance;
