source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'mysql2', '~> 0.5'
gem 'rails', '~> 6.1.1'
gem 'bcrypt', '~> 3.1.7'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'active_model_serializers', '~> 0.10.0'
gem 'config'
gem 'rack-cors'

group :development, :test do
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'rubocop', '~> 1.9', require: false
  gem 'rubocop-performance', '~> 1.9.0'
  gem 'rubocop-rspec', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby)
