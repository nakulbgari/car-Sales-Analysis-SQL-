-- 1. Create main table (careful types)
drop table car_prices;
CREATE TABLE public.car_prices (
  year            INTEGER,
  make            VARCHAR(100),
  model           VARCHAR(200),
  trim            VARCHAR(150),
  body            VARCHAR(80),
  transmission    VARCHAR(80),
  vin             VARCHAR(64),
  state           VARCHAR(50),
  condition       DOUBLE PRECISION,
  odometer        DOUBLE PRECISION,
  color           VARCHAR(80),
  interior        VARCHAR(100),
  seller          VARCHAR(255),
  mmr             DOUBLE PRECISION,
  sellingprice    DOUBLE PRECISION,
  saledate        Text
);



select * from public.car_prices;

--Q1 How many cars sold by each states?
select state, count(*) from public.car_prices
group by state;

create temporary table car_price_valid as
select * from public.car_prices
where body != 'Navitgation';

select state, count(*) from car_price_valid
group by state;

--Q2 Which kind of cars are most popular. How many sales have been made for each make and model?
select make, model, count(*)
from car_price_valid
group by make, model
order by count(*) desc;

--Q3 Are there differences in sale prices for each state? whats the average sale price for cars in each state?
select state, avg(sellingprice) as avg_selling_price
from car_price_valid
group by state
order by avg_selling_price


--Q4 Find out the sale prices for cars over time.What is the average sale price for cars sold in each month and year?

SELECT
  saledate,
  'year' as manufactured_year,
make,
model,
trim,
body,
transmission,
vin,
state,
'condition' as car_condition,
odometer,
color,
interior,
seller,
mmr,
sellingprice,
saledate,
  
  substring(saledate FROM 12 FOR 4) AS sale_year,
  substring(saledate FROM 5 FOR 3) AS sale_monthname,
  substring(saledate FROM 9 FOR 2) AS sale_day,
  CASE substring(saledate FROM 5 FOR 3)
    WHEN 'Jan' THEN 1
    WHEN 'Feb' THEN 2
    WHEN 'Mar' THEN 3
    WHEN 'Apr' THEN 4
    WHEN 'May' THEN 5
    WHEN 'Jun' THEN 6
    WHEN 'Jul' THEN 7
    WHEN 'Aug' THEN 8
    WHEN 'Sep' THEN 9
    WHEN 'Oct' THEN 10
    WHEN 'Nov' THEN 11
    WHEN 'Dec' THEN 12
    ELSE NULL
  END AS sale_month
FROM car_price_valid
LIMIT 1000;

SELECT
  sale_year,
  sale_month,
  AVG(sellingprice) AS avg_selling_price,
  COUNT(*) AS rows_count
FROM (
  SELECT
    sellingprice,
    substr(saledate, 12, 4)::int AS sale_year,
    CASE substr(saledate, 5, 3)
      WHEN 'Jan' THEN 1 WHEN 'Feb' THEN 2 WHEN 'Mar' THEN 3 WHEN 'Apr' THEN 4
      WHEN 'May' THEN 5 WHEN 'Jun' THEN 6 WHEN 'Jul' THEN 7 WHEN 'Aug' THEN 8
      WHEN 'Sep' THEN 9 WHEN 'Oct' THEN 10 WHEN 'Nov' THEN 11 WHEN 'Dec' THEN 12
      ELSE NULL
    END AS sale_month
  FROM car_price_valid
  WHERE saledate IS NOT NULL
) t
GROUP BY sale_year, sale_month
ORDER BY sale_year, sale_month;

--Q5 which month of the year had the most sales?
select sale_month,
count(*) from
car_price_valid
group by sale_month
order by sale_month asc;

--Q6 What are the top 5 most selling models within each body type?

SELECT
    make,
    model,
    body,
    num_sales,
    body_rank
FROM (
    SELECT
        make,
        model,
        body,
        COUNT(*) AS num_sales,
        RANK() OVER (PARTITION BY body ORDER BY COUNT(*) DESC) AS body_rank
    FROM car_price_valid
    GROUP BY make, model, body
) s
WHERE body_rank <= 5
ORDER BY body ASC, num_sales DESC;




--Q7 Find any sales where the sale price is higher than the average for that model and how much higher it is than the average?
SELECT 
  make,
  model,
  vin,
  substr(saledate, 12, 4)::int AS sale_year,
  
  CASE substr(saledate, 5, 3)
      WHEN 'Jan' THEN 1 WHEN 'Feb' THEN 2 WHEN 'Mar' THEN 3 WHEN 'Apr' THEN 4
      WHEN 'May' THEN 5 WHEN 'Jun' THEN 6 WHEN 'Jul' THEN 7 WHEN 'Aug' THEN 8
      WHEN 'Sep' THEN 9 WHEN 'Oct' THEN 10 WHEN 'Nov' THEN 11 WHEN 'Dec' THEN 12
  END AS sale_month,

  substr(saledate, 9, 2)::int AS sale_day,
  
  sellingprice,
  AVG(sellingprice) OVER (PARTITION BY make, model) AS avg_model
FROM car_price_valid;




