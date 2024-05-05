# frozen_string_literal: true

require_relative 'piece'

# Defines a player in the connect four game
class Player
  def initialize(name, pieces = [])
    @name = name
    @pieces = pieces
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

  def game_won?; end
end
