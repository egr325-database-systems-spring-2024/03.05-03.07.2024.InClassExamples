DROP PROCEDURE IF EXISTS test;

-- Change statement delimiter from semicolon to double front slash (needed because the semicolon is used within the CREATE PROCEDURE statement, it allows // to define the end of the CREATE PROCEDURE statement (it is also common to use $$)
DELIMITER //

CREATE PROCEDURE test()
BEGIN
	SELECT 'This is a test.' AS message;
END//

-- Change statement delimiter back to default
DELIMITER ;

CALL test();