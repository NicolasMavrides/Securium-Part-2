source 'https://rubygems.org'

source 'https://gems.shefcompsci.org.uk' do
  gem 'airbrake'
  gem 'rubycas-client'
  gem 'epi_cas'
  gem 'epi_deploy', group: :development
  gem 'capybara-select2', group: :test
  gem 'epi_js'
end

gem 'rails', '6.0.0'
gem 'activerecord-session_store'
gem 'bootsnap'
gem 'responders'
gem 'thin'
gem 'figaro'
gem 'devise-async'
gem 'geocoder'

gem 'sqlite3', '1.4.1', group: [:development, :test]
gem 'pg'

gem 'rubocop', require: false
gem 'haml_lint', require: false

# HAML Framework
gem 'haml-rails'
gem 'sassc-rails'
gem 'sassc', '2.2.0' # 2.2.1 is currently broken on LTSP
gem 'uglifier'
gem 'coffee-rails'

# Design Frameworks
gem 'sprockets-rails', '>= 2.3.2', require: 'sprockets/railtie'
gem 'bootstrap', '~> 4.3.1'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'font-awesome-sass', '~> 5.9.0'
# select2-rails is vendored under vendor/assets

gem 'open3'
gem 'simple_form'
gem 'draper'
gem 'ransack'

gem 'will_paginate'
gem 'bootstrap-will_paginate'

gem 'devise'
gem 'devise_ldap_authenticatable'
gem 'devise_cas_authenticatable'
gem 'devise_token_auth'
gem 'cancancan'

gem 'whenever'
gem 'delayed_job'
gem 'delayed_job_active_record'
gem 'delayed-plugins-airbrake'
gem 'daemons', '1.1.9'

gem 'ed25519'
gem 'bcrypt_pbkdf'
gem 'faraday'

group :development, :test do
  gem 'rspec-rails'
  gem 'rspec-wait'
  gem 'byebug'
end

group :development do
  gem 'listen'
  gem 'web-console'

  gem 'capistrano', '~> 3.11'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-passenger', require: false

  gem 'eventmachine'
  gem 'letter_opener'
  gem 'annotate'

  gem 'bullet'
end

group :test do
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'webdrivers'
  gem 'rspec-instafail', require: false

  gem 'database_cleaner'
  gem 'launchy'
  gem 'simplecov'
end
