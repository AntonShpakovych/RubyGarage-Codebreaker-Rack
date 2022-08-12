# frozen_string_literal: true

RSpec.configure do |config|
  config.include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('config.ru').first
  end
end
