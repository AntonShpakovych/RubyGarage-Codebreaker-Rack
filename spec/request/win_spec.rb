# frozen_string_literal: true

RSpec.describe 'GameWinController', type: :request do
  let(:game) { '/game' }
  let(:win) { '/win' }
  let(:type) { :easy }
  let(:user) { Codebreaker::User.new('User') }
  let(:game_session) { Codebreaker::Game.new(user: user, type_of_difficulty: type) }
  let(:win_number) { '1111' }
  let(:win_secret) { %w[1 1 1 1] }
  let(:total_attempts) { game_session.attempts }
  let(:total_hints) { game_session.hints }

  describe 'GET, #update' do
    context 'when game in session' do
      context 'when user post win number' do
        before do
          game_session.instance_variable_set(:@secret_code, win_secret)
          env('rack.session', game: game_session)
          post game, number: win_number
        end

        it 'redirect to win' do
          expect(last_response).to be_redirect
        end
      end

      context 'when game is win' do
        after do
          File.delete(Constants::FILE_NAME)
        end

        before do
          game_session.instance_variable_set(:@win, true)
          env('rack.session', game: game_session, total_attempts: total_attempts, total_hints: total_hints)
          get win
        end

        it 'render win' do
          expect(last_response).to be_ok
        end
      end

      context 'when game is not win' do
        before do
          env('rack.session', game: game_session, total_attempts: total_attempts, total_hints: total_hints)
          get win
        end

        it 'redirect to game' do
          expect(last_response).to be_redirect
        end
      end
    end

    context 'when game not in session' do
      before { get win }

      it 'redirect to home' do
        expect(last_response).to be_redirect
      end
    end
  end
end
