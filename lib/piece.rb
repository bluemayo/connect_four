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

  def connect_four?(hash = Hash.new(1), connected_piece = self, direction = nil)
    hash.each_value do |count|
      return true if count == 4
    end

    connected_piece.instance_variable_get(:@connected).each do |piece|
      new_direction = direction_hash(connected_piece.calculate_direction(piece))
      hash[new_direction] += 1
      return connect_four?(hash, piece, direction) if new_direction == direction

      return connect_four?(hash, piece, new_direction) if direction.nil?
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

  def direction_hash(direction) # rubocop: disable Metrics/CyclomaticComplexity
    case direction
    when [0, 1] || [0, -1]
      :updown
    when [1, 0] || [-1, 0]
      :leftright
    when [1, 1] || [-1, -1]
      :upright
    when [-1, 1] || [1, -1]
      :upleft
    end
  end
end
