class Cell
  attr_reader :coordinate
  attr_accessor :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    ship.nil?
  end

  def fired_upon?
    fired_upon
  end

  def place_ship(ship)
    self.ship = ship
  end

  def fire_upon
    # ship.hit if ship
    ship&.hit
    self.fired_upon = true
  end

  def render(reveal_ship = false)
    if ship
      return 'X' if fired_upon && ship.sunk?
      return 'H' if fired_upon
      return 'S' if reveal_ship
    end

    return 'M' if fired_upon && empty?
    return '.' unless fired_upon
  end
end
