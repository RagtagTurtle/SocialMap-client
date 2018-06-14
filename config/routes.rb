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
  end
end
