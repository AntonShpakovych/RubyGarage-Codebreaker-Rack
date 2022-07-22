# frozen_string_literal: true

RSpec.describe 'spec/request/statistics', type: :request do
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('config.ru').first
  end

  describe '#statistics' do
    let(:statistics) { '/statistics' }

    context 'when game not in session' do
      it 'render statistics' do
        get statistics
        expect(last_response).to be_ok
      end

      context 'when statistics empty' do
        let(:file) { Constants::FILE_NAME }

        before do
          File.delete(file)
        end

        it 'give u message about statistics is empty' do
          get statistics
          expect(last_response.body).to include('There are no winners yet! Be the first!')
        end
      end
    end

    context 'when game in session' do
      before do
        env('rack.session', game: 'game')
      end

      it 'redirect to game' do
        get statistics
        expect(last_response).to be_redirect
      end
    end
  end
end
