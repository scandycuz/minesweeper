require_relative "board"
require_relative "player"
require_relative "tile"

class Minesweeper
  attr_reader :board, :player

  def initialize(player_name = "Bob")
    @board = Board.new
    @player = HumanPlayer.new(player_name)
  end

  def take_turn
    # debugger
    move = player.get_move
    @current_move = move
    board.reveal(move)
    board.reveal_empty_adjacent(move)
    board.render
  end

  def run
    board.render
    until game_won? || game_lost?
      take_turn
    end

    puts game_won? ? "Congratulations!" : "KERPLAM!!"
  end

  def game_won?
    board.won?
  end

  def game_lost?
    if !@current_move.nil?
      board[@current_move].has_bomb?
    else
      false
    end
  end
end
game = Minesweeper.new
game.run
