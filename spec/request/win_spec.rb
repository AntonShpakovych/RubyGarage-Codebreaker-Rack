#frozen_string_literal: true

RSpec.describe 'spec/request/win', type: :request do
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('config.ru').first
  end
  let(:game) { '/game' }
  let(:win) { '/win' }

  let(:type) { :easy }
  let(:user) { Codebreaker::User.new('User') }
  let(:game_session) { Codebreaker::Game.new(user: user, type_of_difficulty: type) }
  let(:win_number) { '1111' }
  let(:win_secret) { %w[1 1 1 1] }

  describe '#win' do
    before do
      game_session.instance_variable_set(:@win, true)
      env('rack.session', game: game_session)
    end

    it 'render win' do
      get win
      expect(last_response).to be_ok
    end
  end
end
