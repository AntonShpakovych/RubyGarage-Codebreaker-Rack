# frozen_string_literal: true

class HomeController < BaseController
  include SharedMethod
  include Validations
  include Constants

  def index
    return redirect('/game') if session_has_game?(@request)

    respond('menu.html.erb', difficulty: DIFFICULTY, error: '')
  end
end
