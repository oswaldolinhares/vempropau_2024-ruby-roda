#!/bin/sh
set -e

echo "Waiting for PostgreSQL to become ready..."
while ! pg_isready -h db -p 5432 > /dev/null 2>&1; do
  sleep 1
done
echo "PostgreSQL is ready."

if [ "$EXECUTE_DB_SETUP" = "true" ]; then
  echo "Running database migrations..."
  bundle exec sequel -m db/migrate ${DATABASE_URL}

  echo "Seeding the database..."
  ruby db/seeds.rb
fi

echo "Starting the application..."
exec bundle exec puma -C config/puma.rb
