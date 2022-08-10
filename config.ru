# frozen_string_literal: true

require_relative 'connection'
require 'delegate'

use Rack::Reloader
use Rack::Static, :urls => ['/assets'], :root => 'templates'
use Rack::Session::Cookie, key: 'rack.session', path: '/', expire_after: 2_592_000, secret: 'my_secret'
run Router
