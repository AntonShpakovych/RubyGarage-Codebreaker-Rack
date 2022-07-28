# frozen_string_literal: true

class LoseController < BaseController
  include SharedMethod
  include Validations

  def initialize(request)
    super(request)
    @game = request.session[:game]
    @total_hints = @request.session[:total_hints]
    @total_attempts = @request.session[:total_attempts]
  end

  def index
    return redirect('/') unless session_has_game?(@request)
    return redirect('/game') if game_has_attempts?(@request)

    @request.session.clear
    respond('lose.html.erb', game: @game, total_hints: @total_hints, total_attempts: @total_attempts)
  end
end
