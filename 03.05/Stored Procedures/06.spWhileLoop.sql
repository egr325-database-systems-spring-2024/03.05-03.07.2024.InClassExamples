USE ap;

DROP PROCEDURE IF EXISTS test;

-- Change statement delimiter from semicolon to double front slash (needed because the semicolon is used within the CREATE PROCEDURE statement, it allows // to define the end of the CREATE PROCEDURE statement (it is also common to use $$)
DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE i INT DEFAULT 1;
	DECLARE s VARCHAR(400) DEFAULT '';
	
	WHILE i < 4 DO
		SET s = CONCAT(s, 'i=',i, ' | ');
		SET i = i + 1;
	END WHILE;
	
	SELECT s AS message;
END//

-- Change statement delimiter back to default
DELIMITER ;

CALL test();