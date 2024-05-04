--Question:

-- Write an SQL query to find out the supplied_id, product_id, and starting date (record_date) for the records where the stock quantity is less than 50 for two or more consecutive days.

CREATE TABLE stock (
    supplier_id INT,
    product_id INT,
    stock_quantity INT,
    record_date DATE
);

-- Insert the data
delete from stock;
INSERT INTO stock (supplier_id, product_id, stock_quantity, record_date)
VALUES
    (1, 1, 60, '2022-01-01'),
    (1, 1, 40, '2022-01-02'),
    (1, 1, 35, '2022-01-03'),
    (1, 1, 45, '2022-01-04'),
 (1, 1, 51, '2022-01-06'),
 (1, 1, 55, '2022-01-09'),
 (1, 1, 25, '2022-01-10'),
    (1, 1, 48, '2022-01-11'),
 (1, 1, 45, '2022-01-15'),
    (1, 1, 38, '2022-01-16'),
    (1, 2, 45, '2022-01-08'),
    (1, 2, 40, '2022-01-09'),
    (2, 1, 45, '2022-01-06'),
    (2, 1, 55, '2022-01-07'),
    (2, 2, 45, '2022-01-08'),
 (2, 2, 48, '2022-01-09'),
    (2, 2, 35, '2022-01-10'),
 (2, 2, 52, '2022-01-15'),
    (2, 2, 23, '2022-01-16');

with cte1 as (
select *,LAG(record_date,1,record_date)OVER(partition by supplier_id,product_id
order by record_date) lag1,
DATEDIFF(DAY,LAG(record_date,1,record_date)OVER(partition by supplier_id,product_id
order by supplier_id,product_id),
record_date) datediff1
from stock 
where stock_quantity<50)
,cte2 as(select * ,
case when datediff1<=1 then 0 else 1 end as flag1,
sum(case when datediff1<=1 then 0 else 1 end) 
OVER(partition by supplier_id,product_id
order by record_date) as sum1
from cte1 )
,cte3 as (select supplier_id,product_id, sum1, count(*) py,min(record_date) ky 
from cte2 group by supplier_id,product_id,sum1)
select supplier_id,product_id, ky as start_date from cte3
where py > 1

-- OUTPUT
/*
2022-01-02 
2022-01-10 
2022-01-15
2022-01-08
2022-01-08

*/





































































