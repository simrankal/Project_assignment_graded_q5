-- =========================================
-- TRANSACTION 1
-- STUDENT SUBMISSION CREATION
-- =========================================

START TRANSACTION;

INSERT INTO submissions_staging
(
submission_id,
student_id,
problem_id,
language,
score,
status
)
VALUES
(
99001,
101,
205,
'Python',
100,
'successful'
);

INSERT INTO test_results_staging
(
test_result_id,
submission_id,
test_case_id,
status
)
VALUES
(
88001,
99001,
301,
'passed'
);

COMMIT;

-- EXPECTED RESULT:
-- Both submission and test result are permanently stored.

-- =========================================
-- TRANSACTION 2
-- INVALID ENROLLMENT WITH ROLLBACK
-- =========================================

START TRANSACTION;

INSERT INTO enrollments_staging
(
enrollment_id,
student_id,
course_id
)
VALUES
(
50001,
99999,
12
);

-- Validation check fails because student does not exist

ROLLBACK;

-- EXPECTED RESULT:
-- No enrollment row remains in the database.

-- =========================================
-- TRANSACTION 3
-- SAVEPOINT EXAMPLE
-- =========================================

START TRANSACTION;

UPDATE submissions_staging
SET score = 85
WHERE submission_id = 7001;

SAVEPOINT score_update_done;

UPDATE submissions_staging
SET status = 'successful'
WHERE submission_id = 7001;

-- Suppose validation fails

ROLLBACK TO score_update_done;

COMMIT;

-- EXPECTED RESULT:
-- Score update remains.
-- Status update is undone.

-- =========================================
-- TRANSACTION 4
-- REGRADE REQUEST RESOLUTION
-- =========================================

START TRANSACTION;

UPDATE regrade_requests_staging
SET request_status = 'resolved'
WHERE request_id = 1201;

UPDATE submissions_staging
SET score = score + 10
WHERE submission_id = 7001;

COMMIT;

-- EXPECTED RESULT:
-- Regrade resolution and score update both succeed together.
