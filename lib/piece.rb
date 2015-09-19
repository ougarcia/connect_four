require 'colorize'

class Piece
  attr_reader :pos, :color

  def initialize(color, row, column)
    @color = color
    @pos = [row, column]
  end

  def nil?
    false
  end

  def to_s
    "\u25CF".colorize(color: @color.to_sym)
  end

end
