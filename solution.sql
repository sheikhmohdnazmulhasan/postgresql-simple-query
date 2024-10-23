-- Active: 1729130742383@@127.0.0.1@5432@university_db

-- crating database
CREATE DATABASE university_db;

-- crating students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    frontend_mark INT NOT NULL,
    backend_mark INT NOT NULL,
    status VARCHAR(100)
);

-- creating courses table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    credits INT NOT NULL
);

-- crate enrollment table with ref
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students (student_id),
    course_id INT REFERENCES courses (course_id)
);

-- insert data into students table
INSERT INTO
    students (
        student_id,
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark,
        status
    )
VALUES (
        1,
        'Sameer',
        21,
        'sameer@example.com',
        48,
        60,
        NULL
    ),
    (
        2,
        'Zoya',
        23,
        'zoya@example.com',
        52,
        58,
        NULL
    ),
    (
        3,
        'Nabil',
        22,
        'nabil@example.com',
        37,
        46,
        NULL
    ),
    (
        4,
        'Rafi',
        24,
        'rafi@example.com',
        41,
        40,
        NULL
    ),
    (
        5,
        'Sophia',
        22,
        'sophia@example.com',
        50,
        52,
        NULL
    ),
    (
        6,
        'Hasan',
        23,
        'hasan@gmail.com',
        43,
        39,
        NULL
    );

-- Insert data into the courses table
INSERT INTO
    courses (
        course_id,
        course_name,
        credits
    )
VALUES (1, 'Next.js', 3),
    (2, 'React.js', 4),
    (3, 'Databases', 3),
    (4, 'Prisma', 3);

-- Insert data into the enrollment table:
INSERT INTO
    enrollment (
        enrollment_id,
        student_id,
        course_id
    )
VALUES (1, 1, 1),
    (2, 1, 2),
    (3, 2, 1),
    (4, 3, 2);

-- Query 1: Insert a new student record with the following details
INSERT INTO
    students (
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark,
        status
    )
VALUES (
        'Sheikh Mohammad Nazmul H.',
        21,
        'nazmulofficial@outlook.com',
        32,
        54,
        NULL
    );

-- Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
SELECT s.student_name
FROM
    students s
    JOIN enrollment e USING (student_id)
    JOIN courses c USING (course_id)
WHERE
    c.course_name = 'Next.js';

-- Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
UPDATE students
SET
    status = 'Awarded'
WHERE
    student_id = (
        SELECT student_id
        FROM students
        ORDER BY (frontend_mark + backend_mark) DESC
        LIMIT 1
    );

-- Query 4: Delete all courses that have no students enrolled.
DELETE FROM courses
WHERE
    course_id NOT IN (
        SELECT DISTINCT
            course_id
        FROM enrollment
    );

-- Query 5: Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name
FROM students
ORDER BY student_id
OFFSET
    2
LIMIT 2;

-- Query 6: Retrieve the course names and the number of students enrolled in each course.
SELECT c.course_name, COUNT(e.student_id) AS student_enrolled
FROM courses c
    LEFT JOIN enrollment e USING (course_id)
GROUP BY
    c.course_name;

-- Query 7: Calculate and display the average age of all students.
SELECT ROUND(AVG(age), 2) AS average_age FROM students;

-- Query 8: Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name FROM students WHERE email ILIKE '%example.com%';