USE ap;

DROP PROCEDURE IF EXISTS test;

-- Change statement delimiter from semicolon to double front slash (needed because the semicolon is used within the CREATE PROCEDURE statement, it allows // to define the end of the CREATE PROCEDURE statement (it is also common to use $$)
DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE first_invoice_due_date DATE;
	
	SELECT MIN(invoice_due_date)
	INTO first_invoice_due_date
	FROM invoices
	WHERE invoice_total - payment_total - credit_total > 0;
	
	IF first_invoice_due_date < NOW() THEN
		SELECT 'Outstanding invoices overdue!';
	ELSEIF first_invoice_due_date = NOW() THEN	
		SELECT 'Outstanding invoices due TODAY!';
	ELSE
		SELECT 'No invoices are overdue.';
	END IF;
END//

-- Change statement delimiter back to default
DELIMITER ;

CALL test();