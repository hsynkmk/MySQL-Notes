USE sql_store;

CREATE INDEX idx_state_points ON customers (state, points);

SELECT customer_id FROM customers WHERE state = 'CA' AND points > 1000;

-- SHOW STATUS LIKE 'last_query_cost';