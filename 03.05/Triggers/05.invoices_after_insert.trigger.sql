USE ap;

DROP TRIGGER IF EXISTS invoices_after_insert;
DROP TRIGGER IF EXISTS invoices_after_update;
DROP TRIGGER IF EXISTS invoices_after_delete;
DROP TABLE IF EXISTS invoices_audit;

CREATE TABLE invoices_audit
(
	vendor_id INT NOT NULL,
	invoice_number VARCHAR(50) NOT NULL,
	invoice_total DECIMAL(9,2) NOT NULL,
	action_type VARCHAR(50) NOT NULL,
	action_date DATETIME NOT NULL
);

-- Change statement delimiter from semicolon to double front slash (needed because the semicolon is used within the CREATE PROCEDURE statement, it allows // to define the end of the CREATE PROCEDURE statement (it is also common to use $$)
DELIMITER //

CREATE TRIGGER invoices_after_insert
	AFTER INSERT ON invoices
	FOR EACH ROW
BEGIN
	INSERT INTO invoices_audit 
	VALUES
	(
		NEW.vendor_id,
		NEW.invoice_number,
		NEW.invoice_total, 
		'INSERTED',
		NOW()
	);
END//


CREATE TRIGGER invoices_after_update
	AFTER UPDATE ON invoices
	FOR EACH ROW
BEGIN
	INSERT INTO invoices_audit 
	VALUES
	(
		NEW.vendor_id,
		NEW.invoice_number,
		NEW.invoice_total, 
		'UPDATED',
		NOW()
	);
END//

CREATE TRIGGER invoices_after_delete
	AFTER DELETE ON invoices
	FOR EACH ROW
BEGIN
	INSERT INTO invoices_audit 
	VALUES
	(
		OLD.vendor_id,
		OLD.invoice_number,
		OLD.invoice_total, 
		'DELETED',
		NOW()
	);
END//

-- Change statement delimiter back to default
DELIMITER ;

INSERT INTO invoices VALUES
(115, 34, 'ZXA-080', '2015-02-01', 14092.59, 0, 0, 3, '2015-02-01', NULL);

UPDATE invoices
	SET payment_total = 59.37
    WHERE invoice_id < 5;

DELETE FROM invoices WHERE invoice_id = 115;

SELECT * FROM invoices_audit;