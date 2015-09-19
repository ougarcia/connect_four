require_relative "piece"
require_relative "null_piece"

class Board

  def initialize(player1, player2, length, win)
    @player1, @player2 = player1, player2
    @win_length = win
    @length = length
    @grid = Array.new(length) { Array.new(length) { NullPiece.new } }
    @visited = {}
  end

  def move(color, column)
    @grid.each_with_index do |row, idx|
      if row[column].nil?
        @grid[idx][column] = Piece.new(color, idx, column)
        @origin = [idx, column]
        return true
      end
    end

    false
  end

  def render
    print_legend
    @grid.reverse.each do |row|
      print "|"
      row.each { |piece| print " #{piece.to_s}|" }
      puts
    end
    print_legend
  end

  def won?
    color = at(@origin).color
    [[0, 1], [1, 0], [1, 1], [1, -1]].each do |dir|
      left = check_direction(dir, @origin, 0, color)
      right = check_direction(reverse(dir), @origin, 0, color)
      return true if left + right + 1 >= @win_length
    end

    false
  end

  private

  def check_direction(dir, origin, count, color)
    pos = add_arrays(origin, dir)

    # create a proc to be called if we want to memoize before we return
    memoize = Proc.new do
      @visited[[*@origin, *dir, color]] = count + 1
      return count
    end

    # check if we've been here before
    if @visited[[*pos, *dir, color]]
      count += @visited[[*pos, *dir, color]]
      memoize.call
    end

    # memoize if reached the end of the board
    memoize.call if !in_range?(pos)

    # stop searching but don't memoize if reached an empty position
    return count if at(pos).nil?

    # memoize if reached a different color piece
    memoize.call if at(pos).color != color

    # if all checks are passed move on to the next piece
    check_direction(dir, pos, count + 1, color)
  end

  def at(pos)
    @grid[pos[0]][pos[1]]
  end

  def reverse(dir)
    dir.map { |el| el * -1 }
  end

  def print_legend
    puts "  #{[*0...@length].join("  ")}"
  end

  def in_range?(pos)
    pos.all? { |n| n.between?(0, @length - 1) }
  end

  def add_arrays(arr1, arr2)
    arr1.map.with_index { |el, i| el + arr2[i] }
  end
end
