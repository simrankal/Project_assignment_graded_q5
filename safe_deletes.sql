-- =========================================
-- DELETE 1: REMOVE DUPLICATE ENROLLMENTS
-- =========================================

CREATE TABLE enrollments_staging AS
SELECT *
FROM enrollments;

-- BEFORE

SELECT
student_id,
course_id,
COUNT(*) AS duplicate_count
FROM enrollments_staging
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

-- DELETE

DELETE e1
FROM enrollments_staging e1
JOIN enrollments_staging e2
ON e1.student_id = e2.student_id
AND e1.course_id = e2.course_id
AND e1.enrollment_id > e2.enrollment_id;

-- AFTER

SELECT
student_id,
course_id,
COUNT(*) AS duplicate_count
FROM enrollments_staging
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

-- SAFETY NOTE:
-- Only duplicate rows with larger enrollment_id values are removed.

-- =========================================
-- DELETE 2: REMOVE ORPHAN TEST RESULTS
-- =========================================

CREATE TABLE test_results_staging AS
SELECT *
FROM test_results;

-- BEFORE

SELECT
tr.test_result_id
FROM test_results_staging tr
LEFT JOIN submissions s
ON tr.submission_id = s.submission_id
WHERE s.submission_id IS NULL;

-- DELETE

DELETE tr
FROM test_results_staging tr
LEFT JOIN submissions s
ON tr.submission_id = s.submission_id
WHERE s.submission_id IS NULL;

-- AFTER

SELECT
tr.test_result_id
FROM test_results_staging tr
LEFT JOIN submissions s
ON tr.submission_id = s.submission_id
WHERE s.submission_id IS NULL;

-- SAFETY NOTE:
-- Only orphan rows without matching submissions are deleted.
