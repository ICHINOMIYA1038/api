#!/usr/bin/env bash
# exit on error

bundle install
#bundle exec rails db:migrate
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rake db:migrate:reset
bundle exec rails db:seed RAILS_ENV=production 
