# frozen_string_literal: true

RSpec.describe 'GamesController', type: :request do
  let(:user) { Codebreaker::User.new('User') }
  let(:session_game) { Codebreaker::Game.new(user: user, type_of_difficulty: :easy) }
  let(:game) { '/game' }
  let(:test_number) { 1111 }
  let(:test_secret) { 2222 }

  describe 'POST #create' do
    context 'when request.params not present' do
      before { post game }

      it 'redirect to home' do
        expect(last_response).to be_redirect
      end
    end

    context 'when request.params present' do
      context 'when correct params' do
        let(:test_user_name) { 'User' }
        let(:test_difficulty) { 'easy' }

        before { post game, player_name: test_user_name, level: test_difficulty }

        it 'sets game in session' do
          expect(last_request.session).to include(:game)
        end
      end

      context 'when incorrect params' do
        let(:test_user_name) { 'U' }
        let(:test_difficulty) { 'easy' }

        before { post game, player_name: test_user_name, level: test_difficulty }

        it 'render game with error' do
          expect(last_response).to be_ok
        end
      end
    end
  end

  describe 'POST, #show' do
    context 'when game not in session' do
      before { post game, number: test_number }

      it 'redirect to home' do
        expect(last_response).to be_redirect
      end
    end

    context 'when game in session but request.params number not present' do
      let(:bad_number) { 1 }
      let(:error_message) do
        I18n.t('game.welcome_game',
               name: user.name,
               good_length: Codebreaker::Constants::Shared::LENGTH_GOOD,
               min_digit: Codebreaker::Constants::Shared::CORRECT_RANGE.first,
               max_digit: Codebreaker::Constants::Shared::CORRECT_RANGE.last)
      end

      before do
        session_game.instance_variable_set(:@secret_code, test_secret)
        env('rack.session', game: session_game)
        post game, number: bad_number
      end

      it 'render game page' do
        expect(last_response).to be_ok
      end

      it 'with error' do
        expect(last_response.body).to include(error_message)
      end
    end

    context 'when game in session and number in request.params' do
      before do
        session_game.instance_variable_set(:@secret_code, test_secret)
        env('rack.session', game: session_game)
        post game, number: test_number
      end

      it 'render game' do
        expect(last_response).to be_ok
      end
    end
  end
end
