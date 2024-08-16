SELECT
    productid, productname
FROM
    products
WHERE
    productname LIKE '%queso%'

/*
The LIKE operator is always used with wildcards, such as % , which substitutes for any number of characters.
Note that even though the search string used a lowercase "q" with the LIKE clause,
the resulting rows had an uppercase Q.
*/
