class Client::CitiesController < ApplicationController
  def index
    client_params = {
                    search: params[:search]
                      }
    response = Unirest.get(
                            "http://localhost:3000/api/cities",
                            parameters: client_params
                            )
    @cities = response.body
    render 'index.html.erb'
  end

  def new
    @city = {}
    render 'new.html.erb'
  end

  def create
    @city = {
              'name' => params[:name],
              'state' => params[:state],
              'geography_id' => params[:geography_id],
              'region' => params[:region]
              }
    response = Unirest.post(
                            "http://localhost:3000/api/cities",
                            parameters: @city
                            )
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
    city_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/cities/#{city_id}")
    @city = response.body
    render 'show.html.erb'
  end
end
