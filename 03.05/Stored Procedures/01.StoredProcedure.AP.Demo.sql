USE ap;

DROP PROCEDURE IF EXISTS test;

-- Change statement delimiter from semicolon to double front slash (needed because the semicolon is used within the CREATE PROCEDURE statement, it allows // to define the end of the CREATE PROCEDURE statement (it is also common to use $$)
DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE sum_balance_due_var DECIMAL(9,2);
	
	SELECT SUM(invoice_total - payment_total - credit_total)
	INTO sum_balance_due_var
	FROM invoices
	WHERE vendor_id = 95;
	
	IF sum_balance_due_var > 0 THEN	
		SELECT CONCAT('Balance due: $', sum_balance_due_var) AS message;
	ELSE
		SELECT 'Balance paid in full' AS message;
	END IF;
END//

-- Change statement delimiter back to default
DELIMITER ;

CALL test();