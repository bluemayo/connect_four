# frozen_string_literal: true

# defines a piece in a board of connect four, a node in a linked list
class Piece
  @height = [0, 0, 0, 0, 0, 0, 0]

  def initialize(position, connected = [])
    @position = position
  end

  def update_connected; end

  def connected?; end
end
