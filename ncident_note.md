# Reliability Incident Note

## Incident Summary

A developer accidentally executed:

```sql id="0g6zq7"
UPDATE submissions
SET status = 'successful';
```

without a WHERE clause.

---

## Impact

All submission records in the database were modified.

This caused:

* incorrect analytics
* invalid contest rankings
* inaccurate student performance reports

---

## Detection

The issue was detected because:

* submission success rates suddenly became 100%
* audit logs showed an unusually large UPDATE operation
* row modification counts were abnormally high

---

## Recovery

Recovery options included:

* transaction rollback (if not yet committed)
* restoring from backup
* restoring affected rows from staging tables

---

## Preventive Measures

Future prevention measures:

* require transactions for bulk updates
* require WHERE clause validation during code review
* use row-count confirmation before COMMIT
* maintain automated database backups
* restrict direct production access
