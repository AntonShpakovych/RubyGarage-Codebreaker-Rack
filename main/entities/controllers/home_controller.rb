# frozen_string_literal: true

class HomeController < BaseController
  include SharedMethod
  include Validations

  def index
    return redirect('/game') if session_has_game?

    @difficulty = Codebreaker::Constants::Shared::TYPE_OF_DIFFICULTY
    respond('menu.html.erb')
  end
end
