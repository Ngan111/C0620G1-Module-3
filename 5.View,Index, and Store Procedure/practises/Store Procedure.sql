SELECT * FROM classicmodels.customers;
DELIMITER //

CREATE PROCEDURE findCusById

(IN cusNum INT(11))

BEGIN

  SELECT * FROM customers WHERE customerNumber = cusNum;

END //

DELIMITER ;
call findCusById(119);

