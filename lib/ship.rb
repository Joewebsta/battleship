class Ship
  attr_reader :name, :length
  attr_accessor :health, :sunk

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
    @sunk = false
  end

  def sunk?
    health <= 0
  end

  def hit
    self.health -= 1
  end
end
