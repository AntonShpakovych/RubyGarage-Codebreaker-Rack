# frozen_string_literal: true

RSpec.describe 'RulesController', type: :request do
  let(:rules) { '/rules' }

  describe 'GET, #index' do
    context 'when game not in session' do
      before { get rules }

      it 'render rules' do
        expect(last_response).to be_ok
      end
    end

    context 'when game in session' do
      before do
        env('rack.session', game: 'game')
        get rules
      end

      it 'redirect to game' do
        expect(last_response).to be_redirect
      end
    end
  end
end
