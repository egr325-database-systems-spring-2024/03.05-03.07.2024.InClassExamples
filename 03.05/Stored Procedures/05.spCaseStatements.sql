USE ap;

DROP PROCEDURE IF EXISTS test;

-- Change statement delimiter from semicolon to double front slash (needed because the semicolon is used within the CREATE PROCEDURE statement, it allows // to define the end of the CREATE PROCEDURE statement (it is also common to use $$)
DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE terms_id_var INT;
	
	SELECT terms_id INTO terms_id_var
	FROM invoices WHERE invoice_id = 4;
	
	CASE terms_id_var
		WHEN 1 THEN
			SELECT 'Net due 10 days' AS Terms;
		WHEN 2 THEN
			SELECT 'Net due 20 days' AS Terms;
		WHEN 3 THEN 
			SELECT 'Net due 30 days' AS Terms;
		ELSE
			SELECT 'Net due more than 30 days' AS Terms;
	END CASE;
END//

-- Change statement delimiter back to default
DELIMITER ;

CALL test();