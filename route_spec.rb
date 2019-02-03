require './route.rb'
require './station.rb'

RSpec.describe Route do
  let!(:station1) { Station.new('st1') }
  let!(:station2) { Station.new('st2') }
  let!(:station3) { Station.new('st3')}
  let!(:route) { Route.new(station1, station2) }

  describe '.all' do
    it 'returns all routes' do
      expect(Route.all).to be_instance_of(Array)
      expect(Route.all.count).to eq 1
    end
  end

  describe '.show_routes_names' do
    it 'shows routes names' do
      routes = Route.show_routes_names
      names = routes.map(&:name)
      expect(names.include?('st1 - st2')).to eq true
    end
  end

  describe '#start' do
    it 'returns first station' do
      expect( route.start == station1 ).to eq true
    end
  end

  describe '#finish' do
    it 'returns last station' do
      expect( route.finish == station2 ).to eq true
    end
  end

  describe '#stations' do
    it 'returns stations' do
      expect(route.stations).to be_instance_of(Array)
      expect(route.stations.include?(station1) && route.stations.include?(station2)).to eq true
    end
  end

  describe '#name' do
    it 'returns route name' do
      expect( route.name == "#{station1.name} - #{station2.name}" ).to eq true
    end
  end

  describe '#add_station' do
    it 'adds station' do
      route.add_station(station3)
      expect(route.stations.include?(station3)).to eq true
    end
  end

  describe '#delete_station' do
    it 'deletes station' do
      route.delete_station(station3)
      expect(route.stations.include?(station3)).to eq false
    end
  end
end
