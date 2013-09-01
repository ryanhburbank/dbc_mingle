class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :location
      t.string :phone_number
      t.string :website_url
      t.time :open_time
      t.time :close_time
      t.integer :price

      t.timestamps
    end
  end
end
