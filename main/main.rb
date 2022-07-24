# frozen_string_literal: true

require 'rack'
require 'erb'
require 'bundler/setup'

ENV['RACK_ENV'] = 'production'
Bundler.require(:default, ENV.fetch('RACK_ENV'))

require_relative 'helper/constants'
require_relative 'helper/shared_methods'
require_relative 'helper/validations'
require_relative 'entities/adapters/statistics_adapter'
require_relative 'entities/controllers/base_controller'
require_relative 'entities/controllers/game_controller'
require_relative 'entities/controllers/rules_controller'
require_relative 'entities/controllers/statistics_controller'
require_relative 'entities/controllers/home_controller'
require_relative 'entities/routers/router'
