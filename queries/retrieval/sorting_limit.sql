SELECT course_code,title,price FROM course ORDER BY price ASC;
SELECT course_code,price FROM course ORDER BY price DESC LIMIT 5;
SELECT student_id,first_name,last_name,middle_name,join_date FROM student ORDER BY join_date DESC LIMIT 10;
SELECT enrollment_id,student_id,enrollment_date FROM enrollment ORDER BY enrollment_date ASC LIMIT 5;
SELECT course_code,title,price FROM course WHERE price > 50 LIMIT 3;
SELECT course_code,title,price FROM course WHERE difficulty_level = 'Professional' ORDER BY price DESC limit 2;
SELECT course_code,title,price FROM course WHERE price > 50 ORDER BY price ASC LIMIT 4;