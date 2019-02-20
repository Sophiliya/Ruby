class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |r|
      r.string :name
      r.timestamps null: false
    end
  end
end
