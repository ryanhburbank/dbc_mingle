get '/' do
  @events = Event.all
  # Look in app/views/index.erb
  erb :index
end

get '/events/categories' do
  @category = ["Coffee", "Pizza", "Mexican", "Italian", "Breakfast", "Thai", "Chinese", "Sandwiches"]
  if request.xhr? 
    erb :_categories, layout: false
  else
    erb :_categories
  end
end

post '/events/categories' do
  @category = params[:category]
  @current_restaurants = Restaurant.where("type_of_food = ?", @category)
  puts "*" * 100
  p @current_restaurants
  if request.xhr?
    erb :_restaurants, layout: false
  else
    erb :_restaurants
  end
end

get '/events/new' do
  @category = params[:category]
  @restaurant_id = params[:restaurant_id]
  @restaurant_name = Restaurant.find(@restaurant_id).name
  if request.xhr?
    erb :_new_event_form, layout: false
  else
    erb :_new_event_form
  end
end

post '/events/new' do
  user = User.find_by_email(params[:email])
  event = user.created_events.build(restaurant_id: params[:restaurant_id],
                                  time: params[:time], category: params[:category],
                                  description: params[:description], creator_name: user.name)
  event.save
  if request.xhr?
    erb :_event_list, layout: false
  else
    redirect '/'
  end
end

get '/events/:id/join' do
    @event_id = params[:id]
    @restaurant_name = Event.find(params[:id]).restaurant.name
    if request.xhr?
      erb :_event_join, layout: false
    else
      erb :_event_join
  end
end

post '/events/:id/join' do
  event = Event.find(params[:id])
  user = User.find_by_email(params[:email])
  attendence = event.attendences.create(user_id: user.id, event_id: event.id)
  redirect '/'
end
