# frozen_string_literal: true

class RulesController < BaseController
  include SharedMethod
  include Validations

  def index
    return redirect('/game') if session_has_game?(@request)

    @rules = Codebreaker::Rules.call
    respond('rules.html.erb', rules: @rules)
  end
end
