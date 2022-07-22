#frozen_string_literal: true

RSpec.describe 'spec/request/win', type: :request do
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('config.ru').first
  end
  let(:game) { '/game' }
  let(:lose) { '/lose' }

  let(:type) { :easy }
  let(:user) { Codebreaker::User.new('User') }
  let(:game_session) { Codebreaker::Game.new(user: user, type_of_difficulty: type) }
  let(:lose_number) { '1111' }
  let(:test_secret) { %w[1 2 3 6] }
  let(:total_attempts) { game_session.attempts }
  let(:total_hints) { game_session.hints }

  describe '#win' do
    context 'when game in session' do
      context 'when user post not win number but attempts is positive' do
        before do
          env('rack.session', game: game_session, total_attempts: total_attempts, total_hints: total_hints)
        end

        it 'redirect to game' do
          get lose
          expect(last_response).to be_redirect
        end
      end

      context 'when user post not win number and attempts not positive' do
        before do
          game_session.instance_variable_set(:@secret_code, test_secret)
          game_session.instance_variable_set(:@attempts, 1)
          env('rack.session', game: game_session)
        end

        it 'redirect to lose' do
          post game, number: lose_number
          expect(last_response).to be_redirect
        end
      end

      context 'when game lose' do
        before do
          game_session.instance_variable_set(:@attempts, 0)
          env('rack.session', game: game_session, total_attempts: total_attempts, total_hints: total_hints)
        end

        it 'render lose' do
          get lose
          expect(last_response).to be_ok
        end
      end
    end

    context 'when game not in session' do
      it 'redirect to home' do
        get lose
        expect(last_response).to be_redirect
      end
    end
  end
end
