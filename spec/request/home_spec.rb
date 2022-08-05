# frozen_string_literal: true

RSpec.describe 'HomeController', type: :request do
  let(:home) { '/' }

  describe 'GET, #index' do
    context 'when game not in session' do
      before { get home }

      it 'render home' do
        expect(last_response).to be_ok
      end
    end

    context 'when game in session' do
      before do
        env('rack.session', game: 'game')
        get home
      end

      it 'redirect to game' do
        expect(last_response).to be_redirect
      end
    end
  end
end
