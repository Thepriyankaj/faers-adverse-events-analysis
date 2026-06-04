USE faers_analysis;

-- ========================
-- DRUG TABLE CLEANING
-- ========================

-- Remove unwanted columns
ALTER TABLE drug
DROP COLUMN val_vbm,
DROP COLUMN dose_vbm,
DROP COLUMN cum_dose_chr,
DROP COLUMN cum_dose_unit,
DROP COLUMN lot_num,
DROP COLUMN exp_dt,
DROP COLUMN nda_num,
DROP COLUMN rechal;

-- Remove duplicates
CREATE TABLE drug_cleaned AS
SELECT DISTINCT primaryid, caseid, drug_seq, role_cod, 
                drugname, prod_ai, route, dechal,
                dose_amt, dose_unit, dose_form, dose_freq
FROM drug;

-- Check row counts
SELECT COUNT(*) FROM drug;
SELECT COUNT(*) FROM drug_cleaned;

-- Replace original table
DROP TABLE drug;
RENAME TABLE drug_cleaned TO drug;

-- Verify
SELECT COUNT(*) FROM drug;

-- ========================
-- REAC TABLE CLEANING
-- ========================

-- Remove unwanted columns
ALTER TABLE reac
DROP COLUMN drug_rec_act;

-- Remove duplicates
CREATE TABLE reac_cleaned AS
SELECT DISTINCT primaryid, caseid, pt
FROM reac;

-- Check row counts
SELECT COUNT(*) FROM reac;
SELECT COUNT(*) FROM reac_cleaned;

-- Replace original table
DROP TABLE reac;
RENAME TABLE reac_cleaned TO reac;

-- Verify
SELECT COUNT(*) FROM reac;

-- ========================
-- OUTCOMES TABLE CLEANING
-- ========================

-- Remove unwanted columns
-- No columns to drop - all columns retained

-- Remove duplicates
CREATE TABLE outcomes_cleaned AS
SELECT DISTINCT primaryid, caseid, outc_cod
FROM outcomes;

-- Check row counts
SELECT COUNT(*) FROM outcomes;
SELECT COUNT(*) FROM outcomes_cleaned;

-- Replace original table
DROP TABLE outcomes;
RENAME TABLE outcomes_cleaned TO outcomes;

-- Verify
SELECT COUNT(*) FROM outcomes;

-- ========================
-- RENAME COLUMNS
-- ========================

-- Rename DEMO columns to match other tables
ALTER TABLE demo
RENAME COLUMN primary_id TO primaryid,
RENAME COLUMN case_id TO caseid;

-- Verify
DESCRIBE demo;