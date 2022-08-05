# frozen_string_literal: true

RSpec.describe 'RestartController', type: :request do
  let(:restart) { '/restart' }
  let(:type) { :easy }
  let(:user) { Codebreaker::User.new('User') }
  let(:game) { Codebreaker::Game.new(user: user, type_of_difficulty: type) }

  describe 'GET, #index' do
    before do
      env('rack.session', game: game)
      get restart
    end

    it 'clear session' do
      expect(last_request.session).not_to include(:game)
    end

    it 'after redirect to home' do
      expect(last_response).to be_redirect
    end
  end
end
