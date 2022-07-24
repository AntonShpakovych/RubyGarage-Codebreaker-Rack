# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.7.3'
git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'codebreaker', git: 'https://github.com/AntonShpakovych/newgemruby', branch: 'development', ref: 'e3033cb'
gem 'rack', '~> 2.2.4'

group :test do
  gem 'rack-test', '~> 2.0.2'
  gem 'rspec', '~> 3.11.0'
  gem 'simplecov', '~> 0.21.2'
end

group :development do
  gem 'fasterer', '~> 0.10.0'
  gem 'rubocop', '~> 1.31.2'
  gem 'rubocop-performance', '~> 1.14.3'
  gem 'rubocop-rspec', '~> 2.12.1'
end
