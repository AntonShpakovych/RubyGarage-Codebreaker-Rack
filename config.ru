# frozen_string_literal: true

require_relative 'main/main'

use Rack::Reloader
use Rack::Static, :urls => ['/assets'], :root => 'main/templates'
use Rack::Session::Cookie, key: 'rack.session', path: '/', expire_after: 2_592_000, secret: 'my_secret'
run Router
