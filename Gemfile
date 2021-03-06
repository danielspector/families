source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0.rc2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'mini_magick'
gem 'carrierwave'
gem 'fog'
gem 'faker'
gem 'unf'
gem 'remotipart'
gem 'magnific-popup-rails'
gem 'friendly_id'
gem 'launchy'
gem "ransack", github: "activerecord-hackery/ransack", branch: "rails-4.1"
gem "polyamorous", github: "activerecord-hackery/polyamorous"
gem 'jquery-ui-rails'
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
# gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'figaro', git: 'https://github.com/laserlemon/figaro.git'

group :test, :development do
  gem "rspec-rails"
  gem "capybara", github: 'jnicklas/capybara'
  gem "poltergeist"
  gem "selenium-webdriver"
  # gem "capybara-webkit"
  gem "better_errors"
  gem "sprockets_better_errors"
  gem "binding_of_caller"
  gem "factory_girl_rails"
  gem "simplecov"
  gem "database_cleaner"
  gem "sqlite3"
  gem "pry"
end

group :production do
  gem "pg"
  gem "google-analytics-rails"
  gem "rails_12factor"
end

gem "bootstrap-sass", "~> 3.1.1"
gem "devise"