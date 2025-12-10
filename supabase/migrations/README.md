Baseline and migration notes
============================

- `00008_prod_schema.sql` is the current baseline schema dump from production. Use this to bootstrap new environments (apply it alone, not in combination with the older incremental migrations).
- Older migrations (`00001`–`00007`) are preserved under `supabase/migrations/old/` for history and reference but should not be applied on top of the baseline.
- For new changes going forward, add incremental migrations after `00008_prod_schema.sql` rather than replacing the baseline dump.

Typical bootstrap for a fresh environment:
- Apply `00008_prod_schema.sql`.
- Apply any newer incremental migrations that follow it.
- Optionally, use `scripts/reset-db.sh` (non-prod) to drop/recreate the public schema and apply the baseline to a target database. Requires `CONFIRM_RESET=yes` and `DATABASE_URL` (non-prod only).

