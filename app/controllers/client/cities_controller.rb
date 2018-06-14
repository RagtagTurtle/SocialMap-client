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
      flash[:success] = "Successfully created city"
      redirect_to "/client/cities"
    elsif response.code == 401
      flash[:warning] = "You cannot make cities"
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

  def edit
    city_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/cities/#{params[:id]}")
    @city = response.body
    render 'edit.html.erb'
  end

  def update
    @city = {
              'name' => params[:name],
              'state' => params[:state],
              'geography_id' => params[:geography_id],
              'region' => params[:region]
              }
    response = Unirest.patch(
                              "http://localhost:3000/api/cities/#{params[:id]}",
                              parameters: @city
                            )
    if response.code == 200
      flash[:success] = "Successfully Updated City."
      redirect_to "/client/cities/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to update cities."
      redirect_to "/"
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end 
  end

  def destroy
    city_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/cities/#{city_id}")
    if response.code == 200
      flash[:success] = "Successfully Deleted City"
      redirect_to "/"
    else
      flash[:warning] = "You are not authorized to delete this city"
      redirect_to "/"
    end
  end
end
