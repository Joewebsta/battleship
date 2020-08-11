class Cell
  attr_reader :coordinate
  attr_accessor :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def fired_upon?
    fired_upon
  end

  def place_ship(ship)
    self.ship = ship
  end

  def fire_upon
    ship.hit
    self.fired_upon = true
  end
end
