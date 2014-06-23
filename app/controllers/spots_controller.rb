class SpotsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @spots = current_user.spots.all 

    respond_to do |f|
      f.json { render :json => @spots}
    end
  end

  def new 
    @spot = current_user.spots.new
  end

  def create 
    @spot = current_user.spots.new(spot_params)
  end

  def show 
    @spot = current_user.spots.find(params[:id])
  end

  def delete 
    @spot = current_user.spots.find(params[:id])
  end

  private 
    def spot_params 
      params.require(:spot).permit(:longitude, :latitude, :description)
    end
end
