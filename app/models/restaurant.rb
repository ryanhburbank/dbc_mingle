class Restaurant < ActiveRecord::Base
  has_many :events
  before_save :capitalize_type_of_food

  def capitalize_type_of_food
  	self.type_of_food = self.type_of_food.capitalizegit 
  end
end
