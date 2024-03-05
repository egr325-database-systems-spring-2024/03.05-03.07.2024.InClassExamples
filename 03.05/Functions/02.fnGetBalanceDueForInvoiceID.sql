USE ap;

DROP FUNCTION IF EXISTS fnGetBalanceDueForInvoiceID;

-- Change statement delimiter from semicolon to double front slash (needed because the semicolon is used within the CREATE PROCEDURE statement, it allows // to define the end of the CREATE PROCEDURE statement (it is also common to use $$)
DELIMITER //

CREATE FUNCTION fnGetBalanceDueForInvoiceID
(
	invoice_id_param INT
)
RETURNS DECIMAL(9,2)
DETERMINISTIC
BEGIN
	DECLARE balance_due_var DECIMAL(9,2);
	
	SELECT invoice_total - payment_total - credit_total
	INTO balance_due_var
	FROM invoices
	WHERE invoice_id = invoice_id_param;
	
	RETURN(balance_due_var);
END//

-- Change statement delimiter back to default
DELIMITER ;

SELECT
	vendor_id,
	invoice_number,
    invoice_id,
	fnGetBalanceDueForInvoiceID(invoice_id) AS balance_due
FROM invoices
WHERE 
	vendor_id = 37;