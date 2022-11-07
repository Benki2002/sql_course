/*** JOINS ***/
-- combining rows from one or more tables based on common column between them

-- preparation--
-- 1) create  a new scheme 'jn'   
-- )create table jn.shipper (id serial PRIMARY KEY, name varchar(30))
-- )insert into jn.shipper ('Yalidine'),('World Express'), ('Kazi Tour')
-- ) create a table jn.customers(id int PK serial ,first_name varchar(30),family_name varchar(30))
-- ) insert the following into jn.customers rows ('james','benki'), ('kai','tarigo'), ('kalouza','tab3a'),('khassra','nassira')
-- ) create  a table jn.orders(id int PK serial ,CustomerID FK int on delete restrict , OrderDate Date, shipperID FK(shipper name) on delete restrict)  
 --) insert into jn.orders (2,'2020-02-23'),(3,'2021-05-25'),(2,'2022-02-23'),(1,'2022-11-01'),(3,'2022-02-01')
-- ) create table jn.suppliers(id pk serial, business_name varchar(30), city varchar(30))
-- )insert into suppliers ('angouda','EL EULMA'), ('Lamar','Tiaret'),('Bahia Cos','Oran');
-- )create table jn.products (id serial pk, product_name varchar(30), supplierID FK jn.suppliers(id), price numeric)
--) insert  into jn.products ('fdt lequide note',1,750),('mascara  essence',1,450),('creme anti sol vichy',3,300),('palette Dodo Girl 24 Couleures',3, 650),
-- ('Creme eclairssisante magic dream',2,1200)

--Schema
drop schema if EXISTS jn;
create schema jn;
--Shipper Table
drop table if exists jn.shipper;
create table jn.shipper(id serial primary key, shipper_name varchar(30));
select * from jn.shipper; --check
insert into jn.shipper (shipper_name) values ('Yalidine'),('World Express'), ('Kazi Tour');
-- Customers Tyble
drop table if EXISTS jn.customers;
create  table jn.customers (id  serial  PRIMARY KEY, first_name varchar(30), family_name varchar(30), city varchar(30));
insert into jn.customers (first_name, family_name, city) values 
('james','benki','Sougueur'), ('kai','tarigo','Tiaret'), ('kalouza','tab3a','Tiaret'),
('Khassra','Nassira','Tousnina Fil'), ('hamma','masita','Sougueur')
,('Benouda','malissa','Relizane'), ('Thamer','Ouzouaza','Relizane');

select * from jn.customers; --check
-- Orders Table
drop table if exists jn.orders;
create table jn.orders (id  serial primary key,customerID int references jn.customers(id) on delete RESTRICT,date Date, shipperID int references jn.shipper(id) on delete restrict) ;
insert into jn.orders(customerID,date,shipperID) values (2,'2020-02-23',1),(3,'2021-05-25',2),(2,'2022-02-23',2),(1,'2022-11-01',1),(3,'2022-02-01',3),(null,'2023-02-01',null);
select * from jn.orders ;
-- Suppliers Table:
drop table if exists jn.suppliers;
create table jn.suppliers(id serial primary key,business_name varchar(30),city varchar(30));
insert into jn.suppliers (business_name, city) values ('angouda','EL EULMA'), ('Lamar','Tiaret'),('Bahia Cos','Oran'),('Mihoubi','Setif');
select * from jn.suppliers; --check
-- Products:
drop table if exists jn.products;
create table jn.products
    (id serial primary key, product_name varchar(30), supplierID int references jn.suppliers(id),price numeric);
insert into jn.products (product_name,supplierID,price) values
('fdt lequide note',1,750),('mascara  essence',1,450),('creme anti sol vichy',3,300),
('palette Dodo Girl 24 Clrs',3, 650),('Creme eclairssisante md',2,1200);
select * from jn.products;

-- 1) INNER JOIN 
select c.id, c.first_name,c.family_name, o.id, o.date from jn.customers c inner join jn.orders  o
on c.id=o.customerID
-- Why khassra is not in the list ?? 

--2) LEFT (OUTER JOIN) JOIN
select c.id, c.first_name,c.family_name, o.id, o.date from jn.customers c left join jn.orders  o
on c.id=o.customerID
--What do you remark?

--3) Right OUTER JOIN
select c.id, c.first_name,c.family_name, o.id, o.date from jn.customers c right join jn.orders  o
on c.id=o.customerID
-- What do you remark 

--4) FULL OUTER JOIN 
select c.id ,c.first_name,c.family_name, o.id, o.date from jn.customers c full outer join jn.orders  o
on c.id=o.customerID;
-- what do you remark?

-- self join
-- select cutomers who  lives in the same city 
select a.id, a.first_name,a.family_name,b.id, b.first_name,b.family_name, a.city city
from jn.customers a , jn.customers b
where a.city=b.city and a.id<>b.id
order by a.city
;
select a.id, a.first_name,a.family_name,b.id, b.first_name,b.family_name, a.city city
from jn.customers a 
join jn.customers b on a.city=b.city 
where a.id <> b.id
order by a.city
;
--TODO: find a way to display the two customers only once >>>>

--UNION: combine the result of two tables. the result tables 
     --must have the same numbers of columns 
     --the columns must have the same data TYPES
     -- the columns in every select must be in the same orders
     --UNION join tables without reption 
     

--display all clients(ids,family_name,city, person_type ) and suppliers(ids, busines_name,city, person_type):
-- the person_type can have these values 'Customer' /'Supplier 

select c.id, c.first_name,c.city, 'client' as personType from jn.customers c
UNION
select s.id, s.business_name,s.city ,'supplier'as personType from jn.suppliers s;
;
select city from jn.customers 
--UNION 
UNION ALL
select city from jn.suppliers 
;
-- try both UNION and UNION ALL 


-- Exersices
--- Display customers that have ordered something (orderID, client names and shipper names) must be displayed
select o.id as customerID,c.first_name,c.family_name,s.shipper_name from 
jn.customers c 
join jn.orders o on c.id =o.customerID
join jn.shipper s on o.shipperID=s.id
;


