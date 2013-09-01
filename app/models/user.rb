class User < ActiveRecord::Base
  belongs_to :cohort
  has_many   :created_events, :foreign_key => "user_id", class_name: "Event"
  has_many   :attendences
  has_many   :attended_events, 
             :through => :attendences,
             :source => :event
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  # Remember to create a migration!
end
