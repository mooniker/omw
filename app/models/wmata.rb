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

  def get_bus_stops(lat, long, radius)
    response = self.class.get('/Bus.svc/json/jStops', @options)
    JSON.parse(response.body)['Bus Stops']
  end

  def get_predictions(stop_id)
    response = self.class.get('https://api.wmata.com/NextBusService.svc/json/jPredictions', @options)
    JSON.parse(response.body)['Predictions']
  end

  def get_departure_times_for_nearby_bus_stops(lat, long, radius)
    bus_stops = self.get_bus_stops(lat, long, radius)
    bus_stops.each do |stop|
      # get all predictions for this stop
    end
  end
end
