# [PostgreSQL for Everybody (PG4E)](https://www.pg4e.com/lessons/) Notes

## [Text in PostgreSQL](https://www.pg4e.com/lessons/week4#)

Handling text in PostgreSQL (but not Natural Language).

- create some text data with Postgres functions

```sql

```




## TIMESTAMPZ - Best Practice 
- store timestamps with timezone
- prefer UTC (Coordinated Universal Time) for stored timestamps
- convert to local timezone when retrieving

## Casting to different types
- casting - convert from one type to another
- Postgres has several types of casting
```
SELECT NOW()::DATE  <!-- 2024-09-09 -->

CAST(NOW() AS DATE) <!-- 2024-09-09 -->

CAST(NOW() AS TIME) <!-- 11:45:43.8798756 -->
```