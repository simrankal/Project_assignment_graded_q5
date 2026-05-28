# ACID Property Explanation

## Transaction Used

Regrade request resolution transaction.

The transaction:

1. updates the regrade request status
2. updates the submission score
3. commits both operations together

---

## Atomicity

Both updates succeed together or fail together.

If the score update fails, the regrade request update should also be rolled back.

This prevents partial updates.

---

## Consistency

The transaction preserves database rules:

* valid submission IDs
* valid request statuses
* score constraints

The database remains logically correct before and after execution.

---

## Isolation

Other users should not see partially updated data during execution.

For example:

* another instructor should not see the request resolved before the score update completes.

---

## Durability

After COMMIT:

* the new score
* resolved request status

remain permanently stored even if the system crashes afterward.
