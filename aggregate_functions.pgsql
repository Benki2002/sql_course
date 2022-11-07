/*** AGGREGATE FUNCTIONS / GROUP BY / HAVING ***/

/* AGGREGATE FUNCTIONS */ 

-- count() count the numbers of rows
select count(*) from jn.customers;
select count(*) from jn.customers where city ='Tiaret';
-- AVG()
-- SUM()
-- MIN()
-- MAX() 
/*GROUP BY */
-- groups rows that have same values in the summary column, like find the number of customers in Tiaret
-- It's offen used with aggregate functions.
-- selct the number of customers in each city
select count(id) as "number of Customers", city from jn.customers
group by city
order by 2;
-- select the number of orders for each shipper
select s.shipper_name, count(o.id) as "number of orders" from
jn.orders o join jn.shipper s on o.shipperid=s.id
group by shipper_name --s.shipper_name

/*HAVING*/
-- it's like the WHERE clause its used only with GROUP BY though (it commes after GROUP BY)

-- select the cites having more than one customer
select count(id) as "number of Customers", city from jn.customers
group by city
having count(id) >=2
order by 2 
--ASC
DESC
;
-- select clients having more than one command

select c.id, c.family_name,c.city,count(o.id) as "number of orders"
from jn.customers c  
join  jn.orders o   
on o.customerid = c.id
where 
city='Tiaret' 
--city='Sougueur'
group by c.id
having count(o.id)>=2
;  




