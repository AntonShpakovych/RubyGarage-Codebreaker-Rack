# frozen_string_literal: true

RSpec.describe 'spec/request/game', type: :request do
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('config.ru').first
  end

  let(:test_user) { Codebreaker::User.new('User') }
  let(:test_difficulty) { 'easy' }
  let(:session_game) { Codebreaker::Game.new(user: test_user, type_of_difficulty: test_difficulty.to_sym) }
  let(:game) { '/game' }

  describe '#game' do
    context 'when empty parameter' do
      it 'redirect to home' do
        get game
        expect(last_response).to be_redirect
      end
    end

    context 'when session have parameter' do
      let(:test_user_name) { 'User' }
      let(:test_difficulty) { 'easy' }

      it 'sets game in session' do
        post game, player_name: test_user.name, level: test_difficulty
        expect(last_request.session).to include(:game)
      end

      it 'redirect to game' do
        get game
        expect(last_response).to be_redirect
      end
    end

    context 'when session have game' do
      let(:test_secret) { %w[1 1 1 1] }

      context 'when number in session' do
        let(:test_number) { '2222' }

        before do
          session_game.instance_variable_set(:@secret_code, test_secret)
          env('rack.session', game: session_game)
        end

        it 'render game with +- and remember your number' do
          post game, number: test_number
          expect(last_response.body).to include('2222')
        end
      end

      context 'when number not in session' do
        before do
          env('rack.session', game: session_game)
        end

        it 'render game one more time' do
          post game
          expect(last_response).to be_ok
        end
      end
    end
  end
end
