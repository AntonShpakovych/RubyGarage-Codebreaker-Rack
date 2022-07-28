# frozen_string_literal: true

class StatisticsController < BaseController
  include Constants
  include SharedMethod
  include Validations

  def index
    return redirect('/game') if session_has_game?(@request)

    @statistics = StatisticsAdapter.new(FILE_NAME).take_statistics
    respond('statistics.html.erb', statistics: @statistics)
  end
end
