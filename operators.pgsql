/*** OPERATORS***/
/*Subquiries*/
-- are select statement that can be passed as a table to another statments 
-- select cities where we both have customers and clients
select business_name,city  from jn.suppliers where city in (select city from jn.customers );


/* EXISTS */
/* 
- 
- Syntax
    SELECT column_name(s)
    FROM table_name
    WHERE EXISTS
    (SELECT column_name FROM table_name WHERE condition);
*/

-- select suppliers that have at least one product
select s.id, s.business_name
from jn.suppliers  s
where exists (select 1 from jn.products p  where p.supplierID=s.id)
-- select suppliers that have no
select s.id, s.business_name
from jn.suppliers  s
where not exists (select 1 from jn.products p  where p.supplierID=s.id)