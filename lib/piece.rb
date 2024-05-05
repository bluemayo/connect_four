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

# defines a piece in a board of connect four, a node in a doubly linked list
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

  def update_connected(piece)
    @connected << piece
    piece.instance_variable_get(:@connected) << self
  end

  def connected?(piece)
    CONNECTIONS.each do |connection|
      test = []
      @position.each_with_index do |position, index|
        test << (position + connection[index])
      end
      return true if test == piece.instance_variable_get(:@position)
    end
    false
  end

  def connect_four?(connected_piece = self, count = 1, direction = nil)
    return true if count == 4

    connected_piece.instance_variable_get(:@connected).each do |piece|
      new_direction = connected_piece.calculate_direction(piece)
      if new_direction == direction
        count += 1
        return connect_four?(piece, count, direction)
      end
      return connect_four?(piece, count + 1, new_direction) if direction.nil?
    end
    false
  end

  def calculate_direction(connected_piece)
    direction = []
    @position.each_with_index do |position, index|
      direction << (connected_piece.instance_variable_get(:@position)[index] - position)
    end
    direction
  end
end
