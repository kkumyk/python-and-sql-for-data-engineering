SELECT
    suplierid,
    contactname,
    contacttitle
FROM
    suppliers
WHERE contacttitle != 'Marketing Manager';


/* Notes:
Two ways to express "not": <>, !=
*/