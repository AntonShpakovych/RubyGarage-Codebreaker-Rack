# frozen_string_literal: true

class BaseController
  include SharedMethod
  include Constants
  include Validations

  def self.call(env)
    new(env).routes.finish
  end

  def initialize(env)
    @env = env
    @request = Rack::Request.new(env)
  end

  def routes
    case @request.path
    when '/' then home_page
    when '/statistics' then statistics
    when '/rules' then rules
    else
      GAME_COMMAND.include?(@request.path) ? GameController.call(@env) : eror_404_not_found
    end
  end

  def home_page
    return redirect('game') if session_has_game?

    @difficulty = Codebreaker::Constants::Shared::TYPE_OF_DIFFICULTY
    respond('menu.html.erb')
  end

  def statistics
    return redirect('game') if session_has_game?

    @statistics = StatisticsAdapter.new(FILE_NAME).take_statistics
    respond('statistics.html.erb')
  end

  def rules
    return redirect('game') if session_has_game?

    @rules = Codebreaker::Rules.call
    respond('rules.html.erb')
  end
end
