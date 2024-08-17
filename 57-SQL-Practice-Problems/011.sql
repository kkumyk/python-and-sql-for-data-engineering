/* MS SQL Server */

SELECT
    FirstName
    , LastName
    , Title
    , DataOnlyBirthData = convert(date, BirthDate)
FROM Employees
Order By BirthDate;

/* PostgreSQL

CAST function converts one data type to another.
CAST syntax: CAST(expression AS target_data_type) with expression to be value or column to be converted. 
Use DATE keyword to convert the column to the DATE date type which only stores the date part (year, month, day).
*/

SELECT
    "FirstName",
    "LastName",
    "Title",
    CAST("BirthDate" AS DATE) AS "DataOnlyBirthData" 
    -- or use: "BirthDate"::DATE AS "DataOnlyBirthData"
FROM "Employees"
ORDER BY "BirthDate";
