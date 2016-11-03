source 'http://rubygems.org'
ruby '2.3.1'

gem 'rails', '4.2.7.1'
gem 'rake'
gem 'rails_12factor'
gem 'ffi', '1.9.6'
gem 'sass'
gem 'activeadmin', github: 'activeadmin'

gem 'gon'
# gem 'rabl-rails'
gem 'gchartrb'

gem "therubyracer"
gem "less-rails"
#gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'rails-3-x' # For 3.x
gem 'rails3-generators'
group :development, :test do
  # gem 'sqlite3'
  gem "factory_girl_rails"
  gem "guard-rspec"
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'rspec-rails', '~> 3.0'
  gem 'simplecov'
  gem 'test-unit'
  gem 'database_cleaner'
  gem 'irbtools-more', require: 'irbtools/binding'
  gem 'byebug'
  gem 'meta_request'
end
group :production, :staging do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-ui-rails'
  gem 'twitter-bootstrap-rails'
  gem 'inline_svg'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

gem 'devise'
# gem 'omniauth-twitter'
gem 'omniauth'
gem 'omniauth-twitter', :github => 'arunagw/omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-github'
gem 'omniauth-amazon'
gem 'figaro'
#gem 'omniauth-youtube'
