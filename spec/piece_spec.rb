# frozen_string_literal: true

# This file tests the methods in the Piece class
describe Piece do
  subject(:piece) { described_class.new(0) }
  describe '#initialize' do
    # initializes variables, methods inside require testing
  end

  describe '#calculate_position' do
    # Both a Query and Command Method, test for return value and change in state
    context 'When accessing @height' do
      it 'Returns an array containing positional info' do
        expect(piece.calculate_position(1)).to eql([0, 0])
      end
      it 'Increments the correct index of height array' do
        expect { piece.calculate_position(3) }.to change { Piece.instance_variable_get(:@height)[2] }.by(1)
      end
    end
  end
end
