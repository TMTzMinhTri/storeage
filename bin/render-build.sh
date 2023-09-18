#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean

bundle exec rake db:environment:set RAILS_ENV=production
# bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
bundle exec rake db:reset RAILS_ENV=production
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rake import_data:locations
bundle exec rake import_data:borrowers