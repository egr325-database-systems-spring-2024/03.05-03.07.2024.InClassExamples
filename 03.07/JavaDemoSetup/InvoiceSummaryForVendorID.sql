USE ap;

DROP PROCEDURE IF EXISTS InvoiceSummaryForVendorID;

-- Change statement delimiter from semicolon to double front slash (needed because the semicolon is used within the CREATE PROCEDURE statement, it allows // to define the end of the CREATE PROCEDURE statement (it is also common to use $$)
DELIMITER //

CREATE PROCEDURE InvoiceSummaryForVendorID
(
	IN vendor_id_param int,
    OUT max_invoice_total DECIMAL(9,2),
    OUT min_invoice_total DECIMAL(9,2),
    OUT percent_difference DECIMAL(9,4),
    OUT count_invoice_id INT
)
BEGIN
	SELECT MAX(invoice_total), MIN(invoice_total), COUNT(invoice_id)
	INTO max_invoice_total, min_invoice_total, count_invoice_id
	FROM invoices WHERE vendor_id = vendor_id_param;
	
	SET percent_difference = (max_invoice_total - min_invoice_total)/min_invoice_total * 100;
END//

-- Change statement delimiter back to default
DELIMITER ;

CALL InvoiceSummaryForVendorID(95, @max, @min, @pct, @cnt);
SELECT 95, CONCAT('$', @max) AS 'Maximum invoice', 
		CONCAT('$', @min) AS 'Minimum invoice',
		CONCAT('%', ROUND(@pct, 2)) AS 'Percent difference',
		@cnt AS 'Number of invoices';
        
CALL InvoiceSummaryForVendorID(123, @max, @min, @pct, @cnt);
SELECT 123, CONCAT('$', @max) AS 'Maximum invoice', 
		CONCAT('$', @min) AS 'Minimum invoice',
		CONCAT('%', ROUND(@pct, 2)) AS 'Percent difference',
		@cnt AS 'Number of invoices';
        
CALL InvoiceSummaryForVendorID(90, @max, @min, @pct, @cnt);
SELECT 90, CONCAT('$', @max) AS 'Maximum invoice', 
		CONCAT('$', @min) AS 'Minimum invoice',
		CONCAT('%', ROUND(@pct, 2)) AS 'Percent difference',
		@cnt AS 'Number of invoices';