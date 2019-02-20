class CreateTrains < ActiveRecord::Migration[5.2]
  def change
    create_table :trains do |t|
      t.string :number
      t.string :train_type
      t.integer :station_id
      t.integer :route_id

      t.timestamps null: false
    end
  end
end
