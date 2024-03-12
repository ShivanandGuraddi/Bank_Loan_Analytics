#KPI_1

select
count(id)
from bank_lone_data.financial_loan ;

select
count(id)
from bank_lone_data.financial_loan
where month(issue_date) = 12 ;

select
count(id)
from bank_lone_data.financial_loan
where month(issue_date) = 11 ;

select
month(issue_date) as month
,monthname(issue_date) as month_name
,(count(id) - lag(count(id)) over(order by month(issue_date))) as 'MoM change'
from bank_lone_data.financial_loan
group by month,month_name
order by month ;


#KPI_2

select
sum(loan_amount) as Total_loan_amount
from bank_lone_data.financial_loan ;

select
sum(loan_amount) as Total_loan_amount
from bank_lone_data.financial_loan
where month(issue_date) = 12 ;

select
sum(loan_amount) as Total_loan_amount
from bank_lone_data.financial_loan
where month(issue_date) = 11 ;

select
month(issue_date) as month
,monthname(issue_date) as month_name
,(sum(loan_amount) - lag(sum(loan_amount)) over(order by month(issue_date))) as 'MoM change'
from bank_lone_data.financial_loan
group by month,month_name
order by month ;


#KPI_3

select
sum(total_payment) as Total_payment
from bank_lone_data.financial_loan ;

select
sum(total_payment) as Total_payment
from bank_lone_data.financial_loan
where month(issue_date) = 12 ;

select
sum(total_payment) as Total_payment
from bank_lone_data.financial_loan
where month(issue_date) = 11 ;

select
month(issue_date) as month
,monthname(issue_date) as month_name
,(sum(total_payment) - lag(sum(total_payment)) over(order by month(issue_date))) as 'MoM change'
from bank_lone_data.financial_loan
group by month,month_name
order by month ;


# KPI_4

select
avg(int_rate)*100 as Int_rate
from bank_lone_data.financial_loan ;

select
avg(int_rate)*100 as Int_rate
from bank_lone_data.financial_loan
where month(issue_date) = 12 ;

select
avg(int_rate)*100 as Int_rate
from bank_lone_data.financial_loan
where month(issue_date) = 11 ;

select
month(issue_date) as month
,monthname(issue_date) as month_name
,(avg(int_rate) - lag(avg(int_rate)) over(order by month(issue_date)))*100 as 'MoM change'
from bank_lone_data.financial_loan
group by month,month_name
order by month ;


# KPI_5

select
avg(dti)*100 as DtI
from bank_lone_data.financial_loan ;

select
avg(dti)*100 as DtI
from bank_lone_data.financial_loan
where month(issue_date) = 12 ;

select
avg(dti)*100 as DtI
from bank_lone_data.financial_loan
where month(issue_date) = 11 ;

select
month(issue_date) as month
,monthname(issue_date) as month_name
,(avg(dti) - lag(avg(dti)) over(order by month(issue_date)))*100 as 'MoM change'
from bank_lone_data.financial_loan
group by month,month_name
order by month ;


# Good Loan KPI's

# KPI_1

select
count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)/count(id)*100 as '%Good_loan'
from bank_lone_data.financial_loan ;

# KPI_2

select
count(id) as 'Total_Good_loan'
from bank_lone_data.financial_loan
where loan_status = 'fully paid' or loan_status = 'current'; ;

# KPI_3

select
sum(loan_amount) as 'Good_loan_amount'
from bank_lone_data.financial_loan
where loan_status = 'fully paid' or loan_status = 'current';

# KPI_4

select
sum(total_payment) as 'Good_loan_Amount_Recived'
from bank_lone_data.financial_loan
where loan_status = 'fully paid' or loan_status = 'current' ;

# Bad Loan KPIs:

# KPI_1

select
count(case when loan_status = 'Charged off' then id end)/count(id)*100 as '%Bad_loan'
from bank_lone_data.financial_loan ;

# KPI_2

select
count(id) as 'Total_Bad_loan'
from bank_lone_data.financial_loan
where loan_status = 'Charged off' ;

# KPI_3

select
sum(loan_amount) as 'Bad_loan_amount'
from bank_lone_data.financial_loan
where loan_status = 'Charged off' ;

# KPI_4

select
sum(total_payment) as 'Bad_loan_Amount_Recived'
from bank_lone_data.financial_loan
where loan_status = 'Charged off' ;


#Loan Status Grid View
select
loan_status
,count(id) as 'Total Loan Applications'
,sum(loan_amount) as 'Total Funded Amount'
,sum(total_payment) as 'Total Amount Received'
,sum(case when month(issue_date) = 12 then loan_amount end) as 'MTD Funded Amount'
,sum(case when month(issue_date) = 12 then total_payment end) as 'MTD Total Amount Recived'
,avg(int_rate)*100 as 'Avg Int Rate'
,avg(dti)*100 as 'Avg dti'
from bank_lone_data.financial_loan
group by loan_status;

# Monthly Trends by Issue Date('Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received')
select 
month(issue_date) as Month
,monthname(issue_date) as 'month name'
,count(id) as 'Total Loan Applications'
,sum(loan_amount) as 'Total Funded Amount'
,sum(total_payment) as 'Total Amount Received'
from bank_lone_data.financial_loan
group by month,monthname(issue_date)
order by month ;

# Regional Analysis by State(Filled Map): (States and'Total Loan Applications', 'Total Funded Amount', and 'Total Amount Received')
select
address_state
,count(id) as 'Total Loan Applications'
,sum(loan_amount) as 'Total Funded Amount'
,sum(total_payment) as 'Total Amount Received'
from bank_lone_data.financial_loan
group by address_state ;

# Loan Term Analysis (Donut Chart):(Loan Terms and 'Total Loan Applications', 'Total Funded Amount', and 'Total Amount Received')

select
term as 'Loan Term'
,count(id) as 'Total Loan Applications'
,sum(loan_amount) as 'Total Funded Amount'
,sum(total_payment) as 'Total Amount Received'
from bank_lone_data.financial_loan
group by term ;

# Employee Length Analysis (Bar Chart):(Employee Length Categories and 'Total Loan Applications', 'Total Funded Amount', and 'Total Amount Received')
select
emp_length as 'Employee Length'
,count(id) as 'Total Loan Applications'
,sum(loan_amount) as 'Total Funded Amount'
,sum(total_payment) as 'Total Amount Received'
from bank_lone_data.financial_loan
group by emp_length
order by emp_length ;

# Loan Purpose Breakdown (Bar Chart):(Loan Purpose and 'Total Loan Applications', 'Total Funded Amount', and 'Total Amount Received')
select
purpose
,count(id) as 'Total Loan Applications'
,sum(loan_amount) as 'Total Funded Amount'
,sum(total_payment) as 'Total Amount Received'
from bank_lone_data.financial_loan
group by purpose ;

# Home Ownership Analysis (Tree Map):(Home Ownership and 'Total Loan Applications', 'Total Funded Amount', and 'Total Amount Received')
select
home_ownership as 'Home ownership'
,count(id) as 'Total Loan Applications'
,sum(loan_amount) as 'Total Funded Amount'
,sum(total_payment) as 'Total Amount Received'
from bank_lone_data.financial_loan
group by home_ownership