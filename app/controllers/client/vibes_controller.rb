class Client::VibesController < ApplicationController
  def index
    client_params = {
                    search: params[:search]
                      }
    response = Unirest.get(
                            "http://localhost:3000/api/vibes",
                            parameters: client_params
                            )
    @vibes = response.body
    render 'index.html.erb'
  end

  def new
    @vibe = {}
    render 'new.html.erb'
  end

  def create
    @vibe = {
            'name' => params[:name]
            }
    response = Unirest.post(
                            "http://localhost:3000/api/vibes",
                            parameters: @vibe
                            )
    if response.code == 200
      flash[:success] = "Successfully created vibe"
      redirect_to "/client/vibes"
    elsif response.code == 401
      flash[:warning] = "You cannot make vibes"
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    vibe_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/vibes/#{vibe_id}")
    @vibe = response.body
    render 'show.html.erb'
  end

  def edit
    vibe_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/vibes/#{params[:id]}")
    @vibe = response.body
    render 'edit.html.erb'     
  end

  def update
    @vibe = {'name' => params[:name]}
    response = Unirest.patch(
                              "http://localhost:3000/api/vibes/#{params[:id]}",
                              parameters: @vibe
                              )
    if response.code == 200
      flash[:success] = "Successfully Updated Vibe."
      redirect_to "/client/vibes/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to update vibes."
      redirect_to "/"
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end    
  end

  def destroy
    vibe_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/vibes/#{vibe_id}")    
    if response.code == 200
      flash[:success] = "Successfully Deleted Vibe"
      redirect_to "/"
    else
      flash[:warning] = "You are not authorized to delete this vibe"
      redirect_to "/"
    end
  end  
end
