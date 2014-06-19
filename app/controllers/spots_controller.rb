class SpotsController < ApplicationController
  before_action :authenticate_user!

  def new 
    @spot = Spot.new
  end

  def create 
    @spot = Spot.new(spot_params)
  end

  def show 
    @spot = Spot.find(params[:id])
  end

  def delete 
    @spot = Spot.find(params[:id])
  end

  private 
    def spot_params 
      params.require(:spot).permit(:longitude, :latitude, :description)
    end
end
