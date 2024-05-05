# frozen_string_literal: true

require_relative '../lib/piece'

# This file tests the methods in the Piece class
describe Piece do
  subject(:piece) { described_class.new(1) }
  describe '#initialize' do
    # initializes variables, methods inside require testing
  end

  describe '#calculate_position' do
    # located in #initialize
    # Both a Query and Command Method, test for return value and change in state
    context 'When accessing @height' do
      it 'Returns an array containing positional info' do
        expect(piece.calculate_position(1)).to eql([0, 1])
      end
      it 'Increments the correct index of height array' do
        expect { piece.calculate_position(3) }.to change { Piece.instance_variable_get(:@height)[2] }.by(1)
      end
    end
  end

  describe '#update_connected' do
    # located in Player#connect
    # Command Method, test for change in state
    let(:connected_piece) { described_class.new(1) }
    context 'When updating piece' do
      it "Updates piece's @connected once" do
        expect { piece.update_connected(connected_piece) }.to change { piece.instance_variable_get(:@connected).length }.by(1)
      end
      it "Updates piece's @connected correctly" do
        expect { piece.update_connected(connected_piece) }.to change { piece.instance_variable_get(:@connected)[0] }.to(connected_piece)
      end
    end

    context 'When updating connected_piece' do
      it "Updates connected_piece's @connected once" do
        expect { piece.update_connected(connected_piece) }.to change { connected_piece.instance_variable_get(:@connected).length }.by(1)
      end
      it "Updates connected_piece's @connected correctly" do
        expect { piece.update_connected(connected_piece) }.to change { connected_piece.instance_variable_get(:@connected)[0] }.to(piece)
      end
    end
  end

  describe '#connected?' do
    # located in Player#connect
    # Query Method, check for return value: true/false
    context 'When connected piece is given' do
      let(:connected_vertically) { described_class.new(1) }
      let(:connected_horizontally) { described_class.new(2) }
      let(:connected_diagonally) { described_class.new(2) }
      before do
        Piece.instance_variable_set('@height', [0, 0, 0, 0, 0, 0, 0])
      end
      it 'Returns true when piece is connected vertically' do
        expect(piece.connected?(connected_vertically)).to eql(true)
      end
      it 'Returns true when piece is connected horizontally' do
        expect(piece.connected?(connected_horizontally)).to eql(true)
      end
      it 'Returns true when piece is connected diagonally' do
        described_class.new(2)
        expect(piece.connected?(connected_diagonally)).to eql(true)
      end
    end

    context 'When piece given is not connected' do
      let(:disconnected) { described_class.new(7) }
      it 'Returns false' do
        expect(piece.connected?(disconnected)).to eql(false)
      end
    end
  end
end
