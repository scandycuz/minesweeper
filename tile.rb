class Tile
  attr_reader :bomb

  def initialize
    @bomb = false
    @explored = false
    @clicked = false
  end

  def set_bomb
    @bomb = true
  end

  def click
    @clicked = true
  end

  def clicked?
    @clicked
  end

  def reveal
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
    elsif has_bomb? && !explored?
      " X "
    elsif explored? && !has_bomb?
      "   "
    elsif !explored?
      " * "
    end
  end

end
