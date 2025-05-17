# SQL-DATA-ANALYSIS

# SQL Assessment Solutions

This repository contains my solution to the SQL Proficiency Assessment.

## Question 1: High-Value Customers with Multiple Products

### Approach:
To identify high-value customers who have both regular savings and investment plans with confirmed deposits, I joined the `users_customuser`, `plans_plan`, and `savings_savingsaccount` tables. I counted distinct plans of each type per user where confirmed deposits exist, summed the total confirmed deposits, and filtered for customers having at least one active savings and one active investment plan. The results were grouped by user and ordered by total deposits in descending order to highlight the highest value customers.

---

## Question 2: Transaction Frequency Analysis

### Approach:
I analyzed customer transaction frequency by month using a Common Table Expression (CTE). First, I aggregated transactions per customer per month, then calculated the average monthly transactions per customer. Based on the average, I categorized customers into High, Medium, and Low frequency groups. Finally, I summarized the count of customers in each category along with their average transactions per month, ordering the results by frequency level.

---

## Question 3: Account Inactivity Alert

### Approach:
To detect inactive accounts, I joined the `plans_plan` and `savings_savingsaccount` tables and filtered for active, non-archived, and non-deleted plans. I identified the last transaction date per plan and calculated the number of days since that last transaction. Plans with inactivity of 365 days or more were flagged. The output includes plan ID, owner ID, plan type (Savings or Investment), last transaction date, and inactivity duration, ordered by longest inactivity.

---

## Question 4: Customer Lifetime Value (CLV) Estimation

### Approach:
I estimated Customer Lifetime Value by first calculating each customer's tenure in months, total transactions, and average transaction amount using a CTE that joins users, plans, and savings accounts. Using these metrics, I computed an estimated CLV formula that annualizes transaction frequency and adjusts for average transaction size, scaled down appropriately. The results were ordered by estimated CLV in descending order to identify the most valuable customers.

---

## Challenges Encountered

- **Handling Multiple Product Types:** Differentiating between savings and investment plans required careful conditional aggregation and filtering to ensure accurate counts and sums.
- **Date Formatting and Calculations:** Calculating monthly transaction frequencies and inactivity periods involved precise date functions and formatting, which varied slightly depending on SQL dialects.
- **CLV Calculation Complexity:** Designing a meaningful CLV formula that balances tenure, transaction frequency, and amount required assumptions and scaling factors to produce interpretable results.
- **Performance Considerations:** Joining multiple large tables with aggregation and filtering demanded optimization, such as using CTEs and indexed columns, to maintain query efficiency.

These challenges were addressed by iterative query refinement, testing intermediate results, and leveraging SQL functions effectively to ensure correctness and performance.

---
