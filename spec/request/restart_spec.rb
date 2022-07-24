# frozen_string_literal: true

RSpec.describe 'spec/request/restart', type: :request do
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('config.ru').first
  end

  let(:restart) { '/restart' }
  let(:type) { :easy }
  let(:user) { Codebreaker::User.new('User') }
  let(:game) { Codebreaker::Game.new(user: user, type_of_difficulty: type) }

  describe '#restart' do
    before do
      env('rack.session', game: game)
    end

    it 'clear session' do
      get restart
      expect(last_request.session).not_to include(:game)
    end

    it 'after redirect to home' do
      get restart
      expect(last_response).to be_redirect
    end
  end
end
