# first of all kudos, but this is the kind of class that warrants a shit ton of
# comments. Lotsa cool stuff going on here as to what these different methods do
class Wmata
  include HTTParty
  base_uri 'https://api.wmata.com'
  # attr_reader :last_updated

  def initialize #(api_key)
    # @options = { query: { api_key: api_key} }
    @options = { query: { api_key: ENV['wmata_api_key']} }
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

# how does this method definition differ from the one defined below it? I can see that
# you drill further into the body. I guess my biggest hangup is the naming of these two methods.
# providing an x in the second method doesn't provide any more semantic meaning
# If I'm another dev looking at this code, wouldn't really know what get_predictions does
# if get_predictions_x is drilling into a key of Predictions
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

  # def get_departure_times_for_ne3arby_bus_stops(lat, lon, radius)
  #   bus_stops = self.get_bus_stops(lat, lon, radius)
  #   bus_stops.each do |stop|
  #     s = stop['StopID']
  #     stop.merge!('Predictions': self.get_predictions_x(s))
      # stop.merge!(self.get_predictions(s))
  #   end
  #   return bus_stops
  # end
end
