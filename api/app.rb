require "sinatra/base"
require "sinatra/activerecord"
require 'json'
require 'awesome_print'
require 'jsonapi-serializers'
Dir["#{Dir.pwd}/models/*.rb"].each { |file| require file }
Dir["#{Dir.pwd}/serializers/*.rb"].each { |file| require file }

class RailwaysApp < Sinatra::Application
  set :method_override, true
  set :database, {
    adapter: 'postgresql',
    encoding: 'unicode',
    database: 'railways_api',
    pool: 2,
    username: 'postgres_user',
    password: '1123'
  }

  helpers do
    def write_to_file(file, info)
      key = file.split(".").first
      file_info = { }

      file_info[key] = info

      File.open(file, 'w') do |f|
        f.puts(JSON.pretty_generate(file_info))
      end
    end
  end

  get '/trains' do
    content_type :json
    @trains = Train.all
    @trains.to_json
  end

  post '/trains' do
    params = JSON.parse(request.body.read)
    Train.create(params["train"])

    trains = JSON.parse(Train.all.to_json)
    write_to_file('trains.json', trains)
  end

  get '/stations' do
    content_type :json
    @stations = Station.all
    @stations.to_json
  end

  post '/stations' do
    params = JSON.parse(request.body.read)
    Station.create(params["station"])

    stations = JSON.parse(Station.all.to_json)
    write_to_file('stations.json', stations)
  end

  get '/routes' do
    content_type :json
    @routes = Route.all
    @routes.to_json
  end

  post '/routes' do
    Route.create(params)
  end

  patch '/routes/add_station' do
    params = JSON.parse(request.body.read)["route"]
    route = Route.find(params["id"])
    station = Station.find(params["station_id"])

    # добавляет, но выдает ошибку
    if route.stations.count < 2
      route.stations << station
    else
      route.stations.insert(-2, station)
    end
  end

  patch '/trains/assign_route' do
    params = JSON.parse(request.body.read)["train"]
    @train = Train.find(params["id"])
    params["station_id"] = Route.find(params["route_id"]).stations.first.id
    Station.find(params["station_id"]).trains << @train
    @train.update(params)
  end

  get '/routes/all' do
    content_type :json
    routes = []

    Route.all.each do |route|
      route_attr = route.attributes
      route_attr["stations"] = []
      route.stations.each do |station|
        station_attr = station.attributes
        station_attr["trains"] = []
        station.trains.each do |train|
          station_attr["trains"] << train.attributes
        end
        route_attr["stations"] << station_attr
      end
      routes << route_attr
    end

    write_to_file('routes.json', routes)
    @routes_all = File.read('routes.json')

    # JSONAPI::Serializer.serialize(route , include: ["stations"])
    # Route.all.map{ |route| { route.name => route.attributes } }.to_json
  end

  run! if app_file == $0
end
