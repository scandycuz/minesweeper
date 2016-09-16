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

  def won?
    grid.all? do |row|
      row.all? do |tile|
        tile.explored?
      end
    end
  end

  def adjacent_positions(pos)
    row, col = pos
    arr = []

    (row - 1..row + 1).each do |row|
      (col - 1..col + 1).each do |col|
        arr << [row, col]
      end
    end

    arr.delete_if { |adj_pos| adj_pos.any? { |coord| !coord.between?(0,size - 1) } || adj_pos == pos }
    arr
  end

  def reveal_empty_adjacent(pos)
    adj_positions = adjacent_positions(pos)

    if adj_positions.none? { |adj_pos| self[adj_pos].has_bomb? }
      self[pos].click
      adj_positions.each do |adj_pos|
        self[adj_pos].reveal
        reveal_empty_adjacent(adj_pos) unless self[adj_pos].clicked?
      end
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
    print "  "
    (0...size).each { |col_num| print " #{col_num} "}
    print "\n"
    (0...size).each_with_index do |row, row_idx|
      print "#{row_idx} "
      (0...size).each_with_index do |col, col_idx|
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
