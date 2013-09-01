class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.integer :attendence_id
      t.time :meet_time
      t.string :topic
      t.text :description

      t.timestamps
    end
  end
end
