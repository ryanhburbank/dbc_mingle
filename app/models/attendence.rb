class Attendence < ActiveRecord::Base
  belongs_to :user
  belongs_to :event# Remember to create a migration!
end
