class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string     :creator_name
      t.integer    :user_id
      t.belongs_to :restaurant
      t.datetime   :time
      t.text       :description
      t.string     :category

      t.timestamps
    end
  end
end
