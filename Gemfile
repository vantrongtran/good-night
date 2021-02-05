source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "active_model_serializers", "~> 0.10.0"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.4.4", require: false
gem "config"
gem "mysql2", "~> 0.5"
gem "pagy"
gem "puma", "~> 5.0"
gem "rack-cors"
gem "rails", "~> 6.1.1"

group :development, :test do
  gem "brakeman"
  gem "bullet"
  gem "bundler-audit", require: false
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-byebug"
  gem "rspec"
  gem "rspec-collection_matchers"
  gem "rspec-rails"
  gem "rubocop", "~> 1.9", require: false
  gem "rubocop-performance", "~> 1.9.0"
  gem "rubocop-rspec", "~> 2.0.0"
end

group :development do
  gem "listen", "~> 3.3"
  gem "spring"
end

group :test do
  gem "database_cleaner"
  gem "shoulda-matchers", "~> 4.0"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
