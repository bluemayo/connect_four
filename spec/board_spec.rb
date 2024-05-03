# frozen_string_literal: true

require_relative '../lib/board'

# This file tests the methods in the Board class
describe Board do
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

    context 'When looping twice' do
      it 'Calls #input_name twice' do
        expect(game).to receive(:input_name).twice
        game.update_players
      end

      it 'Calls #create_player twice' do
        expect(game).to receive(:create_player).twice
        game.update_players
      end
    end

    context 'When Player variables' do
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
    # Method with outgoing command, test that a message has been sent.
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

  describe '#game_loop' do
    # located inside #play
    # Looping Script Method, behavior should be tested.
    # test for loop end condition: game_won?
    context 'When game_won? is false once' do
      before do
        allow(game).to receive(:game_won?).and_return(false, true)
      end
      it 'Calls #display_turn_order once' do
        expect(game).to receive(:display_turn_order).once
        game.game_loop
      end
    end

    context 'When game_won? is false 4 times' do
      before do
        allow(game).to receive(:game_won?).and_return(false, false, false, false, true)
      end
      it 'Calls #display_turn_order 4 times' do
        expect(game).to receive(:display_turn_order).exactly(4).times
        game.game_loop
      end
    end
  end

  describe '#display_turn_order' do
    # located inside #game_loop
    # Both a Outgoing Command and Script Method, test that messages have been sent

    # Create new subject and instance double and method stubs for them
    let(:test_player) { instance_double(Player) }
    subject(:game_order) { described_class.new(test_player, test_player) }
    context 'When both players have turns' do
      before do
        allow(test_player).to receive(:make_choice).and_return([0, 0])
        allow(game_order).to receive(:update_choice)
        allow(game_order).to receive(:game_won?).and_return(false)
      end
      it 'Calls #make_choice twice' do
        expect(test_player).to receive(:make_choice).twice
        game_order.display_turn_order
      end
      it 'Calls #update_choice twice' do
        expect(game_order).to receive(:update_choice).with([0, 0]).twice
        game_order.display_turn_order
      end
    end

    context 'When only player1 made choice' do
      before do
        allow(test_player).to receive(:make_choice).and_return([0, 0])
        allow(game_order).to receive(:update_choice)
        allow(game_order).to receive(:game_won?).and_return(true)
      end
      it 'Calls #make_choice once' do
        expect(test_player).to receive(:make_choice).once
        game_order.display_turn_order
      end
      it 'Calls #update_choice once' do
        expect(game_order).to receive(:update_choice).with([0, 0]).once
        game_order.display_turn_order
      end
    end
  end
end
