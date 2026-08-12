SELECT course_code,title,price FROM course WHERE price > (SELECT AVG(price) FROM course);

SELECT s.student_id, CONCAT_WS(' ',s.last_name,s.middle_name,s.first_name), COUNT(r.review_id) FROM student s LEFT JOIN review r 
ON s.student_id = r.student_id  GROUP BY student_id HAVING COUNT(r.review_id) = 0;


SELECT course_code,title,price FROM course WHERE price <= (SELECT AVG(price) AS avg_price FROM course);

SELECT c.course_code,c.price,c.title,CONCAT_WS(' ',i.last_name,i.middle_name,i.first_name) AS Full_name FROM course c
INNER JOIN instructor i ON c.instructor_id = i.instructor_id WHERE price = (SELECT MAX(price) AS highest_course_price FROM course);


SELECT s.student_id,CONCAT_WS(' ',s.last_name,s.middle_name,s.first_name) FROM student s LEFT JOIN enrollment e
ON s.student_id = e.student_id WHERE s.student_id NOT IN (SELECT student_id FROM enrollment);

SELECT c.course_code,c.title,c.price FROM course c WHERE c.course_code NOT IN(SELECT DISTINCT course_code from enrollment);

SELECT s.student_id,CONCAT_WS(' ',s.last_name,s.middle_name,s.first_name) FROM student s WHERE s.student_id NOT IN (SELECT DISTINCT student_id from review);

SELECT s.student_id,CONCAT_WS(' ',s.last_name,s.middle_name,s.first_name),r.review_id FROM student s INNER JOIN review r ON s.student_id = r.student_id
WHERE s.student_id NOT IN (SELECT DISTINCT student_id FROM enrollment);

SELECT course_code, COUNT(review_id) AS total_reviews FROM review GROUP BY course_code ORDER BY COUNT(review_id) DESC ;

SELECT student_id,COUNT(review_id) FROM review GROUP BY student_id ORDER BY COUNT(review_id) DESC;


SELECT course_code,COUNT(enrollment_id) FROM enrollment GROUP BY course_code
HAVING COUNT(enrollment_id) > (SELECT AVG(Total_counts) AS avg_enroll FROM (SELECT COUNT(enrollment_id) AS Total_counts FROM enrollment GROUP BY course_code) AS avg_enrol); 