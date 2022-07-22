#frozen_string_literal: true

RSpec.describe 'spec/request/hint', type: :request do
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('config.ru').first
  end

  let(:hint) { '/hint' }
  let(:type) { :easy }
  let(:user) { Codebreaker::User.new('User') }
  let(:game) { Codebreaker::Game.new(user: user, type_of_difficulty: type) }

  describe '#hint' do
    before do
      env('rack.session', game: game, hints: [])
    end

    it 'pushes hint ho hints' do
      get hint
      expect(last_request.session[:hints].size).to be 1
    end

    it 'after pushes redirect to game' do
      get hint
      expect(last_response).to be_redirect
    end
  end
end
