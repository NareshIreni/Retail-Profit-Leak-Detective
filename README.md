# Retail Profit Leak Detective

A Data Analyst portfolio project built using the Superstore dataset.

The main question I wanted to answer was simple:

**The business is making good sales, so why are some products, customers and regions still losing money?**

I used Python, SQL and Power BI to investigate the problem and identify the areas where profit is being lost.

---

## What I Worked On

I followed this workflow:

**Python → MySQL → Power BI → Business Recommendations**

I first cleaned and checked the dataset in Python, then used Python for exploratory analysis. After that, I loaded the cleaned data into MySQL and wrote SQL queries to investigate different business questions.

Finally, I built a 3-page Power BI report to present the findings.

---

## Tools Used

- Python
- Pandas
- Matplotlib
- Jupyter Notebook
- MySQL
- Power BI
- DAX
- Git & GitHub
---

## What I Practiced

This project helped me practice the complete workflow I would follow as a junior data analyst.

- Data cleaning and validation using Python and Pandas
- Exploratory Data Analysis (EDA)
- Finding relationships between discounts and profitability
- Identifying loss-making products, sub-categories and customers
- Working with dates and analyzing trends over time
- SQL analysis using MySQL
- Writing business-focused SQL queries
- Creating KPIs and DAX measures in Power BI
- Building an interactive 3-page Power BI report
- Turning analysis into business recommendations
- Documenting and presenting an end-to-end analytics project
- Using Git and GitHub to version and present the project

---

## Dataset

I used the **Sample Superstore** dataset.

The dataset contains:

- 9,994 rows
- 21 columns
- Orders and customer information
- Product and category information
- Sales, quantity, discount and profit
- Region and location information
- Order and shipping dates

The data covers **2014 to 2017**.

---

## Data Cleaning

Before doing the analysis, I checked the dataset for common data-quality problems.

I checked:

- Missing values
- Duplicate rows
- Invalid dates
- Extra spaces in text fields
- Negative sales
- Invalid quantities
- Invalid discount values
- Data types

After cleaning and validation:

- Rows: **9,994**
- Columns: **21**
- Missing cells: **0**
- Duplicate rows: **0**
- Negative sales: **0**
- Invalid quantities: **0**
- Invalid discounts: **0**

The cleaned dataset is available in the `data/cleaned` folder.

---

## Some Interesting Findings

### Discounts and profit

One of the strongest patterns I found was around discounts.

Transactions with discounts of **30% or more** represented:

- **72.05% of all loss-making transactions**
- **88.72% of the total loss amount**

This does not prove that discounts directly caused the losses, but the relationship was strong enough to make discounting one of the main areas I investigated.

---

### Furniture has high sales but weak profitability

Furniture generated around **$742K in sales**, but its profit was only about **$18K**.

Its profit margin was:

**2.49%**

For comparison:

| Category | Sales | Profit | Margin |
|---|---:|---:|---:|
| Furniture | $742K | $18K | 2.49% |
| Office Supplies | $719K | $122K | 17.04% |
| Technology | $836K | $145K | 17.40% |

So looking only at sales would have hidden an important problem.

---

### Tables were a major profit leak

The Tables sub-category generated approximately:

- Sales: **$207K**
- Profit: **-$17.7K**
- Profit margin: **-8.56%**

This made Tables one of the areas I investigated more closely.

---

### Central was the weakest region by margin

The regional profit margins were:

| Region | Profit Margin |
|---|---:|
| West | 14.94% |
| East | 13.48% |
| South | 11.93% |
| Central | 7.92% |

Central had the lowest margin.

When I broke the Central region down further, Furniture was loss-making overall, which gave another useful direction for the investigation.

---

### Loss frequency is not the same as loss severity

Another thing I found was that the sub-category with the most loss-making transactions was not necessarily the one with the biggest financial impact.

For example:

- **Binders** had a large number of loss-making transactions.
- **Tables** had a large total loss.
- **Machines** had fewer loss transactions but some very large individual losses.

This is why I looked at both **how often losses happened** and **how large the losses were**.

---

## Power BI Report

I created a 3-page Power BI report.

### Page 1 — Executive Overview

This page gives a quick overview of the business:

- Total Sales
- Total Profit
- Profit Margin
- Total Orders
- Total Customers
- Total Quantity
- Profit by Category
- Profit by Region
- Profit by Discount Level
- Profit Trend

### Page 2 — Profit Leak Investigation

This page goes deeper into the loss-making areas:

- Loss by Sub-Category
- Profit by Discount Level
- Loss-Making Transactions by Sub-Category
- Top Loss-Making Products
- Loss Frequency vs Loss Severity
- Loss Transactions by Discount Group

### Page 3 — Regional & Customer Deep Dive

This page focuses on:

- Profit by Region
- Profit Margin by Region
- Profit by Region and Category
- Top Loss-Making Customers
- Top Loss-Making Transactions
- Total Loss by Region

Screenshots of the report are available in the `screenshots` folder.

---

## Business Recommendations

Based on what I found in the analysis, I would recommend:

1. Review the current discount strategy, especially discounts of 30% and above.
2. Investigate pricing and discounting for loss-making sub-categories such as Tables and Bookcases.
3. Look more closely at the Central region, particularly its Furniture performance.
4. Monitor unusually large loss transactions individually.
5. Track both the number of loss transactions and the total amount lost.
6. Include profit margin along with sales when evaluating products and customers.

---

## Project Structure

```text
Retail-Profit-Leak-Detective/
│
├── data/
│   └── cleaned/
│       └── superstore_cleaned.csv
│
├── documentation/
│   └── Retail_Profit_Leak_Detective_Documentation.docx
│
├── power BI/
│   └── Retail_Profit_Leak_Detective.pbix
│
├── python/
│   └── Retail_Profit_Leak_Detective_EDA.ipynb
│
├── screenshots/
│   ├── page1_executive_overview.png
│   ├── page2_profit_leak_investigation.png
│   └── page3_regional_customer_deep_dive.png
│
├── sql/
│   └── retail_profit_leak.sql
│
└── README.md

```
## Author

**Naresh Ireni**

Aspiring Data Analyst | Python | SQL | Power BI

Built as part of my Data Analyst portfolio to practice an end-to-end analytics workflow.
