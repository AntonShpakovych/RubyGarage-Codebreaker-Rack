# frozen_string_literal: true

class GameLoseController < BaseController
  include SharedMethod
  include Validations

  def initialize(request)
    super(request)
    @game = @session[:game]
    @total_hints = @session[:total_hints]
    @total_attempts = @session[:total_attempts]
  end

  def update
    return redirect('/') unless session_has_game?(@request)
    return redirect('/game') if game_has_attempts?(@request)

    @request.session.clear
    respond('lose.html.erb', game: @game, total_hints: @total_hints, total_attempts: @total_attempts)
  end
end
