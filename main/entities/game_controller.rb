# frozen_string_literal: true

class GameController
  include Constants
  include SharedMethod
  include Validations

  def self.call(env)
    new(env).routes
  end

  def initialize(env)
    @request = Rack::Request.new(env)
    @game = @request.session[:game]
    @result_for_guess = @request.session[:guess]
    @guess_player = @request.session[:answer]
    @hints = @request.session[:hints] || []
    @total_hints = @request.session[:total_hints]
    @total_attempts = @request.session[:total_attempts]
    @statistics = StatisticsAdapter.new(FILE_NAME)
  end

  def routes
    case @request.path
    when '/game' then game
    when '/hint' then hint
    when '/lose' then lose
    when '/win' then win
    when '/restart' then restart
    else redirect('/')
    end
  end

  def game
    return redirect('/') if @game.nil? && valid_data_game?

    @game.nil? ? create_game : play_game
    if @game.win
      redirect('/win')
    elsif @game.attempts.zero?
      redirect('/lose')
    else
      game_response
    end
  end

  def hint
    @hints << @game.give_hints
    @request.session[:hints] = @hints
    redirect('/game')
  end

  def create_game
    user = Codebreaker::User.new(@request.params['player_name'])
    difficulty = @request.params['level'].to_sym
    @game = Codebreaker::Game.new(user: user, type_of_difficulty: difficulty)
    @request.session[:game] = @game
    @request.session[:total_hints] = @game.hints
    @request.session[:total_attempts] = @game.attempts
  end

  def play_game
    return game_response if @request.params['number'].nil?

    @guess_player = @request.params['number']
    @request.session[:answer] = @guess_player
    @result_for_guess = @game.my_guess(@guess_player)
    @request.session[:guess] = @result_for_guess
  end

  def restart
    @request.session.clear
    redirect('/')
  end

  private

  def game_response
    respond('game.html.erb')
  end

  def lose
    return redirect('/') if @game.nil?
    return redirect('/game') if @game.attempts.positive?

    @request.session.clear
    respond('lose.html.erb')
  end

  def win
    return redirect('/') if @game.nil?
    return redirect('/game') unless @game.win

    @statistics.save(@game)
    @request.session.clear
    respond('win.html.erb')
  end
end
