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
    choice = verify_choice
    update_choice(choice)
  end

  def verify_choice
    choice = gets.chomp
    if valid?(choice)
      choice.to_i
    else
      print "Invalid choice! #{@name}, please try again: "
      verify_choice
    end
  end

  def update_choice(choice)
    piece = Piece.new(choice)
    connect(piece)
    @pieces << piece
    @last = piece
    p @last
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

  def number_of_pieces
    @pieces.length
  end

  def valid?(choice)
    index = choice.to_i
    if index < 8 && index.positive?
      return false if Piece.instance_variable_get(:@height)[index - 1] == 6

      true
    else
      false
    end
  end
end
