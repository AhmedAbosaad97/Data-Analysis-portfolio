---Retreive dataset---

Select * From practice_Ecommerce_data

---Exploring the data---

Select Distinct(gender) From practice_Ecommerce_data

Select Distinct(city) From practice_Ecommerce_data

Select Distinct(income_bracket) From practice_Ecommerce_data

Select Distinct(preferred_category) From practice_Ecommerce_data

Select Distinct(category) From practice_Ecommerce_data

Select Distinct(order_day_of_week) From practice_Ecommerce_data




---look for missing values---

Select * From practice_Ecommerce_data
Where quantity IS NULL
   or shipping_cost IS NULL
   or age IS NULL
   or gender IS NULL
   or city IS NULL
   or income_bracket IS NULL
   or category IS NULL
   or price IS NULL
   or total_amount IS NULL
   or order_year IS NULL
   or order_month IS NULL
   or order_day_of_week IS NULL

---(No missing values found)---

---look for duplicates---

With CustomerDuplicates as(
SELECT 
    customer_id,
    shipping_cost,     
    gender,              
    city,              
    income_bracket,
    category,
    price,
    total_amount,
    order_year,
    order_month,
    order_day_of_week,
    COUNT(*) as occurrence_count
FROM ( SELECT Distinct
    customer_id,
    shipping_cost,     
    gender,              
    city,              
    income_bracket,
    category,
    price,
    total_amount,
    order_year,
    order_month,
    order_day_of_week
From practice_Ecommerce_data) unique_cusotmers
GROUP BY 
    customer_id,
    shipping_cost,     
    gender,              
    city,              
    income_bracket,
    category,
    price,
    total_amount,
    order_year,
    order_month,
    order_day_of_week
Having COUNT(*) > 1)
SELECT * FROM CustomerDuplicates;

---No Duplicates found---

---delete useless data---

Alter table practice_Ecommerce_data
Drop Column column1

---Create a new column---

Alter table practice_Ecommerce_data
ADD age_category VARCHAR(20)

Update practice_Ecommerce_data
Set age_category = Case
    When age <= 25 Then 'Young Adult'
    When age <= 45 Then 'Adult'
    When age <= 65 Then 'Senior'
    Else 'Retired'
End;


---Changing column title---

EXEC sp_rename 'practice_ecommerce_data.total_amount', 'gross_profit', 'COLUMN';

---Create a new column for net profit---

Alter table practice_Ecommerce_data
ADD net_profit INT

Update practice_Ecommerce_data
Set net_profit = gross_profit - shipping_cost


--Statistical summary for gross profit--

Select AVG(gross_profit) as avg_gross_profit,
       MAX(gross_profit) as max_gross_profit,
       MIN(gross_profit) as min_gross_profit,
       STDEV(gross_profit) as STDEV_gross_profit,
       VAR(gross_profit) as variance_gross_profit
From practice_Ecommerce_data


---Exploratory Data Analysis (EDA)---

Select * from practice_Ecommerce_data

--total number of unique customers--

Select Count(Distinct(customer_id)) as Num_of_unique_customers from practice_Ecommerce_data

--Average price per product--

Select AVG(price) as Avg_price_per_product from practice_Ecommerce_data

--Average shipping cost--

Select AVG(Shipping_cost) as avg_shipping_cost from practice_Ecommerce_data

--Average delivey--

select AVG(delivery_days) as avg_delivery_days from practice_Ecommerce_data

--Average age of customers--

Select AVG(age) as avg_customer_age from practice_Ecommerce_data

--Average gross profit--

Select AVG(gross_profit) as avg_gross_profit from practice_Ecommerce_data

--Average net profit--

Select AVG(net_profit) as avg_net_profit from practice_Ecommerce_data

--top 5 cities by gross profit--

Select top 5 city, sum(gross_profit) as gross_profit
from practice_Ecommerce_data
group by city
order by gross_profit desc

--top 5 cities by net profit--

Select top 5 city, sum(net_profit) as net_profit
from practice_Ecommerce_data
group by city
order by net_profit desc

--top 5 cities by gross and net profit are the same--

--top 5 categories by gross profit--

Select top 5 category, sum(gross_profit) as gross_profit
from practice_Ecommerce_data
group by category
order by gross_profit desc

--top 5 categories by net profit--

Select top 5 category, sum(net_profit) as net_profit
from practice_Ecommerce_data
group by category
order by net_profit desc

--day of week by gross profit--

Select order_day_of_week, sum(gross_profit) as gross_profit
from practice_Ecommerce_data
group by order_day_of_week
order by gross_profit desc

--day of week by net profit--

Select order_day_of_week, sum(net_profit) as net_profit
from practice_Ecommerce_data
group by order_day_of_week
order by net_profit desc

--income bracket by net profit--

Select income_bracket, sum(net_profit) as net_profit
from practice_Ecommerce_data
group by income_bracket
order by net_profit desc

--age_category by net profit--

Select age_category, sum(net_profit) as net_profit
from practice_Ecommerce_data
group by age_category
order by net_profit desc