class Tile
  attr_reader :bomb

  def initialize
    @bomb = false
    @explored = false
  end

  def set_bomb
    @bomb = true
  end

  def reveal
    make_explored
  end

  def make_explored
    @explored = true
  end

  def explored?
    @explored
  end

  def has_bomb?
    @bomb
  end

  def to_s
    if has_bomb? && explored?
      " X "
    elsif explored? && !has_bomb?
      "   "
    elsif !explored?
      " * "
    end
  end

end
