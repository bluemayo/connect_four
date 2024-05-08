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

    context 'When updating Player variables' do
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
    context 'When game_end? is false once' do
      before do
        allow(game).to receive(:game_end?).and_return(false, true)
      end
      it 'Calls #display_turn_order once' do
        expect(game).to receive(:display_turn_order).once
        game.game_loop
      end
    end

    context 'When game_end? is false 4 times' do
      before do
        allow(game).to receive(:game_end?).and_return(false, false, false, false, true)
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
        allow(test_player).to receive(:make_choice)
        allow(test_player).to receive(:game_won?).and_return(false)
        allow(game_order).to receive(:update_board)
      end
      it 'Calls #make_choice twice' do
        expect(test_player).to receive(:make_choice).twice
        game_order.display_turn_order
      end
    end

    context 'When only player1 made choice' do
      before do
        allow(test_player).to receive(:make_choice).and_return(0)
        allow(test_player).to receive(:game_won?).and_return(true)
        allow(game_order).to receive(:update_board)
      end
      it 'Calls #make_choice once' do
        expect(test_player).to receive(:make_choice).once
        game_order.display_turn_order
      end
    end
  end

  describe '#game_end?' do
    # located in #game_loop
    # Outgoing Command Method, test that messages are sent
    # Test that it returns true if one of the players won
    let(:player_end) { instance_double(Player) }
    subject(:game_ending) { described_class.new(player_end, player_end) }
    context 'When there is a winner' do
      it 'Calls Player#game_won? twice when player2 wins' do
        expect(player_end).to receive(:game_won?).twice
        game_ending.game_end?
      end
      it 'Calls Player#game_won? once when player1 wins' do
        allow(player_end).to receive(:game_won?).and_return(true)
        expect(player_end).to receive(:game_won?).once
        game_ending.game_end?
      end
      it 'Returns true when player2 wins' do
        allow(player_end).to receive(:game_won?).and_return(false, true)
        expect(game_ending.game_end?).to eql(true)
      end
      it 'Returns true when player1 wins' do
        allow(player_end).to receive(:game_won?).and_return(true)
        expect(game_ending.game_end?).to eql(true)
      end
    end

    context 'When there are no winners' do
      it 'Calls Player#game_won? twice' do
        expect(player_end).to receive(:game_won?).twice
        game_ending.game_end?
      end
      it 'Returns false' do
        allow(player_end).to receive(:game_won?).and_return(false, false)
        expect(game_ending.game_end?).to eql(false)
      end
    end
  end

  describe '#display_board' do
    # located inside #update_board
    # Method with only puts, no need for testing
  end

  describe '#update_board' do
    # located inside #display_turn_order
    # Command Method, test for change in state
    let(:board_player) { double('player') }
    let(:last_piece) { double('piece') }
    subject(:updated_board) { described_class.new(board_player, board_player) }
    context "When updating Player1's choice" do
      it "Updates @board[0][0] to 'X'" do
        allow(board_player).to receive(:instance_variable_get).with(:@last).and_return(last_piece)
        allow(board_player).to receive(:number_of_pieces).and_return(1, 0)
        allow(last_piece).to receive(:instance_variable_get).and_return([0, 0], nil)
        expect { updated_board.update_board }.to change { updated_board.instance_variable_get(:@board)[0][0] }.to('X')
      end
    end
    context "When updating Player2's choice" do
      it "Updates @board[0][1] to 'O'" do
        allow(board_player).to receive(:instance_variable_get).with(:@last).and_return(last_piece)
        allow(board_player).to receive(:number_of_pieces).and_return(1, 1)
        allow(last_piece).to receive(:instance_variable_get).and_return([0, 1])
        expect { updated_board.update_board }.to change { updated_board.instance_variable_get(:@board)[0][1] }.to('O')
      end
    end
  end
end
