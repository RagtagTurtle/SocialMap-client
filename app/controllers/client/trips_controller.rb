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

  def edit
    trip_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/trips/#{trip_id}")
    @trip = response.body
    render 'edit.html.erb'
  end

  def update
    @trip = {
              'id' => params[:id],
              'climate' => params[:climate],
              'start_date' => params[:start_date],
              'end_date' => params[:end_date]
              }
    response = Unirest.patch(
                              "http://localhost:3000/api/trips/#{params[:id]}",
                              parameters: @trip
                              )
    if response.code == 200
      flash[:success] = "Successfully Updated Trip."
      redirect_to "/client/trips/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to update trips."
      redirect_to "/"
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end      
  end

  def destroy
    trip_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/trips/#{trip_id}")
    if response.code == 200
      flash[:success] = "Successfully Deleted Trip"
      redirect_to "/"
    else
      flash[:warning] = "You are not authorized to delete this trip"
      redirect_to "/"
    end
  end
end
