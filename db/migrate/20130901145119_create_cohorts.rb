class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string  :name
      t.string  :location
      t.string  :email
      t.integer :in_session, :default => 0

      t.timestamps
    end
  end
end
