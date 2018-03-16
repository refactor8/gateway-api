#!/bin/bash
set -e

rake db:exists || bin/rails db:setup

bin/rails db:migrate RAILS_ENV=$RAILS_ENV

bundle exec puma -C config/puma.rb
