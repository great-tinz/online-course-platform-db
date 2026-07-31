CREATE TABLE student(
    student_id INT AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    middle_name VARCHAR(20) ,
    email VARCHAR(50) NOT NULL,
    join_date DATE NOT NULL,

    CONSTRAINT pk_stu PRIMARY KEY (student_id),
    CONSTRAINT uk_stu_email UNIQUE (email)
)
    ENGINE = InnoDB AUTO_INCREMENT = 1000;


CREATE TABLE instructor(
    instructor_id INT AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    middle_name VARCHAR(20),
    email VARCHAR(50) NOT NULL,
    bio TEXT,
    CONSTRAINT pk_instruct PRIMARY KEY (instructor_id),
    CONSTRAINT uk_email_instruct UNIQUE (email)
)
    ENGINE = InnoDB AUTO_INCREMENT = 5000;


CREATE TABLE course(
    course_code VARCHAR(20),
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    difficulty_level VARCHAR(20) NOT NULL,
    instructor_id INT NOT NULL,

    CONSTRAINT pk_coscode PRIMARY KEY (course_code),
    CONSTRAINT chk_cos_difflty_lvl CHECK (difficulty_level IN ('Beginner','Intermediate','Professional')),
    CONSTRAINT fk_cos FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id)
);


CREATE TABLE enrollment(
    enrollment_id INT AUTO_INCREMENT,
    enrollment_date DATE NOT NULL,
    completion_status VARCHAR(20) NOT NULL,
    student_id INT NOT NULL,
    course_code VARCHAR(20) NOT NULL,

    CONSTRAINT pk_enrolmt PRIMARY KEY (enrollment_id),
    CONSTRAINT chk_compltn_stat CHECK (completion_status IN ('Not started','In Progress','Completed')),
    CONSTRAINT fk_enrolmt_stu_id FOREIGN KEY (student_id) REFERENCES student(student_id),
    CONSTRAINT fk_enrolmt_cos_code FOREIGN KEY (course_code) REFERENCES course(course_code),
    CONSTRAINT uk_enrolmt UNIQUE (student_id,course_code)
    )
    ENGINE = InnoDB AUTO_INCREMENT = 100000;


CREATE TABLE review(
    review_id INT AUTO_INCREMENT,
    rating INT NOT NULL,
    comment TEXT NOT NULL,
    student_id INT NOT NULL,
    course_code VARCHAR(20) NOT NULL,

    CONSTRAINT pk_review PRIMARY KEY (review_id),
    CONSTRAINT chk_rating_review CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT fk_review_stu_id FOREIGN KEY (student_id) REFERENCES student(student_id),
    CONSTRAINT fk_review_cos_code FOREIGN KEY (course_code) REFERENCES course(course_code),
    CONSTRAINT uk_review UNIQUE (student_id,course_code)
)
    ENGINE = InnoDB AUTO_INCREMENT = 500000;


CREATE TABLE lesson(
    lesson_id INT AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    sequence_number INT NOT NULL,
    course_code VARCHAR(20) NOT NULL,

    CONSTRAINT pk_lesson PRIMARY KEY (lesson_id),
    CONSTRAINT fk_lessono_cos_code FOREIGN KEY (course_code) REFERENCES course(course_code)
)
    ENGINE = InnoDB AUTO_INCREMENT = 1;