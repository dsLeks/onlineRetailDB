-- 1. Trigger 
-- Trigger to make sure that user that has order placed is not deleted 
DELIMITER $$
CREATE TRIGGER check_order BEFORE DELETE ON general_user
FOR EACH ROW BEGIN 
	DECLARE is_order int; 
    SET is_order = 0; 
    SELECT count(*) INTO is_order FROM orders WHERE general_user = old.user_id; 
    IF (is_order>0) THEN 
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT='USER HAS ORDER PENDING CANNOT BE DELETED';
	END IF;
END $$
DELIMITER ; 

DELETE FROM general_user WHERE user_id=2; -- Cannot be deleted because user-2 has an order pending. 

-- 2. Trigger 
-- Trigger to make sure that only registered users are inserted into the regUser_rewardPoints table
DELIMITER $$
CREATE TRIGGER checkRegistered BEFORE INSERT ON regUser_rewardPoints
FOR EACH ROW BEGIN 
	DECLARE reg int;
    SET reg=0;
    SELECT is_registered INTO reg FROM general_user WHERE user_id = new.user; 
    IF(reg=0) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='USER IS NOT REGISTERED';
	END IF;
END $$
DELIMITER ;

INSERT INTO regUser_rewardPoints(user, rewardPoint) VALUES (1,1); -- Cannot be inserted because user-1 is not registered.

-- 3. Procedure
-- Will return the rows in which users are either registered or unregistered 
DELIMITER $$
CREATE PROCEDURE SelectRegUnregUsers(IN reg INT(1))
BEGIN 
	SELECT * FROM general_user WHERE is_registered=reg; 
END $$
DELIMITER ; 

CALL SelectRegUnregUsers(1);

-- 4. Function 
-- Find the number of premium users who are registered for a mailing list.
DELIMITER $$
CREATE FUNCTION premMailingLists() 
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE num int;
	SET num=0;
	SELECT COUNT(*) INTO num FROM user_register_mail JOIN account ON user_register_mail.user=account.general_user WHERE account.account_type=1;
	RETURN num;
END$$
DELIMITER ;

SELECT premMailingLists(); -- Returns 1. 