Final Project Insights + Summary (SQL + Power BI + Data Cleaning)

These insights are written in a clean, interview-ready style.
They combine:

✔ Your Power BI dashboard totals
✔ The SQL analysis (25 questions)
✔ Domain knowledge (Fin-Tech / Payments)
✔ Patterns visible in charts

📌 A) Data Cleaning Summary (Excel + SQL + Power BI)-
Before analysis, all 6 datasets were cleaned using:
Excel Cleaning (Initial Cleaning)
Removed extra spaces, blank rows, merged cells
Ensured consistent headers in all 6 sheets
Converted dates into a proper date format
Converted amount columns into numeric
Removed invalid text in numeric columns
Standardized category names
Verified no duplicate transaction IDs
Checked for missing user IDs

📌SQL Cleaning (PostgreSQL)-
Loaded all datasets into PostgreSQL
Added correct datatypes (numeric, date, varchar)
Verified row counts
Checked referential integrity with user_id
Used SQL queries to:
Find missing values
Identify incorrect service names
Validate payment statuses
Extract insights using JOINS & aggregations

📌Power BI Cleaning-
Built a proper Star Schema
Created a DateTable for time-intelligence
Removed auto-relationships
Built clean, reusable DAX measures
Validated totals by cross-checking with SQL outputs

Key Insights from the Overall Dashboard (Home Page)-
1️⃣ Total Business Volume:
₹3,474M (3.47 Billion) processed across all services in 2024
This includes Loans, Insurance, Money Transfer, and Recharge/Bills

2️⃣ Transaction Breakdown:
Total Transactions: 300K
Successful: 288K
Failed: 12K
Success Rate: 96%
Failure Rate: 4% (acceptable for fintech standards)

3️⃣ Monthly Trends:
Peaks in July & October
Lowest activity in February & September
Suggests:
July peak linked to mid-year spending / festive loans
October peak linked to festival season (Diwali)

4️⃣ Service-Wise Contribution
Service	Amount (₹M)	Contribution
Loans	2532.51M	⭐ 73%
Insurance	512.92M	15%
Money Transfer	378.19M	11%
Recharge & Bills	50.69M	1%

🔍 Insight: PhonePe’s largest revenue-driving segment is Loans, dominating the total business volume.

5️⃣ Failure Reason Insights-
Top failure reasons:
Wrong Info
Wrong PIN
Insufficient Balance
Bank Denied.
🔍 Insight:
The majority of failures are user-side errors, not technical failures.
This suggests PhonePe could reduce failures via better UI messages or validation steps.

📌 C) Service-Wise Insights
INSURANCE Dashboard Insights
1️⃣ Total Premium Collected:
₹512.92M

2️⃣ Most Popular Insurance Types:
All four categories have very similar transaction counts (~128M transactions each).
Cannot identify a major dominant insurance category — customer base is evenly distributed.

3️⃣ Monthly Premium Trend:
Highest premium collection in July
Lowest in February

4️⃣ Failure Reason:
Wrong PIN, Server Error, & Insufficient Balance contribute equally
Indicates no specific friction point in insurance payments

5️⃣ Success Rate:
95.75% successful
4.25% failed

LOANS Dashboard Insights-
1️⃣ Total Loan Amount Disbursed:
₹2,532.51M (biggest business unit)

2️⃣ Loan Category Performance:
Loan Type	Total Transactions
Auto Loan	644M
Mutual Funds	634M
Gold Loan	632M
Credit Score Services	622M

🔍 Insight:
Auto loans slightly outperform others — indicating high demand.

3️⃣ Monthly Trend:
Peak in July (₹224M)
Minimum in February (₹203M)

4️⃣ Failure Reasons:
Wrong Info (34.53%)
Server Error (31%)
Bank Denied (31%)

🔍 Insight:
Loan applications fail mainly due to incorrect info, suggesting KYC/validation improvements needed.

MONEY TRANSFER Dashboard Insights-
1️⃣ Total Transfer Amount:
₹378.19M

2️⃣ Top Transfer Types:
4 transfer types have equal volume (~94–95M each)
Customers are using all channels equally.

3️⃣ Monthly Trend:
Stable monthly transfer activity (31M–32M)
Indicates:
High repeat usage
Stable customer base

4️⃣ Failure Reasons-
More diverse failures:
Wrong PIN
Insufficient Funds
Server Error
Wrong Info

BILLS & RECHARGE Dashboard Insights-
1️⃣ Total Recharge/Bills Amount:
₹50.69M

2️⃣ Top Recharge Types:
Electricity
DTH
Mobile Recharge
Streaming/TV
All categories show similar usage.

3️⃣ Monthly Trend:
Peak in May & October
Minimum in June

4️⃣ Success Rate:
96.16% success
Very low failure rate compared to other services
