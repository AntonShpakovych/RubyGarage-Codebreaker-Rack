# frozen_string_literal: true

module Validations
  def valid_data_game?
    @request.params['player_name'].nil? || @request.params['level'].nil?
  end

  def session_has_game?
    @request.session.key?(:game)
  end
end
