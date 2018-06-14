class Client::RecommendationsController < ApplicationController
  def index
    client_params = {
                    search: params[:search]
                    }
    response = Unirest.get(
                            "http://localhost:3000/api/recommendations",
                            parameters: client_params
                          )
    @recommendations = response.body
    render 'index.html.erb'
  end

  def new
    @recommendation = {}
    render 'new.html.erb'
  end

  def create
    @recommendation = {
                      'category' => params[:category],
                      'name' => params[:name],
                      'city_id' => params[:city_id],
                      'trip_id' => params[:trip_id]
                      }
    response = Unirest.post(
                            "http://localhost:3000/api/recommendations",
                            parameters = @recommendation
                            )
    if response.code == 200
      flash[:success] = "Successfully created recommendation"
      redirect_to "/client/recommendations"
    elsif response.code == 401
      flash[:warning] = "You cannot make recommendations"
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    recommendation_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/recommendations/#{recommendation_id}")
    @recommendation = response.body
    render 'show.html.erb'    
  end

  def edit
    recommendation_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/recommendations/#{params[:id]}")
    @recommendation = response.body
    render 'edit.html.erb'
  end

  def update
    @recommendation = {
                      'category' => params[:category],
                      'name' => params[:name],
                      'trip_id' => params[:trip_id],
                      'city_id' => params[:city_id]
                        }
    response = Unirest.patch(
                            "http://localhost:3000/api/recommendations/#{params[:id]}",
                            parameters = @recommendation
                            )
    if response.code == 200
      flash[:success] = "Successfully Updated Recommendation."
      redirect_to "/client/recommendations/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to update recommendations."
      redirect_to "/"
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end 
  end

  def destroy
    recommendation_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/recommendations/#{recommendation_id}")
    if response.code == 200
      flash[:success] = "Successfully Deleted Recommendation"
      redirect_to "/"
    else
      flash[:warning] = "You are not authorized to delete this recommendation"
      redirect_to "/"
    end
  end
end
