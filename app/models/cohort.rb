class Cohort < ActiveRecord::Base
  has_many :students, :foreign_key => "cohort_id", class_name: "User"
end
