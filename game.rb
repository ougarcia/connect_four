require_relative "lib/board"
require_relative "lib/player"

class Game
  def initialize
    @player1 = Player.new('red', "Player 1")
    @player2 = Player.new('blue', "Player 2")
    @board_length = get_length
    @win_length = get_win
    @board = Board.new(@player1, @player2, @board_length, @win_length)
  end

  def get_length
    print "How big of a board?\t"
    length = gets.chomp
    if length.match(/^\d+$/) && length.to_i.between?(0, 99)
      length.to_i
    else
      puts "Try Again"
      get_length
    end
  end

  def get_win
    print "How many to win?\t"
    length = gets.chomp
    if length.match(/^\d+$/) && length.to_i.between?(0, @board_length)
      length.to_i
    else
      puts "Try Again"
      get_win
    end
  end

  def handle_win
    @board.render
    puts "Game Over, #{@current_player.name} wins!"
  end

  def start
    @current_player = @player1
    loop do
      @board.render
      move = @current_player.take_turn
      if @board.available?(move)
        @board.move(@current_player, move)
        break if @board.won?
        switch_player
      else
        puts "Try Again"
      end
    end
    handle_win
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end

Game.new.start
