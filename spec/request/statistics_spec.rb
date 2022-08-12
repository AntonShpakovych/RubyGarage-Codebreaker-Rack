# frozen_string_literal: true

RSpec.describe 'StatisticsController', type: :request do
  describe 'GET, #index' do
    let(:statistics) { '/statistics' }

    context 'when game not in session' do
      before { get statistics }

      it 'render statistics' do
        expect(last_response).to be_ok
      end

      context 'when statistics empty' do
        let(:file) { Constants::FILE_NAME }

        it 'give u message about statistics is empty' do
          expect(last_response.body).to include(I18n.t('statistics.statistics_empty'))
        end
      end
    end

    context 'when game in session' do
      before do
        env('rack.session', game: 'game')
        get statistics
      end

      it 'redirect to game' do
        expect(last_response).to be_redirect
      end
    end
  end
end
