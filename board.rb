require_relative "tile"
require_relative "player"
require 'byebug'

class Board
  attr_reader :grid

  def initialize(grid = default_grid, num_of_bombs = 10)
    @grid = grid
    place_bombs(num_of_bombs)
    @current_move = nil
  end

  def default_grid
    grid = Array.new(9) { Array.new (9) }
    grid = grid.map do |row|
      row.map { |square| Tile.new }
    end
    grid
  end

  def place_bombs(num_of_bombs)
    num_of_bombs.times do
      position = nil
      until valid_position?(position)
        position = get_random
      end

      self[position].set_bomb
    end
  end

  def size
    grid.length
  end

  def get_random
    [rand(size), rand(size)]
  end

  def reveal(pos)
    self[pos].reveal
  end

  def valid_position?(pos)
    !(pos.nil? || self[pos].has_bomb?)
  end

  def render
    (0...size).each do |row|
      (0...size).each do |col|
        print self[[row, col]].to_s
      end
      puts "\n"
    end
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end




end
