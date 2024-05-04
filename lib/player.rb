# frozen_string_literal: true

# Defines a player in the connect four game
class Player
  def initialize(name, head_piece = nil)
    @name = name
    @head = head_piece
  end

  def make_choice
    print "#{@name}, please pick your row from 1-7: "
    gets.chomp.to_i
  end
end
