WITH CustomerMetrics AS (
    SELECT
        u.id AS customer_id,
        u.name AS name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE()) AS tenure_months,
        COUNT(s.id) AS total_transactions,
        AVG(s.confirmed_amount) AS avg_transaction_amount
    FROM
        users_customuser u
    JOIN
        plans_plan p ON u.id = p.owner_id
    JOIN
        savings_savingsaccount s ON p.id = s.plan_id
    WHERE
        s.confirmed_amount > 0
    GROUP BY
        u.id, u.name, u.date_joined
    HAVING
        tenure_months > 0
)
SELECT
    customer_id,
    name,
    tenure_months,
    total_transactions,
    ROUND(
        (total_transactions / tenure_months) * 12 * (avg_transaction_amount * 0.001) / 100,
        2
    ) AS estimated_clv
FROM
    CustomerMetrics
ORDER BY
    estimated_clv DESC;
