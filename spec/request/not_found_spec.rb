# frozen_string_literal: true

RSpec.describe 'spec/request/not_found', type: :request do
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('config.ru').first
  end

  let(:wrong_path) { '/wrong_path' }

  describe '#error_404_not_found' do
    it 'render home page' do
      get wrong_path
      expect(last_response).to be_not_found
    end
  end
end
