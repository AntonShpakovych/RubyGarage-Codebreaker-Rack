# frozen_string_literal: true

class WinController < BaseController
  include SharedMethod
  include Validations
  include Constants

  def initialize(request)
    super(request)
    @game = request.session[:game]
    @statistics = StatisticsAdapter.new(FILE_NAME)
    @total_hints = @request.session[:total_hints]
    @total_attempts = @request.session[:total_attempts]
  end

  def index
    return redirect('/') unless session_has_game?(@request)
    return redirect('/game') unless win?(@game)

    @statistics.save(@game)
    @request.session.clear
    respond('win.html.erb', game: @game, total_attempts: @total_attempts, total_hints: @total_hints)
  end
end
