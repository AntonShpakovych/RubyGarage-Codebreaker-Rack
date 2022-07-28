# frozen_string_literal: true

class Router
  include SharedMethod

  def self.call(env)
    new(env).routes.finish
  end

  def initialize(env)
    @env = env
    @request = Rack::Request.new(env)
  end

  def routes
    case @request.path
    when '/' then HomeController.new(@request).index
    when '/statistics' then StatisticsController.new(@request).index
    when '/rules' then RulesController.new(@request).index
    when '/game' then GamesController.new(@request).index
    when '/hint' then HintController.new(@request).index
    when '/restart' then RestartController.new(@request).index
    when '/win' then WinController.new(@request).index
    when '/lose' then LoseController.new(@request).index
    else
      eror_404_not_found
    end
  end

  private

  def eror_404_not_found
    respond('404.html.erb', 404)
  end
end
