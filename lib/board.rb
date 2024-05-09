# frozen_string_literal: true

require_relative 'player'

# Defines the board of connect four
class Board
  def initialize(player1 = nil, player2 = nil)
    @player1 = player1
    @player2 = player2
    @board = Array.new(7) { Array.new(6, ' ') }
  end

  def play
    introduction
    update_players
    game_loop
    display_winner
  end

  def update_players
    (1..2).each do |player_number|
      new_player = create_player(input_name(player_number))
      player_number == 1 ? @player1 = new_player : @player2 = new_player
    end
  end

  def game_loop
    display_turn_order until game_end?
  end

  # private

  def create_player(name)
    Player.new(name)
  end

  def input_name(player_number)
    print "Enter Player#{player_number} Name: "
    gets.chomp
  end

  def display_turn_order
    @player1.make_choice
    update_board
    return if @player1.game_won?

    @player2.make_choice
    update_board
  end

  def game_end?
    return true if @player1.game_won?

    @player2.game_won?
  end

  def update_board
    if @player1.number_of_pieces > @player2.number_of_pieces
      position = @player1.instance_variable_get(:@last).instance_variable_get(:@position)
      @board[position[0]][position[1]] = 'X'
    else
      position = @player2.instance_variable_get(:@last).instance_variable_get(:@position)
      @board[position[0]][position[1]] = 'O'
    end
    display_board
  end

  def display_board # rubocop: disable Metrics/AbcSize
    puts "|#{@board[0][5]}|#{@board[1][5]}|#{@board[2][5]}|#{@board[3][5]}|#{@board[4][5]}|#{@board[5][5]}|#{@board[6][5]}|"
    puts "|#{@board[0][4]}|#{@board[1][4]}|#{@board[2][4]}|#{@board[3][4]}|#{@board[4][4]}|#{@board[5][4]}|#{@board[6][4]}|"
    puts "|#{@board[0][3]}|#{@board[1][3]}|#{@board[2][3]}|#{@board[3][3]}|#{@board[4][3]}|#{@board[5][3]}|#{@board[6][3]}|"
    puts "|#{@board[0][2]}|#{@board[1][2]}|#{@board[2][2]}|#{@board[3][2]}|#{@board[4][2]}|#{@board[5][2]}|#{@board[6][2]}|"
    puts "|#{@board[0][1]}|#{@board[1][1]}|#{@board[2][1]}|#{@board[3][1]}|#{@board[4][1]}|#{@board[5][1]}|#{@board[6][1]}|"
    puts "|#{@board[0][0]}|#{@board[1][0]}|#{@board[2][0]}|#{@board[3][0]}|#{@board[4][0]}|#{@board[5][0]}|#{@board[6][0]}|"
    puts '+-+-+-+-+-+-+-+'
  end

  def introduction
    puts ''
    puts "Let's play a game of Connect Four!"
    puts 'Whose playing?'
  end

  def display_winner
    if @player1.number_of_pieces > @player2.number_of_pieces
      puts "#{@player1.instance_variable_get(:@name)} won!"
    else
      puts "#{@player2.instance_variable_get(:@name)} won!"
    end
  end
end
