class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer    :user_id
      t.belongs_to :restaurant
      t.datetime   :time
      t.string     :topic
      t.text       :description

      t.timestamps
    end
  end
end
