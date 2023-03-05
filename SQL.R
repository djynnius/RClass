#enable ribraries
#library(tidyverse)
#library(tidyquery)
#library(sqldf)

#load data
sex <- read_csv("datasets/school/sex.csv")
students_subjects <- read_csv("datasets/school/students_subjects.csv")
students <- read_csv("datasets/school/students.csv")
subjects <- read_csv("datasets/school/subjects.csv")
teachers_course <- read_csv("datasets/school/teachers_course.csv")
teachers <- read_csv("datasets/school/teachers.csv")


sqldf("
SELECT 
  s.reg_num, 
  s.firstname, 
  s.lastname AS surname, 
  s.sex, 
  e.sex_id, 
  e.gender
FROM students AS s 
  INNER JOIN sex AS e ON s.sex=e.sex_id
")

teachers_course
teachers
subjects

sqldf("
SELECT 
  t.firstname, 
  t.lastname,
  s.course
FROM teachers_course AS tc
  JOIN teachers AS t ON tc.teacher=t.staff_num 
  JOIN subjects AS s ON tc.subject=s.subject_id

")


sqldf("
SELECT 
  teacher 
  ,MIN(firstname) AS firstname
  ,MAX(lastname) AS surname
  ,COUNT(teacher) AS students
FROM (
  SELECT 
    ss.subject_id, 
    tc.subject, 
    tc.teacher, 
    t.staff_num, 
    t.firstname, 
    t.lastname
  FROM students_subjects AS ss 
    JOIN teachers_course AS tc ON ss.subject_id=tc.subject 
    JOIN teachers AS t ON tc.teacher=t.staff_num 
) GROUP BY teacher
ORDER BY students DESC
")
#2051
sqldf("
SELECT 
  a.student_num, 
  b.firstname, 
  b.lastname
FROM (
SELECT
  DISTINCT ss.student_num
FROM students_subjects AS ss 
  JOIN teachers_course AS tc ON ss.subject_id=tc.subject 
  JOIN teachers AS t ON tc.teacher=t.staff_num 
  JOIN students AS s ON ss.student_num=s.reg_num
WHERE t.staff_num = 2051
) AS a JOIN students AS b ON a.student_num=b.reg_num
")


--SELECT
--FROM
--WHERE
--GROUP BY
--HAVING
--BETWEEN
--IN
--AS
--AND
--OR
--ORDER BY
--DESC
--JOIN
--ON
