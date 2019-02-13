require 'sinatra'
require_relative 'station'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'route'

set :show_exceptions, false

helpers do
  def store_station_info(params)
    return if params['station_name'].empty?
    station = Station.new(params['station_name'])
    station_info = "ID: #{Station.all.count}, name: #{params['station_name']}, created_at: #{Time.now}"

    File.open('stations.txt', 'a+') do |file|
      file.puts(station_info)
    end
  end

  def store_train_info(params)
    return if params["train_type"] == nil || params['train_number'].empty?
    create_train(params)
    train_info = "ID: #{Train.all.count}, type: #{params["train_type"]}, number: #{params['train_number']}, created_at: #{Time.now}"

    File.open('trains.txt', 'a+') do |file|
      file.puts(train_info)
    end
  end

  def create_train(params)
    case params["train_type"]
    when "cargo"
      CargoTrain.new(params["train_number"])
    when "passenger"
      PassengerTrain.new(params["train_number"])
    else
      return
    end
  end

  def store_route_info(params)
    return if params["station_1"] == params["station_2"]
    route = create_route(params)
    route_info = "ID: #{Route.all.count}, name: #{route.name}, created_at: #{Time.now}"

    File.open('routes.txt', 'a+') do |file|
      file.puts(route_info)
    end
  end

  def create_route(params)
    station_1 = Station.all.find { |station| station.name == params["station_1"] }
    station_2 = Station.all.find { |station| station.name == params["station_2"] }

    Route.new(station_1, station_2)
  end

  def read_info(file)
    return [] unless File.exist?(file)
    File.read(file).split("\n")
  end
end

get '/app' do
  erb :main
end

get '/stations' do
  @stations_info = read_info('stations.txt')
  erb :stations
end

post '/station_info' do
  store_station_info(params)
  redirect '/stations'
end

get '/trains' do
  @trains_info = read_info('trains.txt')
  erb :trains
end

post '/train_info' do
  store_train_info(params)
  redirect '/trains'
end

get '/routes' do
  @stations = Station.all.map(&:name)
  @routes_info = read_info('routes.txt')
  erb :routes
end

post '/route_info' do
  store_route_info(params)
  redirect '/routes'
end

error do
  'Oops! An error occured ' + env['sinatra.error'].message
end
