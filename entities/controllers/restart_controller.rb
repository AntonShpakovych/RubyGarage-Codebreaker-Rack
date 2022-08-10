# frozen_string_literal: true

class RestartController < BaseController
  include SharedMethod

  def index
    @request.session.clear
    redirect('/')
  end
end
