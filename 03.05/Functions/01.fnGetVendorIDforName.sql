USE ap;
DROP FUNCTION IF EXISTS fnGetVendorIdForName;

-- Change statement delimiter from semicolon to double front slash (needed because the semicolon is used within the CREATE PROCEDURE statement, it allows // to define the end of the CREATE PROCEDURE statement (it is also common to use $$)
DELIMITER //

CREATE FUNCTION fnGetVendorIdForName
(
	vendor_name_param VARCHAR(50)
)
RETURNS INT
DETERMINISTIC  -- Must have DETERMINISTIC, NO SQL, or READS SQL DATA in the declaration - need DETERMINISTIC for this to work 
BEGIN
	DECLARE vendor_id_var INT;
	
	SELECT vendor_id
	INTO vendor_id_var
	FROM vendors
	WHERE vendor_name = vendor_name_param;
	
	RETURN(vendor_id_var);
END//

-- Change statement delimiter back to default
DELIMITER ;

SELECT
	invoice_number,
	invoice_total
FROM invoices
WHERE 
	vendor_id = fnGetVendorIdForName('IBM');