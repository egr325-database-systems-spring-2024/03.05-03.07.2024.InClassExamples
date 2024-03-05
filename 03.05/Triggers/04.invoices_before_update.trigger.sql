USE ap;

DROP TRIGGER IF EXISTS invoices_before_update;

-- Change statement delimiter from semicolon to double front slash (needed because the semicolon is used within the CREATE PROCEDURE statement, it allows // to define the end of the CREATE PROCEDURE statement (it is also common to use $$)
DELIMITER //

CREATE TRIGGER invoices_before_update
	BEFORE UPDATE ON invoices
	FOR EACH ROW
BEGIN
	DECLARE sum_line_item_amount DECIMAL(9,2);
	
	SELECT SUM(line_item_amount)
	INTO sum_line_item_amount
	FROM invoice_line_items
	WHERE invoice_id = NEW.invoice_id;
	
	IF sum_line_item_amount != NEW.invoice_total THEN
		SIGNAL SQLSTATE 'HY000'
		   SET MESSAGE_TEXT = 'Line item total must match invoice total.',
		   MYSQL_ERRNO = 1290;
	END IF;
END//

-- Change statement delimiter back to default
DELIMITER ;

SELECT SUM(line_item_amount) FROM invoice_line_items WHERE invoice_id = 100;

UPDATE invoices
SET invoice_total = 1000.00
WHERE invoice_id = 100;