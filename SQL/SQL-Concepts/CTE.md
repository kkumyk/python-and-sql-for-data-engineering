
# CTE (Common Table Expression) 

Notes based on material from [Common Table Expressions - The Ultimate Guide - Essential SQL](https://www.essentialsql.com/introduction-common-table-expressions-ctes/#why-do-you-need-sql-ctes)
- a temporary result set that you can reference within another SELECT, INSERT, UPDATE, or DELETE statement
- used to simplify complex joins and sub-queries, and to provide a means to query hierarchical data
- always returns a result set
- use WITH statement to define
- you can define more than one SQL CTE within a WITH statement

## Reasons to Use Over Other Methods - 3R's
- Readability (lets you get the chunks of data you need and combine them in a final SELECT)
- Recursion (CTEs can be used to create recursive queries - queries that call themselves; hand when working with hierarchical data)
- Ranking (when you want to use ranking function such as ROW_NUMBER(), RANK(), NTILE() etc)

## CTE Types

1. <strong>Recursive CTEs</strong>
    - reference/call themselves
    - repeatedly run on a subset of the data until reaching the end condition and stop calling themselves indefinitely
    - once the end is reached, the recursion starts to unwind, collect and calculate data as it reviews each successive result
2. <strong>Non-Recursive CTE’s</strong>
    - does not use recursion



```sql
 /*Use Case:
 list the most common words among all poems; these are defined as appearing more than 7 times:*/

 WITH word_frequency AS (
    SELECT w.word_id, w.word, w.eng_transl, COUNT(pw.poem_id) AS poem_count
    FROM poems_word AS w
    LEFT JOIN poems_poem_words AS pw ON w.word_id = pw.word_id
    GROUP BY w.word_id, w.word, w.eng_transl
)
SELECT p.poem_id, p.title, wf.word, wf.eng_transl, wf.poem_count
FROM word_frequency AS wf
JOIN poems_poem_words AS pw ON wf.word_id = pw.word_id
JOIN poems_poem AS p ON pw.poem_id = p.poem_id where wf.poem_count>=7
ORDER BY wf.poem_count DESC, wf.word ASC;
```
<summary> Expected Results:<details>
```sql

 poem_id |               title               |  word   |                                   eng_transl                                   | poem_count 
<!-- ---------+-----------------------------------+---------+--------------------------------------------------------------------------------+------------
       4 | Си лъахэ - си удз гъэгъа          | абы     | he, him, she, her, it (ergative case)                                          |         18
      11 | Уи гъащIэм гурыфIыгъуэ хэмылъыжмэ | абы     | he, him, she, her, it (ergative case)                                          |         18
      93 | Иджы сощIэ                        | абы     | he, him, she, her, it (ergative case)                                          |         18
      62 | ИгъащIэм зыри сыущэхуакъым...     | абы     | he, him, she, her, it (ergative case)                                          |         18
      92 | Тэрч и Iуфэм                      | абы     | he, him, she, her, it (ergative case)                                          |         18
      21 | Щlымахуэ                          | абы     | he, him, she, her, it (ergative case)                                          |         18
      60 | Шулъагъуэ                         | абы     | he, him, she, her, it (ergative case)                                          |         18
      25 | Дыхейкъым…                        | абы     | he, him, she, her, it (ergative case)                                          |         18
      81 | Дыгъэ бзийр си пшынэ Iэпэу…       | абы     | he, him, she, her, it (ergative case)                                          |         18
      70 | Сымыгупсысэу сыщыпсалъэ...        | абы     | he, him, she, her, it (ergative case)                                          |         18
      94 | Бжьыхьэ тхьэмпэхэр полъэлъыр…     | абы     | he, him, she, her, it (ergative case)                                          |         18
      31 | Гъатхэ жэщхэм умыжей              | абы     | he, him, she, her, it (ergative case)                                          |         18
      34 | Йощэщ IэмыщIэм пшахъуэ гъущэр     | абы     | he, him, she, her, it (ergative case)                                          |         18
      90 | Гугъэ                             | абы     | he, him, she, her, it (ergative case)                                          |         18
      35 | Къулъкъужын и зы махуэ            | абы     | he, him, she, her, it (ergative case)                                          |         18
      71 | ЩIы фIыцIэм                       | абы     | he, him, she, her, it (ergative case)                                          |         18
      36 | Анэшхуэ жьэгу                     | абы     | he, him, she, her, it (ergative case)                                          |         18
      38 | Гъуэгугъэлъагъуэ                  | абы     | he, him, she, her, it (ergative case)                                          |         18
      88 | Нэф                               | ауэ     | but, however, on the other hand                                                |         14 -->
      69 | КIуэцIрыкIыбжэ                    | ауэ     | but, however, on the other hand                                                |         14
       8 | Сабиигъуэм щыщ                    | ауэ     | but, however, on the other hand                                                |         14
      89 | ЩIылъэ вагъуэ                     | ауэ     | but, however, on the other hand                                                |         14
      94 | Бжьыхьэ тхьэмпэхэр полъэлъыр…     | ауэ     | but, however, on the other hand                                                |         14
      90 | Гугъэ                             | ауэ     | but, however, on the other hand                                                |         14
      56 | Шындырхъуо                        | ауэ     | but, however, on the other hand                                                |         14
      71 | ЩIы фIыцIэм                       | ауэ     | but, however, on the other hand                                                |         14
      93 | Иджы сощIэ                        | ауэ     | but, however, on the other hand                                                |         14
      64 | Мом*                              | ауэ     | but, however, on the other hand                                                |         14
      76 | ЩIакхъуэ                          | ауэ     | but, however, on the other hand                                                |         14
      38 | Гъуэгугъэлъагъуэ                  | ауэ     | but, however, on the other hand                                                |         14
       3 | МэракIуэIупэ                      | ауэ     | but, however, on the other hand                                                |         14
      87 | Сурэт                             | ауэ     | but, however, on the other hand                                                |         14
      33 | ЗгъэкIуащ жэщ псор нэбэнэушэу     | нэхъ    | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only |         13
      34 | Йощэщ IэмыщIэм пшахъуэ гъущэр     | нэхъ    | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only |         13
      36 | Анэшхуэ жьэгу                     | нэхъ    | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only |         13
      83 | КъоӀукӀ си гущӀэм зы макъ гуэр    | нэхъ    | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only |         13
       4 | Си лъахэ - си удз гъэгъа          | нэхъ    | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only |         13
      40 | Зы лъэбакъуэ закъуэ               | нэхъ    | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only |         13
      42 | Лъагъуныгъэр къандесджэгукъым     | нэхъ    | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only |         13
       8 | Сабиигъуэм щыщ                    | нэхъ    | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only |         13
      76 | ЩIакхъуэ                          | нэхъ    | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only |         13
      80 | КъоIукI  си гущIэм зы макъ гуэр   | нэхъ    | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only |         13
      70 | Сымыгупсысэу сыщыпсалъэ...        | нэхъ    | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only |         13
      64 | Мом*                              | нэхъ    | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only |         13
      20 | ЦIыхум я гум Iейуэ илъыр          | нэхъ    | 1. more, to a greater degree or extent 2. except, unless, perhaps, maybe, only |         13
      87 | Сурэт                             | куэд    | much, many, a lot of, lots of, plenty, a number of; plural                     |         10
      70 | Сымыгупсысэу сыщыпсалъэ...        | куэд    | much, many, a lot of, lots of, plenty, a number of; plural                     |         10
      18 | Ухэтат си гъащIэм                 | куэд    | much, many, a lot of, lots of, plenty, a number of; plural                     |         10
      28 | Къосыр уэс…                       | куэд    | much, many, a lot of, lots of, plenty, a number of; plural                     |         10
      35 | Къулъкъужын и зы махуэ            | куэд    | much, many, a lot of, lots of, plenty, a number of; plural                     |         10
      40 | Зы лъэбакъуэ закъуэ               | куэд    | much, many, a lot of, lots of, plenty, a number of; plural                     |         10
      83 | КъоӀукӀ си гущӀэм зы макъ гуэр    | куэд    | much, many, a lot of, lots of, plenty, a number of; plural                     |         10
      64 | Мом*                              | куэд    | much, many, a lot of, lots of, plenty, a number of; plural                     |         10
      80 | КъоIукI  си гущIэм зы макъ гуэр   | куэд    | much, many, a lot of, lots of, plenty, a number of; plural                     |         10
      77 | Схуэзыгъэбагъуэу си гуащIэр...    | куэд    | much, many, a lot of, lots of, plenty, a number of; plural                     |         10
      36 | Анэшхуэ жьэгу                     | нэгъуей | Nogai (man, woman, nation)                                                     |         10
       4 | Си лъахэ - си удз гъэгъа          | нэгъуей | Nogai (man, woman, nation)                                                     |         10
      30 | Бжьыхьэ дыгъэпс                   | нэгъуей | Nogai (man, woman, nation)                                                     |         10
      23 | Арати, бжьыхьэр ежьэжащ           | нэгъуей | Nogai (man, woman, nation)                                                     |         10
      20 | ЦIыхум я гум Iейуэ илъыр          | нэгъуей | Nogai (man, woman, nation)                                                     |         10
      10 | Си гум и макъамэм къыдежьу        | нэгъуей | Nogai (man, woman, nation)                                                     |         10
      19 | Уэс Iэпэхъ                        | нэгъуей | Nogai (man, woman, nation)                                                     |         10
      18 | Ухэтат си гъащIэм                 | нэгъуей | Nogai (man, woman, nation)                                                     |         10
      11 | Уи гъащIэм гурыфIыгъуэ хэмылъыжмэ | нэгъуей | Nogai (man, woman, nation)                                                     |         10
      41 | Кавказ                            | нэгъуей | Nogai (man, woman, nation)                                                     |         10
      36 | Анэшхуэ жьэгу                     | нобэ    | 1. today 2. now, at present, in our days                                       |          9
      31 | Гъатхэ жэщхэм умыжей              | нобэ    | 1. today 2. now, at present, in our days                                       |          9
      32 | Ей, дунеижьурэ дыгъужь нэщIа…     | нобэ    | 1. today 2. now, at present, in our days                                       |          9
      70 | Сымыгупсысэу сыщыпсалъэ...        | нобэ    | 1. today 2. now, at present, in our days                                       |          9
      29 | Адыгэпсэм и хъуэпсапIэ            | нобэ    | 1. today 2. now, at present, in our days                                       |          9
      28 | Къосыр уэс…                       | нобэ    | 1. today 2. now, at present, in our days                                       |          9
      88 | Нэф                               | нобэ    | 1. today 2. now, at present, in our days                                       |          9
      61 | Сонет                             | нобэ    | 1. today 2. now, at present, in our days                                       |          9
      71 | ЩIы фIыцIэм                       | нобэ    | 1. today 2. now, at present, in our days                                       |          9
       3 | МэракIуэIупэ                      | хьэту   | name of a Circassian national dance                                            |          8
      43 | Ажэгъуэмэ нэху                    | хьэту   | name of a Circassian national dance                                            |          8
      44 | Уэшх                              | хьэту   | name of a Circassian national dance                                            |          8
      46 | Ландыщэ                           | хьэту   | name of a Circassian national dance                                            |          8
      55 | Джабэ щыгум                       | хьэту   | name of a Circassian national dance                                            |          8
      56 | Шындырхъуо                        | хьэту   | name of a Circassian national dance                                            |          8
      58 | Дадэ и дэIэпыкъуэгъу              | хьэту   | name of a Circassian national dance                                            |          8
      84 | АЖЭГЪУЭМЭ НЭХУ                    | хьэту   | name of a Circassian national dance                                            |          8
       5 | НэкIуэж щэбэтым къуажэм           | махуэ   | 1. day (not night) 2. day (24 hour period) 3. day, date (of the month)         |          7
      88 | Нэф                               | махуэ   | 1. day (not night) 2. day (24 hour period) 3. day, date (of the month)         |          7
      67 | Удз гъэгъа щхъуантIэ              | махуэ   | 1. day (not night) 2. day (24 hour period) 3. day, date (of the month)         |          7
      66 | Си гъащIэр зырикIт, уэ ухэмытам   | махуэ   | 1. day (not night) 2. day (24 hour period) 3. day, date (of the month)         |          7
       4 | Си лъахэ - си удз гъэгъа          | махуэ   | 1. day (not night) 2. day (24 hour period) 3. day, date (of the month)         |          7
      55 | Джабэ щыгум                       | махуэ   | 1. day (not night) 2. day (24 hour period) 3. day, date (of the month)         |          7
      35 | Къулъкъужын и зы махуэ            | махуэ   | 1. day (not night) 2. day (24 hour period) 3. day, date (of the month)         |          7
      21 | Щlымахуэ                          | псы     | 1. water 2. river, stream                                                      |          7
      77 | Схуэзыгъэбагъуэу си гуащIэр...    | псы     | 1. water 2. river, stream                                                      |          7
      39 | Епэр                              | псы     | 1. water 2. river, stream                                                      |          7
      35 | Къулъкъужын и зы махуэ            | псы     | 1. water 2. river, stream                                                      |          7
      58 | Дадэ и дэIэпыкъуэгъу              | псы     | 1. water 2. river, stream                                                      |          7

    ```
    </details>
</summary>