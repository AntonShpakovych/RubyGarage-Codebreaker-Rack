# frozen_string_literal: true

class LoseController < BaseController
  include SharedMethod
  include Validations

  def initialize(request)
    super(request)
    @game = request.session[:game]
  end

  def index
    return redirect('/') unless session_has_game?
    return redirect('/game') if game_has_attempts?

    @request.session.clear
    respond('lose.html.erb')
  end
end
