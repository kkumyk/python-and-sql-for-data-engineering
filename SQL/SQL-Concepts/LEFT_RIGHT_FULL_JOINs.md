#  LEFT JOIN (or LEFT OUTER JOIN)

- include all records from the left/first table and matching records from the right (second) table
- if there are no matches in the right table, returned value for not found matches will be NULL
- order matters: the "source of truth" / the primary table should be specified first

```sql
/*
Use case: Identify poems that don't have any associated words

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
/*
Use Case: list of all words, along with the poems they appear in (if any).
This includes orphan words - words that are not associated with any poem.

As the current dataset does not include any orphan words, the expected result will be:

 poem_id | title | word | eng_transl 
---------+-------+------+------------
(0 rows) */

SELECT w.word, w.eng_transl, p.poem_id, p.title
FROM poems_word AS w
RIGHT JOIN poems_poem_words AS pw ON w.word_id = pw.word_id
RIGHT JOIN poems_poem AS p ON pw.poem_id = p.poem_id
WHERE p.title is NULL;
```


<!-- 
return all words associated with a poem

SELECT p.poem_id, p.title, w.word, w.eng_transl
FROM poems_poem AS p
LEFT JOIN poems_poem_words AS pw ON p.poem_id = pw.poem_id
LEFT JOIN poems_word AS w ON pw.word_id = w.word_id
LIMIT 10; 

list words that only appear once among all poems:
 WITH word_frequency AS (
    SELECT w.word_id, w.word, w.eng_transl, COUNT(pw.poem_id) AS poem_count
    FROM poems_word AS w
    LEFT JOIN poems_poem_words AS pw ON w.word_id = pw.word_id
    GROUP BY w.word_id, w.word, w.eng_transl
)
SELECT p.poem_id, p.title, wf.word, wf.eng_transl, wf.poem_count
FROM word_frequency AS wf
JOIN poems_poem_words AS pw ON wf.word_id = pw.word_id
JOIN poems_poem AS p ON pw.poem_id = p.poem_id where wf.poem_count=1
ORDER BY wf.poem_count ASC;



show in which poems a word does appear:
SELECT p.poem_id, p.title, w.word, w.eng_transl
FROM poems_poem AS p
RIGHT JOIN poems_poem_words AS pw ON p.poem_id = pw.poem_id
RIGHT JOIN poems_word AS w ON pw.word_id = w.word_id
LIMIT 10;
-->


</br>


# FULL JOIN (or FULL OUTER JOIN)
- combines all records from both tables
- if there is no match in either table, the returned value will be NULL
- a union of LEFT and RIGHT joins
- on large datasets can be resource-intensive - can have high processing and memory costs if there are a lot of unmatched rows on both sides

<!-- ```sql

``` -->
</br>

# JOIN Alternatives

## UNION and UNION ALL
- used to combine the results of two or more SELECT statements

## Self Join

