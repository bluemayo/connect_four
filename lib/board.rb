# frozen_string_literal: true

require_relative 'display'

# Defines the board of connect four
class Board
  include display

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Array.new(7).map { Array.new(6) }
  end

  def play; end
end
