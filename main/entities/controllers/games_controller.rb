# frozen_string_literal: true

class GamesController < BaseController
  include SharedMethod
  include Validations
  include Constants

  def initialize(request)
    super(request)
    @error = nil
  end

  def create
    return redirect('/') unless valid_params_for_game?(@request)

    user =  Codebreaker::User.validate_for_name(@player_name)
    @game = Codebreaker::Game.new(user: Codebreaker::User.new(user), type_of_difficulty: @player_difficulty.to_sym)
    @request.session[:game] = @game
    @request.session[:total_hints] = @game.hints
    @request.session[:total_attempts] = @game.attempts
    game_response
  rescue StandardError => e
    respond('menu.html.erb', difficulty: DIFFICULTY, error: e)
  end

  def show
    return game_response unless @request.params.key?('number')

    @request.session[:answer] = @guess_player
    @result_for_guess = @game.my_guess(@guess_player)
    @request.session[:guess] = @result_for_guess
    game_response
  rescue StandardError => e
    @error = [] << e
    game_response
  end

  private

  def game_response
    if @game.win
      redirect('/win')
    elsif @game.attempts.zero?
      redirect('/lose')
    else
      respond('game.html.erb', game: @game,
                               hints: @hints,
                               result_for_guess: @result_for_guess,
                               guess_player: @guess_player, error: @error)
    end
  end
end
