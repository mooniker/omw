# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

routes_json = JSON.parse(File.read('routes.json'))

routes_json['Routes'].each do |route|
  Route.create!(route)
end

# route_json = {"Routes": [{"LineDescription": "Hunting Point-Pentagon Line", "Name": "10A - HUNTING POINT -PENTAGON", "RouteID": "10A"}, {"LineDescription": "Hunting Point-Pentagon Line", "Name": "10A - PENDELTON+COLUMBUS-PENTAGON", "RouteID": "10Av1"}]}
