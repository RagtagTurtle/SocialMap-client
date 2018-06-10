Rails.application.routes.draw do

  get "/signup" => "users#new"
  post "/users" => "users#create"

  get '/' => 'client/trips#index'
  namespace :client do
    get '/trips' => 'trips#index'
    get '/trips/new' => 'trips#new'
    post '/trips' => 'trips#create'
    get '/trips/:id' => 'trips#show'
  end
end
