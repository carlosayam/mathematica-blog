source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'twitter-bootstrap-rails'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development do
  gem "spork", "> 0.9.0.rc"
  gem "guard-spork"
  gem 'guard-rspec'
  gem 'guard-livereload'
end

group :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "shoulda"

  # cucumber gems
  gem "cucumber"
  gem "cucumber-rails"
  gem "capybara"
  gem "database_cleaner"

  gem "launchy"    # So you can do Then show me the page
  gem "minitest"  # currently breaks without this
  # Guard
  group :darwin do
    gem 'rb-fsevent', :require => false
  end

end

group :development do
  gem "rails3-generators"
  gem "nifty-generators"
end

gem "haml"
gem "haml-rails"
gem "devise"
gem "cancan"
gem "decent_exposure"

# Deployment
group :development do
  gem "capistrano-ext"
  gem "capistrano"
end
gem "mocha", :group => :test

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
