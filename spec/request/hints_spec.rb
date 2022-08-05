# frozen_string_literal: true

RSpec.describe 'HintsController', type: :request do
  let(:hints) { '/hints' }
  let(:type) { :easy }
  let(:user) { Codebreaker::User.new('User') }
  let(:game) { Codebreaker::Game.new(user: user, type_of_difficulty: type) }

  before do
    env('rack.session', game: game, hints: [])
  end

  describe 'GET, #index' do
    before { get hints }

    it 'pushes hint ho hints' do
      expect(last_request.session[:hints].size).to be 1
    end

    it 'after pushes redirect to game' do
      expect(last_response).to be_redirect
    end
  end
end
