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
    response = self.class.get(uri_with_params, @options)
    JSON.parse(response.body)['Stops']
  end

  def get_predictions(stop_id)
    uri_with_params = "https://api.wmata.com/NextBusService.svc/json/jPredictions?StopID=#{stop_id}"
    response = self.class.get(uri_with_params, @options)
    JSON.parse(response.body)
  end

  def get_predictions_x(stop_id)
    uri_with_params = "https://api.wmata.com/NextBusService.svc/json/jPredictions?StopID=#{stop_id}"
    response = self.class.get(uri_with_params, @options)
    JSON.parse(response.body)['Predictions']
  end

  # def get_departure_times_for_nearby_bus_stops(lat, lon, radius)
  #   bus_stops = self.get_bus_stops(lat, lon, radius)
  #   bus_stops.each do |stop|
  #     s = stop['StopID']
  #     stop.merge!('Predictions': self.get_predictions_x(s))
      # stop.merge!(self.get_predictions(s))
  #   end
  #   return bus_stops
  # end
end
