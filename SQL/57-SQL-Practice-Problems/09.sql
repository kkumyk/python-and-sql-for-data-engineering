-- 9. Orders shipping to any country in Latin America

select
   orderid, customerid, shipcountry
from
   orders
where
   shipcountry in ('Brazil','Venisuella','Argentina');

/*
Using In operator to find orders from Latin America. Output Result:

 orderid | customerid | shipcountry 
---------+------------+-------------
   10250 | HANAR      | Brazil
   10253 | HANAR      | Brazil
'''
   11054 | CACTU      | Argentina
   11059 | RICAR      | Brazil
   11068 | QUEEN      | Brazil
(99 rows)
*/