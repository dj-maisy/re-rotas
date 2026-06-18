#!/usr/bin/env bash

set -eu

export RAILS_ENV=development

command -v npm > /dev/null || (echo "npm not installed" && exit 1)

bundle check || bundle install
npm install

echo "Running any migrations..."
bin/rake db:migrate
echo "Starting dev server..."
DISABLE_AUTH=yes bin/dev
