# frozen_string_literal: true

module Constants
  FILE_NAME = 'statistics.yml'
  ROUTES = {
    '/' => ->(request) { HomeController.new(request).index },
    '/statistics' => ->(request) { StatisticsController.new(request).index },
    '/rules' => ->(request) { RulesController.new(request).index },
    '/hints' => ->(request) { HintsController.new(request).index },
    '/game' => lambda { |request|
                 if request.session.key?(:game)
                   GamesController.new(request).show
                 else
                   GamesController.new(request).create
                 end
               },
    '/lose' => ->(request) { GameLoseController.new(request).update },
    '/win' => ->(request) { GameWinController.new(request).update },
    '/restart' => ->(request) { RestartController.new(request).index }
  }.freeze

  DIFFICULTY = Codebreaker::Constants::Shared::TYPE_OF_DIFFICULTY
end
