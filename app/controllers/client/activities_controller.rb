class Client::ActivitiesController < ApplicationController
  def index
    client_params = {
                    search: params[:search]
                      }
    response = Unirest.get(
                            "http://localhost:3000/api/activities",
                            parameters: client_params
                            )
    @activities = response.body
    render 'index.html.erb'
  end

  def new
    @activity = {}
    render 'new.html.erb'
  end

  def create
    @activity = {
            'name' => params[:name]
            }
    response = Unirest.post(
                            "http://localhost:3000/api/activities",
                            parameters: @activity
                            )
    if response.code == 200
      flash[:success] = "Successfully created activity"
      redirect_to "/client/activities"
    elsif response.code == 401
      flash[:warning] = "You cannot make activities"
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    activity_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/activities/#{activity_id}")
    @activity = response.body
    render 'show.html.erb'
  end

  def edit
    activity_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/activities/#{params[:id]}")
    @activity = response.body
    render 'edit.html.erb'     
  end

  def update
    @activity = {'name' => params[:name]}
    response = Unirest.patch(
                              "http://localhost:3000/api/activities/#{params[:id]}",
                              parameters: @activity
                              )
    if response.code == 200
      flash[:success] = "Successfully Updated Activity."
      redirect_to "/client/activities/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to update activities."
      redirect_to "/"
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end    
  end

  def destroy
    activity_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/activities/#{activity_id}")    
    if response.code == 200
      flash[:success] = "Successfully Deleted Activity"
      redirect_to "/"
    else
      flash[:warning] = "You are not authorized to delete this activity"
      redirect_to "/"
    end
  end
end
