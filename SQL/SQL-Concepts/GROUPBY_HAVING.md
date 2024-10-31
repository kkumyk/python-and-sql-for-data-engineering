## GROUP BY
- groups rows sharing a common value into a summary rows

## HAVING
- filters groups after aggregation (since WHERE filters rows, not groups)

### Practice Tasks

1. Identify words where eng and rus translation scraping went wrong:
    find words that have both English and Russian translations appearing at least twice in the table poems_word.

```sql
-- The query below groups words by English and Russian translations, counts the occurrences of each translation pair, and filters for pairs that appear at least twice.

SELECT
    eng_transl, 
    rus_transl, 
    COUNT(word_id) AS num_of_words
FROM 
    poems_word
GROUP BY 
    eng_transl, rus_transl
HAVING 
    COUNT(word_id) > 1
ORDER BY 
    num_of_words DESC;

--         eng_transl         |        rus_transl         | num_of_words 
-- ---------------------------+---------------------------+--------------
--  See "псалъафэ зэпыщӀахэр" | См. "псалъафэ зэпыщӀахэр" |            5
--  see псалъафэ зэпыщӀахэр   | см. псалъафэ зэпыщӀахэр   |            3
--  wall (house)              | стена                     |            2
-- (3 rows)
```

2. Find words with more than one Russian translation for the same English word.

```sql
SELECT 
    eng_transl, 
    COUNT(DISTINCT rus_transl) AS num_rus_transls
FROM 
    poems_word
GROUP BY 
    eng_transl
HAVING 
    COUNT(DISTINCT rus_transl) > 1;

--   eng_transl   | num_rus_transls 
-- ---------------+----------------------
--  dawn, sunrise |                    2
```



 <!-- To show the distinct Russian translations for each English translation that has multiple unique Russian translations, you can use a Common Table Expression (CTE) to identify the qualifying English translations first, and then join it back to the original table to retrieve the individual Russian translations.

WITH multiple_rus_translations AS (
    SELECT 
        eng_transl
    FROM 
        poems_word
    GROUP BY 
        eng_transl
    HAVING 
        COUNT(DISTINCT rus_transl) > 1
)
SELECT 
    lt.eng_transl,
    lt.rus_transl
FROM 
    poems_word lt
JOIN 
    multiple_rus_translations mrt ON lt.eng_transl = mrt.eng_transl
ORDER BY 
    lt.eng_transl, 
    lt.rus_transl;

--   eng_transl   |  rus_transl   
-- ---------------+---------------
--  dawn, sunrise | рассвет
--  dawn, sunrise | рассвет, заря
-- (2 rows)  -->