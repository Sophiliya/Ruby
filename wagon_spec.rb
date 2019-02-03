RSpec.describe Wagon do
  let!(:wagon) { Wagon.new(88) }

  describe '.all' do
    it 'returns all wagons' do
      expect(Wagon.all).to be_instance_of(Array)
      expect(Wagon.all.include?(wagon)).to eq true
    end
  end

  describe '.show_wagons_list' do
    it 'shows all wagons' do
      expect(Wagon.show_wagons_list == Wagon.all).to eq true

      wagons = []
      2.times { wagons << Wagon.new(50)}
      expect(Wagon.show_wagons_list(wagons) == wagons).to eq true
    end
  end

  describe '#volume' do
    it 'returns volume/size' do
      expect(wagon.volume).to eq 88
    end
  end
end
