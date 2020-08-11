require './lib/cell'

describe Cell do
  subject { Cell.new('B4') }

  describe '#initialize' do
    it 'has a coordinate' do
      expect(subject.coordinate).to eql('B4')
    end
  end
end
