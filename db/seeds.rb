# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# {"Routes": [{"LineDescription": "Hunting Point-Pentagon Line",
#              "Name": "10A - HUNTING POINT -PENTAGON", "RouteID": "10A"}, ...
routes_json = JSON.parse(File.read('routes.json'))

routes_json['Routes'].each do |route|
  Route.create!(route)
end

# {"Stops": [{"Lat": 38.670006, "StopID": "3000037", "Lon": -77.010283,
#             "Name": "LIVINGSTON RD + INDIAN HEAD HWY", "Routes": ["W19"]}, ...
stops_json = JSON.parse(File.read('bus_stops.json'))

stops_json['Stops'].each do |stop|
  new_stop = Stop.create!(stop.except('Routes'))
  stop['Routes'].each do |route|
    Route.find_by(RouteID: route).connections.create!(stop_id: new_stop.id)
  end
end

# create GA dashboard
# 38.9049836
# -77.0336719
# 1001294 1001325 1001221
# 1133 15th St NW

# TA Building
# 38.881064
# -77.177093
#

# 105 W Broad St, Falls Church, VA 22046
# 38.882327
# -77.171752
