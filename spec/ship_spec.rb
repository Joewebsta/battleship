require './lib/ship'

describe Ship do
  before { @ship = Ship.new('Cruiser', 3) }

  example 'has a name' do
    expect(@ship.name).to eql('Cruiser')
  end

  example 'has a length' do
    expect(@ship.length).to eql(3)
  end
end
