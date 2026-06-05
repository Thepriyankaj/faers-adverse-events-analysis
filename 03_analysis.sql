USE faers_analysis;

-- ========================
-- BASIC COUNTS
-- ========================

-- Total reports
SELECT COUNT(*) AS total_reports
FROM demo;

-- Total unique patients
SELECT COUNT(DISTINCT primaryid) AS unique_patients
FROM demo;

-- Total drug records reported
SELECT COUNT(*) AS total_drug_records
FROM drug;

-- Total unique drugs
SELECT COUNT(DISTINCT drugname) AS unique_drugs
FROM drug;

-- Total reaction records
SELECT COUNT(*) AS total_reaction_records
FROM reac;

-- Total unique reactions
SELECT COUNT(DISTINCT pt) AS unique_reactions
FROM reac;

-- Total reports per quarter
SELECT quarter, COUNT(*) AS total_reports
FROM demo
GROUP BY quarter
ORDER BY quarter;

-- ========================
-- DRUG ANALYSIS
-- ========================

-- Top 10 most reported drugs
SELECT drugname, COUNT(*) AS total_reports
FROM drug
GROUP BY drugname
ORDER BY total_reports DESC
LIMIT 10;

-- ========================
-- REACTION ANALYSIS
-- ========================

-- Top 10 most reported reactions
SELECT pt, COUNT(*) AS total_reports
FROM reac
GROUP BY pt
ORDER BY total_reports DESC
LIMIT 10;

-- ========================
-- OUTCOME ANALYSIS
-- ========================

-- Outcome analysis with full names
SELECT 
    CASE outc_cod
        WHEN 'DE' THEN 'Death'
        WHEN 'HO' THEN 'Hospitalization'
        WHEN 'LT' THEN 'Life Threatening'
        WHEN 'DS' THEN 'Disability'
        WHEN 'CA' THEN 'Congenital Anomaly'
        WHEN 'RI' THEN 'Required Intervention'
        WHEN 'OT' THEN 'Other'
    END AS outcome_type,
    COUNT(*) AS total_cases
FROM outcomes
GROUP BY outc_cod
ORDER BY total_cases DESC;

-- ========================
-- DEMOGRAPHICS
-- ========================

-- Reports by gender
SELECT sex, COUNT(*) AS total_reports
FROM demo
GROUP BY sex
ORDER BY total_reports DESC;

-- Reports by age group
SELECT 
    CASE age_group
        WHEN 'A' THEN 'Adult'
        WHEN 'E' THEN 'Elderly'
        WHEN 'C' THEN 'Child'
        WHEN 'T' THEN 'Teen'
        WHEN 'I' THEN 'Infant'
        WHEN 'N' THEN 'Neonate'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(*) AS total_reports
FROM demo
GROUP BY age_group
ORDER BY total_reports DESC;

-- Top 10 countries by reports
SELECT reporter_country, COUNT(*) AS total_reports
FROM demo
GROUP BY reporter_country
ORDER BY total_reports DESC
LIMIT 10;

-- ========================
-- JOIN ANALYSIS
-- ========================

-- Top drug-reaction pairs for most reported drug
SELECT d.drugname, r.pt, COUNT(*) AS total_reports
FROM drug d
JOIN reac r ON d.primaryid = r.primaryid
WHERE d.drugname = 'DUPIXENT'
GROUP BY d.drugname, r.pt
ORDER BY total_reports DESC
LIMIT 10;

-- Top 3 drugs associated with death
SELECT d.drugname, COUNT(*) AS death_cases
FROM drug d
JOIN outcomes o ON d.primaryid = o.primaryid
WHERE o.outc_cod = 'DE'
GROUP BY d.drugname
ORDER BY death_cases DESC
LIMIT 3;

-- Reports by reporter type
SELECT 
    CASE report_cod
        WHEN 'EXP' THEN 'Expedited'
        WHEN 'PER' THEN 'Periodic'
        WHEN 'DIR' THEN 'Direct'
        WHEN '30DAY' THEN '30 Day'
        WHEN '5DAY' THEN '5 Day'
        ELSE 'Unknown'
    END AS report_type,
    COUNT(*) AS total_reports
FROM demo
GROUP BY report_cod
ORDER BY total_reports DESC;

-- ========================
-- QUARTERLY TRENDS
-- ========================

-- Q1 vs Q2 comparison
SELECT 
    quarter,
    COUNT(*) AS total_reports,
    SUM(CASE WHEN outc_cod = 'DE' THEN 1 ELSE 0 END) AS death_cases
FROM demo d
JOIN outcomes o ON d.primaryid = o.primaryid
GROUP BY quarter
ORDER BY quarter;

