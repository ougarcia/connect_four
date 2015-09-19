require_relative "lib/board"
require_relative "lib/player"

class Game
  def initialize
    @player1 = Player.new('red', "Player 1")
    @player2 = Player.new('blue', "Player 2")
    board_length = ask("How big of a board?\t", 3, 99)
    win_length = ask("How many to win?\t", 3, board_length)
    @board = Board.new( @player1, @player2, board_length, win_length)
  end

  def start
    @current_player = @player1
    loop do
      @board.render
      if @board.move(@current_player.color, @current_player.take_turn)
        break if @board.won?
        switch_player
      else
        puts "Try Again"
      end
    end
    handle_win
  end

  private

  def handle_win
    @board.render
    puts "Game Over, #{@current_player.name} wins!"
  end

  def ask(prompt, min, max)
    print prompt
    response = gets.chomp
    if response.match(/^\d+$/) && response.to_i.between?(min, max)
      response.to_i
    else
      puts "Try Again"
      ask(prompt, min, max)
    end
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end

Game.new.start
