require './lib/ship'

describe Ship do
  before { @ship = Ship.new('Cruiser', 3) }

  it 'has a name' do
    expect(@ship.name).to eql('Cruiser')
  end

  it 'has a length' do
    expect(@ship.length).to eql(3)
  end

  it 'has health equal to length' do
    expect(@ship.health).to eql(@ship.length)
  end
end
