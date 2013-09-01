class Event < ActiveRecord::Base
  has_many   :attendences
  has_many   :attendees,
             :through => :attendences,
             :source =>  :user
  belongs_to :restaurant
  belongs_to :creator, :foreign_key => "user_id", class_name: "User"
  # Remember to create a migration!
end
