# frozen_string_literal: true

require_relative '../lib/player'

# This file tests the methods in the Player class
describe Player do
  subject(:player) { described_class.new('mayo') }
  describe '#initialize' do
    # Only creates instance variables.
  end

  describe '#make_choice' do
    # Method with only puts and gets, no need to test.
  end

  describe '#update_choice' do
    # located inside #make_choice
    # Outgoing Command Method, check that messages are sent
    # also a Command Method, check that state is changed
    context 'When creating new Piece' do
      it 'Calls Piece#new once' do
        expect(Piece).to receive(:new).once
        player.update_choice(1)
      end
      it 'Calls #connect once' do
        expect(player).to receive(:connect).once
        player.update_choice(1)
      end
    end
    context 'When updating Piece' do
      let(:test_choice) { double('piece') }
      before do
        allow(Piece).to receive(:new).with(1).and_return(test_choice)
        allow(player).to receive(:connect)
      end
      it 'Updates @pieces' do
        expect { player.update_choice(1) }.to change { player.instance_variable_get(:@pieces).first }.to(test_choice)
      end
      it 'Updates @last' do
        expect { player.update_choice(1) }.to change { player.instance_variable_get(:@last) }.to(test_choice)
      end
    end
  end

  describe '#connect' do
    # located inside #update_choice
    # Outgoing Command Method, chech that message is sent
    context 'When looping over @pieces twice' do
      let(:test_piece) { double('piece') }
      subject(:player_pieces) { described_class.new('mayo', [test_piece, test_piece]) }
      before do
        allow(test_piece).to receive(:update_connected)
      end
      it 'Calls Piece#connected? twice' do
        expect(test_piece).to receive(:connected?).twice
        player_pieces.connect(test_piece)
      end
      it 'Calls Piece#update_connected twice' do
        allow(test_piece).to receive(:connected?).and_return(true, true)
        expect(test_piece).to receive(:update_connected).twice
        player_pieces.connect(test_piece)
      end
    end
  end

  describe '#game_won?' do
    # located in Board#game_end?
    # Script method that will activate DFS for checking win condition
    # Does not need testing, but recursive method inside will need testing.
  end

  describe '#pieces_position' do
    # located inside Board#display_turn_order
    # Query Method, test that it returns an array containing positional arrays
    context 'When the board is not fully occupied' do
      let(:player1) { described_class.new('mayo') }
      let(:piece) { instance_double(Piece) }
      it 'Returns Array of arraysq' do
        piece.instance_variable_set('@position', [0, 0])
        player1.instance_variable_set('@pieces', [piece])
        expect(player1.pieces_position).to eql([[0, 0]])
      end
    end
  end

  describe '#number_of_pieces' do
    # located inside Board#update_board
    # Query Method, test for return value
    context 'When @pieces is empty' do
      it 'Returns 0' do
        expect(player.number_of_pieces).to eql(0)
      end
    end
    context 'When @pieces is not empty' do
      subject(:pieces_player) { described_class.new('mayo', [0, 1, 2, 3]) }
      it 'Returns 4' do
        expect(pieces_player.number_of_pieces).to eql(4)
      end
    end
  end

  describe '#verify_choice' do
    # located in #make_choice
    # Test that incorrect inputs get rejected
    # Looping script with only gets and puts, no need for testing
  end

  describe '#valid?' do
    # located in #verify_choice
    # Query Method, test that valid inputs will return true false otherwise
    context 'When input is valid' do
      it 'Returns true' do
        expect(player.valid?('4')).to eql(true)
      end
    end
    context 'When input is invalid' do
      it 'Returns false when input is not a numeral' do
        expect(player.valid?('a')).to eql(false)
      end

      it 'Returns false when numeral input is not between 1-7' do
        expect(player.valid?('9')).to eql(false)
      end

      it 'Returns false when column selected is full' do
        allow(Piece).to receive(:instance_variable_get).and_return([6, 0, 0, 0, 0, 0, 0])
        expect(player.valid?('1')).to eql(false)
      end
    end
  end
end
