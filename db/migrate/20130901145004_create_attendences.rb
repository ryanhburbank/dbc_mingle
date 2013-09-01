class CreateAttendences < ActiveRecord::Migration
  def change
    create_table :attendences do |t|
      t.integer :user_id
      t.integer :event_id
    end
  end
end
