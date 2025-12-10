#!/usr/bin/env bash
set -euo pipefail

# Reset a non-production database to the baseline schema.
# Uses Postgres 17 client in Docker to avoid local pg client dependency.
#
# REQUIRED:
#   DATABASE_URL   - target DB URL (NON-PROD ONLY)
#   CONFIRM_RESET  - must be "yes" to proceed
#
# Example:
#   CONFIRM_RESET=yes DATABASE_URL="postgresql://user:pass@host:5432/db?sslmode=require" ./scripts/reset-db.sh
#
# WARNING: This DROPS and recreates the public schema.

if [[ "${CONFIRM_RESET:-}" != "yes" ]]; then
  echo "Refusing to run. Set CONFIRM_RESET=yes to proceed (non-prod only)." >&2
  exit 1
fi

if [[ -z "${DATABASE_URL:-}" ]]; then
  echo "DATABASE_URL is required (non-prod only)." >&2
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCHEMA_FILE="$ROOT_DIR/supabase/migrations/00008_prod_schema.sql"

if [[ ! -f "$SCHEMA_FILE" ]]; then
  echo "Schema file not found at $SCHEMA_FILE" >&2
  exit 1
fi

echo "Resetting database (public schema) at DATABASE_URL... (non-prod only)"

docker run --rm -v "$ROOT_DIR:/work" -w /work postgres:17 bash -c "
  set -euo pipefail
  psql \"${DATABASE_URL}\" -v ON_ERROR_STOP=1 -c \"DROP SCHEMA public CASCADE; CREATE SCHEMA public;\"
  psql \"${DATABASE_URL}\" -v ON_ERROR_STOP=1 -f supabase/migrations/00008_prod_schema.sql
"

echo "Database reset complete."

