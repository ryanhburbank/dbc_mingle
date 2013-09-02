class AddIndexToRestaurants < ActiveRecord::Migration
  def change
    add_index :restaurants, :type_of_food
  end
end
