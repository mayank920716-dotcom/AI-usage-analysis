LOAD DATA INFILE 'path/to/clean_data.csv'
INTO TABLE ai_usage_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@date, year, month, metric, value, ai_tool, metric_type)
SET date = STR_TO_DATE(@date, '%d-%m-%Y');
