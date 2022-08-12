# frozen_string_literal: true

RSpec.describe '/not_found', type: :request do
  let(:wrong_path) { '/wrong_path' }

  describe 'path not_found' do
    before { get wrong_path }

    it 'render home page' do
      expect(last_response).to be_not_found
    end
  end
end
