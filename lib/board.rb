# frozen_string_literal: true

require_relative 'display'
require_relative 'player'

# Defines the board of connect four
class Board
  include Display

  def initialize(player1 = nil, player2 = nil)
    @player1 = player1
    @player2 = player2
    @board = Array.new(7).map { Array.new(6) }
  end

  def play
    update_players
  end

  def update_players
    (1..2).each do |player_number|
      new_player = create_player(input_name(player_number))
      player_number == 1 ? @player1 = new_player : @player2 = new_player
    end
  end

  def create_player(name)
    Player.new(name)
  end

  def input_name(player_number)
    print "Enter Player#{player_number} Name: "
    gets.chomp
  end
end
