# frozen_string_literal: true

RSpec.describe StatisticsAdapter do
  let(:test_file) { 'testing.yml' }
  let(:statistics) { described_class.new(test_file) }
  let(:user) { Codebreaker::User.new('User') }
  let(:difficulty) { :easy }
  let(:game) { Codebreaker::Game.new(user: user, type_of_difficulty: difficulty) }

  describe '#save' do
    context 'when file creating' do
      before { statistics.save(game) }

      it 'create file' do
        expect(File.exist?(test_file)).to be(true)
      end
    end

    context 'when write to file' do
      it 'save your game to file' do
        expect { statistics.save(game) }.to change { YAML.load_file(test_file).size }.by(1)
      end
    end
  end

  describe '#take_statistics' do
    context 'when file exist' do
      after do
        File.delete(test_file)
      end

      it 'give some array with statistics' do
        expect(statistics.take_statistics).to be_kind_of(Array)
      end
    end

    context 'when file not exist' do
      it 'give nil' do
        expect(statistics.take_statistics).to be_nil
      end
    end
  end
end
