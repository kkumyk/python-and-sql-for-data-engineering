/* 11. Show only the date with the date time field

The original task is based on the assumption the the previous one returns time of the birthday field (00:00:00.000)/
In output we see in Postgres however does not return the time part. As a result, we see the same output as in the task 010.sql:

 firstname | lastname  |          title           | dataonlybirthdata 
-----------+-----------+--------------------------+-------------------
 Margaret  | Peacock   | Sales Representative     | 1937-09-19
 Nancy     | Davolio   | Sales Representative     | 1948-12-08
 Andrew    | Fuller    | Vice President, Sales    | 1952-02-19

CAST function converts one data type to another.
CAST syntax: CAST(expression AS target_data_type) with expression to be value or column to be converted. 
Use DATE keyword to convert the column to the DATE date type which only stores the date part (year, month, day).
*/

SELECT
    FirstName,
    LastName,
    Title,
    CAST(BirthDate AS DATE) AS DataOnlyBirthData 
FROM Employees
ORDER BY BirthDate;

SELECT
    FirstName,
    LastName,
    Title,
    BirthDate::DATE AS DataOnlyBirthData
FROM Employees
ORDER BY BirthDate;
