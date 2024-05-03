# frozen_string_literal: true

# Defines a player in the connect four game
class Player
  def initialize(name)
    @name = name
  end

  def make_choice
    print "#{@name}, please pick your row from 1-7: "
    gets.chomp.to_i
  end
end
