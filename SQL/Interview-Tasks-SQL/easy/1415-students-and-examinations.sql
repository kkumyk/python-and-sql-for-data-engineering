/*
Write a solution to find the number of times each student attended each exam.
Return the result table ordered by student_id and subject_name.

Students:
+------------+--------------+
| student_id | student_name |
+------------+--------------+
| 1          | Alice        |
| 2          | Bob          |
| 13         | John         |
| 6          | Alex         |
+------------+--------------+

Subjects:
+--------------+
| subject_name |
+--------------+
| Math         |
| Physics      |
| Programming  |
+--------------+

Examinations:
+------------+--------------+
| student_id | subject_name |
+------------+--------------+
| 1          | Math         |
| 1          | Physics      |
| 1          | Programming  |
| 2          | Programming  |
| 1          | Physics      |
| 1          | Math         |
| 13         | Math         |
| 13         | Programming  |
| 13         | Physics      |
| 2          | Math         |
| 1          | Math         |
+------------+--------------+

Learnings:
In PostgreSQL, all columns in the SELECT clause must either be part of the GROUP BY clause or used in an aggregate function

Execution Order:

1. FROM clause:
    - all combinations are created between the students and the subjects - for every student a row is created for every subject;

    students st CROSS JOIN subjects s

2. LEFT JOIN clause:
    - the examinations table is joined with the results of all products from the FROM clause;
    - if the is a match in the examinations table, the corresponding collumns from e are included;
    - if no match, the examinations table are filled with NULL due to the LEFT JOIN;

    e.student_id = st.student_id AND e.subject_name=s.subjects_name

3. SELECT clause
4. GROUP BY clause
5. COUNT aggregation:
    - count(e.student_id) function is computed for each group;
6. ORDER BY clause

Expected Output: 
+------------+--------------+--------------+----------------+
| student_id | student_name | subject_name | attended_exams |
+------------+--------------+--------------+----------------+
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
| 6          | Alex         | Math         | 0              |
| 6          | Alex         | Physics      | 0              |
| 6          | Alex         | Programming  | 0              |
| 13         | John         | Math         | 1              |
| 13         | John         | Physics      | 1              |
| 13         | John         | Programming  | 1              |
+------------+--------------+--------------+----------------+  */

SELECT  st.student_id,
        st.student_name,
        s.subject_name,
        COUNT(e.student_id) AS attended_exams
FROM students st
CROSS JOIN subjects s
LEFT JOIN examinations e
    ON st.student_id = e.student_id
    AND e.subject_name = s.subject_name
GROUP BY st.student_id, st.student_name, s.subject_name
ORDER BY st.student_id, st.student_name, s.subject_name;

 