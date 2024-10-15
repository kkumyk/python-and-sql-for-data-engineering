/* 20. Categories, and the total products in each category
- return total number of products in each category
- sort the result by total number of products in descending order
- combine join and group by

Products:
 productid |  productname  | supplierid | categoryid |   quantityperunit   | unitprice | unitsinstock | unitsonorder | reorderlevel | discontinued 
-----------+---------------+------------+------------+---------------------+-----------+--------------+--------------+--------------+--------------
         1 | Chai          |          8 |          1 | 10 boxes x 30 bags  |        18 |           39 |            0 |           10 |            1
         2 | Chang         |          1 |          1 | 24 - 12 oz bottles  |        19 |           17 |           40 |           25 |            1
         3 | Aniseed Syrup |          1 |          2 | 12 - 550 ml bottles |        10 |           13 |           70 |           25 |            0 ...

Categories:
 categoryid | categoryname |                        description                         | picture 
------------+--------------+------------------------------------------------------------+---------
          1 | Beverages    | Soft drinks, coffees, teas, beers, and ales                | \x
          2 | Condiments   | Sweet and savory sauces, relishes, spreads, and seasonings | \x
          3 | Confections  | Desserts, candies, and sweet breads                        | \x ...

Expected Result:
  categoryname  | totalproducts 
----------------+---------------
 Confections    |            13
 Beverages      |            12
 Seafood        |            12
 Condiments     |            12
 Dairy Products |            10
 Grains/Cereals |             7
 Meat/Poultry   |             6
 Produce        |             5

Task's Focus: A parent-child relationship between two joined tables.
*/

SELECT categoryname, COUNT(productid) as TotalProducts
FROM products 
JOIN categories ON categories.categoryid=products.categoryid  
GROUP BY categoryname
ORDER BY COUNT(productid) DESC;