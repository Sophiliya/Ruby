# require './train.rb'
# require './station.rb'
# require './route.rb'
# require './wagon.rb'


RSpec.describe Train do
  let!(:train) { Train.new('tr1') }
  let!(:station1) { Station.new('st1') }
  let!(:station2) { Station.new('st2') }
  let!(:route) { Route.new(station1, station2) }
  let!(:wagon) { Wagon.new(250)}

  before { train.assign_route(route) }
  before { train.hook(wagon) }

  describe '.all' do
    it 'returns all trains' do
      expect(Train.all).to be_instance_of(Array)
      expect(Train.all.include?(train)).to eq true
    end
  end

  describe '.show_trains_list' do
    it 'shows all trains' do
      expect(Train.show_trains_list == Train.all).to eq true

      trains = []
      2.times { |i| trains << Train.new("T#{i}")}
      expect(Train.show_trains_list(trains) == trains).to eq true
    end
  end

  describe '#number' do
    it 'returns train number' do
      expect(train.number).to eq 'tr1'
    end
  end

  describe '#current_speed' do
    it 'returns current speed' do
      expect(train.current_speed).to eq 0
    end
  end

  describe '#stop' do
    it 'returns zero current speed' do
      expect(train.stop).to eq 0
      expect(train.current_speed == 0).to eq true
    end
  end

  describe '#current_station' do
    it 'returns current station' do
      expect(train.current_station.name).to eq 'st1'
    end
  end

  describe '#route' do
    it 'returns assigned route' do
      expect(train.route).to eq route
    end
  end

  describe '#assign_route' do
    it 'adds route' do
      expect(train.route == route).to eq true
      expect(train.current_station == route.start).to eq true
    end
  end

  describe '#move_forward' do
    it 'moves to next station' do
      train.move_forward
      expect(train.current_station == route.finish).to eq true
    end
  end

  describe '#wagons' do
    it 'returns wagons' do
      expect(train.wagons).to be_instance_of(Array)
      expect(train.wagons.count).to eq 1
    end
  end

  describe '#hook' do
    it 'adds wagon' do
      expect(train.wagons.include?(wagon)).to eq true
    end
  end

  describe '#unhook' do
    it 'deletes wagon' do
      train.unhook(wagon)
      expect(train.wagons.include?(wagon)).to eq false
    end
  end
end
