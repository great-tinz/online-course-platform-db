SELECT c.course_code,
i.first_name AS Instructors_firstName,
i.last_name AS Instructors_last_Name
FROM instructor i
INNER JOIN course c
ON c.instructor_id = i.instructor_id;


SELECT e.enrollment_id,
       s.last_name AS Last_Name,
       s.first_name AS First_Name,
       e.course_code 
FROM enrollment e
JOIN student s
ON   e.student_id = s.student_id;


SELECT CONCAT_WS(' ',s.last_name,s.middle_name,s.first_name) AS student_fullname,
       r.course_code,
       r.rating
FROM student s
INNER JOIN review r
ON s.student_id = r.student_id;


SELECT title AS lesson_title,course_code FROM lesson;


SELECT c.course_code,
       c.title AS course_title,
       CONCAT_WS(' ',i.last_name,i.middle_name,i.first_name) AS instructor_fullName
FROM course c
INNER JOIN instructor i
ON c.instructor_id = i.instructor_id;

SELECT r.course_code,
       c.title,
       AVG(r.rating) AS average_rating 
FROM review r
INNER JOIN course c
ON r.course_code = c.course_code
GROUP BY course_code
ORDER BY AVG(r.rating) DESC;


SELECT c.course_code,
       c.difficulty_level,
       COUNT(l.lesson_id)
FROM course c
INNER JOIN lesson l
ON c.course_code = l.course_code
GROUP BY c.course_code
ORDER BY COUNT(l.lesson_id) DESC;


SELECT CONCAT_WS(' ',s.last_name,s.middle_name,s.last_name) AS Student_fullname,
       c.title,
       r.rating
FROM  student s
INNER JOIN review r
ON s.student_id = r.student_id
INNER JOIN course c
ON r.course_code = c.course_code
WHERE r.rating > 4
ORDER BY r.student_id DESC;


SELECT CONCAT_WS(' ',i.last_name,i.middle_name,i.first_name) AS instructors_fullname,
       COUNT(c.instructor_id)
FROM instructor i
INNER JOIN course c
ON i.instructor_id = c.instructor_id
GROUP BY CONCAT_WS(' ',i.last_name,i.middle_name,i.first_name) 
ORDER BY COUNT(c.instructor_id) DESC;


SELECT c.course_code,c.title,CONCAT_WS(' ',i.last_name,i.middle_name,i.first_name),COUNT(e.enrollment_id)
FROM course c INNER JOIN instructor i ON c.instructor_id = i.instructor_id
INNER JOIN enrollment e ON c.course_code = e.course_code GROUP BY c.course_code;

SELECT c.course_code,c.title,COUNT(l.lesson_id) AS total_lessons FROM course c
LEFT JOIN lesson l ON c.course_code = l.course_code GROUP BY c.course_code ORDER BY COUNT(l.lesson_id) DESC;

SELECT c.course_code,c.title,COUNT(l.lesson_id) AS total_lessons FROM course c
LEFT JOIN lesson l ON c.course_code = l.course_code GROUP BY c.course_code HAVING COUNT(l.lesson_id) = 0;

SELECT c.course_code,c.title,COUNT(r.review_id) AS total_review FROM course c
LEFT JOIN review r ON c.course_code = r.course_code GROUP BY c.course_code ORDER BY COUNT(r.review_id) ASC;

SELECT c.course_code,c.title,COUNT(r.review_id) AS total_review FROM course c
LEFT JOIN review r ON c.course_code = r.course_code GROUP BY c.course_code HAVING COUNT(r.review_id) = 0;

SELECT CONCAT_WS(' ',i.last_name,i.middle_name,i.first_name) AS instructors_fullname, COUNT(c.course_code) 
FROM instructor i 
LEFT JOIN course c
ON i.instructor_id = c.instructor_id 
GROUP BY CONCAT_WS(' ',i.last_name,i.middle_name,i.first_name)
ORDER BY COUNT(c.course_code)  DESC;

SELECT CONCAT_WS(' ',i.last_name,i.middle_name,i.first_name) AS instructors_fullname, COUNT(c.course_code) 
FROM instructor i 
LEFT JOIN course c
ON i.instructor_id = c.instructor_id 
GROUP BY CONCAT_WS(' ',i.last_name,i.middle_name,i.first_name)
HAVING COUNT(c.course_code) = 0;

SELECT c.course_code,c.title,COUNT(DISTINCT e.enrollment_id) AS total_enrollment,COUNT(DISTINCT r.review_id) AS total_review
FROM course c
LEFT JOIN enrollment e
ON c.course_code = e.course_code
LEFT JOIN review r
ON c.course_code = r.course_code
GROUP BY c.course_code
ORDER BY COUNT(DISTINCT e.enrollment_id) DESC;


SELECT s.student_id,CONCAT_WS(' ',s.last_name,s.middle_name,s.first_name) AS student_Fullname, COUNT(r.review_id) AS total_reviews
FROM student s
LEFT JOIN review r
ON s.student_id = r.student_id GROUP BY student_id
ORDER BY COUNT(r.review_id) DESC;

