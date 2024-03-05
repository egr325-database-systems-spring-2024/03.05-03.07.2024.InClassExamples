USE ap;

DROP PROCEDURE IF EXISTS test;

-- Change statement delimiter from semicolon to double front slash (needed because the semicolon is used within the CREATE PROCEDURE statement, it allows // to define the end of the CREATE PROCEDURE statement (it is also common to use $$)
DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE invoice_id_var INT;
	DECLARE invoice_total_var DECIMAL(9,2);
	DECLARE row_not_found TINYINT DEFAULT FALSE;
	DECLARE update_count INT DEFAULT 0;
	
	DECLARE invoices_cursor CURSOR FOR
		SELECT invoice_id, invoice_total FROM invoices
		WHERE invoice_total - payment_total - credit_total > 0;
		
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET row_not_found = TRUE;
		
	OPEN invoices_cursor;
	
	WHILE row_not_found = FALSE DO
		FETCH invoices_cursor INTO invoice_id_var, invoice_total_var;
		
		IF invoice_total_var > 1000 THEN
			UPDATE invoices
				SET credit_total = credit_total + (invoice_total* .1)
				WHERE invoice_id = invoice_id_var;
			SET update_count = update_count + 1;
		END IF;
		
	END WHILE;
	
	CLOSE invoices_cursor;
	
	SELECT CONCAT(update_count, ' rows(s) updated.');
END//

-- Change statement delimiter back to default
DELIMITER ;

CALL test();