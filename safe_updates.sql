You need at least 4 safe UPDATE examples.

Every example must contain:

BEFORE query
UPDATE
AFTER query
safety explanation


-- =========================================
-- CREATE STAGING TABLE
-- =========================================

CREATE TABLE students_staging AS
SELECT *
FROM students;

-- =========================================
-- UPDATE 1: FIX INVALID EMAIL
-- =========================================

-- BEFORE

SELECT
student_id,
email
FROM students_staging
WHERE email = 'rahul.gmail.com';

-- UPDATE

UPDATE students_staging
SET email = '[rahul@gmail.com](mailto:rahul@gmail.com)'
WHERE student_id = 1042
AND email = 'rahul.gmail.com';

-- AFTER

SELECT
student_id,
email
FROM students_staging
WHERE student_id = 1042;

-- SAFETY NOTE:
-- WHERE clause uses both student_id and old email value
-- to avoid modifying unintended rows.

-- =========================================
-- UPDATE 2: FIX NEGATIVE SCORE
-- =========================================

CREATE TABLE submissions_staging AS
SELECT *
FROM submissions;

-- BEFORE

SELECT
submission_id,
score
FROM submissions_staging
WHERE score < 0;

-- UPDATE

UPDATE submissions_staging
SET score = 0
WHERE submission_id = 88312
AND score = -5;

-- AFTER

SELECT
submission_id,
score
FROM submissions_staging
WHERE submission_id = 88312;

-- SAFETY NOTE:
-- Specific submission_id prevents accidental bulk updates.

-- =========================================
-- UPDATE 3: FIX INVALID DIFFICULTY
-- =========================================

CREATE TABLE problems_staging AS
SELECT *
FROM problems;

-- BEFORE

SELECT
problem_id,
difficulty
FROM problems_staging
WHERE difficulty = 'Intermediate';

-- UPDATE

UPDATE problems_staging
SET difficulty = 'Medium'
WHERE problem_id = 204
AND difficulty = 'Intermediate';

-- AFTER

SELECT
problem_id,
difficulty
FROM problems_staging
WHERE problem_id = 204;

-- =========================================
-- UPDATE 4: UPDATE SUBMISSION STATUS
-- =========================================

-- BEFORE

SELECT
submission_id,
status
FROM submissions_staging
WHERE submission_id = 5012;

-- UPDATE

UPDATE submissions_staging
SET status = 'successful'
WHERE submission_id = 5012
AND score = 100;

-- AFTER

SELECT
submission_id,
status
FROM submissions_staging
WHERE submission_id = 5012;
