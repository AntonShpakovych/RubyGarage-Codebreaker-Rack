# frozen_string_literal: true

RSpec.describe Validations do
  let(:class_with_module) do
    Class.new do
      include Validations
    end
  end
  let(:instance_class) { class_with_module.new }
  let(:user) { Codebreaker::User.new('User') }
  let(:difficulty) { :easy }
  let(:game) { Codebreaker::Game.new(user: user, type_of_difficulty: difficulty) }

  describe '#win' do
    context 'when game not win' do
      it 'give false' do
        expect(instance_class).not_to be_win(game)
      end
    end

    context 'when game is win' do
      before { game.instance_variable_set(:@win, true) }

      it 'give true' do
        expect(instance_class).to be_win(game)
      end
    end
  end

  describe '#game_has_attempts?' do
    let(:session_game) { { game: game } }
    let(:request_double) { instance_double('Request') }

    before do
      allow(request_double).to receive(:session).and_return(session_game)
    end

    context 'when game has attempts possitive' do
      it 'give true' do
        expect(instance_class).to be_game_has_attempts(request_double)
      end
    end

    context 'when game attempts not possitive' do
      before do
        game.instance_variable_set(:@attempts, 0)
      end

      it 'give false' do
        expect(instance_class).not_to be_game_has_attempts(request_double)
      end
    end
  end

  describe '#session_has_game?' do
    let(:request_double) { instance_double('Request') }

    context 'when game in session' do
      let(:session_game) { { game: game } }

      before do
        allow(request_double).to receive(:session).and_return(session_game)
      end

      it 'give true' do
        expect(instance_class).to be_session_has_game(request_double)
      end
    end

    context 'when game not in session' do
      let(:session_game) { {} }

      before do
        allow(request_double).to receive(:session).and_return(session_game)
      end

      it 'give false' do
        expect(instance_class).not_to be_session_has_game(request_double)
      end
    end
  end

  describe '#valida_params_for_game?' do
    let(:request_double) { instance_double('Request') }

    context 'when request.params is correct' do
      let(:player_name) { 'Player' }
      let(:level) { 'easy' }
      let(:params_hash) { { 'player_name' => player_name, 'level' => level } }

      before do
        allow(request_double).to receive(:params).and_return(params_hash)
      end

      it 'give true' do
        expect(instance_class).to be_valid_params_for_game(request_double)
      end
    end

    context 'when request.params not correct' do
      let(:params_hash) { {} }

      before do
        allow(request_double).to receive(:params).and_return(params_hash)
      end

      it 'give false' do
        expect(instance_class).not_to be_valid_params_for_game(request_double)
      end
    end
  end
end
