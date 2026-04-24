USE loan_financial;
SELECT * FROM financial_loan;

-- Good Loan Funded Amount
SELECT 
	(SUM(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN loan_amount END)) AS Good_loan_funded_amount
FROM financial_loan;

-- Good Loan Total Received Amount
SELECT 
	(SUM(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN total_payment END)) AS Good_loan_received_amount
FROM financial_loan;

-- Bad Loan Percentage 
SELECT

	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100) 

    / 

    (COUNT(id)) AS Bad_Loan_Percentage 

FROM financial_loan ;

-- Bad Loan Applications

SELECT COUNT(id) AS Bad_Loan_Application 

FROM financial_loan 

WHERE loan_status ='Charged Off' ;

-- Bad Loan Funded Amount
SELECT 
	(SUM(CASE WHEN loan_status = 'Charged Off' THEN loan_amount END)) AS Bad_loan_funded_amount
FROM financial_loan;

-- Bad Loan Total Received Amount
SELECT 
	(SUM(CASE WHEN loan_status = 'Charged Off' THEN total_payment END)) AS Bad_loan_received_amount
FROM financial_loan;

-- Loan Status
SELECT 
	loan_status,
	COUNT(id) AS Total_Loan_Applications,
    SUM(total_payment) AS Total_Loan_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate*100) AS Interest_Rate,
    AVG(dti*100) AS DTI
FROM financial_loan
GROUP BY loan_status;

SELECT 
	loan_status,
    SUM(total_payment) AS MTD_Total_Loan_Received,
    SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM financial_loan
WHERE MONTH(STR_TO_DATE(issue_date,'%d-%m-%Y')) = 12
GROUP BY loan_status;

-- BANK LOAN REPORT
-- MONTH
SELECT 
	MONTH(STR_TO_DATE(issue_date,'%d-%m-%Y')) AS Month_Number,
    MONTHNAME(STR_TO_DATE(issue_date,'%d-%m-%Y')) AS Month_Name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(total_payment) AS Total_Loan_Received,
    SUM(loan_amount) AS Total_Funded_Received 
FROM financial_loan
GROUP BY MONTH(STR_TO_DATE(issue_date,'%d-%m-%Y')), MONTHNAME(STR_TO_DATE(issue_date,'%d-%m-%Y'))
ORDER BY MONTH(STR_TO_DATE(issue_date,'%d-%m-%Y'));

-- STATE
SELECT 
	address_state,
    COUNT(id) AS Total_Loan_Applications,
    SUM(total_payment) AS Total_Loan_Received,
    SUM(loan_amount) AS Total_Funded_Received 
FROM financial_loan
GROUP BY address_state
ORDER BY address_state;

-- TERM
SELECT 
	term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(total_payment) AS Total_Loan_Received,
    SUM(loan_amount) AS Total_Funded_Received 
FROM financial_loan
GROUP BY term
ORDER BY term;

-- Employee Length
SELECT 
	emp_length AS Employment_Length,
    COUNT(id) AS Total_Loan_Applications,
    SUM(total_payment) AS Total_Loan_Received,
    SUM(loan_amount) AS Total_Funded_Received 
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length;

-- Purpose
SELECT 
	purpose AS Purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(total_payment) AS Total_Loan_Received,
    SUM(loan_amount) AS Total_Funded_Received 
FROM financial_loan
GROUP BY purpose
ORDER BY purpose;

-- HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(total_payment) AS Total_Loan_Received,
    SUM(loan_amount) AS Total_Funded_Received 
FROM financial_loan
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;




    
    

    
    
	
    







