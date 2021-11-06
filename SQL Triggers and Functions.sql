#Creating a table within Synthea Database
CREATE TABLE KaieeB_Hospital (
id INT AUTO_INCREMENT PRIMARY KEY,
patientUID INT NOT NULL,
lastname VARCHAR(50) NOT NULL,
firstname VARCHAR(50) NOT NULL,
SystolicBloodPressure INT NOT NULL
);

#Inserting new data into clinical_data table in Synthea DB
INSERT INTO clinical_data (patientUID, lastname, systolic,
diastolic) VALUES (77777, 'Kaiee', 120, 70);

#Creating a Trigger
delimiter $$
CREATE TRIGGER KaieeB_Systolic BEFORE INSERT ON clinical_data
FOR EACH ROW
BEGIN
	IF NEW.systolic >= 300 THEN
	   SIGNAL SQLSTATE '45000'
	   SET MESSAGE_TEXT = 'ERROR: Systolic BP MUST BE BELOW 300 mg!';
	END IF;
END; $$

delimiter ;

#Creating a Function
DELIMITER $$
CREATE FUNCTION overnightCost(
    cost DECIMAL(10,2)
)

RETURNS VARCHAR(20)
BEGIN
DECLARE overnightCost VARCHAR(20);
IF cost > 1000 THEN
SET overnightCost = ‘expensive’;

ELSEIF cost < 1000 THEN
SET overnightCost = ‘inexpensive’;
END IF;
-- return the overnight cost category
RETURN (overnightCost);
END; $$

#TO VIEW ADDED FUNCTION (OVERNIGHTCOST)
show function status;