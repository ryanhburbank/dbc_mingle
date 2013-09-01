require 'yelpster'
require 'dbc-ruby'
DBC::token = "4b02bda17d6f8bcb564bf3addc26da75"
all_cohorts = DBC::Cohort.all

def twitter_handle(twitter_string)
  if twitter_string
    return twitter_string.gsub(/(.{20})(.+)/,"@" + '\2')
  else
    return nil
  end
end

def in_session(cohort_boolean)
  return 1 if cohort_boolean == true
  0
end

all_cohorts.each do |cohort|
  current_cohort = Cohort.new(name: cohort.name, 
             location: cohort.location, 
             email: cohort.email,
             in_session: in_session(cohort.in_session) )
  if current_cohort.save
    cohort.students.each do |student|
      current_student = User.new(name: student.name,
                                    email: student.email,
                                    twitter: twitter_handle(student.profile[:twitter]),
                                    cohort_id: current_cohort.id)
      if current_student.save
        puts "#{student.name} added to the database as a member of the #{cohort.name}!"
      else
        puts "#{student.name} failed to save, here's why: #{current_student.errors.full_messages}"
      end
    end

    puts "#{cohort.name} added to database!"
  else
    puts "#{cohort.name} failed to save, here's why: #{current_cohort.errors.full_messages}"
  end
end



gps_grid = 0.6 # area around point in KM

gps_lat = 41.889943
gps_long = -87.637066
gps_lat_km = gps_grid*(360.0/40075.0) 
gps_long_km = gps_grid*(360.0/(Math.cos(gps_long)*40075.0))
gps_coordinates = [gps_lat-gps_lat_km, gps_long-gps_long_km,gps_lat+gps_lat_km,gps_long+gps_long_km  ]


search_terms = ["coffee", "pizza", "mexican", "italian", "breakfast", "thai", "chinese", "sandwiches"]
client = Yelp::Client.new
include Yelp::V2::Search::Request


search_terms.each do |term|

  request = BoundingBox.new(
               :term => term,
               :sw_latitude => gps_coordinates[0],
               :sw_longitude => gps_coordinates[1],
               :ne_latitude => gps_coordinates[2],
               :ne_longitude => gps_coordinates[3],
               :limit => 20,
               :consumer_key => 'Dh4aT-xW6BWPivQ2UpDBAw',
               :consumer_secret => '_7k4OW1RitvvukayIKNPj5lpYlM',
               :token => 'elfMIiJYibsVWDMycVXxuPxGKt-Fzaax',
               :token_secret => 'SrW53Cb-D4Hi544SIiLAVurY5s8')

  @response = client.search(request)

  @attributes_all = ["name", "rating", "review_count", "url", "phone", "image_url", "categories", "display_phone", "id", "location"]
  @attributes = ["name", "rating", "url", "display_phone", "location"]
  @businesses = []

  @response["businesses"].each do |b|
    @business = []
    @attributes.each do |attribute|
      @business << b[attribute]
    end
    location = @business[4]["display_address"]
    restaurant = Restaurant.new(:name => @business[0],
    	             :rating => @business[1],
    	             :website_url => @business[2],
    	             :phone_number => @business[3],
    	             :location => location[0] + " " + location[2],
                   :type_of_food => term)
    if restaurant.save
    	puts "#{restaurant.name} saved"
    else
    	puts "#{restaurant.name} failed to save, here's why: #{restaurant.errors.full_messages}"
    end
  end
end
