class HumanPlayer
  def initialize(name)
    @name = name

  end

  def valid_move?(pos)
    !pos.nil?
  end

  def in_range?(pos)
    parse(pos).all? { |coord| coord.between?(0, 8) }
  end

  def get_move
    input = nil
    until valid_move?(input) && in_range?(input)
      prompt
      input = gets.chomp
    end
    parse(input)
  end

  def parse(input)
    input.split(",").map(&:to_i)
  end

  def prompt
    puts "Pick a move"
  end
end
