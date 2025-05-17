SELECT 
    u.id AS owner_id,
    u.name AS name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
    ROUND(SUM(s.confirmed_amount) / 100, 2) AS total_deposits
FROM 
    users_customuser u
JOIN 
    plans_plan p ON u.id = p.owner_id
JOIN 
    savings_savingsaccount s ON p.id = s.plan_id
GROUP BY 
    u.id, u.name
HAVING 
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 AND s.confirmed_amount > 0 THEN p.id END) > 0
    AND
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 AND s.confirmed_amount > 0 THEN p.id END) > 0
ORDER BY 
    total_deposits DESC;
