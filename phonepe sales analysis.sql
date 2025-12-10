create database phone_pay;

CREATE TABLE all_users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    join_date DATE
);
drop table all_transactions;
CREATE TABLE all_transactions (
    transaction_id VARCHAR(50) PRIMARY KEY,
	amount NUMERIC(12,2),
    user_id VARCHAR(50),
    service VARCHAR(50),
    service_type VARCHAR(50),
    payment_status VARCHAR(20),
    reason VARCHAR(100),
    date DATE,
    FOREIGN KEY (user_id) REFERENCES all_users(user_id)
);

CREATE TABLE recharge_bills (
    transaction_id VARCHAR(50),
    user_id VARCHAR(50),
    recharge_type VARCHAR(50),
    amount NUMERIC(12,2),
    date DATE,
    payment_status VARCHAR(20),
    reason VARCHAR(200),
    FOREIGN KEY (transaction_id) REFERENCES all_transactions(transaction_id),
    FOREIGN KEY (user_id) REFERENCES all_users(user_id)
);

CREATE TABLE money_transfer (
    transaction_id VARCHAR(50),
    user_id VARCHAR(50),
    transfer_type VARCHAR(50),
    amount NUMERIC(12,2),
    date DATE,
    payment_status VARCHAR(20),
    reason VARCHAR(200),
    FOREIGN KEY (transaction_id) REFERENCES all_transactions(transaction_id),
    FOREIGN KEY (user_id) REFERENCES all_users(user_id)
);

CREATE TABLE loan (
    transaction_id VARCHAR(50),
    user_id VARCHAR(50),
    loan_type VARCHAR(50),
    loan_amount NUMERIC(12,2),
    date DATE,
    payment_status VARCHAR(20),
    reason VARCHAR(200),
    FOREIGN KEY (transaction_id) REFERENCES all_transactions(transaction_id),
    FOREIGN KEY (user_id) REFERENCES all_users(user_id)
);

CREATE TABLE insurance (
    transaction_id VARCHAR(50),
    user_id VARCHAR(50),
    insurance_type VARCHAR(50),
    premium NUMERIC(12,2),
    date DATE,
    payment_status VARCHAR(20),
    reason VARCHAR(200),
    FOREIGN KEY (transaction_id) REFERENCES all_transactions(transaction_id),
    FOREIGN KEY (user_id) REFERENCES all_users(user_id)
);

COPY all_users
FROM 'C:\phone pe\all_user.csv'
DELIMITER ','
CSV HEADER;

COPY all_transactions
FROM 'C:\phone pe\all_transactions.csv'
DELIMITER ','
CSV HEADER;

COPY recharge_bills
FROM 'C:\phone pe\recharge biils.csv'
DELIMITER ','
CSV HEADER;

COPY money_transfer
FROM 'C:\phone pe\Money transfer.csv'
DELIMITER ','
CSV HEADER;

COPY loan
FROM 'C:\phone pe\loan.csv'
DELIMITER ','
CSV HEADER;

COPY insurance
FROM 'C:\phone pe\insurance.csv'
DELIMITER ','
CSV HEADER;

select * from all_users;
-------Basic Question--------

-- 1) Count total users in the system
select count(*) as total_user from all_users;

-- 2) Find total number of transactions (all services combined)
select count(*) as total_transaction from all_transactions;

-- 3) List all distinct service categories used by customers
select distinct service from all_transactions;

-- 4) Find total successful transactions
SELECT COUNT(*) AS successful_transactions
FROM all_transactions
WHERE payment_status = 'Successful';

-- 5) Find failed transactions count
SELECT COUNT(*) AS failed_transactions
FROM all_transactions
WHERE payment_status = 'Failed';

-- 6) Get top 5 users with highest number of transactions
select user_id, count(*) as total_trs from
all_transactions group by user_id
order by total_trs desc limit 5;

-- 7) Find total recharge amount
select sum(amount) as total_recharge_amount
from recharge_bills;

-- 8) List all loan types available
select distinct loan_type from loan;

-- 9) Count transactions for each payment status
select payment_status, count(transaction_id)
from all_transactions group by payment_status;

-- 10) Show latest transaction date in the entire system
select max(date) as latest_transactions
from all_transactions; 

-------Intermediate Questions-----------

-- 11) Monthly total amount across all services
select date_trunc('month', date) as month,
sum(amount) as total_transactions
from all_transactions
group by month
order by month;

-- 12) Find top 3 insurance types by premium collected
SELECT insurance_type, SUM(premium) AS total_premium
FROM insurance
GROUP BY insurance_type
ORDER BY total_premium DESC
LIMIT 3;

-- 13) Show user details of people who have taken at least one loan?
SELECT DISTINCT u.user_id, u.name, u.age, u.join_date
FROM all_users u
JOIN loan l ON u.user_id = l.user_id;

            --OR--
--Find users who have NOT taken any loan	
select user_id, name  from all_users where user_id 
not in (select user_id from loan);

-- 14) Compare successful vs failed payments in recharge
select payment_status, count(*)
from recharge_bills
group by payment_status;

-- 15) Count money transfers grouped by transfer_type
select transfer_type, count(*)
from money_transfer
group by transfer_type;

-- 16) Find top 10 highest loan amounts and their users
select user_id, loan_type, loan_amount
from loan  order by loan_amount
desc limit 10;

-- 17) Total amount spent by each user (all services combined)
SELECT user_id, SUM(amount) AS total_spent
FROM all_transactions
GROUP BY user_id
ORDER BY total_spent DESC;

-- 18) Which month had the highest number of failed transactions?
select date_trunc('month', date) as month,
count(*) as failed_transactions
from all_transactions
where payment_status = 'Failed'
group by month
order by failed_transactions desc
limit 1;

-- 19) Find all users who have done money transfers but never bought insurance
select distinct user_id from money_transfer
where user_id not in (select distinct user_id from insurance);

-- 20) Find the average premium collected per insurance type
select insurance_type, avg(premium) as avg_premium from 
insurance group by insurance_type;

--------Advanced Question-----------

-- 21) Find users who have used all four major services (Recharge, Money Transfer, Loan, Insurance)
select user_id from all_users
where user_id in (select user_id from insurance)
and user_id in (select user_id from loan)
and user_id in (select user_id from money_transfer)
and user_id in (select user_id from recharge_bills);

-- 22) Find repeat failed users (users who failed more than 3 times across any service)
select user_id , count(*) as failed_user
from all_transactions
where payment_status = 'Failed'
group by user_id
having count(*) > 3;

-- 23) Identify which service generates the highest revenue
select service, sum(amount) as highest_revenue
from all_transactions
group by service
order by highest_revenue desc limit 1;

-- 24) Compare monthly loans vs monthly insurance premiums
SELECT 
    COALESCE(l.month, i.month) AS month,
    l.total_loans,
    i.total_premiums
FROM 
    (
        SELECT DATE_TRUNC('month', date) AS month,
               SUM(loan_amount) AS total_loans
        FROM loan
        GROUP BY DATE_TRUNC('month', date)
    ) l
FULL JOIN 
    (
        SELECT DATE_TRUNC('month', date) AS month,
               SUM(premium) AS total_premiums
        FROM insurance
        GROUP BY DATE_TRUNC('month', date)
    ) i
ON l.month = i.month
ORDER BY month;

-- 25) Find most common failure reason across ALL services
select reason, count(*) as total_failure
from all_transactions
where payment_status = 'Failed'
group by reason
order by total_failure desc
limit 1;