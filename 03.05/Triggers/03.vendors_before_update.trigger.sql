USE ap;

DROP TRIGGER IF EXISTS vendors_before_update;

-- Change statement delimiter from semicolon to double front slash (needed because the semicolon is used within the CREATE PROCEDURE statement, it allows // to define the end of the CREATE PROCEDURE statement (it is also common to use $$)
DELIMITER //

CREATE TRIGGER vendors_before_update
	BEFORE UPDATE ON vendors
	FOR EACH ROW
BEGIN
	SET NEW.vendor_state = UPPER(NEW.vendor_state);
END//

-- Change statement delimiter back to default
DELIMITER ;

SELECT * FROM vendors WHERE vendor_id = 1;

UPDATE vendors
SET vendor_state = 'xx'
WHERE vendor_id = 1;

SELECT * FROM vendors WHERE vendor_id = 1;