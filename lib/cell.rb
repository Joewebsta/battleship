class Cell
  attr_reader :coordinate
  attr_accessor :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end
end
