User.create(:name => "Ryan", :email => "Ryan@gmail.com")
Restaurant.create(:name => "McDonalds")
User.last.created_events.create(:restaurant_id => 1, :time => Time.now)
