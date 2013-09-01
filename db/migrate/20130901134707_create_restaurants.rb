class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string  :name
      t.string  :location
      t.string  :phone_number
      t.string  :website_url
      t.string  :rating
      t.string  :type_of_food

      t.timestamps
    end
  end
end
