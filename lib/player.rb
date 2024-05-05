# frozen_string_literal: true

require_relative 'piece'

# Defines a player in the connect four game
class Player
  def initialize(name, pieces = [])
    @name = name
    @pieces = pieces
    @last = nil
  end

  def make_choice
    print "#{@name}, please pick your row from 1-7: "
    choice = gets.chomp.to_i
    update_choice(choice)
  end

  def update_choice(choice)
    piece = Piece.new(choice)
    connect(piece)
    @pieces << piece
    @last = piece
  end

  def connect(piece)
    @pieces.each do |each|
      piece.update_connected(each) if piece.connected?(each)
    end
  end

  def game_won?
    # Implement Depth-First Search in a doubly linked list of pieces with @last as root
    # A recursive method that returns true, using a method call stack
    # Base case: when stack length is > 4
    @last&.connect_four?
  end

  def pieces_position
    @pieces.map do |piece|
      piece.instance_variable_get(:@position)
    end
  end
end
