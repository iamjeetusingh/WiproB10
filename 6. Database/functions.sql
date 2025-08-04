# string functions
	SELECT upper('wipro') AS result;
	SELECT lower('WIPRO') AS result;
	SELECT length('wipro') AS result;
	SELECT substring('wipro',1,4) AS result;
	SELECT replace('Apple','p','b') AS result;

# Number functions
	SELECT round(12.3456,2) AS result;
    SELECT floor(10.9) AS result;
    SELECT ceil(10.9) AS result;
    SELECT power(2,4) AS result;
    
# Date & time
	SELECT current_date() AS result;
    SELECT now() AS result;
    SELECT datediff('2025-08-04','1970-01-01') AS result;
    SELECT datediff((current_date()),'1970-01-01') AS result;
    
