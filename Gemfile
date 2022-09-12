# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'

gem 'httparty', '~> 0.20.0'
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'sidekiq', '~> 6.2', '>= 6.2.2'
gem "sidekiq-scheduler", "~> 4.0"
gem 'sinatra', '~> 2.1'
gem 'webpacker', '~> 5.0'
gem "net-ftp", "~> 0.1.3"

gem 'bootsnap', '>= 1.4.4', require: false
gem 'bootstrap-daterangepicker-rails'
gem 'devise', '~> 4.8'
gem 'foreman'
gem 'hotwire-rails', '~> 0.1.3'
gem 'jquery-rails' # dependency of daterangepicker
gem 'momentjs-rails' # dependency of daterangepicker
gem 'ransack', '~> 2.5'
gem 'redis', '~> 4.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'dotenv-rails'
end

group :development do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'webdrivers'
end
