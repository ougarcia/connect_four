class Player
  attr_reader :color, :name

  def initialize(color, name)
    @color = color
    @name = name
  end

  def take_turn
    puts "#{@name}'s turn"
    puts "Choose Column"
    response = gets.chomp
    if response.match(/^\d+$/) && response.to_i.between?(0, 9)
      response.to_i
    else
      puts "Try again"
      take_turn
    end
  end
end
