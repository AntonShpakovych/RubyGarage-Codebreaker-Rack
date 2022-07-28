# frozen_string_literal: true

class GamesController < BaseController
  include SharedMethod
  include Validations
  include Constants

  def initialize(request)
    super(request)
    @game = @request.session[:game]
    @result_for_guess = @request.session[:guess]
    @guess_player = @request.session[:answer]
    @hints = @request.session[:hints] || []
  end

  def index
    return redirect('/') if @game.nil? && valid_data_game?(@request)

    @game.nil? ? create : show
    if @game.win
      redirect('/win')
    elsif @game.attempts.zero?
      redirect('/lose')
    else
      game_response
    end
  end

  def create
    user = Codebreaker::User.new(@request.params['player_name'])
    difficulty = @request.params['level'].to_sym
    @game = Codebreaker::Game.new(user: user, type_of_difficulty: difficulty)
    @request.session[:game] = @game
    @request.session[:total_hints] = @game.hints
    @request.session[:total_attempts] = @game.attempts
  end

  def show
    return game_response if @request.params['number'].nil?

    @guess_player = @request.params['number']
    @request.session[:answer] = @guess_player
    @result_for_guess = @game.my_guess(@guess_player)
    @request.session[:guess] = @result_for_guess
  end

  private

  def game_response
    respond('game.html.erb', game: @game,
                             hints: @hints,
                             result_for_guess: @result_for_guess,
                             guess_player: @guess_player)
  end
end
