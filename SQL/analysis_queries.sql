-- 1. Total users per AI tool
SELECT ai_tool, SUM(value) AS total_users
FROM ai_usage_data
WHERE metric_type = 'users'
GROUP BY ai_tool
ORDER BY total_users DESC;

-- 2. Monthly usage trend
SELECT year, month, SUM(value) AS monthly_users
FROM ai_usage_data
GROUP BY year, month
ORDER BY year, month;

-- 3. Yearly usage trend
SELECT year, SUM(value) AS yearly_users
FROM ai_usage_data
GROUP BY year
ORDER BY year;

-- 4. Peak usage record
SELECT ai_tool, date, value
FROM ai_usage_data
ORDER BY value DESC;

-- 5. Tool-wise yearly growth
SELECT ai_tool, year, SUM(value) AS total_users
FROM ai_usage_data
GROUP BY ai_tool, year
ORDER BY ai_tool, year;

-- 6. Compare tools (pivot style)
SELECT 
    date,
    SUM(CASE WHEN ai_tool = 'grammarlyai_global' THEN value ELSE 0 END) AS grammarly_users
FROM ai_usage_data
GROUP BY date
ORDER BY date;

-- 7. Year-over-Year Growth Percentage
SELECT 
    year,
    SUM(value) AS total_users,
    LAG(SUM(value)) OVER (ORDER BY year) AS prev_year_users,
    ROUND(
        (SUM(value) - LAG(SUM(value)) OVER (ORDER BY year)) 
        / LAG(SUM(value)) OVER (ORDER BY year) * 100, 2
    ) AS growth_percentage
FROM ai_usage_data
GROUP BY year;

-- 8. Rank AI tools by usage
SELECT 
    ai_tool,
    SUM(value) AS total_users,
    RANK() OVER (ORDER BY SUM(value) DESC) AS rank_position
FROM ai_usage_data
GROUP BY ai_tool;

-- 9. Top AI tool per year
SELECT *
FROM (
    SELECT 
        year,
        ai_tool,
        SUM(value) AS total_users,
        RANK() OVER (PARTITION BY year ORDER BY SUM(value) DESC) AS rnk
    FROM ai_usage_data
    GROUP BY year, ai_tool
) ranked
WHERE rnk = 1;

-- 10. Month-on-Month Growth per Tool
SELECT 
    ai_tool,
    date,
    value,
    LAG(value) OVER (PARTITION BY ai_tool ORDER BY date) AS prev_value,
    value - LAG(value) OVER (PARTITION BY ai_tool ORDER BY date) AS growth
FROM ai_usage_data;

-- 11. Rolling Average (7-period smoothing)
SELECT 
    ai_tool,
    date,
    AVG(value) OVER (
        PARTITION BY ai_tool
        ORDER BY date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM ai_usage_data;

-- 12. Fastest growing AI tool (overall growth)
SELECT 
    ai_tool,
    (MAX(value) - MIN(value)) AS total_growth
FROM ai_usage_data
GROUP BY ai_tool
ORDER BY total_growth DESC;

-- 13. Most consistent AI tool (low fluctuation)
SELECT 
    ai_tool,
    STDDEV(value) AS usage_variation
FROM ai_usage_data
GROUP BY ai_tool
ORDER BY usage_variation ASC;

-- 14. Best performing month overall
SELECT 
    month,
    SUM(value) AS total_usage
FROM ai_usage_data
GROUP BY month
ORDER BY total_usage DESC;

-- 15. Year with highest growth
SELECT 
    year,
    SUM(value) AS total_usage
FROM ai_usage_data
GROUP BY year
ORDER BY total_usage DESC
LIMIT 1;
