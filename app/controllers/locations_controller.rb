class LocationsController < ApplicationController

  def index
    @locations = Location.all

    @route_attributes = ['RouteID', 'Name', 'LineDescription']
    # @routes = Wmata.new(ENV['wmata_api_key']).get_bus_routes
    @routes = Wmata.new.get_bus_routes
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
    # this is great, but seems like a lot of logic happening in the controller.
    # What I would do is abstract this functionality and create a Prediction model.
    # A PORO(plain old ruby object) would do nicely here since we aren't inheriting from AR for this.
    # But the prediction model should do the functionality here instead of having alot of your business logic in the controller
    @location = Location.find(params[:id])
    # @stop_attributes = ['StopID', 'Name', 'Lon', 'Lat', 'Routes']
    # stops = Wmata.new(ENV['wmata_api_key']).get_bus_stops(@location.lat, @location.lon, 300)
    stops = Wmata.new.get_bus_stops(@location.lat, @location.lon, 300)
    stop_ids = []
    stops.each do |s|
      stop_ids << s['StopID']
    end
    @stops = stop_ids.join(', ')
    # puts stops.inspect
    @predictions = []
    stops.each do |stop|
      # @predictions << Wmata.new(ENV['wmata_api_key']).get_predictions(stop['StopID'])
      @predictions << Wmata.new.get_predictions(stop['StopID'])
    end # why does this nest like this?

  end

  private
    def location_params
      params.require(:location).permit(:lat, :lon)
    end

end
