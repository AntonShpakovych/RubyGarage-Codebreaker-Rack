# frozen_string_literal: true

class BaseController
  def initialize(request)
    @request = request
    @params = request.params
    @session = request.session
  end
end
