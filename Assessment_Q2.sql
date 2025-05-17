WITH CustomerTransactions AS (
    SELECT
        u.id AS customer_id,
        u.name AS customer_name,
        DATE_FORMAT(s.transaction_date, '%%Y-%%m-01') AS month,
        COUNT(*) AS transactions_in_month
    FROM
        users_customuser u
    JOIN
        plans_plan p ON u.id = p.owner_id
    JOIN
        savings_savingsaccount s ON p.id = s.plan_id
    WHERE
        s.confirmed_amount > 0
    GROUP BY
        u.id, u.name, DATE_FORMAT(s.transaction_date, '%%Y-%%m-01')
),
CustomerAvgTransactions AS (
    SELECT
        customer_id,
        customer_name,
        AVG(transactions_in_month) AS avg_transactions_per_month
    FROM
        CustomerTransactions
    GROUP BY
        customer_id, customer_name
),
CustomerFrequency AS (
    SELECT
        customer_id,
        customer_name,
        avg_transactions_per_month,
        CASE
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month >= 3 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM
        CustomerAvgTransactions
)
SELECT
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM
    CustomerFrequency
GROUP BY
    frequency_category
ORDER BY
    CASE
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        WHEN frequency_category = 'Low Frequency' THEN 3
    END;
