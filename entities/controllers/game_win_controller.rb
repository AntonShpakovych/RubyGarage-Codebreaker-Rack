# frozen_string_literal: true

class GameWinController < BaseController
  include SharedMethod
  include Validations
  include Constants

  def initialize(request)
    super
    @statistics = StatisticsAdapter.new(FILE_NAME)
    @game = @session[:game]
    @total_hints = @session[:total_hints]
    @total_attempts = @session[:total_attempts]
  end

  def update
    return redirect('/') unless session_has_game?(@request)
    return redirect('/game') unless win?(@game)

    @statistics.save(@game)
    @request.session.clear
    respond('win.html.erb', game: @game, total_attempts: @total_attempts, total_hints: @total_hints)
  end
end
