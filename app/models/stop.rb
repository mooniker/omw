class Stop < ActiveRecord::Base
  has_many :connections
  has_many :routes, :through => :connections

  def get_routes_string
    route_strings = []
    self.connections.each do |r|
      begin
        route_strings << Route.find_by(id: r)['RouteID']
      rescue
        return '.'
      end
    end
    return route_strings.join(', ')
  end
  # 
  # def get_lat
  #   return self.lat
  # end
  #
  # def get_lon
  #   return self.lon
  # end
end
