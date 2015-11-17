class Wmata
  include HTTParty
  base_uri 'https://api.wmata.com'
  # attr_reader :last_updated

  def initialize(api_key)
    @options = { query: { api_key: api_key} }
  end

  def get_bus_routes
    response = self.class.get('/Bus.svc/json/jRoutes', @options)
    JSON.parse(response.body)['Routes']
  end

  def get_all_bus_stops
    response = self.class.get('/Bus.svc/json/jStops', @options)
    JSON.parse(response.body)['Stops']
  end

  def get_bus_stops(lat, lon, radius)
    # https://api.wmata.com/Bus.svc/json/jStops?Lat=38.878586&Lon=-76.989626&Radius=500
    uri_with_params = "https://api.wmata.com/Bus.svc/json/jStops?Lat=#{lat}&Lon=#{lon}&Radius=#{radius}"
    puts uri_with_params
    response = self.class.get(uri_with_params, @options)
    JSON.parse(response.body)['Stops']
  end

  def get_predictions(stop_id)
    response = self.class.get('https://api.wmata.com/NextBusService.svc/json/jPredictions', @options)
    JSON.parse(response.body)['Predictions']
  end

  def get_departure_times_for_nearby_bus_stops(lat, long, radius)
    bus_stops = self.get_bus_stops(lat, long, radius)
    bus_stops.each do |stop|
      # get all predictions for this stop
      stop[]
    end
  end
end
