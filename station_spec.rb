RSpec.describe Station do
  let!(:station) { Station.new('st1') }
  let!(:train) { Train.new('tr1') }
  let!(:trains) { station.trains }

  describe '.all' do
    it 'returns all stations' do
      expect(Station.all).to be_instance_of(Array)
      expect(Station.all.include?(station)).to eq true
    end
  end

  describe '.show_stations_names' do
    it 'shows stations names' do
      stations = Station.show_stations_names
      names = stations.map(&:name)
      expect(names.include?('st1')).to eq true
    end
  end

  # self.read_file

  describe '#name' do
    it 'returns name of the station' do
      expect(station.name).to eq 'st1'
    end
  end

  describe '#trains' do
    it 'returns trains of the station' do
      expect(station.trains).to be_instance_of(Array)
    end
  end

  describe '#get_train' do
    it 'adds train to trains list' do
      expect(station.get_train(train)).to eq trains
      expect(station.trains.include?(train)).to eq true
    end
  end

  describe '#send_train' do
    it 'deletes train from trains list' do
      expect(station.send_train(train)).to eq trains.delete(train)
      expect(station.trains.include?(train)).to eq false
    end
  end

  describe '#show_trains_list' do
    it 'returns trains if they exists' do
      expect(station.show_trains_list == nil && station.trains.empty?).to eq true

      station.get_train(train)
      expect(station.show_trains_list == station.trains).to eq true
    end
  end

  # write_to_file
end
