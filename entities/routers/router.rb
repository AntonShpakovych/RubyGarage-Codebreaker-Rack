# frozen_string_literal: true

class Router
  include Constants
  include SharedMethod

  def self.call(env)
    new(env).routes.finish
  end

  def initialize(env)
    @env = env
    @request = Rack::Request.new(env)
  end

  def routes
    ROUTES.key?(@request.path) ? ROUTES[@request.path].call(@request) : eror_404_not_found
  end

  private

  def eror_404_not_found
    respond('404.html.erb', 404)
  end
end
