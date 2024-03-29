USE sql_invoicing;

DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$

CREATE PROCEDURE get_clients_by_state(state CHAR(2))
BEGIN
	IF state IS NULL THEN
		SELECT * FROM clients;
    ELSE
		SELECT * FROM clients c
		WHERE c.state = state;
    END IF;
END$$

-- CREATE PROCEDURE get_clients_by_state(state CHAR(2))
-- BEGIN
-- 	SELECT * FROM clients c
--     WHERE c.state = IFNULL(state, c.state);
-- END$$

DELIMITER ;
CALL get_clients_by_state(NULL);