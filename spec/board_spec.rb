# frozen_string_literal: true

require_relative '../lib/board'

# This file tests the methods in the Board class
describe Board do # rubocop: disable Metrics/BlockLength
  # generic Board object
  subject(:game) { described_class.new }

  describe '#initialize' do
    # Only creates instance variables.
  end

  describe '#play' do
    # Public Script Method, methods inside should be tested.
  end

  describe '#update_players' do
    # located inside #play
    # Looping Script Method, behavior should be tested.
    # Command Method, change in state should be tested.
    before do
      allow(game).to receive(:input_name)
    end

    context 'Loops twice' do
      it 'Calls #input_name twice' do
        expect(game).to receive(:input_name).twice
        game.update_players
      end

      it 'Calls #create_player twice' do
        expect(game).to receive(:create_player).twice
        game.update_players
      end
    end

    context 'Player variables updated' do
      # create method stub for #create_player to return fake values
      before do
        allow(game).to receive(:create_player).and_return('mayo', 'tddman')
      end

      it 'Updates @player1' do
        expect { game.update_players }.to change { game.instance_variable_get(:@player1) }.to('mayo')
      end

      it 'Updates @player2' do
        expect { game.update_players }.to change { game.instance_variable_get(:@player2) }.to('tddman')
      end
    end
  end

  describe '#create_player' do
    # located inside #update_players
    # Method with outgoing command -> test that a message has been sent.
    context 'When creating players:' do
      let(:test_player) { 'mayo' }

      it 'Calls #new on Player class' do
        expect(Player).to receive(:new).once
        game.create_player(test_player)
      end
    end
  end

  describe '#input_name' do
    # located inside #update_players
    # Only contain puts and gets
  end
end
