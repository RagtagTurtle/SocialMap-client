class Client::TripsController < ApplicationController
  def index
    client_params = {
                      search: params[:search]
                      }
    response = Unirest.get(
                            "http://localhost:3000/api/trips",
                            parameters: client_params
                            )  
    @trips = response.body
    render 'index.html.erb'
  end

  def new
    @trip = {}
    render 'new.html.erb'
  end

  def create
    @trip = {
              'climate' => params[:climate],
              'start_date' => params[:start_date],
              'end_date' => params[:end_date]
              }
    response = Unirest.post("http://localhost:3000/api/trips",
                            parameters: @trip)
    if response.code == 200
      flash[:success] = "Successfully created trip"
      redirect_to "/client/trips"
    elsif response.code == 401
      flash[:warning] = "You cannot make trips"
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    trip_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/trips/#{trip_id}")
    @trip = response.body
    render 'show.html.erb'
  end
end
