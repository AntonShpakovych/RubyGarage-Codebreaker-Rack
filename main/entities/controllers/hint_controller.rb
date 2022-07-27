# frozen_string_literal: true

class HintController < BaseController
  include SharedMethod
  include Validations

  def initialize(request)
    super(request)
    @game = request.session[:game]
    @hints = @request.session[:hints] || []
  end

  def index
    @hints << @game.give_hints
    @request.session[:hints] = @hints
    redirect('/game')
  end
end
