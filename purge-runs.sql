SELECT COUNT(*) FROM builds;
SELECT COUNT(*) FROM runs;
SELECT COUNT(*) FROM statistics;

WITH builds_to_delete AS (
    SELECT id FROM "builds" WHERE "builds"."createdAt" < current_date - interval '10 days'
),
stats_to_delete AS (
    DELETE FROM "statistics" WHERE "buildId" IN (
        SELECT * FROM builds_to_delete
    )
    RETURNING id as deleted_stats_ids
),
runs_to_delete AS (
    DELETE FROM "runs" WHERE "buildId" IN (
        SELECT * FROM builds_to_delete
    )
    RETURNING id as deleted_runs_ids
)
DELETE FROM "builds" WHERE "builds"."id" in (
    SELECT * FROM builds_to_delete
);

SELECT COUNT(*) FROM builds;
SELECT COUNT(*) FROM runs;
SELECT COUNT(*) FROM statistics
