#  LEFT JOIN (or LEFT OUTER JOIN)

- include all records from the left/first table and matching records from the right (second) table
- if there are no matches in the right table, returned value for not found matches will be NULL
- order matters: the "source of truth" / the primary table should be specified first

```sql
/*
Identify poems that don't have any associated words

Expected Result:
 poem_id |            title             
---------+------------------------------
      78 | ЦIыхубзыр дунейм и дыгъэщ...           */

SELECT p.poem_id, p.title
FROM poems_poem AS p
LEFT JOIN poems_poem_words AS pw ON p.poem_id = pw.poem_id
LEFT JOIN poems_word AS w ON pw.word_id = w.word_id
WHERE w.eng_transl is NULL;

/*
The above query helped to identify poems where no word translations could be
scraped and added into the vocabulary section:
*/
```
<img src="https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/_doc/missing_vocabulary.png" width=400 hight=500>

</br>

# RIGHT JOIN (or RIGHT OUTER JOIN)
- includes all records from the right/second table and matching records from the left/first table
- if there are no matches on the left table, the returned values will be NULL
- less used than LEFT JOIN since the effect of the RIGHT JOIN can be achieved with the LEFT JOIN by simply swapping the order of tables used in the query

```sql

```

</br>

# FULL JOIN (or FULL OUTER JOIN)
- combines all records from both tables
- if there is no match in either table, the returned value will be NULL
- a union of LEFT and RIGHT joins
- on large datasets can be resource-intensive - can have high processing and memory costs if there are a lot of unmatched rows on both sides

```sql

```

# JOIN Alternatives

## UNION and UNION ALL
- used to combine the results of two or more SELECT statements

## Self Join

