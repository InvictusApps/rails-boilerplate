#!/bin/bash

set -e

if rake db:exists
then
  rake db:migrate
  echo "Migrated database"
else
  rake db:setup
  echo "Setup database"
fi

bundle exec puma -C config/puma.rb --quiet