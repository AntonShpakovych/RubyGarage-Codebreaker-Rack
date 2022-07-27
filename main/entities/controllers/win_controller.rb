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
    return redirect('/') unless session_has_game?
    return redirect('/game') unless win?

    @statistics.save(@game)
    @request.session.clear
    respond('win.html.erb')
  end
end
