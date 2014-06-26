class SpotsController < ApplicationController
  before_action :authenticate_user!
  before_action :gonify
  def index 
    @spots = current_user.spots.last

    respond_to do |f|
      f.json { render json: @spots}
    end
  end

  def new 
    @spot = current_user.spots.new
    @user_id = current_user.id
  end

  def create 
    @spot = current_user.spots.new(spot_params)
    respond_to do |format|
      if @spot.save
        format.json { render json: @spot, status: :created}
      else
        format.json { render json: @spot.errors, status: :unprocessable_entity}
      end
    end
  end

  def show 
    @spot = current_user.spots.find(params[:id])
  end

  def delete 
    @spot = current_user.spots.find(params[:id])
  end

  def gonify  
    gon.current_user = current_user
  end

  private 
    def spot_params 
      params.require(:spot).permit(:longitude, :latitude, :description)
    end

end
