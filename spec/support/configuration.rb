# frozen_string_literal: true

def app
  Rack::Builder.parse_file('config.ru').first
end
