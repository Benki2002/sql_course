/*** Constraints***/
--primary key: a uniqe not null key that uniqely identifies a column 
--check: check a column on a given expresion
--unique: each column has a unique value 
--foreign key : restricts the user from adding values to the concered column which not exist in the referenced table*/

/* 1- add a constraint by the time of creation*/
drop table if exists hr.test_constraint;
create table hr.test_constraint 
(id int constraint mypkey primary key,
 name varchar(30),
 zakat numeric constraint omar check (zakat >100) );
-- test 1
insert into  hr.test_constraint values (1,'yaya', 50);  --zakat 9lila
-- test 2
insert into  hr.test_constraint values (1,'yaya', 120); 
insert into  hr.test_constraint values (1,'baba', 170);  -- primary key not unique
--test3
insert into  hr.test_constraint values (2,'khaltah', 10000);  -- drahem weljana 
/* 2- add a constraint on existing table */
/*remarks: if a constraint is added after the table is created it fails to create 
if already existing values violate this constraint**/
alter table hr.test_constraint add constraint name_constraint check (name not like ('juda'));
insert into  hr.test_constraint (id,name) values  (5,'kalouzaa'); -- null can't be checked because its not a value
-- test 1
insert into  hr.test_constraint values (3,'juda', 170); -- mechi nayek 
insert into  hr.test_constraint values (3,'abu andrew', 170); -- bdahtek
--test 2: 
insert into  hr.test_constraint values (4,'kalouzaa', 120);  --zakat 9lila
insert into  hr.test_constraint (id,name) values  (5,'kalouzaa'); -- null can't be checked because its not a value
--test3: related to remark
insert into  hr.test_constraint (id,name) values  (6,'kalouzaa'); 
alter table hr.test_constraint add constraint uniquename unique (name);
/* 3- drop a constraint */
alter table hr.test_constraint drop constraint name_constraint; --rja3na ouvert 
/* 4- update a constraint:the only way is to drop it and create a new one vive l'algerie */

CREATE EXTENSION btree_gist;
CREATE TABLE example(
name varchar,
age integer,
EXCLUDE USING gist
(AGE WITH <>));
INSERT INTO example VALUES ('scott', '26')
INSERT INTO example VALUES ('scott', '26')
INSERT INTO example VALUES ('djamel', '26')
INSERT INTO example VALUES ('scott', '27')

CREATE TABLE reservation(
name varchar,
room int,
checkin date,
checkout date,	
constraint pkey primary key (room)	
constraint overlap exclude using gist (room with =, tsrange("checkin","checkout",'[]') with && ));

CREATE TABLE products (
    product_no integer not null unique,
    name text,
    price numeric
);
select * from products;
alter table products add constraint testpkey primary key (name);
alter table products drop constraint testpkey;
alter table products add constraint testpkey primary key (product_no);
insert into  products values (1,'toufah',4);
insert into products values (2,'boutkal',2);
select * from products;
CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    product_no integer REFERENCES products (product_no), --fk
    quantity integer
);
--test1: check case;  the ordered product_no doesnt exist ?
insert into orders values(1,3,5);
--test2: check case: if the ordered product is null? what to do now?
insert into orders (order_id,quantity ) values(1,5); -- not null again is a problem so  define it explictly 

//*** exercice: FOREIGN KEY ***/
-- add schema exercice
-- add a table departement (id int primary key, departement varchar) into exercice
-- add some values to it 
-- create table worker (id int primary key, name varchar(30), familyname varchar(30), wage numeric, departement integer not null fk (departement) into exercice
-- add some values to it so that  each department has at least one worker 
-- try to delete a value from departement table  which hat at least one worker ? what do u remark?
-- delete all worker from worker wich work on the departement u tried to delete  and try to delete this departement again
-- now delete the fk  from worker table using alter table drop (fkNAME)==> fkNAME u find it under constraints in the worker table
-- now create a new fk in departement column in worker  that references to departement with the property on delete restrict
-- try to delete a value from departement table  which hat at least one worker ? what do u remark?
-- check worker table again what do u remark

Lösung:
drop table if exists  hr.department;
create table hr.department (id serial , department varchar(30));
insert into hr.department (department) values('Entwicklung'),('Geschäftsführung'),('Buchhaltung'),('Vertrib'),('Sekretariat'),
('Sales mangement'),('Einkauf');
drop tabl if exists hr.worker
create table hr.departement('name,familyname')
insert into hr.department (department) values('Entwicklung'),('Geschäftsführung'),('Buchhaltung'),('Vertrib'),('Sekretariat'),
('Sales mangement'),('Einkauf');
select  * from hr.department;
select  * from hr.worker;
insert into hr.department (department) values('Entwicklung'),('Geschäftsführung'),('Buchhaltung'),('Vertrib'),('Sekretariat'),
('Sales mangement'),('Einkauf');
alter table hr.department add primary key(department);
alter table hr.worker add  foreign key (departement) references hr.department;
alter table hr.worker alter column departement set not null ;
alter table hr.worker add column gf int references hr.worker  on delete set null;
/**
REMARK: when referencing to a table , no values can be delete from it
if there ist at least one row in the referencing wich has this value  see below test one
**/

alter table hr.worker drop constraint fk2 ;
alter table hr.worker  add constraint fk  foreign key(departement) references hr.department on delete restrict  ;

delete from hr.worker  where id in (10,13) 
delete from hr.department  where id in (4) 
update hr.department set department='' where id=3 
;


