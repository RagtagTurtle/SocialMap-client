Rails.application.routes.draw do
  get "/signup" => "users#new"
  post "/users" => "users#create"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  get '/' => 'client/trips#index'
  namespace :client do
    get '/trips' => 'trips#index'
    get '/trips/new' => 'trips#new'
    post '/trips' => 'trips#create'
    get '/trips/:id' => 'trips#show'
    get '/trips/:id/edit' => 'trips#edit'
    patch '/trips/:id' => 'trips#update'
    delete '/trips/:id' => 'trips#destroy'

    get '/city_trips' => 'city_trips#index'
    get '/city_trips/new' => 'city_trips#new'
    post '/city_trips' => 'city_trips#create'
    get '/city_trips/:id' => 'city_trips#show'
    get '/city_trips/:id/edit' => 'city_trips#edit'
    patch '/city_trips/:id' => 'city_trips#update'
    delete '/city_trips/:id' => 'city_trips#destroy'

    get '/cities' => 'cities#index'
    get '/cities/new' => 'cities#new'
    post '/cities' => 'cities#create'
    get '/cities/:id' => 'cities#show'
    get '/cities/:id/edit' => 'cities#edit'
    patch '/cities/:id' => 'cities#update'
    delete '/cities/:id' => 'cities#destroy'

    get '/recommendations' => 'recommendations#index'
    get '/recommendations/new' => 'recommendations#new'
    post '/recommendations' => 'recommendations#create'
    get '/recommendations/:id' => 'recommendations#show'
    get '/recommendations/:id/edit' => 'recommendations#edit'
    patch '/recommendations/:id' => 'recommendations#update'
    delete '/recommendations/:id' => 'recommendations#destroy'

    get '/vibes' => 'vibes#index'
    get '/vibes/new' => 'vibes#new'
    post '/vibes' => 'vibes#create'
    get '/vibes/:id' => 'vibes#show'
    get '/vibes/:id/edit' => 'vibes#edit'
    patch '/vibes/:id' => 'vibes#update'
    delete '/vibes/:id' => 'vibes#destroy'

    get '/trip_vibes' => 'trip_vibes#index'
    get '/trip_vibes/new' => 'trip_vibes#new'
    post '/trip_vibes' => 'trip_vibes#create'
    get 'trip_vibes/:id' => 'trip_vibes#show'
    get '/trip_vibes/:id/edit' => 'trip_vibes#edit'
    patch '/trip_vibes/:id' => 'trip_vibes#update'
    delete '/trip_vibes/:id' => 'trip_vibes#destroy'

    get '/activities' => 'activities#index'
    get '/activities/new' => 'activities#new'
    post '/activities' => 'activities#create'
    get 'activities/:id' => 'activities#show'
    get '/activities/:id/edit' => 'activities#edit'
    patch '/activities/:id' => 'activities#update'
    delete '/activities/:id' => 'activities#destroy'

    get '/trip_activities' => 'trip_activities#index'
    get '/trip_activities/new' => 'trip_activities#new'
    post '/trip_activities' => 'trip_activities#create'
    get '/trip_activities/:id' => 'trip_activities#show'
    get '/trip_activities/:id/edit' => 'trip_activities#edit'
    patch '/trip_activities/:id' => 'trip_activities#update'
    delete '/trip_activities/:id' => 'trip_activities#destroy'
  end
end
