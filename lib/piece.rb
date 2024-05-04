# frozen_string_literal: true

CONNECTIONS = [
  [-1, -1],
  [-1, 0],
  [-1, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1]
].freeze

# defines a piece in a board of connect four, a node in a linked list
class Piece
  @height = [0, 0, 0, 0, 0, 0, 0]

  def initialize(choice, connected = [])
    @position = calculate_position(choice)
    @connected = connected
  end

  def calculate_position(choice)
    index = choice - 1
    position = [index, Piece.instance_variable_get(:@height)[index]]
    Piece.instance_variable_get(:@height)[index] += 1
    position
  end

  def update_connected(piece); end

  def connected?; end
end
