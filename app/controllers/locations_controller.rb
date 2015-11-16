class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def new # get user's location, mapped to from/where
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.save
    redirect_to @location
  end

  def show
    @location = Location.find(params[:id])
  end
  
  private
    def location_params
      params.require(:location).permit(:lat, :lon)
    end

end
