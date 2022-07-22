# frozen_string_literal: true

require 'simplecov'
require 'rack/test'

SimpleCov.start do
  enable_coverage :branch
  add_filter %w[/spec/]
  minimum_coverage 100
end

require_relative '../main/main'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
