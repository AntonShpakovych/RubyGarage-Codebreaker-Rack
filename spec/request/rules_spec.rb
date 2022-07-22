# frozen_string_literal: true

RSpec.describe 'spec/request/rules', type: :request do
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('config.ru').first
  end

  let(:rules) { '/rules' }

  describe '#rules' do
    context 'when game not in session' do
      it 'render rules' do
        get rules
        expect(last_response).to be_ok
      end
    end

    context 'when game in session' do
      before do
        env('rack.session', game: 'game')
      end

      it 'redirect to game' do
        get rules
        expect(last_response).to be_redirect
      end
    end
  end
end
