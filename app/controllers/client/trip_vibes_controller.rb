class Client::TripVibesController < ApplicationController
  def index
    client_params ={
                    search: params[:search]
                    } 
    response = Unirest.get(
                          "http://localhost:3000/api/trip_vibes",
                          parameters: client_params
                          )
    @trip_vibes = response.body
    render 'index.html.erb'
  end

  def new
    @trip_vibe = {}
    render 'new.html.erb'
  end

  def create
    @trip_vibe = {
                  'trip_id' => params[:trip_id],
                  'vibe_id' => params[:vibe_id]
                  }
    response = Unirest.post(
                            "http://localhost:3000/api/trip_vibes",
                            parameters: @trip_vibe
                            )
    if response.code == 200
      flash[:success] = "Successfully created trip vibe"
      redirect_to "/client/trip_vibes"
    elsif response.code == 401
      flash[:warning] = "You cannot make trip vibes"
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    trip_vibe_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/trip_vibes/#{params[:id]}")
    @trip_vibe = response.body
    render 'show.html.erb'
  end

  def edit
    trip_vibe_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/trip_vibes/#{params[:id]}")
    @trip_vibe = response.body
    render 'edit.html.erb'
  end

  def update
    @trip_vibe = {
                  'trip_id' => params[:trip_id],
                  'vibe_id' => params[:vibe_id]
                  }
    response = Unirest.patch(
                              "http://localhost:3000/api/trip_vibes/#{params[:id]}",
                              parameters: @trip_vibes
                              )
    if response.code == 200
      flash[:success] = "Successfully Updated Trip Vibe."
      redirect_to "/client/trip_vibes/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to update trip vibes."
      redirect_to "/"
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end 
  end

  def destroy
    trip_vibe_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/trip_vibes/#{trip_vibe_id}")
    if response.code == 200
      flash[:success] = "Successfully Deleted Trip Vibe"
      redirect_to "/"
    else
      flash[:warning] = "You are not authorized to delete this trip vibe"
      redirect_to "/"
    end
  end
end
