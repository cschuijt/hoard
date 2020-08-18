source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'
gem 'rails', '~> 6.0.3'

# Postgres in production, SQLite in development
gem 'sqlite3', '~> 1.4'
gem 'pg', '~> 1.2'

# Puma as webserver for development
gem 'puma', '~> 4.1'

# Asset pipelines
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'

gem 'bootsnap', '>= 1.4.2', require: false

# Authentication through Devise and OmniAuth
gem 'devise', '~> 4.7.2'
gem 'omniauth', '~> 1.9.1'
gem 'omniauth-twitter', '~> 1.4.0'

# File uploads, validation and image processing
gem 'active_storage_validations', '~> 0.8.9'
gem 'image_processing', '~> 1.11.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'rspec-rails', '~> 4.0.0'
  gem "factory_bot_rails", '~> 5.2.0'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Capistrano for deployment
gem 'capistrano', '~> 3.14'
gem 'capistrano-rails', '~> 1.4'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'

gem 'ed25519'
gem 'bcrypt_pbkdf'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
