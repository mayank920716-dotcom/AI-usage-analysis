# AI Usage Analytics Dashboard (SQL + Python + Power BI)

## Project Overview

This project analyzes **AI tool usage trends** using real-world structured data.
It combines **data cleaning (Python), data analysis (SQL), and visualization (Power BI)** to generate meaningful insights about AI adoption.

---

## Objectives

* Analyze usage patterns of different AI tools
* Identify top-performing AI tools
* Track growth trends over time
* Build an interactive dashboard for decision-making

---

## Tech Stack

* **Python (Pandas, NumPy)** → Data Cleaning & Preprocessing
* **MySQL (SQL)** → Data Analysis
* **Power BI** → Dashboard & Visualization
* **GitHub** → Project Hosting

---

## Project Structure

```
AI-Usage-Analytics/
│── data/
│   ├── raw_data.csv
│   └── clean_ai_data.csv
│
│
│── sql/
│   ├── create_table.sql
│   ├── load_data.sql
│   └── analysis.sql
│
│── dashboard/
│   └── ai_dashboard.pbix
│
│
│── README.md
```

---

## Data Cleaning (Python)

Performed using **Pandas & NumPy**:

* Handled missing values
* Removed inconsistencies in categorical data
* Standardized `metric_type` column
* Converted data types (date, numeric)
* Cleaned noisy values for accurate analysis

---

## SQL Analysis

### Basic Analysis

```sql
-- Total users per AI tool
SELECT ai_tool, SUM(value) AS total_users
FROM ai_usage_data
WHERE metric_type = 'users'
GROUP BY ai_tool
ORDER BY total_users DESC;
```

---

### Time-Based Analysis

```sql
-- Monthly usage trend
SELECT year, month, SUM(value) AS monthly_users
FROM ai_usage_data
GROUP BY year, month
ORDER BY year, month;
```

```sql
-- Yearly usage trend
SELECT year, SUM(value) AS yearly_users
FROM ai_usage_data
GROUP BY year
ORDER BY year;
```

---

### Advanced SQL (Window Functions)

```sql
-- Year-over-Year Growth
SELECT 
    year,
    SUM(value) AS total_users,
    LAG(SUM(value)) OVER (ORDER BY year) AS prev_year_users
FROM ai_usage_data
GROUP BY year;
```

```sql
-- Ranking AI tools
SELECT 
    ai_tool,
    SUM(value) AS total_users,
    RANK() OVER (ORDER BY SUM(value) DESC) AS rank_position
FROM ai_usage_data
GROUP BY ai_tool;
```

---

### Business Insights Queries

* Peak usage analysis
* Top AI tool per year
* Month-on-month growth
* Rolling averages
* Most consistent tool (low variation)
* Fastest growing AI tool

---

## Power BI Dashboard

### Features

* KPI Cards:

  * Total Users
  * Total Revenue
  * Market Share

* Visualizations:

  * 📊 Bar Chart → Top AI Tools
  * 📈 Area Chart → Growth Trend
  * 🍩 Donut Chart → Market Share
  * 🎛️ Slicers → Interactive filtering

---

## Dashboard Design

* Dark AI-themed UI
* Professional color palette
* Interactive and user-friendly
* Clean layout with proper hierarchy

---

## Dashboard Preview

*(Add your screenshot here)*

---

## Key Insights

* Certain AI tools dominate user adoption
* Significant growth observed over time
* Usage trends vary across tools and periods
* Some tools show consistent performance with low variation

---

## Future Improvements

* Add real-world dataset
* Include company-level analysis
* Deploy dashboard online (Power BI Service)
* Add predictive modeling

---

## Author

**Mayank Sharma**

* GitHub: https://github.com/mayank920716-dotcom
* LinkedIn: https://www.linkedin.com/in/mayank-sharma-32335b277

---

## Support

If you found this project useful, give it a ⭐ on GitHub!
