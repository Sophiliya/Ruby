class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |s|
      s.string :name
      s.timestamps null: false
    end
  end
end
