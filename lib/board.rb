require_relative "piece"
require_relative "null_piece"
class Board

  def initialize(player1, player2, length, win)
    @player1, @player2 = player1, player2
    @win_length = win
    @length = length
    @grid = Array.new(length) { Array.new(length) { NullPiece.new } }
  end

  def at(pos)
    @grid[pos[0]][pos[1]]
  end

  def move(player, column)
    piece = Piece.new(player.color, column)
    @grid.each_with_index do |row, idx|
      if row[column].nil?
        piece.pos = [idx, column]
        @grid[idx][column] = piece
        @latest_move = piece
        break
      end
    end
  end

  def available?(column)
    @grid.each_with_index do |row, idx|
      if row[column].nil?
        return true
      end
    end

    false
  end

  def print_legend
    print " "
    0.upto(@length - 1) do |num|
      print num.to_s.rjust(2, '0')
      print " "
    end
    puts
  end

  def render
    print_legend
    @grid.reverse.each do |row|
      print "|"
      row.each do |piece|
        print " #{piece.to_s}|"
      end
      puts
    end
    print_legend
  end

  def won?
    # using this hash for memo-ization
    #   key is flattened position and direction
    #   value is the count in that direction from that position
    @visited ||= {}
    origin = @latest_move.pos
    directions = [0, 1, 1, -1, -1].permutation(2).to_a.uniq
    directions.each do |dir|
      pos = origin
      color = @latest_move.color
      count = 1
      loop do
        pos = add_arrays(pos, dir)
        if @visited[[*pos, *dir]]
          count += @visited[[*pos, *dir]]
          if count >= @win_length
            return true
          else
            @visited[[*origin, *dir]] = count
            break
          end
        else
          # memo-ize if reached the end of the board
          if !in_range?(pos)
            @visited[[*origin, *dir]] = count
            break
          end
          # stop searching but don't memo-ize if reached an empty position
          if at(pos).nil?
            break
          end
          # memo-ize if reached a different color piece
          if at(pos).color != color
            @visited[[*origin, *dir]] = count
            break
          end
          # if all checks are passed move on to the next piece
          count += 1
          return true if count >= @win_length
        end
      end
    end

    false
  end

  private
  def in_range?(pos)
    pos.all? { |n| n.between?(0, @length) }
  end

  def add_arrays(arr1, arr2)
    result = []
    arr1.each_index do |i|
      result[i] = arr1[i] + arr2[i]
    end

    result
  end

end
