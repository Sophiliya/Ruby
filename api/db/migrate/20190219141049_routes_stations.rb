class RoutesStations < ActiveRecord::Migration[5.2]
  def change
    create_table :routes_stations do |t|
      t.integer :route_id
      t.integer :station_id

      t.timestamps null: false
    end
  end
end
