class Cohorts < ActiveRecord::Base
  has_many :students, class_name: "User"
  # Remember to create a migration!
end
