Your README should explain:

project objective
safety strategy
use of staging/temp tables
transaction handling
rollback and savepoint usage

# CodeJudge Transactions and Database Reliability

## Objective

This project demonstrates:

* safe UPDATE operations
* safe DELETE operations
* transaction management
* rollback handling
* savepoint usage
* ACID property understanding

The implementation focuses on database reliability and preventing accidental data corruption.

## Safety Measures

The original imported database was never modified directly.

All operations were performed using:

* staging tables
* transactional testing
* rollback validation

## Files

| File                | Purpose                       |
| ------------------- | ----------------------------- |
| safe_updates.sql    | Verified UPDATE operations    |
| safe_deletes.sql    | Verified DELETE operations    |
| transactions.sql    | Transaction scenarios         |
| acid_explanation.md | ACID property explanation     |
| incident_note.md    | Reliability incident analysis |
