class Client::CityTripsController < ApplicationController
  def index
    client_params = {
                    search: params[:search]
                    }
    response = Unirest.get("http://localhost:3000/api/city_trips",
                          parameters: client_params
                          )
    @city_trips = response.body
    render 'index.html.erb'
  end

  def new
    @city_trip = {}
    render 'new.html.erb'
  end

  def create
    @city_trip = {
                  'city_id' => params[:city_id],
                  'trip_id' => params[:trip_id]
                  }
    response = Unirest.post(
                            "http://localhost:3000/api/city_trips",
                            parameters: @city_trip
                            )
    if response.code == 200
      flash[:success] = "Successfully created city trip"
      redirect_to "/client/trips"
    elsif response.code == 401
      flash[:warning] = "You cannot make city trips"
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    city_trip_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/city_trips/#{city_trip_id}")
    @city_trip = response.body
    render 'show.html.erb'
  end

  def edit
    city_trip_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/city_trips/#{city_trip_id}")
    @city_trip = response.body
    render 'edit.html.erb'
  end

  def update
    @city_trip = {
                  'id' => params[:id],
                  'city_id' => params[:city_id],
                  'trip_id' => params[:trip_id]
                  }
    response = Unirest.patch(
                              "http://localhost:3000/api/city_trips/#{params[:id]}",
                              parameters: @city_trip
                            )
    if response.code == 200
      flash[:success] = "Successfully Updated City Trip."
      redirect_to "/client/city_trips/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to update city trips."
      redirect_to "/"
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end    
  end

  def destroy
    city_trip_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/city_trips/#{city_trip_id}")
    if response.code == 200
      flash[:success] = "Successfully Deleted City Trip"
      redirect_to "/"
    else
      flash[:warning] = "You are not authorized to delete this city trip"
      redirect_to "/"
    end
  end
end
