-- ============================================================
-- Level 5 — Subqueries
-- Practice questions Q1-Q10 + bonus (Online Course Platform)
-- Written by hand and verified in the MySQL CLI.
-- ============================================================

-- Q1: Which courses are priced at or below the average course price?
-- Result: 16 rows (avg price = 93.54)
SELECT course_code, title, price
FROM course
WHERE price <= (SELECT AVG(price) FROM course);

-- Q2: What is the most expensive course and who teaches it?
-- Result: CL301 Big Data Technologies (159.99) — Agyeman Yaw Kojo
SELECT c.course_code, c.title, c.price,
       CONCAT_WS(' ', i.last_name, i.middle_name, i.first_name) AS instructor
FROM course c
INNER JOIN instructor i ON c.instructor_id = i.instructor_id
WHERE c.price = (SELECT MAX(price) FROM course);

-- Q3: Which students have never enrolled in any course?
-- Result: empty set — all 603 students have enrolled at least once
SELECT s.student_id, CONCAT_WS(' ', s.last_name, s.middle_name, s.first_name) AS student
FROM student s
WHERE s.student_id NOT IN (SELECT student_id FROM enrollment);

-- Q4: Which courses has nobody ever enrolled in? (TO DO — run me)
-- Predict: 2 courses
SELECT c.course_code, c.title
FROM course c
WHERE c.course_code NOT IN (SELECT DISTINCT course_code FROM enrollment);

-- Q5: Which students have written a review? (TO DO — run me)
-- Predict: 100 rows
SELECT s.student_id, CONCAT_WS(' ', s.last_name, s.middle_name, s.first_name) AS student
FROM student s
WHERE s.student_id IN (SELECT DISTINCT student_id FROM review);

-- Q6: Students who reviewed a course but never enrolled (ghost reviewers)?
-- Result: empty set — impossible here since every student is enrolled
SELECT s.student_id, CONCAT_WS(' ', s.last_name, s.middle_name, s.first_name) AS student, r.review_id
FROM student s
INNER JOIN review r ON s.student_id = r.student_id
WHERE s.student_id NOT IN (SELECT DISTINCT student_id FROM enrollment);

-- Q7: Which course has the most reviews?
-- Result: DS101 with 5 reviews
SELECT course_code, COUNT(review_id) AS total_reviews
FROM review
GROUP BY course_code
ORDER BY COUNT(review_id) DESC;

-- Q8: Which student has written the most reviews?
-- Result: 100-way tie — every reviewer has exactly 1 review
SELECT student_id, COUNT(review_id) AS total_reviews
FROM review
GROUP BY student_id
ORDER BY COUNT(review_id) DESC;

-- Q9: Courses priced above the average price of their own subject area
--      (correlated subquery). (TO DO — run me)
--      Subject area = first 2 letters of the course code (CS, PY, DS, ...)
SELECT c1.course_code, c1.title, c1.price,
       (SELECT AVG(c2.price) FROM course c2
        WHERE LEFT(c2.course_code, 2) = LEFT(c1.course_code, 2)) AS subject_avg
FROM course c1
WHERE c1.price > (SELECT AVG(c2.price) FROM course c2
                  WHERE LEFT(c2.course_code, 2) = LEFT(c1.course_code, 2));

-- Q10: Which courses have FEWER enrollments than the average per course?
--      Derived-table pattern: count per course first, then average the counts.
--      avg per course = 20.79. Result: CS105 (2), WEB301 (1).
SELECT course_code, COUNT(enrollment_id) AS total_enrollments
FROM enrollment
GROUP BY course_code
HAVING COUNT(enrollment_id) < (SELECT AVG(Total_counts) FROM (
    SELECT COUNT(enrollment_id) AS Total_counts FROM enrollment GROUP BY course_code
) AS avg_enrol);

-- BONUS: Which instructor earns the highest total revenue?
--        revenue = sum of course price x enrollments per course. (TO DO — run me)
SELECT i.instructor_id,
       CONCAT_WS(' ', i.last_name, i.middle_name, i.first_name) AS instructor,
       SUM(c.price * e.cnt) AS total_revenue
FROM instructor i
INNER JOIN course c ON i.instructor_id = c.instructor_id
INNER JOIN (SELECT course_code, COUNT(*) AS cnt FROM enrollment GROUP BY course_code) e
           ON c.course_code = e.course_code
GROUP BY i.instructor_id
ORDER BY total_revenue DESC;
