/* 35. Month-end Orders
- show all orders made on the last day of the month
- use DATE_TRUNC() and INTERVAL functions.

 employeeid | orderid | orderdate  
------------+---------+------------
          1 |   10461 | 1997-02-28
          1 |   10616 | 1997-07-31
          2 |   10583 | 1997-06-30
          2 |   10686 | 1997-09-30
          ...
          8 |   10399 | 1996-12-31
          8 |   10460 | 1997-02-28
          8 |   10491 | 1997-03-31
          8 |   10987 | 1998-03-31
          9 |   10687 | 1997-09-30 */

select employeeid,
       orderid,
       orderdate
from orders
where orderdate = date_trunc('month', orderdate) + interval '1 month' - interval '1 day'
order by employeeid,
         orderid;

/*
date_trunc and interval - how do they work here:

    1. date_trunc(interval, date) truncates a date or a timestamp to the specified precision,
       here to the start of the month with time info set to 00:00:00
       e.g.: 2024-04-22 >> 2024-04-01
    2. +internal '1 month' adds an interval of one month to the truncated month: 2024-04-01 >> 2024-05-01
    3. -interval '1 day' subtracts one day from the previous result: 2024-05-01 >> 2024-04-30
*/
