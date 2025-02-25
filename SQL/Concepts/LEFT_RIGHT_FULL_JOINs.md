#  LEFT JOIN (or LEFT OUTER JOIN)

- include all records from the left/first table and matching records from the right (second) table
- if there are no matches in the right table, returned value for not found matches will be NULL
- order matters: the "source of truth" / the primary table should be specified first

<br>

```sql
/* Use Case: count the number of poems a word appears in

Expected Result:

word_id |       word       |                                                                                                            eng_transl                                                                                                             | poem_count 
---------+------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------
      39 | абы              | he, him, she, her, it (ergative case)                                                                                                                                                                                             |         18
      24 | ауэ              | but, however, on the other hand                                                                                                                                                                                                   |         14
      47 | нэхъ             | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only                                                                                                                                                    |         13
     159 | куэд             | much, many, a lot of, lots of, plenty, a number of; plural                                                                                                                                                                        |         10
      51 | нэгъуей          | Nogai (man, woman, nation)                                                                                                                                                                                                        |         10
     301 | нобэ             | 1. today 2. now, at present, in our days                                                                                                                                                                                          |          9
      23 | хьэту            | name of a Circassian national dance                                                                                                                                                                                               |          8
     131 | сыт              | what? (questions about everything except people)                                                                                                                                                                                  |          7
      50 | махуэ            | 1. day (not night) 2. day (24 hour period) 3. day, date (of the month)                                                                                                                                                            |          7
     193 | псы              | 1. water 2. river, stream                                                                                                                                                                                                         |          7
     142 | хэт              | 1. who (only about people) 2. as a separator                                                                                                                                                                                      |          7
... */

SELECT w.word_id, w.word, w.eng_transl, COUNT(pw.poem_id) AS poem_count
FROM poems_word AS w
LEFT JOIN poems_poem_words AS pw ON w.word_id = pw.word_id
GROUP BY w.word_id, w.word, w.eng_transl
ORDER BY poem_count DESC;



/* Use Case: return all words associated with a poem

Expected Result:

 poem_id |            title            | word_id |                eng_transl                                                      
       1 | Мазэ                        |       1 | 1. moon 2. month
       1 | Мазэ                        |       2 | sky
       1 | Мазэ                        |       3 | gold, (Au) aurum
       1 | Мазэ                        |       4 | red (colour)
       1 | Мазэ                        |       5 | beautifully, prettily, attractively, well
       1 | Мазэ                        |       6 | 1. The ancient Adyghes" (Circassians") dieties, gods 2. Allah
       1 | Мазэ                        |       7 | be the watchman or guard
       1 | Мазэ                        |       8 | 1. star (heavenly body) 2. star (geometric figure ...
       2 | Мэбзэрабзэ бзур, мэбзэрабзэ |      17 | melody, tune
       2 | Мэбзэрабзэ бзур, мэбзэрабзэ |      18 | 1. Adyghe language (of the Kabardians, Cherkesses ...
(10 rows) */

SELECT p.poem_id, p.title, w.word, w.eng_transl
FROM poems_poem AS p
LEFT JOIN poems_poem_words AS pw ON p.poem_id = pw.poem_id
LEFT JOIN poems_word AS w ON pw.word_id = w.word_id
LIMIT 10;



/* Use case: Identify poems that don't have any associated words

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
The above query helped to identify poems where no translation for extracted words could be
scraped and added into vocabulary section of the page:
*/
```
<img src="https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/_doc/missing_vocabulary.png" width=400 hight=500>

</br>

# RIGHT JOIN (or RIGHT OUTER JOIN)
- includes all records from the right/second table and matching records from the left/first table
- if there are no matches on the left table, the returned values will be NULL
- less used than LEFT JOIN since the effect of the RIGHT JOIN can be achieved with the LEFT JOIN by simply swapping the order of tables used in the query

```sql
/* Use Case: list all words, along with the poems they appear in (if any).
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
</br>

# FULL JOIN (or FULL OUTER JOIN)
- combines all records from both tables
- if there is no match in either table, the returned value will be NULL
- a union of LEFT and RIGHT joins
- on large datasets can be resource-intensive - can have high processing and memory costs if there are a lot of unmatched rows on both sides



```sql

/*
Use Case: return poems and their associated word where the translation exists:
 poem_id |  title |   word            | translation                                      
---------+-------------------------------------+------------------
       1 | Мазэ    | мазэ             | 1. moon 2. month
       1 | Мазэ    | уафэ             | sky
       1 | Мазэ    | дыщэ             | gold, (Au) aurum
       1 | Мазэ    | плъыжь           | red (colour) ...      */ 
SELECT
  pp.poem_id,
  pp.title AS title,
  pw.word AS word,
  pw.eng_transl AS translation
FROM
  poems_poem pp
FULL JOIN
  poems_poem_words ppw ON pp.poem_id = ppw.poem_id
FULL JOIN
  poems_word pw ON ppw.word_id = pw.word_id
WHERE eng_transl IS NOT NULL
ORDER BY
  pp.poem_id, ppw.id;
```

</br>

# JOIN Alternatives

## UNION and UNION ALL
- used to combine the results of two or more SELECT statements

## Self Join