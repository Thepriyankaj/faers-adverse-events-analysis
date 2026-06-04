CREATE DATABASE faers_analysis;
USE faers_analysis;

-- ========================
-- DEMO TABLE
-- ========================

CREATE TABLE demo (
    primary_id BIGINT,
    case_id BIGINT,
    event_date VARCHAR(10),
    report_cod VARCHAR(10),
    mfr_sender VARCHAR(100),
    age INT,
    age_cod VARCHAR(3),
    age_group VARCHAR(2),
    age_group_derived VARCHAR(2),
    sex VARCHAR(10),
    weight INT,
    weight_cod VARCHAR(3),
    occupation_cod VARCHAR(2),
    reporter_country VARCHAR(2),
    occurrence_country VARCHAR(2),
    quarter VARCHAR(10)
);

SET GLOBAL local_infile = 1;

-- Import Q1 and Q2
LOAD DATA LOCAL INFILE "C:/Users/Shree/Desktop/FAERS project/2025 Q1/DEMO2025Q1.csv"
INTO TABLE demo
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:/Users/Shree/Desktop/FAERS project/2025 Q2/DEMO2025Q2.csv"
INTO TABLE demo
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM demo;

-- ========================
-- DRUG TABLE
-- ========================

CREATE TABLE drug (
    primaryid BIGINT,
    caseid BIGINT,
    drug_seq INT,
    role_cod VARCHAR(2),
    drugname VARCHAR(500),
    prod_ai VARCHAR(500),
    val_vbm INT,
    route VARCHAR(100),
    dose_vbm VARCHAR(200),
    cum_dose_chr VARCHAR(50),
    cum_dose_unit VARCHAR(10),
    dechal VARCHAR(2),
    rechal VARCHAR(2),
    lot_num VARCHAR(100),
    exp_dt VARCHAR(10),
    nda_num VARCHAR(20),
    dose_amt VARCHAR(50),
    dose_unit VARCHAR(10),
    dose_form VARCHAR(100),
    dose_freq VARCHAR(100)
);

-- Attempt 1: tried tab delimiter - failed, all nulls
LOAD DATA LOCAL INFILE "C:/Users/Shree/Desktop/FAERS project/2025 Q1/DRUG25Q1.txt"
INTO TABLE drug
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
TRUNCATE TABLE drug;

-- Attempt 2: correct! dollar sign delimiter worked
LOAD DATA LOCAL INFILE "C:/Users/Shree/Desktop/FAERS project/2025 Q1/DRUG25Q1.txt"
INTO TABLE drug
FIELDS TERMINATED BY '$'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:/Users/Shree/Desktop/FAERS project/2025 Q2/DRUG25Q2.txt"
INTO TABLE drug
FIELDS TERMINATED BY '$'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM drug;

-- ========================
-- REAC TABLE
-- ========================

CREATE TABLE reac (
    primaryid BIGINT,
    caseid BIGINT,
    pt VARCHAR(500),
    drug_rec_act VARCHAR(100)
);

LOAD DATA LOCAL INFILE "C:/Users/Shree/Desktop/FAERS project/2025 Q1/REAC25Q1.txt"
INTO TABLE reac
FIELDS TERMINATED BY '$'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:/Users/Shree/Desktop/FAERS project/2025 Q2/REAC25Q2.txt"
INTO TABLE reac
FIELDS TERMINATED BY '$'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM reac;

-- ========================
-- OUTCOMES TABLE
-- ========================

CREATE TABLE outcomes (
    primaryid BIGINT,
    caseid BIGINT,
    outc_cod VARCHAR(2)
);

LOAD DATA LOCAL INFILE "C:/Users/Shree/Desktop/FAERS project/2025 Q1/OUTC25Q1.txt"
INTO TABLE outcomes
FIELDS TERMINATED BY '$'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:/Users/Shree/Desktop/FAERS project/2025 Q2/OUTC25Q2.txt"
INTO TABLE outcomes
FIELDS TERMINATED BY '$'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM outcomes;