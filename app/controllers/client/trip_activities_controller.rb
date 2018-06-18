class Client::TripActivitiesController < ApplicationController
  def index
    client_params ={
                    search: params[:search]
                    } 
    response = Unirest.get(
                          "http://localhost:3000/api/trip_activities",
                          parameters: client_params
                          )
    @trip_activities = response.body
    render 'index.html.erb'
  end

  def new
    @trip_activity = {}
    render 'new.html.erb'
  end

  def create
    @trip_activity = {
                  'trip_id' => params[:trip_id],
                  'activity_id' => params[:activity_id]
                  }
    response = Unirest.post(
                            "http://localhost:3000/api/trip_activities",
                            parameters: @trip_activity
                            )
    if response.code == 200
      flash[:success] = "Successfully created trip activity"
      redirect_to "/client/trip_activities"
    elsif response.code == 401
      flash[:warning] = "You cannot make trip activities"
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    trip_activity_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/trip_activities/#{params[:id]}")
    @trip_activity = response.body
    render 'show.html.erb'
  end

  def edit
    trip_activity_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/trip_activities/#{params[:id]}")
    @trip_activity = response.body
    render 'edit.html.erb'
  end

  def update
    @trip_activity = {
                  'trip_id' => params[:trip_id],
                  'activity_id' => params[:activity_id]
                  }
    response = Unirest.patch(
                              "http://localhost:3000/api/trip_activities/#{params[:id]}",
                              parameters: @trip_activity
                              )
    if response.code == 200
      flash[:success] = "Successfully Updated Trip Activity."
      redirect_to "/client/trip_activities/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to update trip activities."
      redirect_to "/"
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end 
  end

  def destroy
    trip_activity_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/trip_activities/#{trip_activity_id}")
    if response.code == 200
      flash[:success] = "Successfully Deleted Trip Activity"
      redirect_to "/"
    else
      flash[:warning] = "You are not authorized to delete this trip activity"
      redirect_to "/"
    end
  end
end
