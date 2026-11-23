#!/bin/sh
set -e

DB_PORT="${DB_PORT:-5432}"

if [ -n "$DB_HOST" ]; then
    echo "==> Waiting for PostgreSQL at ${DB_HOST}:${DB_PORT} ..."
    i=0
    while [ "$i" -lt 60 ]; do
        if PGPASSWORD="$DB_PASSWORD" pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" >/dev/null 2>&1; then
            echo "==> PostgreSQL is ready."
            break
        fi
        i=$((i + 1))
        echo "    ...not ready yet ($i/60)"
        sleep 2
    done
fi

echo "==> Starting Odoo ..."
exec /odoo/odoo-bin \
    --addons-path=/odoo/addons,/odoo/odoo/addons \
    --db_host="$DB_HOST" \
    --db_port="$DB_PORT" \
    --db_user="$DB_USER" \
    --db_password="$DB_PASSWORD" \
    -d "$DB_NAME" \
    -i base,hr,crm \
    --without-demo=all \
    --http-interface=0.0.0.0 \
    --http-port="${PORT:-8069}" \
    --log-level=info
