# frozen_string_literal: true

class BaseController
  def initialize(request)
    @request = request
    @game = @request.session[:game]
    @result_for_guess = @request.session[:guess]
    @guess_player = @request.session[:answer]
    @hints = @request.session[:hints] || []
    @total_hints = @request.session[:total_hints]
    @total_attempts = @request.session[:total_attempts]
    @player_name = @request.params['player_name']
    @player_difficulty = @request.params['level']
    @guess_player = @request.params['number']
  end
end
