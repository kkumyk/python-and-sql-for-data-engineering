-- 6. Suppliers and ContactTitles

select
    SupplierID,
    ContactName,
    ContactTitle
from
    Suppliers
where ContactTitle != 'Marketing Manager'; -- MS SQL Server


select
    "SupplierID",
    ContactName",
    ContactTitle"
from
    "Suppliers"
where "ContactTitle" != 'Marketing Manager'; -- PostgreSQL

/*
Learnings:
Two ways to express "not": <>, !=
*/