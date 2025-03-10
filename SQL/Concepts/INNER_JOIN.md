
# INNER JOIN
- returns matching recordes only:
    - only includes rows where there is a match between the specified columns in both tables
    - rows without matches in either table are excluded from the result

- typically used to combine related data from two tables based on a common key or column
- can be computationally intensive on large tables, especially if there’s no index on the join columns; proper indexing can help improve performance
- does not include NULLs by default; if a value in the join column is NULL in either table, that row will not appear in the results unless handled specifically
- tends to reduce the number of rows in the result set since it only includes rows with matching values in both tables. This contrasts with OUTER JOINs, which retain unmatched rows
- useful for retrieving related data across tables

```sql
/* Use case: Select all poems that contain a certain word based on its word_id 32 (here: удз - grass).
Expected result:
 poem_id | word_id |             title              
---------+---------+--------------------------------
       4 |      32 | Си лъахэ - си удз гъэгъа
      10 |      32 | Си гум и макъамэм къыдежьу
      35 |      32 | Къулъкъужын и зы махуэ
      67 |      32 | Удз гъэгъа щхъуантIэ
      77 |      32 | Схуэзыгъэбагъуэу си гуащIэр...
      81 |      32 | Дыгъэ бзийр си пшынэ Iэпэу… */

select p.poem_id, w.word_id, p.title
from poems_poem p
join poems_poem_words w on p.poem_id=w.poem_id
where word_id in (32);

/* Use case: Find all poems that contain specific words along with the words' translations.
Tables 
poems_poem:       poem_id | title | autor | contents
poems_poem_words: id | poem_id | word_id
poems_word:       word_id | word | eng_transl

 poem_id |             title              | word |             eng_transl              
---------+--------------------------------+------+-------------------------------------
      81 | Дыгъэ бзийр си пшынэ Iэпэу…    | удз  | grass, plant
      39 | Епэр                           | епэр | 1. violet 2. flower, blossom, blume
      35 | Къулъкъужын и зы махуэ         | удз  | grass, plant
      35 | Къулъкъужын и зы махуэ         | епэр | 1. violet 2. flower, blossom, blume
      10 | Си гум и макъамэм къыдежьу     | удз  | grass, plant
       4 | Си лъахэ - си удз гъэгъа       | удз  | grass, plant
      77 | Схуэзыгъэбагъуэу си гуащIэр... | удз  | grass, plant
      67 | Удз гъэгъа щхъуантIэ           | удз  | grass, plant
(8 rows) */

select p.poem_id, p.title, w.word, w.eng_transl
from poems_poem p
join poems_poem_words pw on p.poem_id=pw.poem_id
join poems_word w on w.word_id=pw.word_id
where w.word='удз' or w.word='епэр'
order by p.title;

select p.poem_id, p.title, w.word, w.eng_transl
from poems_poem p
join poems_poem_words pw on p.poem_id=pw.poem_id
join poems_word w on w.word_id=pw.word_id
where w.word='нобэ'
order by p.title;

/*
 poem_id |             title             | word |                eng_transl                
---------+-------------------------------+------+------------------------------------------
      29 | Адыгэпсэм и хъуэпсапIэ        | нобэ | 1. today 2. now, at present, in our days
      36 | Анэшхуэ жьэгу                 | нобэ | 1. today 2. now, at present, in our days
      31 | Гъатхэ жэщхэм умыжей          | нобэ | 1. today 2. now, at present, in our days
      32 | Ей, дунеижьурэ дыгъужь нэщIа… | нобэ | 1. today 2. now, at present, in our days
      28 | Къосыр уэс…                   | нобэ | 1. today 2. now, at present, in our days
      88 | Нэф                           | нобэ | 1. today 2. now, at present, in our days
      61 | Сонет                         | нобэ | 1. today 2. now, at present, in our days
      70 | Сымыгупсысэу сыщыпсалъэ...    | нобэ | 1. today 2. now, at present, in our days
      71 | ЩIы фIыцIэм                   | нобэ | 1. today 2. now, at present, in our days
(9 rows) */
```





