# frozen_string_literal: true

class StatisticsAdapter
  include Constants

  def initialize(filename = FILE_NAME)
    @statistics = Codebreaker::Statistics.new(filename)
  end

  def save(game)
    @statistics.add_to_data_store(game)
    @statistics.save_unit
  end

  def take_statistics
    @statistics.show if File.exist?(@statistics.filename)
  end
end
