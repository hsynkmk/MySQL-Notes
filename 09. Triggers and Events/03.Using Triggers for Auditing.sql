USE sql_invoicing;

DELIMITER $$
DROP TRIGGER IF EXISTS payment_after_insert;
CREATE TRIGGER payment_after_insert
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
    
    INSERT INTO payments_audit
    VALUES (NEW.client_id, NEW.date, NEW.amount, 'Insert', NOW());
END$$

DELIMITER ;


DELIMITER $$
DROP TRIGGER IF EXISTS payment_after_delete;
CREATE TRIGGER payment_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + OLD.amount
    WHERE invoice_id = OLD.invoice_id;
    
    INSERT INTO payments_audit
    VALUES (OLD.client_id, OLD.date, OLD.amount, 'Delete', NOW());
END$$

DELIMITER ;


INSERT INTO payments
VALUES (DEFAULT, 5, 3, '2019-01-01', 10, 1);

DELETE FROM payments
WHERE payment_id = 11;