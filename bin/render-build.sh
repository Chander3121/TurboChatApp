#!/usr/bin/env bash
# This script is for deploying a Ruby on Rails application
# It installs gems, sets up the database, precompiles assets, and cleans up

# Exit immediately if a command exits with a non-zero status
set -o errexit

# Trap errors and perform cleanup tasks
trap 'bundle exec rails assets:clean' ERR

# Install gems
bundle install

# Disable database environment check to avoid issues in production
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:migrate RAILS_ENV=production

# Remove old compiled assets
bundle exec rails assets:clobber

# Precompile assets for the production environment
bundle exec rails assets:precompile RAILS_ENV=production

# Clean up any temporary files generated during asset precompilation
bundle exec rails assets:clean