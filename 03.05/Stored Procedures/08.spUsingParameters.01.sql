USE ap;

DROP PROCEDURE IF EXISTS test;

-- Change statement delimiter from semicolon to double front slash (needed because the semicolon is used within the CREATE PROCEDURE statement, it allows // to define the end of the CREATE PROCEDURE statement (it is also common to use $$)
DELIMITER //

CREATE PROCEDURE test
(
	IN vendor_id_param int,
    OUT count_invoice_id int
)
BEGIN
	DECLARE max_invoice_total DECIMAL(9,2);
	DECLARE min_invoice_total DECIMAL(9,2);
	DECLARE percent_difference DECIMAL(9,4);
	-- DECLARE count_invoice_id INT;
	
	SELECT MAX(invoice_total), MIN(invoice_total), COUNT(invoice_id)
	INTO max_invoice_total, min_invoice_total, count_invoice_id
	FROM invoices WHERE vendor_id = vendor_id_param;
	
	SET percent_difference = (max_invoice_total - min_invoice_total)/min_invoice_total * 100;
	
	SELECT CONCAT('$', max_invoice_total) AS 'Maximum invoice', 
		CONCAT('$', min_invoice_total) AS 'Minimum invoice',
		CONCAT('%', ROUND(percent_difference, 2)) AS 'Percent difference',
		count_invoice_id AS 'Number of invoices';
        
END//

-- Change statement delimiter back to default
DELIMITER ;

CALL test(95, @count);
SELECT @count AS count;
CALL test(123, @count);
SELECT @count AS count;
CALL test(90, @count);
SELECT @count AS count;