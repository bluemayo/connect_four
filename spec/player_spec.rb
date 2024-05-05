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
end
