require 'colorize'

class Piece
  attr_accessor :pos
  attr_reader :color

  def initialize(color, column)
    @color = color
    @column = column
  end

  def adjacent
    [0, 1, 1, -1, -1].permutation(2).to_a.uniq
  end

  def nil?
    false
  end

  def to_s
    "\u25CF".colorize(color: @color.to_sym)
  end

end
