# frozen_string_literal: true

class HintsController < BaseController
  include SharedMethod
  include Validations

  def index
    @hints << @game.give_hints
    @request.session[:hints] = @hints
    redirect('/game')
  end
end
