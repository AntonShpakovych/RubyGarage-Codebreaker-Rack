# frozen_string_literal: true

require 'bundler/setup'
require 'rack'
require 'erb'
Bundler.require(:default)

require_relative 'helper/constants'
require_relative 'helper/shared_methods'
require_relative 'helper/validations'
require_relative 'entities/statistics'
require_relative 'entities/game_controller'
require_relative 'entities/base_controller'
