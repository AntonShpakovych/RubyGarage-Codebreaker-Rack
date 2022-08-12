# frozen_string_literal: true

module Validations
  def valid_params_for_game?(request)
    request.params.key?('player_name') && request.params.key?('level')
  end

  def session_has_game?(request)
    request.session.key?(:game)
  end

  def win?(game)
    game.win
  end

  def game_has_attempts?(request)
    request.session[:game].attempts.positive?
  end
end
